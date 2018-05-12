using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ITwork.Models
{
    public class UserViewModel
    {
        public string username { get; set; }
        public string password { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string gender { get; set; }
        public int phone { get; set; }
        public string email { get; set; }
        public int active { get; set; }
        public int cardNumber { get; set; }
        public bool createAccount()
        {
            string query = "insert into account values( @username , @password , @fName , @lName , @gender , @phone , @email , 1, CAST(GETDATE() AS DATETIME), @card , null)";
            DataProvider.Instance.ExecuteNonQuery(query, new object[] { username, password, firstName, lastName, gender, phone, email, cardNumber });
            return false;
        }
    }
}
