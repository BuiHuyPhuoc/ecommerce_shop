﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.JSInterop.Infrastructure;
using ShopoesAPI.DTOs;
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
                    var dbProduct = dbCart.IdProductVarientNavigation.IdProductNavigation;
                    if (dbProduct!.NewPrice!= null 
                        && dbProduct!.NewPrice < dbProduct!.PriceProduct)
                    {
                        amount += (decimal)dbProduct.NewPrice * dbCart.Quantity;
                    }
                    else
                    {
                        amount += dbProduct.PriceProduct * dbCart.Quantity;
                    }
                    var newOrderDetail = new OrderDetail
                    {
                        IdOrder = newOrder.Id,
                        IdProductVarient = dbCart.IdProductVarient,
                        ProductName = dbProduct.NameProduct + $" (Size: {dbCart.IdProductVarientNavigation.Size})",
                        ProductPrice = dbProduct.PriceProduct,
                        SalePrice = dbProduct.NewPrice ?? dbProduct.PriceProduct,
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
        [Route("GetAllOrder")]
        [Authorize(Roles = "2")]
        public async Task<ActionResult<Order>> GetAllOrder()
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = _context.Customers.Where(x => x.Account!.Email == emailClaim).FirstOrDefault();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            var dbOrders = await _context.Orders
                            .Include(x => x.IdAddressNavigation)
                            .OrderByDescending(x => x.Date)
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
                            .ThenInclude(y => y.IdProductVarientNavigation)
                            .ThenInclude(t => t.IdProductNavigation)
                            .ThenInclude(z => z!.IdBrandNavigation)
                            .Include(x => x.OrderDetails)
                            .ThenInclude(y => y.IdProductVarientNavigation)
                            .ThenInclude(t => t.IdProductNavigation)
                            .ThenInclude(z => z!.IdCategoryNavigation)
                            .Where(x => x.Id == id)
                            .AsNoTracking()
                            .FirstOrDefaultAsync();
            return Ok(dbOrders);
        }

        [HttpPost]
        [Route("NextStepOrder")]
        [Authorize(Roles = "2")]
        public async Task<IActionResult> NextStepOrder([FromBody] int id)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = _context.Customers.Where(x => x.Account!.Email == emailClaim).AsNoTracking().FirstOrDefault();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            var dbOrder = await _context.Orders.Where(x => x.Id == id).Include(x => x.OrderDetails).FirstOrDefaultAsync();
            if (dbOrder == null)
            {
                return BadRequest("Order is empty");
            }
            if (dbOrder.Status == "CANCELED")
            {
                return BadRequest("Order is canceled");
            }
            foreach(var orderDetail in  dbOrder.OrderDetails)
            {
                
            }
            switch (dbOrder.Status)
            {
                case "BOOKED":
                    dbOrder.Status = "READY";
                    break;
                case "READY":
                    dbOrder.Status = "DELIVERING";
                    break;
                case "DELIVERING":
                    dbOrder.Status = "DONE";
                    break;
            }
            await _context.SaveChangesAsync();
            return Ok();
        }

        private void ChangeQuantityFromOrder(int idOrder)
        {

        }

        [HttpPost]
        [Route("CancelOrder")]
        [Authorize(Roles = "2")]
        public async Task<IActionResult> CancelOrder([FromBody] int id)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = _context.Customers.Where(x => x.Account!.Email == emailClaim).AsNoTracking().FirstOrDefault();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            var dbOrder = await _context.Orders.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (dbOrder == null)
            {
                return BadRequest("Order is empty");
            }
            if (dbOrder.Status == "CANCELED")
            {
                return BadRequest("Order is canceled");
            }
            dbOrder.Status = "CANCELED";
            await _context.SaveChangesAsync();
            return Ok();
        }
    }    
}
