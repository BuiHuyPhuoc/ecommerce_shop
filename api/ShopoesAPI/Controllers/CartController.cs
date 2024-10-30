using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
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
            try {
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
            catch (Exception ex) {
                return BadRequest(ex.Message);
            }

        }


    }
}
