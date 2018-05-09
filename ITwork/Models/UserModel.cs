using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace ITwork.Models
{
    public class UserModel
    {
        private static UserModel instance;

        public static UserModel Instance
        {
            get { if (instance == null) instance = new UserModel(); return instance; }
            private set { instance = value; }
        }
        private UserModel() { _username = "#NA"; _isLogIn = false; }
        public static string _username;

        public static string _email;
        public static string _password;
        public static bool _isLogIn;
        public bool LogIn(string username, string password)
        {
            if (_isLogIn) return false;
            string query = "EXEC dbo.logInUser @username , @password";
            if (username == null) username = "";
            if (password == null) password = "";
            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { username, password });
            _isLogIn = result.Rows.Count > 0 ? true : false;
            if (_isLogIn) _username = username;
            return _isLogIn;
        }
        public void LogOut()
        {
            _username = "#NA"; _isLogIn = false;
        }
    }
}
