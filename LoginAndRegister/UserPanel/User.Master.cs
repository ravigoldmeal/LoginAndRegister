using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoginAndRegister.UserPanel
{
    public partial class User : System.Web.UI.MasterPage
    {
        DBConnect Dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDataUser();

            }
            lblusername.Text = "Hello! " + HttpContext.Current.User.Identity.Name;
        }

        private void GetDataUser()
        {
            
            SqlCommand cmd = new SqlCommand("Select UserHome, UserProfile, UserReport from Permissions where UserType = 'User' ;", Dbcon.GetCon());

            try
            {
                Dbcon.OpenCon();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        panelUserHome.Visible = Convert.ToBoolean(reader["UserHome"]);
                        panelUserProfile.Visible = Convert.ToBoolean(reader["UserProfile"]);
                        panelUserReport.Visible = Convert.ToBoolean(reader["UserReport"]);

                     
                    }
                }

                reader.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
            }
            finally
            {
                if (Dbcon.GetCon().State == ConnectionState.Open)
                {
                    Dbcon.CloseCon();
                }
            }
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("Login Page.aspx");

        }
    }
}