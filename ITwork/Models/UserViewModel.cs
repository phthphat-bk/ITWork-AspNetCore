using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ITwork.Models
{
    public class UserViewModel
    {
        public string _username { get; set; }
        public string _password { get; set; }
        public string _firstName { get; set; }
        public string _lastName { get; set; }
        public string _gender { get; set; }
        public int _phone { get; set; }
        public string _email { get; set; }
        public int _active { get; set; }
        public int _cardNumber { get; set; }
        public bool createAccount()
        {
            string query = "INSERT INTO account values( @username , @password , @fName , @lName , @gender , @phone , @email , 1, CAST(GETDATE() AS DATETIME), @card , null)";
            DataProvider.Instance.ExecuteNonQuery(query, new object[] { _username, _password, _firstName, _lastName, _gender, _phone, _email, _cardNumber });
            return true;
        }
    }
}
