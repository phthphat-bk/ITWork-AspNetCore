using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ITwork.Models;

namespace ITwork.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            string query = "EXEC [dbo].[joinTableTest]";

            return View(DataProvider.Instance.ExecuteQuery(query));
        }
        public IActionResult Search(string job, string company,string location)
        {
            string query = "EXEC dbo.findJobAndLocation @job , @company , @location";
            if (job == null) job = "";
            if (company == null) company = "";
            if (location == null) location = "";

            ViewData["SearchJob"] = job;
            ViewData["SearchCompany"] = company;
            ViewData["SearchLocation"] = location;
            return View(DataProvider.Instance.ExecuteQuery(query, new object[] {job, company,location}));
        }
        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
