using Microsoft.EntityFrameworkCore;
using Web_Api_Demo.Models;
using Web_Api_Demo;

namespace Web_Api_Demo
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
        {
        }

        public DbSet<Products> Products { get; set; }
    }
}
