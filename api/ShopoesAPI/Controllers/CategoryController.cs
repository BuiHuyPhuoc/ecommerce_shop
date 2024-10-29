using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShopoesAPI.Models;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        private readonly ShopoesDbContext _context;

        public CategoryController(ShopoesDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        [Route("GetAllCategory")]
        public async Task<ActionResult<List<Category>>> GetAllCategory()
        {
            var dbCategory = await _context.Categories.ToListAsync();
            return Ok(dbCategory);
        }

        [HttpGet]
        [Route("GetCategoryById/{idCategory}")]
        public async Task<ActionResult<Category>> GetCategoryById(int idCategory)
        {
            var dbCategory = await _context.Categories.FindAsync(idCategory);
            if (dbCategory is null)
            {
                return BadRequest("Category not found");
            }
            return Ok(dbCategory);
        }

        [HttpGet]
        [Route("GetCategoryByName/{nameCategory}")]
        public async Task<ActionResult<Category>> GetCategoryById(string nameCategory)
        {
            var dbCategory = await _context.Categories.FirstOrDefaultAsync(c => c.Name == nameCategory);
            if (dbCategory is null)
            {
                return BadRequest("Category not found");
            }
            return Ok(dbCategory);
        }

        [HttpPost("CreateCategory")]
        public async Task<ActionResult<Category>> CreateCategory(Category category)
        {
            _context.Categories.Add(category);
            await _context.SaveChangesAsync();
            return Ok(await _context.Categories.ToListAsync());
        }

        [HttpPut]
        [Route("UpdateCategory")]
        public async Task<ActionResult<Category>> UpdateCategory(Category category)
        {
            var dbCategory = await _context.Categories.FindAsync(category.Id);
            if (dbCategory is null)
            {
                return BadRequest("Category not found");
            }
            dbCategory.Name = dbCategory.Name;
            await _context.SaveChangesAsync();

            return Ok(await _context.Categories.ToListAsync());
        }

        [HttpDelete]
        [Route("DeleteCategory")]
        public async Task<ActionResult<Category>> DeleteCategory(int id)
        {
            var dbCategory = await _context.Categories.FindAsync(id);
            if (dbCategory is null)
            {
                return BadRequest("Category not found");
            }

            var dbProduct = await _context.Products.Where(x => x.IdCategory == id).FirstOrDefaultAsync();

            if (dbProduct is not null)
            {
                return Conflict("Some products have this Category. Please remove first.");
            }

            _context.Categories.Remove(dbCategory);
            await _context.SaveChangesAsync();

            return Ok(await _context.Categories.ToListAsync());
        }
    }
}
