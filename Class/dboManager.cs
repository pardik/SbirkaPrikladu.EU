using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;

namespace SbirkaPrikladuEU
{
    public class dboManager : IDisposable
    {
        public String connStr;        
        public SqlConnection Connection;
        public SqlConnection Connection2;
        public SqlConnection Connection3;
        public SqlCommand command;
        public SqlCommand command2;
        public SqlCommand command3;
        
        public dboManager()
        {
            connStr = ConfigurationManager.ConnectionStrings["SbirkaPrikladuEU"].ConnectionString;            
            Connection = new SqlConnection(connStr);
            Connection2 = new SqlConnection(connStr);
            Connection3 = new SqlConnection(connStr);
            Connection.Open();
            Connection2.Open();
            Connection3.Open();
            command = new SqlCommand("", Connection);
            command2 = new SqlCommand("", Connection2);
            command3 = new SqlCommand("", Connection2);
        }
        //destruktor
        ~dboManager()
        {
            Dispose();
        }

        public SqlDataReader ExecuteQuery(string queryString)
        {            
            SqlDataReader reader = new SqlCommand(queryString, Connection).ExecuteReader();
            {
                if (queryString.Contains("SELECT") || queryString.Contains("select")) return reader;
                reader.Dispose();
                return null;
            }
        }
        
        public string getScalar(string dboTable, string propertyNameToSelect, string whereFilter)
        {
            SqlCommand command = new SqlCommand("SELECT [" + propertyNameToSelect + "] FROM [" + dboTable + "] WHERE " + whereFilter, Connection2);
            SqlDataReader reader = command.ExecuteReader();
            string scalar = null;
            if (reader.Read()) scalar = reader[propertyNameToSelect].ToString();
            reader.Close();
            reader.Dispose();
            return scalar;
        }

        public void Dispose()
        {
            try { Connection.Close(); } catch { }
            try { Connection.Dispose(); } catch { }
            try { Connection2.Close(); } catch { }
            try { Connection2.Dispose(); } catch { }
            try { Connection3.Close(); } catch { }
            try { Connection3.Dispose(); } catch { }
        }            
    }
}