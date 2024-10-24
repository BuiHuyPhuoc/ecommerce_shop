using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ShopoesAPI.Models;

namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly ShopoesDbContext _context;

        public AccountController(ShopoesDbContext context)
        {
            _context = context;
        }


    }
}
