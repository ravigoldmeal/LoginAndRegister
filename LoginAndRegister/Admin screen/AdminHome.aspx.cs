using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoginAndRegister.Admin_screen
{
    [Authorize]
    public partial class WebForm1 : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<Book> books = GetBooksFromDatabase();
                ViewState["Books"] = books;
            }


        }
        public List<Book> GetBooksFromDatabase()
        {
            List<Book> books = new List<Book>();
            DBConnect dbcon = new DBConnect();

            try
            {
                using (SqlCommand cmd = new SqlCommand("ShowBooks", dbcon.GetCon()))
                {
                    dbcon.OpenCon();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Book book = new Book();
                            book.Title = reader["Title"].ToString();
                            book.Author = reader["Author"].ToString();
                            book.Genre = reader["Genre"].ToString();
                            book.PublicationDate = Convert.ToDateTime(reader["PublicationDate"]);
                            book.IsPopular = Convert.ToBoolean(reader["IsPopular"]);
                            book.RackNo = Convert.ToInt32(reader["RackNo"]);
                            book.BookImage = reader["BookImage"].ToString();
                            book.Quantity = Convert.ToInt32(reader["Quantity"]);
                            book.MaximumDays = Convert.ToInt32(reader["MaximumDays"]);

                            books.Add(book);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine("Error fetching books from database: " + ex.Message);
            }
            finally
            {
                dbcon.CloseCon();
            }

            return books;
        }
       
    }
}