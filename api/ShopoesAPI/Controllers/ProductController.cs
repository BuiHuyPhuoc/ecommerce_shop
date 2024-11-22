using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShopoesAPI.DTOs;
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
            var dbProducts = await _context.Products.Include(x => x.IdCategoryNavigation)
                .Include(x => x.IdBrandNavigation).Where(x => x.IsValid == true).OrderByDescending(x => x.NameProduct).Take(10).ToListAsync();
            return Ok(dbProducts);
        }

        [HttpGet]
        [Route("GetProductByName")]
        public async Task<ActionResult<List<Product>>> GetProductByName(string name)
        {
            var results = await _context.Products.Include(x => x.IdCategoryNavigation)
                .Include(x => x.IdBrandNavigation).Where(x => EF.Functions.Like(x.NameProduct, $"%{name}%") && x.IsValid == true).ToListAsync();
            return Ok(results);
        }

        [HttpGet]
        [Route("GetProductById")]
        public async Task<ActionResult<Product>> GetProductById(int id)
        {
            var dbProduct = await _context.Products
                .Include(x => x.IdCategoryNavigation)
                .Include(x => x.IdBrandNavigation)
                .Include(x => x.ProductVarients)
                .Include(x => x.ProductImages)
                .Include(x => x.Reviews)
                .ThenInclude(y => y.IdCustomerNavigation)
                .FirstOrDefaultAsync(x => x.Id == id);
            var dbReview = _context.Reviews.Where(x => x.IdProduct == dbProduct!.Id).AsNoTracking().Average(x => x.Rating);
            
            if (dbProduct == null)
            {
                return Conflict("Product with this id not found");
            }
            return Ok(new { dbProduct , rate = dbReview});
        }

        [HttpGet]
        [Route("GetProductByCategory")]
        public async Task<ActionResult<List<Product>>> GetProductByCategory(int idCateogry)
        {
            var dbProduct = await _context.Products
                                   .Include(x => x.IdCategoryNavigation)
                                   .Include(x => x.IdBrandNavigation)
                                   .Where(x => x.IdCategory == idCateogry && x.IsValid == true)
                                   .ToListAsync();
            return Ok(dbProduct);
        }

        [HttpGet]
        [Route("GetProductByBrand")]
        public async Task<ActionResult<List<Product>>> GetProductByBrand(int idBrand)
        {
            var dbProduct = await _context.Products.Include(x => x.IdCategoryNavigation).Include(x => x.IdBrandNavigation).Where(x => x.IdBrand == idBrand && x.IsValid == true).ToListAsync();
            return Ok(dbProduct);
        }

        [HttpGet]
        [Route("GetSaleProduct")]
        public async Task<ActionResult<List<Product>>> GetSaleProduct()
        {
            var dbProduct = await _context.Products
                .Include(x => x.IdCategoryNavigation)
                .Include(x => x.IdBrandNavigation)
                .Where(x => x.IsValid == true && x.PriceProduct != x.NewPrice)
                .ToListAsync();
            return Ok(dbProduct);
        }

        [HttpGet("FilterProduct")]
        public async Task<IActionResult> FilterProduct([FromQuery] int? idBrand, [FromQuery] int? idCategory, [FromQuery] string? searchString)
        {
            var products = _context.Products
                .Include(x => x.IdCategoryNavigation)
                .Include(x => x.IdBrandNavigation)
                .Where(x => x.IsValid == true)
                .AsQueryable();

            // Lọc theo brand nếu được truyền vào
            if (idBrand != null)
            {
                products = products.Where(p => p.IdBrand == idBrand);
            }

            // Lọc theo category nếu được truyền vào
            if (idCategory != null)
            {
                products = products.Where(p => p.IdCategory == idCategory);
            }

            if (searchString != null)
            {
                products = products.Where(x => EF.Functions.Like(x.NameProduct, $"%{searchString}%") && x.IsValid == true);
            }

            var result = await products.AsNoTracking().ToListAsync();

            return Ok(result);
        }

        [HttpPut]
        [Route("UpdateProduct")]
        public async Task<IActionResult> UpdateProduct(Product product)
        {
            var dbProduct = await _context.Products.FindAsync(product.Id);
            if (dbProduct is null)
            {
                return BadRequest("Product is not found");
            }
            else
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
                return Ok();
            }
        }
    }
}
