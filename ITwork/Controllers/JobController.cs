using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ITwork.Models;
using Microsoft.AspNetCore.Mvc;

namespace ITwork.Controllers
{
    public class JobController : Controller
    {
        public IActionResult Index()
        {
            JobModel allJob = new JobModel();
            return View(allJob.allJobsInfo());
        }
        public IActionResult detailJob(string idJob)
        {
            JobModel job = new JobModel();
            return View(job.detailJob(idJob));
        }
    }
}