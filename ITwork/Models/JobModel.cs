using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace ITwork.Models
{

    public class JobModel
    {
        public string title { get; set; }
        public string company { get; set; }
        public string decription { get; set; }
        public string salary { get; set; }
        public string titleJob { get; set; }
        public JobModel detailJob(string idJob)
        {
            if (idJob == null) idJob = "";
            string query = "DECLARE @tempTable TABLE(id NVARCHAR(10), title NVARCHAR(100), companyName NVARCHAR(100), decription NVARCHAR(MAX) ) INSERT INTO @tempTable SELECT job.ID, title, name ,job.description FROM dbo.job INNER JOIN dbo.company ON dbo.job.com_ID = dbo.company.ID SELECT* FROM @tempTable WHERE id = '"+ idJob + "'";
            DataTable result =  DataProvider.Instance.ExecuteQuery(query);
            JobModel jobDetail = new JobModel();
            jobDetail.titleJob = (string)result.Rows[0][1];
            jobDetail.company = (string)result.Rows[0][2];
            jobDetail.decription = (string)result.Rows[0][3];
            return jobDetail;
        }
        public DataTable allJobsInfo()
        {
            string query = "EXEC [dbo].[joinTableTest]";
            return DataProvider.Instance.ExecuteQuery(query);
        }
        public DataTable searchJob(string jobName, string company, string location)
        {
            string query = "EXEC dbo.findJobAndLocation @job , @company , @location";
            if (jobName == null) jobName = "";
            if (company == null) company = "";
            if (location == null) location = "";
            return DataProvider.Instance.ExecuteQuery(query, new object[] { jobName, company, location });
        }
    }
}