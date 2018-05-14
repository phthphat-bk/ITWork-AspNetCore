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
            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { username, password });
            if (result == 1)
            {
                _isLogIn = true;
                _username = username;
            }
            return _isLogIn;
        }
        public void changePassword(string newPassword)
        {
            string query = "EXEC dbo.changePassword @username , @newPassword";
            DataProvider.Instance.ExecuteQuery(query, new object[] { _username, newPassword });
        }
        public void LogOut()
        {
            _username = "#NA"; _isLogIn = false;
        }
    }
}
