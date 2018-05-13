using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace ITwork.Models
{
    public class CompanyModel
    {
        public string _name { get; set; }
        public string _managerUsername { get; set; }
        public string _description { get; set; }
        public int _phoneNumber { get; set; }
        public string _email { get; set; }
        public string _numEmployee { get; set; }
        public string _nation { get; set; }

        public void loadCompany(string name)
        {
            string query = "SELECT * FROM dbo.company WHERE name LIKE '%' + @name + '%'";
            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { name });
            DataRow row = result.Rows[0];
            _name = (string)row[2];
            _description = (string)result.Rows[0][3];
            _phoneNumber = (int)result.Rows[0][10];
            if (_description == null) _description = "";
            _email = (string)result.Rows[0][8];
        }
        public static DataTable showAllCompany()
        {
            string query = "SELECT * FROM dbo.company";
            return DataProvider.Instance.ExecuteQuery(query);
        }
        public bool createCompany()
        {
            string query = "insert into company(man_username, name, num_employee, nation, email, phoneNumber) values( @man_username , @name , @num_employee , @nation , @email , @phoneNumber );";
            //man_username, name, num_employee, nation, email, phoneNumber
            DataProvider.Instance.ExecuteQuery(query, new object[] { _managerUsername, _name, _numEmployee, _nation, _email, _phoneNumber });
            return true;
        }
    }
}
