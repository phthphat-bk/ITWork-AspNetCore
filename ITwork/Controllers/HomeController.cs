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
            JobModel allJob = new JobModel();
            return View(allJob.allJobsInfo());
        }
        public IActionResult Search(string jobName, string company,string location)
        {
            JobModel result = new JobModel();
            ViewData["SearchJob"] = jobName;
            ViewData["SearchCompany"] = company;
            ViewData["SearchLocation"] = location;
            return View(result.searchJob(jobName, company, location));
        }
        public IActionResult About()
        {
            ViewData["Message"] = "Just for fun :)";

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
