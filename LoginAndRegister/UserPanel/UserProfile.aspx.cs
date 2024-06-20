using Microsoft.AspNetCore.Authorization;
using System;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.UI;

namespace LoginAndRegister.UserPanel
{
    [Authorize]
    public partial class UserProfile : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();
            }
        }

        private void GetData()
        {

            SqlCommand cmd = new SqlCommand("UserData", dbcon.GetCon());

            cmd.CommandType = CommandType.StoredProcedure;


            cmd.Parameters.AddWithValue("@Username", HttpContext.Current.User.Identity.Name);

            try
            {

                dbcon.OpenCon();


                using (SqlDataReader reader = cmd.ExecuteReader())
                {

                    if (reader.HasRows)
                    {

                        while (reader.Read())
                        {
                            txtname.Text = reader["Name"].ToString();
                            txtAddress.Text = reader["Address"].ToString();
                            txtcity.Text = reader["City"].ToString();
                            txtmobileno.Text = reader["MobileNo"].ToString();
                            txtemail.Text = reader["EmailId"].ToString();
                            DateTime dob = Convert.ToDateTime(reader["DateOfBirth"]);
                            txtdob.Text = dob.ToString("yyyy-MM-dd");

                            txtusername.Text = reader["Username"].ToString();
                        }

                    }
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine("An error occurred: " + ex.Message);
            }
            finally
            {

                dbcon.CloseCon();
            }

        }



        protected void btnupdate_Click(object sender, EventArgs e)
        {
            string uName = txtname.Text;
            string uAddress = txtAddress.Text;
            string uCity = txtcity.Text;
            string uUsername = txtusername.Text;

            SqlCommand cmd = new SqlCommand("UPDATE Users SET Name = @Name, Address = @Address, City = @City WHERE Username = @Username", dbcon.GetCon());


            cmd.Parameters.AddWithValue("@Name", uName);
            cmd.Parameters.AddWithValue("@Address", uAddress);
            cmd.Parameters.AddWithValue("@City", uCity);
            cmd.Parameters.AddWithValue("@Username", uUsername);

            try
            {
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {

                Console.WriteLine("An error occurred: " + ex.Message);
            }
            finally
            {
                dbcon.CloseCon();
            }

        }


        protected void btnsavechanges_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("UpdatePassword", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Password", txtpassword.Text);
            cmd.Parameters.AddWithValue("@Username", txtusername.Text);
            dbcon.OpenCon();
            cmd.ExecuteNonQuery();
            dbcon.CloseCon();

        }
    }
}
