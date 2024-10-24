using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShopoesAPI.Models;
using System.Runtime.InteropServices;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BrandController : ControllerBase
    {
        private readonly ShopoesDbContext _context;

        public BrandController(ShopoesDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        [Route("GetAllBrand")]
        public async Task<ActionResult<List<Brand>>> GetAllBrand()
        {
            var brands = await _context.Brands.ToListAsync();
            return Ok(brands);
        }


        [HttpGet("GetBrandById/{id}")]
        public async Task<ActionResult<Brand>> GetBrandById(int id)
        {
            var brand = await _context.Brands.FindAsync(id);
            if (brand is null)
            {
                return BadRequest("Brand not found");
            }
            return Ok(brand);
        }

        [HttpPost]
        [Route("AddBrand")]
        public async Task<ActionResult<List<Brand>>> AddBrand([FromBody]Brand brand)
        {
            _context.Brands.Add(brand);
            await _context.SaveChangesAsync();
            return Ok(await _context.Brands.ToListAsync());
        }

        [HttpPut]
        [Route("UpdateBrand")]
        public async Task<ActionResult<Brand>> UpdateBrand(Brand brand)
        {
            var dbBrand = await _context.Brands.FindAsync(brand.Id);
            if (dbBrand is null)
            {
                return BadRequest("Brand not found");
            }
            dbBrand.NameBrand = brand.NameBrand;
            await _context.SaveChangesAsync();

            return Ok(await _context.Brands.ToListAsync());
        }

        [HttpDelete]
        [Route("DeleteBrand")]
        public async Task<ActionResult<Brand>> DeleteBrand(int id)
        {
            var dbBrand = await _context.Brands.FindAsync(id);
            if (dbBrand is null)
            {
                return BadRequest("Brand not found");
            }

            var dbProduct = await _context.Products.Where(x => x.IdCategory == id).FirstOrDefaultAsync();
            
            if (dbProduct is not null) 
            {
                return Conflict("Some products have this brand. Please remove first.");
            }
            
            _context.Brands.Remove(dbBrand);
            await _context.SaveChangesAsync();

            return Ok(await _context.Brands.ToListAsync());
        }

        [HttpGet]
        [Route("GetBrandByName/{NameBrand}")]
        public async Task<ActionResult<Brand>> GetBrandByName(string NameBrand)
        {
            var brand = await _context.Brands.Where(x => x.NameBrand == NameBrand).FirstOrDefaultAsync();
            if (brand is null)
            {
                return BadRequest("Brand not found");
            }
            return Ok(brand);
        }

    }
}
