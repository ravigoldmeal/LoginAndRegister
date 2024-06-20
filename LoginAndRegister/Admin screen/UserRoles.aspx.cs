using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoginAndRegister.Admin_screen
{
    public partial class UserRoles : System.Web.UI.Page
    {
        DBConnect Dbcon = new DBConnect();
        List<string> Librarian = new List<string>();
        List<string> nLibrarian = new List<string>();
        List<string> User = new List<string>();
        List<string> nUser = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                GetDataAdmin();
                GetDataLibrarian();
                GetDataUser();

            }
        }

        private void GetDataAdmin()
        {
            SqlCommand cmd = new SqlCommand("Select [Home],[UserManagement],[Report],[CatalogManagement],[Circulation],[UserRoles] from Permissions where UserType = 'Admin' ;", Dbcon.GetCon());

            try
            {
                Dbcon.OpenCon();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        bool home = Convert.ToBoolean(reader["Home"]);
                        bool userManagement = Convert.ToBoolean(reader["UserManagement"]);
                        bool report = Convert.ToBoolean(reader["Report"]);
                        bool catalogManagement = Convert.ToBoolean(reader["CatalogManagement"]);
                        bool userRoles = Convert.ToBoolean(reader["UserRoles"]);
                        bool circulation = Convert.ToBoolean(reader["Circulation"]);

                        SetCheckBoxListAdminValues(home, userManagement, catalogManagement, userRoles, circulation, report);
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

        private void GetDataLibrarian()
        {
            SqlCommand cmd = new SqlCommand("Select [Home],[UserManagement],[Report],[CatalogManagement],[Circulation] from Permissions where UserType = 'Librarian' ;", Dbcon.GetCon());

            try
            {
                Dbcon.OpenCon();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        bool home = Convert.ToBoolean(reader["Home"]);
                        bool userManagement = Convert.ToBoolean(reader["UserManagement"]);
                        bool report = Convert.ToBoolean(reader["Report"]);
                        bool catalogManagement = Convert.ToBoolean(reader["CatalogManagement"]);
                        bool circulation = Convert.ToBoolean(reader["Circulation"]);

                        SetCheckBoxListLibrarianValues(home, userManagement, catalogManagement, circulation, report);
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
                        bool userHome = Convert.ToBoolean(reader["UserHome"]);
                        bool userProfile = Convert.ToBoolean(reader["UserProfile"]);
                        bool userReport = Convert.ToBoolean(reader["UserReport"]);

                        SetCheckBoxListUserValues(userHome, userProfile, userReport);
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

        private void SetCheckBoxListUserValues(bool userHome, bool userProfile, bool userReport)
        {
            foreach (ListItem item in chkUser.Items)
            {
                switch (item.Text)
                {
                    case "UserHome":
                        item.Selected = userHome;
                        break;
                    case "UserProfile":
                        item.Selected = userProfile;
                        break;
                    case "UserReport":
                        item.Selected = userReport;
                        break;
                }
            }
        }

        private void SetCheckBoxListAdminValues(bool home, bool userManagement, bool catalogManagement, bool userRoles, bool circulation, bool report)
        {
            foreach (ListItem item in chkAdmin.Items)
            {
                switch (item.Text)
                {
                    case "Home":
                        item.Selected = home;
                        break;
                    case "UserManagement":
                        item.Selected = userManagement;
                        break;
                    case "CatalogManagement":
                        item.Selected = catalogManagement;
                        break;
                    case "CirculationManagement":
                        item.Selected = circulation;
                        break;
                    case "UserRoles":
                        item.Selected = userRoles;
                        break;
                    case "Report":
                        item.Selected = report;
                        break;
                }
            }
        }

        private void SetCheckBoxListLibrarianValues(bool home, bool userManagement, bool catalogManagement, bool circulation, bool report)
        {
            foreach (ListItem item in chkLibrarian.Items)
            {
                switch (item.Text)
                {
                    case "Home":
                        item.Selected = home;
                        break;
                    case "UserManagement":
                        item.Selected = userManagement;
                        break;
                    case "CatalogManagement":
                        item.Selected = catalogManagement;
                        break;
                    case "CirculationManagement":
                        item.Selected = circulation;
                        break;
                    case "Report":
                        item.Selected = report;
                        break;



                }
            }
        }



        protected void btnlibrarian_Click(object sender, EventArgs e)
        {

            string action = "Update";
            string usertype = "Librarian";
            bool Isselected = false;

            foreach (ListItem li in chkLibrarian.Items)
            {
                if (li.Selected)
                {
                    Librarian.Add(li.Text);
                }
                else
                {
                    nLibrarian.Add(li.Text);
                }
            }
            SqlCommand cmd = new SqlCommand("PermissionCrud", Dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Action ", action);
            cmd.Parameters.AddWithValue("@UserType", usertype);
            foreach (string text in Librarian)
            {
                Isselected = true;
                cmd.Parameters.AddWithValue("@" + text , Isselected);

            }
            foreach (string notselected in nLibrarian)
            {
                Isselected = false;
                cmd.Parameters.AddWithValue("@" + notselected  , Isselected);
            }
            try
            {
                Dbcon.OpenCon();
                cmd.ExecuteNonQuery();
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

        protected void brnuser_Click(object sender, EventArgs e)
        {
            string action = "Update";
            string usertype = "User";
            bool Isselected = false;

            foreach (ListItem li in chkUser.Items)
            {
                if (li.Selected)
                {
                    User.Add(li.Text);
                }
                else
                {
                    nUser.Add(li.Text);
                }
            }
            SqlCommand cmd = new SqlCommand("PermissionCrud", Dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Action ", action);
            cmd.Parameters.AddWithValue("@UserType", usertype);
            foreach (string text in User)
            {
                Isselected = true;
                cmd.Parameters.AddWithValue("@" + text, Isselected);

            }
            foreach (string notselected in nUser)
            {
                Isselected = false;
                cmd.Parameters.AddWithValue("@" + notselected, Isselected);
            }
            try
            {
                Dbcon.OpenCon();
                cmd.ExecuteNonQuery();
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
    }
}