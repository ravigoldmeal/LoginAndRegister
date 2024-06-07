using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Microsoft.AspNetCore.Authorization;

namespace LoginAndRegister.Admin_screen
{
    [Authorize]
    public partial class WebForm4 : System.Web.UI.Page
    {
        DBConnect Dbcon = new DBConnect();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();
                UpdateFine();

            }

        }

        private void GetData()
        {
            using (SqlCommand cmd = new SqlCommand("ShowTransition", Dbcon.GetCon()))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                Dbcon.OpenCon();
                transition.DataSource = cmd.ExecuteReader();
                transition.DataBind();
                Dbcon.CloseCon();
            }
        }

        private void clearData()
        {
            txtbookid.Text = string.Empty;
            txtusername.Text = string.Empty;
            txtissuedate.Text = string.Empty;
            txtduedate.Text = string.Empty;
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (getMemberName() && getBookName())
                {
                    IsExistTransaction();

                }
                else
                {
                    //lblerror1.Text = "Enter a valid Book And Username";
                }
            }
        }
        private bool getBookName()
        {
            using (SqlCommand cmd = new SqlCommand("SELECT Title FROM Books WHERE  BookID = @bookId and  @bookId not in(select DelUID where DelUID is Not null) ", Dbcon.GetCon()))
            {
                cmd.Parameters.AddWithValue("@bookId", txtbookid.Text);
                DataTable Dtt = Dbcon.Load_Data(cmd);
                if (Dtt.Rows.Count >= 1)
                {

                    return true;
                }
                else
                {
                    lblbookid.Text = "Enter a valid BookID";
                    return false;
                }
            }
        }

        private bool getMemberName()
        {
            using (SqlCommand cmd = new SqlCommand("SELECT Username FROM Users WHERE Username = @UserName", Dbcon.GetCon()))
            {
                cmd.Parameters.AddWithValue("@UserName", txtusername.Text.Trim());
                DataTable Dtt = Dbcon.Load_Data(cmd);
                if (Dtt.Rows.Count >= 1)
                {

                    return true;
                }
                else
                {
                    lblusername.Text = "Enter a valid Username";
                    return false;
                }
            }
        }

        private void IsExistTransaction()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("SELECT IssueDate, DueDate FROM [Transaction] WHERE BookID = @BookID AND UserName = @UserName AND IsSubmited = 0;", Dbcon.GetCon()))
                {
                    cmd.Parameters.AddWithValue("@BookID", txtbookid.Text);
                    cmd.Parameters.AddWithValue("@UserName", txtusername.Text);
                    Dbcon.OpenCon();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            DateTime issueDate = reader.GetDateTime(0);
                            DateTime dueDate = reader.GetDateTime(1);
                            txtissuedate.Text = issueDate.ToString("yyyy-MM-dd");
                            txtduedate.Text = dueDate.ToString("yyyy-MM-dd");
                            btnissue.Visible = false;

                        }
                        else
                        {
                            lblerror1.Text = "No active transaction found for this book and user.";
                            txtissuedate.Text = string.Empty;
                            txtduedate.Text = string.Empty;
                            btnissue.Visible = true;
                        }
                    }
                    Dbcon.CloseCon();
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                Dbcon.CloseCon();
            }
        }


        protected void btnissue_Click(object sender, EventArgs e)
        {
            if (IsBookExist() && IsUserExist())
            {
                if (IsIssueEntryExistornot())
                {
                    Response.Write("<script>alert('This member already has this book.');</script>");
                }
                else
                {
                    if (CheckAvailableStock())
                    {
                        issueBook();
                    }
                }
            }
            else
            {
                Response.Write("<script>alert('Wrong Book ID or Username');</script>");
            }
        }

        private bool CheckAvailableStock()
        {
            bool isAvailable = false;

            using (SqlCommand cmd = new SqlCommand("SELECT Quantity FROM Books WHERE BookId = @BookId", Dbcon.GetCon()))
            {
                cmd.Parameters.AddWithValue("@BookId", txtbookid.Text);

                Dbcon.OpenCon();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int quantity = reader.GetInt32(0);
                        if (quantity > 0)
                        {
                            isAvailable = true;
                        }
                        else
                        {
                            lblbookid.Text = "Book is out of stock";
                        }
                    }
                }
                Dbcon.CloseCon();
            }

            return isAvailable;
        }

        private void issueBook()
        {
            using (SqlCommand cmd = new SqlCommand("sp_IssueBook", Dbcon.GetCon()))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", txtusername.Text.Trim());
                cmd.Parameters.AddWithValue("@BookId", txtbookid.Text.Trim());
                cmd.Parameters.AddWithValue("@IssueDate", txtissuedate.Text.Trim());
                cmd.Parameters.AddWithValue("@DueDate", txtduedate.Text.Trim());

                Dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                Dbcon.CloseCon();
                GetData();
                clearData();
            }
        }

        private bool IsIssueEntryExistornot()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("sp_IsIssueEntryExistornot", Dbcon.GetCon()))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", txtusername.Text);
                    cmd.Parameters.AddWithValue("@BookId", txtbookid.Text);

                    Dbcon.OpenCon();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
               
                lblError.Text = "Error: " + ex.Message;
                return false;
            }
            finally
            {
                Dbcon.CloseCon();
            }
        }
        private bool IsBookExist()
        {
            using (SqlCommand cmd = new SqlCommand("sp_checkbookstock", Dbcon.GetCon()))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@bookid", txtbookid.Text.Trim());
                DataTable dtt = Dbcon.Load_Data(cmd);
                return dtt.Rows.Count >= 1;
            }
        }

        private bool IsUserExist()
        {
            using (SqlCommand cmd = new SqlCommand("sp_checkIsUserExist", Dbcon.GetCon()))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", txtusername.Text.Trim());

                Dbcon.OpenCon();
                object result = cmd.ExecuteScalar();
                Dbcon.CloseCon();

                return Convert.ToInt32(result) == 1;
            }
        }


        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            if (IsIssueEntryExistornot())
            {
                try
                {

                    using (SqlCommand cmd = new SqlCommand("sp_returnbook", Dbcon.GetCon()))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Username", txtusername.Text);
                        cmd.Parameters.AddWithValue("@BookId", txtbookid.Text);

                        SqlParameter fineParameter = new SqlParameter("@Fine", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(fineParameter);

                        Dbcon.OpenCon();
                        cmd.ExecuteNonQuery();

                        int Fine = (int)fineParameter.Value;
                        if (Fine > 0)
                        {
                            Response.Write($"<script>alert('Applicable fine on this user = {Fine}');</script>");
                        }
                        else
                        {

                        }
                    }

                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                }
                finally
                {
                    Dbcon.CloseCon();
                    btnissue.Visible = true;
                }

                GetData();
                clearData();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('User dont have this Book');", true);
            }

        }


        private void UpdateFine()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("calcFine", Dbcon.GetCon()))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    Dbcon.OpenCon();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
            finally
            {
                Dbcon.CloseCon();
            }
        }
    }
}
