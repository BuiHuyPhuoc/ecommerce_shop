using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShopoesAPI.DTOs;
using ShopoesAPI.Models;
using System.Security.Claims;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReviewController : ControllerBase
    {
        private readonly ShopoesDbContext _context;
        public ReviewController(ShopoesDbContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("PostReview")]
        [Authorize]
        public async Task<IActionResult> PostReview([FromBody] PostReviewRequest reviewRequest)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = await _context.Customers.AsNoTracking().FirstOrDefaultAsync(x => x.Account!.Email == emailClaim);
            if (dbCustomer == null)
            {
                return Unauthorized();
            }

            if (reviewRequest.Content.Trim().Length < 3)
            {
                return BadRequest("Content must more than 3 characters");
            }
            var newReview = new Review
            {
                IdCustomer = dbCustomer.Id,
                IdProduct = reviewRequest.IdProduct,
                Rating = reviewRequest.Rating,
                Content = reviewRequest.Content,
                Date = DateTime.Now,
            };
            _context.Reviews.Add(newReview);
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
