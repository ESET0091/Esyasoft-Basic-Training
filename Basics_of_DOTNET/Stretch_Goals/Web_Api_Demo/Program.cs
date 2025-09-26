using Microsoft.EntityFrameworkCore;
using Web_Api_Demo.Models;
namespace Web_Api_Demo
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            //var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");


            // Add services to the container.
            builder.Services.AddControllersWithViews();
            builder.Services.AddControllers();
            builder.Services.AddDbContext<AppDbContext>(options =>
            {
                // Retrieve the connection string from appsettings.json
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{Std_id?}");

            app.Run();
        }
    }
}
