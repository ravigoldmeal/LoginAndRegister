using Microsoft.AspNetCore.Authorization;
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

namespace LoginAndRegister.Admin_screen
{
    [Authorize]
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        DBConnect Dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                string userRole = Session["UserRole"] as string;
             if(userRole == "Librarian")
                {
                    GetDataLibrarian();
                }
               
                    
            }
            lblusername.Text = "Hello! " + HttpContext.Current.User.Identity.Name;

        }
       

        private void GetDataLibrarian()
        {
            SqlCommand cmd = new SqlCommand("Select [Home],[UserManagement],[Report],[CatalogManagement],[Circulation] from Permissions where UserType = 'Librarian' ;", Dbcon.GetCon());

            try
            {
                Dbcon.OpenCon();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {  while(reader.Read())            
                    {
                        panelUserRoles.Visible = false;
                        panelHome.Visible = Convert.ToBoolean(reader["Home"]);
                        panelUserManagement.Visible = Convert.ToBoolean(reader["UserManagement"]);
                        panelReports.Visible = Convert.ToBoolean(reader["Report"]);
                        panelBookManagement.Visible = Convert.ToBoolean(reader["CatalogManagement"]);
                        panelCirculationManagement.Visible = Convert.ToBoolean(reader["Circulation"]);                                            
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


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("Login Page.aspx");
        }
    }
}