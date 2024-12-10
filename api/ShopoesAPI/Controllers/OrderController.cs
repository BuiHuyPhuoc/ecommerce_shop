using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShopoesAPI.DTOs.Order;
using ShopoesAPI.Models;
using System.Security.Claims;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly ShopoesDbContext _context;

        public OrderController(ShopoesDbContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("AddOrder")]
        [Authorize]
        public async Task<IActionResult> AddOrder([FromBody] OrderRequest order)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {
                var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
                var dbCustomer = await _context.Customers.Where(x => x.Account!.Email == emailClaim).FirstOrDefaultAsync();
                if (dbCustomer == null)
                {
                    return Unauthorized("User not found");
                }
                 
                var dbAddress = await _context.Addresses.FindAsync(order.IdAddress);
                if (dbAddress == null)
                {
                    return BadRequest("Address is invalid");
                }
                var newOrder = new Order();
                newOrder.Date = DateTime.Now;
                newOrder.IdCustomer = dbCustomer.Id;
                newOrder.Status = order.Status;
                newOrder.IdAddress = order.IdAddress;
                _context.Orders.Add(newOrder);
                await _context.SaveChangesAsync();

                decimal amount = 0;
                foreach (var idCart in order.IdCarts)
                {
                    var dbCart = await _context.Carts
                                .Include(x => x.IdProductVarientNavigation)
                                .ThenInclude(y => y.IdProductNavigation)
                                .Where(x => x.Id == idCart)
                                .FirstOrDefaultAsync();
                    if (dbCart == null)
                    {
                        return BadRequest("Cart is empty");
                    }
                    var getProductVarient = dbCart.IdProductVarientNavigation;
                    var getProduct = getProductVarient.IdProductNavigation;
                    if (getProduct == null)
                    {
                        return BadRequest("Product not found");
                    }
                    if (getProduct.NewPrice != null && getProduct.NewPrice < getProduct.PriceProduct)
                    {
                        amount += (decimal)getProduct.NewPrice;
                    }
                    else
                    {
                        amount += getProduct.PriceProduct;
                    }
                    var newOrderDetail = new OrderDetail
                    {
                        IdOrder = newOrder.Id,
                        IdProduct = getProduct.Id,
                        ProductName = getProduct.NameProduct + $" (Size: {getProductVarient.Size})",
                        ProductPrice = getProduct.PriceProduct,
                        SalePrice = getProduct.NewPrice ?? getProduct.PriceProduct,
                        Quantity = dbCart.Quantity
                    };
                    _context.OrderDetails.Add(newOrderDetail);
                    _context.Carts.Remove(dbCart);
                }

                newOrder.Amount = amount;
                await _context.SaveChangesAsync();

                await transaction.CommitAsync();
                return Ok("Order success");
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                return BadRequest($"Failed when create order: {ex.Message}");
            }
        }

        [HttpGet]
        [Route("GetOrder")]
        [Authorize]
        public async Task<ActionResult<Order>> GetOrder()
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = _context.Customers.Where(x => x.Account!.Email == emailClaim).FirstOrDefault();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            var dbOrders = await _context.Orders
                            .Include(x => x.IdAddressNavigation)
                            .Where(x => x.IdCustomer == dbCustomer.Id).OrderByDescending(x => x.Date)
                            .ToListAsync(); 
            return Ok(dbOrders);
        }

        [HttpGet]
        [Route("GetOrderDetail")]
        [Authorize]
        public async Task<ActionResult<Order>> GetOrderDetail(int id)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = _context.Customers.Where(x => x.Account!.Email == emailClaim).AsNoTracking().FirstOrDefault();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            var dbOrders = await _context.Orders
                            .Include(x => x.IdAddressNavigation)
                            .Include(x => x.OrderDetails)
                            .ThenInclude(y => y.IdProductNavigation)
                            .ThenInclude(z => z.IdBrandNavigation)
                            .Include(x => x.OrderDetails)
                            .ThenInclude(y => y.IdProductNavigation)
                            .ThenInclude(z => z.IdCategoryNavigation)
                            .Where(x => x.IdCustomer == dbCustomer.Id && x.Id == id)
                            .AsNoTracking()
                            .FirstOrDefaultAsync();
            return Ok(dbOrders);
        }

    }    
}
