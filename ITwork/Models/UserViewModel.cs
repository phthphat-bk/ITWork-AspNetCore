using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ITwork.Models
{
    public class UserViewModel
    {
        public string username;
        public string password;
        public string firstName;
        public string lastName;
        public string gender;
        public int phone;
        public string email;
        public int active;
        public int cardNumber;
        public bool createAccount(UserViewModel user)
        {
            string query = "insert into account values( @username , @password , @fName , @lName , @gender , @phone , @email , 1, CAST(GETDATE() AS DATETIME), @card , null)";
            DataProvider.Instance.ExecuteNonQuery(query, new object[] { user.username, user.password, user.firstName, user.lastName, user.gender, user.phone, user.email, user.cardNumber });
            return false;
        }
    }
}
