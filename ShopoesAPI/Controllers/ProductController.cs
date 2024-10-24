using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShopoesAPI.Function;
using ShopoesAPI.Models;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly ShopoesDbContext _context;

        public ProductController(ShopoesDbContext context)
        {
            _context = context;
        }
        
        [HttpGet]
        [Route("GetAllProduct")]
        public async Task<ActionResult<List<Product>>> GetAllProduct()
        {
            var dbProducts = await _context.Products.Where(x => x.IsValid == true).ToListAsync();
            return Ok(dbProducts);
        }

        [HttpGet]
        [Route("GetProductByName")]
        public async Task<ActionResult<List<Product>>> GetProductByName(string name)
        {
            var searchTerm = StringFormat.RemoveDiacritics(name);
            var results = await _context.Products.Where(x => EF.Functions.Like(x.NameProduct, searchTerm) && x.IsValid == true).ToListAsync();
            return Ok(results);
        }

        [HttpGet]
        [Route("GetProductById")]
        public async Task<ActionResult<List<Product>>> GetProductById(int id)
        {
            var dbProduct = await _context.Products.FindAsync(id);
            return Ok(dbProduct);
        }
        
        [HttpGet]
        [Route("GetProductByCategory")]
        public async Task<ActionResult<List<Product>>> GetProductByCategory(int idCateogry)
        {
            var dbProduct = await _context.Products.Where(x => x.IdCategory == idCateogry && x.IsValid == true).ToListAsync();
            return Ok(dbProduct);
        }

        [HttpGet]
        [Route("GetProductByBrand")]
        public async Task<ActionResult<List<Product>>> GetProductByBrand(int idBrand)
        {
            var dbProduct = await _context.Products.Where(x => x.IdBrand == idBrand && x.IsValid == true).ToListAsync();
            return Ok(dbProduct);
        }


        // Update

        [HttpPut]
        [Route("UpdateProduct")]
        public async Task<ActionResult<List<Product>>> UpdateProduct(Product product)
        {
            var dbProduct = _context.Products.Find(product.Id);
            if (dbProduct is null)
            {
                return BadRequest("Product is not found");
            } else
            {
                dbProduct.NameProduct = product.NameProduct;
                dbProduct.Description = product.Description;
                dbProduct.PriceProduct = product.PriceProduct;
                dbProduct.NewPrice = product.NewPrice;
                dbProduct.IdCategory = product.IdCategory;
                dbProduct.IdBrand = product.IdBrand;
                dbProduct.ImageProduct = product.ImageProduct;
                dbProduct.IdBrandNavigation = product.IdBrandNavigation;
                dbProduct.IdCategoryNavigation = product.IdCategoryNavigation;
                await _context.SaveChangesAsync();
                return Ok(dbProduct);
            }
        }

    }
}
