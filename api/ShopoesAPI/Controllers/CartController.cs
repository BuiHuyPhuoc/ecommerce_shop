using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using ShopoesAPI.DTOs;
using ShopoesAPI.Models;
using System.Security.Claims;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CartController : ControllerBase
    {
        private readonly ShopoesDbContext _context;

        public CartController(ShopoesDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        [Route("GetCart")]
        [Authorize]
        public async Task<ActionResult<List<Cart>>> GetCart()
        {
            try
            {
                var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
                var dbCart = await _context.Carts
                    .Include(x => x.IdProductVarientNavigation)
                    .ThenInclude(pv => pv.IdProductNavigation)
                    .ThenInclude(p => p!.IdBrandNavigation)
                    .Include(x => x.IdProductVarientNavigation)
                    .ThenInclude(pv => pv.IdProductNavigation)
                    .ThenInclude(p => p!.IdCategoryNavigation)
                    .Where(c => c.IdCustomerNavigation.Account!.Email == emailClaim)
                    .ToListAsync();
                return Ok(dbCart);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }

        [HttpPut]
        [Route("UpdateCart")]
        [Authorize]
        public async Task<IActionResult> UpdateCart([FromBody] UpdateQuantityInCart request)
        {
            var dbCart = await _context.Carts.FindAsync(request.Id);
            if (dbCart == null)
            {
                return BadRequest("Item in cart is not found");
            }
            else
            {
                if (request.IsIncrease)
                {
                    dbCart.Quantity += 1;
                }
                else
                {
                    if (dbCart.Quantity > 0)
                    {
                        dbCart.Quantity -= 1;
                    }
                }
                await _context.SaveChangesAsync();
                return Ok();
            }
        }

        [HttpPost]
        [Route("AddToCart")]
        [Authorize]
        public async Task<IActionResult> AddToCart([FromBody] AddCartRequest request)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = await _context.Customers.FirstOrDefaultAsync(x => x.Account!.Email == emailClaim);
            if (dbCustomer == null)
            {
                return BadRequest();
            }
            else
            {
                var dbCart = await _context.Carts.Where(x => x.IdCustomer == dbCustomer.Id && x.IdProductVarient == request.IdProductVarient).FirstOrDefaultAsync();
                if (dbCart != null)
                {
                    // If existed, update quantity
                    dbCart.Quantity += request.Quantity;
                    await _context.SaveChangesAsync();
                    return Ok("Update quantity");
                } else
                {
                    try
                    {
                        Cart cart = new Cart
                        {
                            IdProductVarient = request.IdProductVarient,
                            IdCustomer = dbCustomer.Id,
                            Quantity = request.Quantity,
                        };
                        await _context.Carts.AddAsync(cart);
                        await _context.SaveChangesAsync();
                        return Ok("Add to cart success");
                    }
                    catch (Exception ex)
                    {
                        return BadRequest(ex.Message);
                    }
                }
                
            }
        }
    }
}
