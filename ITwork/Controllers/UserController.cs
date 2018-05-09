using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ITwork.Models;

namespace ITwork.Controllers
{
    public class UserController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult LogIn(string username, string password)
        {
            if (UserModel._isLogIn == false)
            {
                if (UserModel.Instance.LogIn(username, password))
                {
                    ViewData["Result"] = "Successful";
                    UserModel._isLogIn = true;
                }
            }
            else
            {
                ViewData["Result"] = "Unsuccessful";
                ViewData["Notice"] = "Another user has log in this page. Please log out first.";
            }
            return View();
        }
        public IActionResult LogOut()
        {
            UserModel.Instance.LogOut();
            return View();
        }
    }
}