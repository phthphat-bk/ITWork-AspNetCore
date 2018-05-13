using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ITwork.Models;
using System.Data;

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
        public IActionResult createAccount()
        {
            return View();
        }
        public IActionResult createAccountResult(string username, string password, string firstName, string lastName, string gender, int phone, string email, int cardNumber)
        {
            UserViewModel userInfo = new UserViewModel();
            userInfo._username = username;
            userInfo._firstName = firstName;
            userInfo._lastName  = lastName;
            userInfo._password = password;
            userInfo._gender = gender;
            userInfo._phone = phone;
            userInfo._email = email;
            userInfo._cardNumber = cardNumber;
            userInfo.createAccount();
            return View();
        }
        public IActionResult changePasswordForm()
        {
            return View();
        }
        public IActionResult changePassword(string currentPassword, string newPassword, string confirmPassword)
        {
            string query = "SELECT password FROM dbo.account WHERE username = @username";
            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { UserModel._username });
            if (currentPassword == (string)result.Rows[0][0])
            {
                if (newPassword == confirmPassword)
                {
                    UserModel.Instance.changePassword(newPassword);
                    ViewData["Message"] = "You has changed your password completely";
                }
                else ViewData["Message"] = "Confirm password failed!";
            }
            else ViewData["Message"] = "Your current password is invalid";
            return View();
        }
        public IActionResult LogOut()
        {
            UserModel.Instance.LogOut();
            return View();
        }
    }
}