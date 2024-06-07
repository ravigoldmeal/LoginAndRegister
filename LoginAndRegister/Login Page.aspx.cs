using Microsoft.AspNetCore.Authorization;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace LoginAndRegister
{
    
    public partial class Login_Page : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            string username = txtusername.Text;
            string password = txtpassword.Text;

            using (SqlConnection con = dbcon.GetCon())
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand("LoginValidation", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserName", username);
                        cmd.Parameters.AddWithValue("@Password", password);

                        SqlParameter isValidParam = new SqlParameter("@Isvalid", SqlDbType.Bit)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(isValidParam);

                        SqlParameter userTypeParam = new SqlParameter("@userType", SqlDbType.NVarChar, 10)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(userTypeParam);

                        SqlParameter errorMessageParam = new SqlParameter("@errorMessage", SqlDbType.NVarChar, 100)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(errorMessageParam);

                        con.Open();
                        cmd.ExecuteNonQuery();

                        bool isValid = Convert.ToBoolean(isValidParam.Value);
                        string errorMessage = errorMessageParam.Value.ToString();
                        string userRole = userTypeParam.Value as string;

                        lblError.Text = errorMessage;

                        if (isValid)
                        {
                            FormsAuthentication.SetAuthCookie(username, false);

                            if (chkRemember.Checked)
                            {
                                FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, username, DateTime.Now, DateTime.Now.AddDays(30), true, userRole);
                                string encryptedTicket = FormsAuthentication.Encrypt(ticket);
                                HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)
                                {
                                    Expires = DateTime.Now.AddDays(30)
                                };
                                Response.Cookies.Add(cookie);
                            }

                            if (userRole == "User")
                            {
                                Response.Redirect("~/UserPanel/UserHome.aspx");
                            }
                            else if (userRole == "Admin")
                            {
                                Response.Redirect("~/Admin screen/AdminHome.aspx");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "An Error Occurred: " + ex.Message;
                }
                finally
                {
                    dbcon.CloseCon();
                }
            }
        }

        protected void btnregister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}
