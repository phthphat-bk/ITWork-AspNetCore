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
        public IActionResult createCompany()
        {
            return View();
        }
        public IActionResult createCompanyResult(string managerUsername, string name, string numEmployee, string nation, string email, int phoneNumber)
        {
            CompanyModel com = new CompanyModel();
            com._managerUsername = managerUsername;
            com._name = name;
            com._nation = nation;
            com._phoneNumber = phoneNumber;
            com._email = email;
            com._numEmployee = numEmployee;
            com.createCompany();
            return View();
        }
    }
}