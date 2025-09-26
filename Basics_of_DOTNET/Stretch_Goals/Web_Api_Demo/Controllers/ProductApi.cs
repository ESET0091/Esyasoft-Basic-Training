using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Web_Api_Demo.Models;


namespace Web_Api_Demo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductApiController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ProductApiController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Products>>> GetProducts()
        {
            try
            {
                if (_context.Products == null)
                {
                    return NotFound("Product table is not found");
                }
                var products = await _context.Products.ToListAsync();

                if (products == null)
                {
                    return NotFound("No products found");
                }
                return Ok(products);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        
    }
}
