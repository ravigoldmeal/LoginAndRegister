using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoginAndRegister.UserPanel
{
    [Authorize]
    public partial class UserHome : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<Book> books = GetBooksFromDatabase();
                BookRepeater.DataSource = books;
                BookRepeater.DataBind();
            }
        }

        public List<Book> GetBooksFromDatabase()
        {
            List<Book> books = new List<Book>();

            try
            {
                using (SqlConnection con = dbcon.GetCon())
                {
                    using (SqlCommand cmd = new SqlCommand("ShowBooks", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Book book = new Book
                                {
                                    BookID = Convert.ToInt32(reader["BookID"]),
                                    Title = reader["Title"].ToString(),
                                    Author = reader["Author"].ToString(),
                                    Genre = reader["Genre"].ToString(),
                                    PublicationDate = Convert.ToDateTime(reader["PublicationDate"]),
                                    IsPopular = Convert.ToBoolean(reader["IsPopular"]),
                                    RackNo = Convert.ToInt32(reader["RackNo"]),
                                    BookImage = reader["BookImage"].ToString(),
                                    Quantity = Convert.ToInt32(reader["Quantity"]),
                                    MaximumDays = Convert.ToInt32(reader["MaximumDays"])
                                };

                                books.Add(book);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine("Error fetching books from database: " + ex.Message);
            }

            return books;
        }

        //protected void btnRequest_Click(object sender, EventArgs e)
        //{
        //    LinkButton btnRequest = (LinkButton)sender;
        //    int bookId = Convert.ToInt32(btnRequest.CommandArgument);
        //    int userId = GetCurrentUserId();
        //    DateTime requestDate = DateTime.Now;
        //    string status = "Pending";


        //    try
        //    {


        //        SqlCommand cmd = new SqlCommand("INSERT INTO BookRequests (UserId, BookID, RequestDate, Status) VALUES (@UserId, @BookID, @RequestDate, @Status)", dbcon.GetCon());

        //        cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userId;
        //        cmd.Parameters.Add("@BookID", SqlDbType.Int).Value = bookId;
        //        cmd.Parameters.Add("@RequestDate", SqlDbType.DateTime).Value = requestDate;
        //        cmd.Parameters.Add("@Status", SqlDbType.NVarChar, 50).Value = status;

        //        dbcon.OpenCon();
        //        cmd.ExecuteNonQuery();




        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Book Request Submitted');", true);
        //    }
        //    catch (Exception ex)
        //    {

        //        Console.WriteLine("Error inserting request into database: " + ex.Message);


        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('There was an error submitting your request. Please try again later.');", true);
        //    }

        //}

        private bool IsBookAlreadytaken(int bookId)
        {
            DBConnect dbconn = new DBConnect();
            try
            {  
                int BookId = bookId;
                string username = HttpContext.Current.User.Identity.Name;

                SqlCommand cmd = new SqlCommand("select BookId  from [Transaction] where Username = @username and BookId = @BookId and IsSubmited = 0 ", dbconn.GetCon());
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@BookId", bookId);
                dbconn.OpenCon();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("An error occurred while checking the book status.", ex);
            }
            finally
            {
                dbconn.CloseCon();
            }
        }

        private int GetCurrentUserId()
        {
            int userId = -1;
            string username = HttpContext.Current.User.Identity.Name;

            try
            {
                using (SqlConnection con = dbcon.GetCon())
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT SlNo FROM users WHERE Username = @Username", con))
                    {
                        cmd.Parameters.Add("@Username", SqlDbType.NVarChar, 50).Value = username;

                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                userId = reader.GetInt32(0);
                            }
                        }
                        con.Close();
                    }
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine("Error fetching user ID: " + ex.Message);
            }

            if (userId == -1)
            {
                throw new Exception("User ID not found.");
            }

            return userId;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LinkButton btnRequest = (LinkButton)sender;
            int bookId = Convert.ToInt32(btnRequest.CommandArgument);
            int userId = GetCurrentUserId();
            DateTime requestDate = DateTime.Now;
            string status = "Pending";

            DBConnect dbconn = new DBConnect();
            if (IsBookAlreadytaken(bookId))
            {
                if (IsBookRequestSent(bookId))
                {
                    try
                    {
                        using (SqlConnection con = dbconn.GetCon())
                        {
                            using (SqlCommand cmd = new SqlCommand("InsertBookRequest", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@UserId", userId);
                                cmd.Parameters.AddWithValue("@BookId", bookId);
                                cmd.Parameters.AddWithValue("@Requestdate", requestDate);
                                cmd.Parameters.AddWithValue("@Status", status);

                                con.Open();
                                cmd.ExecuteNonQuery();
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Book Request Submitted');", true);
                            }
                        }
                    }
                    catch (Exception ex)
                    {

                        Console.WriteLine("Error inserting request into database: " + ex.Message);


                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('There was an error submitting your request. Please try again later.');", true);
                    }
                    finally
                    {
                        dbcon.CloseCon();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User Already sent book request');", true);
                }
            }

               
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User Already have this book');", true);
            }

        }

        private bool IsBookRequestSent(int bookId)
        {
            DBConnect dbconn = new DBConnect();
            try
            {
                int BookId = bookId;
                string username = HttpContext.Current.User.Identity.Name;

                SqlCommand cmd = new SqlCommand("IsBookRequestSent", dbconn.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@BookId", bookId);
                dbconn.OpenCon();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("An error occurred while checking the book status.", ex);
            }
            finally
            {
                dbconn.CloseCon();
            }
        }
    }
}
