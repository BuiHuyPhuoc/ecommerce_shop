using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShopoesAPI.DTOs;
using ShopoesAPI.Function;
using ShopoesAPI.Models;
using System.Security.Claims;
using System.Text.Json;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {

        private readonly ShopoesDbContext _context;
        private readonly IConfiguration _configuration;

        public CustomerController(ShopoesDbContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }
        // API trả về người dùng khi có yêu cầu từ jwt
        [HttpGet("GetCustomerByJwtToken")]
        [Authorize]
        public async Task<IActionResult> GetCustomerByJwtToken() 
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            try
            {
                var dbCustomer = await _context.Customers.Include(x => x.IdRoleNavigation).FirstOrDefaultAsync(x => x.Account!.Email == emailClaim);
                if (dbCustomer == null)
                {
                    return BadRequest("User not found");
                } else
                {
                    return Ok(dbCustomer);
                }

            }
            catch
            {
                return BadRequest("User not found");
            }
            
        }

        [HttpGet("GetCustomer")]
        [Authorize]
        public async Task<IActionResult> GetCustomer()
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.Email == emailClaim);
            if (dbAccount == null)
            {
                return BadRequest("User not found");
            }
            var dbCustomer = await _context.Customers.Include(c => c.IdRoleNavigation).FirstOrDefaultAsync(x => x.Id == dbAccount!.IdCustomer);
            if (dbCustomer == null)
            {
                return BadRequest("User not found");
            }
            else
            {
                CustomerReturn returnCustomer = new CustomerReturn
                {
                    Email = emailClaim!,
                    Name = dbCustomer.Name,
                    Phone = dbCustomer.Phone,
                    NameRole = dbCustomer.IdRoleNavigation.NameRole,
                    AvatarImageUrl = dbCustomer.AvatarImageUrl,
                    IdRole = dbCustomer.IdRole,
                };
                return Ok(returnCustomer);
            }
        }

        [HttpPut("UpdateCustomer")]
        [Authorize]
        public async Task<IActionResult> UpdateCustomer(UpdateCustomerRequestDTO request)
        {
            if (request == null)
            {
                return BadRequest("Required field is missing");
            } else
            {
                if (string.IsNullOrEmpty(request.Name) || string.IsNullOrEmpty(request.Phone))
                {
                    return BadRequest("Required field is missing");
                }
                // Kiểm tra format số điện thoại
                if (!StringFormat.IsDigitsOnly(request.Phone))
                {
                    return BadRequest("Phone number has only number please.");
                }
                if (request.Phone.Length < 10)
                {
                    return BadRequest("Phone number is too short");
                }

                var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
                var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.Email == emailClaim);
                if (dbAccount == null)
                {
                    return BadRequest("User not found");
                }
                var dbCustomer = await _context.Customers.Include(c => c.IdRoleNavigation).FirstOrDefaultAsync(x => x.Id == dbAccount!.IdCustomer);
                if (dbCustomer == null)
                {
                    return BadRequest("User not found");
                }
                dbCustomer.Name = request.Name;
                dbCustomer.Phone = request.Phone;
                await _context.SaveChangesAsync();
                return Ok(new CustomerReturn
                {
                    Email = emailClaim!,
                    Name = dbCustomer.Name,
                    Phone = dbCustomer.Phone,
                    NameRole = dbCustomer.IdRoleNavigation.NameRole,
                    AvatarImageUrl = dbCustomer.AvatarImageUrl,
                    IdRole = dbCustomer.IdRole,
                });
            }
        }

        [HttpPost("UpdateAvatar")]
        [Authorize]
        public async Task<IActionResult> UpdateAvatar([FromBody] string urlImage)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.Email == emailClaim);
            if (dbAccount == null)
            {
                return BadRequest("User not found");
            }
            var dbCustomer = await _context.Customers.FirstOrDefaultAsync(x => x.Id == dbAccount!.IdCustomer);
            if (dbCustomer == null)
            {
                return BadRequest("User not found");
            }
            else
            {
                dbCustomer.AvatarImageUrl = urlImage;
                await _context.SaveChangesAsync();
                return Ok();
            }
        }
    }
}
