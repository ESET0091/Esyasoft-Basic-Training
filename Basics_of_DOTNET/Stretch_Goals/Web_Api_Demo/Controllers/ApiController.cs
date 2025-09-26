using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Web_Api_Demo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ApiController : ControllerBase
    {
        private List<Dictionary<string, string>> student_dict = new List<Dictionary<string, string>>

        {

            new Dictionary<string, string>{{"id","1"},{"name","Sachin"}},
            new Dictionary<string, string>{{"id","2"},{"name","Rahul"}},

        };

        [HttpGet]
        public IActionResult GetAllStudent()
        {
            return new JsonResult(student_dict);
        }

        [HttpGet("{id}")]
        public IActionResult GetAllStudent(string id)
        {
            var student = student_dict.FirstOrDefault(p => p["id"] == id);
            if(student != null)
            {
                return new JsonResult(student);
            }
            return new JsonResult("No match found for your id");
        }

    }
}
