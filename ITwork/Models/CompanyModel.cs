using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace ITwork.Models
{
    public class CompanyModel
    {
        public string _name;
        public string _description;
        public int _phoneNumber;
        public string _email;
        public void loadCompany(string name)
        {
            string query = "SELECT * FROM dbo.company WHERE name LIKE '%' + @name + '%'";
            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { name });
            DataRow row = result.Rows[0];
            _name = (string)row[2];
            _description = (string)result.Rows[0][3];
            _phoneNumber = (int)result.Rows[0][10];
            _email = (string)result.Rows[0][8];
        }
        public static DataTable showAllCompany()
        {
            string query = "SELECT * FROM dbo.company";
            return DataProvider.Instance.ExecuteQuery(query);
        }
    }
}
