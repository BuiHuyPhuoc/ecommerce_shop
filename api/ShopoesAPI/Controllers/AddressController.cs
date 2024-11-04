using Azure.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Server.IISIntegration;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using ShopoesAPI.DTOs;
using ShopoesAPI.Function;
using ShopoesAPI.Models;
using System.Runtime.InteropServices;
using System.Security.Claims;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AddressController : ControllerBase
    {
        private readonly ShopoesDbContext _context;

        public AddressController(ShopoesDbContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("AddAddress")]
        [Authorize]
        public async Task<IActionResult> AddAddress([FromBody] AddAddressDTO address)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = await _context.Customers.Where(x => x.Account!.Email == emailClaim).FirstOrDefaultAsync();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            if (string.IsNullOrEmpty(address.Ward)
                || string.IsNullOrEmpty(address.City)
                || string.IsNullOrEmpty(address.District)
                || string.IsNullOrEmpty(address.Street)
                || string.IsNullOrEmpty(address.ReceiverName) 
                || string.IsNullOrEmpty(address.ReceiverPhone))
            {
                return BadRequest("Missing information.");
            }

            if (!StringFormat.IsDigitsOnly(address.ReceiverPhone))
            {
                return BadRequest("Invalid phone number.");
            }

            var newAddress = new Address
            {
                Ward = address.Ward,
                City = address.City,
                District = address.District,
                Street = address.Street,
                IdCustomer = dbCustomer.Id,
                ReceiverName = address.ReceiverName,
                ReceiverPhone = address.ReceiverPhone,
                IsDefault = false
            };

            _context.Addresses.Add(newAddress);
            await _context.SaveChangesAsync();
            return Ok("Add address success");
        }

        [HttpGet]
        [Route("GetAddress")]
        [Authorize]
        public async Task<IActionResult> GetAddress()
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = await _context.Customers.Where(x => x.Account!.Email == emailClaim).FirstOrDefaultAsync();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            var dbAddress = await _context.Addresses.Where(x => x.IdCustomer == dbCustomer.Id).ToListAsync();
            return Ok(dbAddress);
        }

        [HttpDelete]
        [Route("DeleteAddress")]
        [Authorize]
        public async Task<IActionResult> DeleteAddress(int id)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;
            var dbCustomer = await _context.Customers.Where(x => x.Account!.Email == emailClaim).FirstOrDefaultAsync();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            var dbAddress = await _context.Addresses.FindAsync(id);
            if (dbAddress == null)
            {
                return BadRequest("Address not found");
            }
            _context.Remove(dbAddress);
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpPut]
        [Route("UpdateAddress/{id}")]
        [Authorize]
        public async Task<IActionResult> UpdateAddress(int id, [FromBody] AddAddressDTO address)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;   
            var dbCustomer = await _context.Customers.Where(x => x.Account!.Email == emailClaim).FirstOrDefaultAsync();
            if (dbCustomer == null)
            {
                return Unauthorized("User not found");
            }
            var dbAddress = await _context.Addresses.FindAsync(id);
            if (dbAddress == null)
            {
                return BadRequest("Address not found");
            }
            if (string.IsNullOrEmpty(address.Ward)
                || string.IsNullOrEmpty(address.City)
                || string.IsNullOrEmpty(address.District)
                || string.IsNullOrEmpty(address.Street)
                || string.IsNullOrEmpty(address.ReceiverName)
                || string.IsNullOrEmpty(address.ReceiverPhone))
            {
                return BadRequest("Missing information.");
            }
            if (!StringFormat.IsDigitsOnly(address.ReceiverPhone))
            {
                return BadRequest("Invalid phone number.");
            }
            dbAddress.Ward = address.Ward;
            dbAddress.City = address.City;
            dbAddress.District = address.District;
            dbAddress.Street = address.Street;
            dbAddress.ReceiverName = address.ReceiverName;
            dbAddress.ReceiverPhone = address.ReceiverPhone;
            await _context.SaveChangesAsync();
            return Ok();
        }


    }
}
