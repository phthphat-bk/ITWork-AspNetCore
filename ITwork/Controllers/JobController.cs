using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace ITwork.Controllers
{
    public class JobController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult detailJob()
        {
            return View();
        }
    }
}