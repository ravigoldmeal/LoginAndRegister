using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

using System.Xml.Linq;
using System.Globalization;

namespace LoginAndRegister
{
    public partial class Register : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    getData();

            //}
        }

     

        protected void Submit_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("InsertUser", dbcon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", txtname.Text);
                cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                cmd.Parameters.AddWithValue("@City", txtcity.Text);
                cmd.Parameters.AddWithValue("@MobileNo", txtmobile.Text);
                cmd.Parameters.AddWithValue("@EmailId", txtemail.Text);
                cmd.Parameters.AddWithValue("@UserType", userType.Text);
                cmd.Parameters.AddWithValue("@Gender", gender.SelectedValue);
                cmd.Parameters.AddWithValue("@DateOfBirth", dob.Text);
                cmd.Parameters.AddWithValue("@IsActive", 1);
                cmd.Parameters.AddWithValue("@Username", txtusername.Text);
                cmd.Parameters.AddWithValue("@Password", txtpassword.Text);

                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                Session["JavaScriptFunction"] = "showNotification();";
                Response.Redirect("Login Page.aspx");
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627) 
                {
                   
                    if (ex.Message.Contains("Username"))
                        libusername.Text += "Username already exists.";
                    else if (ex.Message.Contains("EmailId"))
                        libEmailid.Text += "Email ID already exists.";
                    else if (ex.Message.Contains("MobileNo"))
                        libMobileNo.Text += "Mobile number already exists.";
                 
                }
                else
                {
                    lblinfo.Text = "An error occurred: " + ex.Message;
                }
            }
            catch (Exception ex)
            {
                lblinfo.Text = "An error occurred: " + ex.Message;
            }
            finally
            {
                dbcon.CloseCon();
            }
        }


        protected void Login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login Page.aspx");
        }

      
    }
    }


