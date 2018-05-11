using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using ITwork.Models;
using Microsoft.AspNetCore.Mvc;

namespace ITwork.Controllers
{
    public class CompanyController : Controller
    {
        public IActionResult Index()
        {
            return View(CompanyModel.showAllCompany());
        }
        public IActionResult detail1Company(string name)
        {
            CompanyModel detail = new CompanyModel();
            detail.loadCompany(name);
            return View(detail);
        }
    }
}