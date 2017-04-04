using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CMS.Scheduler;
using CMS.EventLog;
using CMS;

[assembly: RegisterCustomClass("Custom.CustomTask", typeof(Custom.CustomTask))]
namespace Custom
{
    /// <summary>
    /// Summary description for CustomTask
    /// </summary>
    public class CustomTask : ITask
    {
        public string Execute(TaskInfo task)
        {
            string detail = "Executed from '~/App_Code/CustomTasks/CustomTask.cs'. Task data:" + task.TaskData;

            // Logs the execution of the task in the event log.
            EventLogProvider.LogInformation("CustomTask", "Execute", detail);

            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(CMS.DataEngine.ConnectionHelper.GetSqlConnectionString()))
            {
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(
                      "INSERT INTO Custom_Task_Test VALUES(NEWID(),'" + DateTime.Now.Millisecond.ToString() + "')", con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }             

            return "Success";
        }
    }
}