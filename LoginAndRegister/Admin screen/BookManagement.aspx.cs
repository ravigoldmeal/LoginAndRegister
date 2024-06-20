using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using Microsoft.AspNetCore.Authorization;

namespace LoginAndRegister.Admin_screen
{
    [Authorize]
    public partial class BookManagement : System.Web.UI.Page
    {

        DBConnect Dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GetData();
                getBookStatus();
            }


        }
        protected void GetData()
        {
            SqlCommand cmd = new SqlCommand("select * from Books", Dbcon.GetCon());
        
            Dbcon.OpenCon();

            bookgrid.DataSource = cmd.ExecuteReader();
            bookgrid.DataBind();

            Dbcon.CloseCon();

        }
        private void getBookStatus()
        {
            SqlCommand cmd = new SqlCommand("Booksstatus", Dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter popularbooks = new SqlParameter("@PopularBooks", SqlDbType.Int);
            popularbooks.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(popularbooks);
            SqlParameter reguarbooks = new SqlParameter("@RegularBooks", SqlDbType.Int);
            reguarbooks.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(reguarbooks);
            SqlParameter totalbooks = new SqlParameter("@TotalBooks", SqlDbType.Int);
            totalbooks.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalbooks);

            Dbcon.OpenCon();
            cmd.ExecuteReader();
            Dbcon.CloseCon();
            lblpopularbooks.Text = popularbooks.Value.ToString();
            lblreguarbooks.Text = reguarbooks.Value.ToString();
            lbltotalbooks.Text = totalbooks.Value.ToString();
        

        }


        protected void btnUpd_Click(object sender, EventArgs e)
        {


            if (ViewState["BookID"] != null)
            {
                string title = TextBox1.Text;
                string author = TextBox2.Text;
                string genre = TextBox3.Text;
                string publicationDate = TextBox4.Text;
                bool isPopular = CheckBox1.Checked;
                int rackNo = int.Parse(DropDownList1.SelectedValue);
                string quantity = TextBox5.Text;
                string maximumDays = TextBox6.Text;

                int bookId = (int)ViewState["BookID"];

                SqlCommand cmd = new SqlCommand("UpdateBookData", Dbcon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@BookID", bookId);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Author", author);
                cmd.Parameters.AddWithValue("@Genre", genre);
                cmd.Parameters.AddWithValue("@PublicationDate", publicationDate);
                cmd.Parameters.AddWithValue("@IsPopular", isPopular);
                cmd.Parameters.AddWithValue("@RackNo", rackNo);

                //FileUpload bookimage = FindControl("FileUpload1") as FileUpload;
                if (FileUpload1.HasFile)
                {
                    string fileName = Path.GetFileName(FileUpload1.FileName);
                    string uniqueFileName = Guid.NewGuid().ToString() + Path.GetExtension(fileName);
                    string filePath = Server.MapPath("~/Uploads/" + uniqueFileName);
                    FileUpload1.SaveAs(filePath);
                    cmd.Parameters.AddWithValue("@BookImage", uniqueFileName);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@BookImage", GetExistingBookImage(bookId));
                }

                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@MaximumDays", maximumDays);

                Dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                Dbcon.CloseCon();
                GetData();
                ViewState.Clear();
                clearData();
            }



        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
         
            ViewState.Clear();
            clearData();

        }
        private void clearData()
        {
          
            TextBox1.Text = string.Empty;
            TextBox2.Text = string.Empty;
            TextBox3.Text = string.Empty;
            TextBox4.Text = string.Empty;
            TextBox5.Text = string.Empty;
            TextBox6.Text = string.Empty;
            DropDownList1.ClearSelection();
            CheckBox1.Checked = false;

           
            Image1.ImageUrl = string.Empty;

        }

        private string GetExistingBookImage(int bookId)
        {
            string existingImage = string.Empty;

            using (SqlCommand cmd = new SqlCommand("select BookImage from Books where BookId = @BookId", Dbcon.GetCon()))
            {
                cmd.Parameters.AddWithValue("@BookId", bookId);

                Dbcon.OpenCon();
                existingImage = cmd.ExecuteScalar() as string;
                Dbcon.CloseCon();
            }

            return existingImage;
        }


        protected void bookgrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            try
            {
                int id = Convert.ToInt32(bookgrid.DataKeys[e.RowIndex].Value);
                SqlCommand cmd = new SqlCommand("DeleteBook", Dbcon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@BookID", id);
                Dbcon.OpenCon();
                cmd.ExecuteNonQuery();
            }
            catch
            {

            }
            finally
            {
                Dbcon.CloseCon();
            }

        }

        protected void bookgrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = bookgrid.SelectedRow;
            int selectedBookID = Convert.ToInt32(bookgrid.DataKeys[row.RowIndex].Value);

            ViewState["BookID"] = selectedBookID;
            string query = "SELECT * FROM Books WHERE BookID = @BookID";
            SqlDataAdapter da = new SqlDataAdapter(query, Dbcon.GetCon());
            da.SelectCommand.Parameters.AddWithValue("@BookID", selectedBookID);

            DataSet ds = new DataSet();
            da.Fill(ds, "book");

            if (ds.Tables.Count > 0)
            {
                DataTable dt = ds.Tables["book"];


                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];

                    TextBox1.Text = dr["Title"].ToString();
                    TextBox2.Text = dr["Author"].ToString();
                    TextBox3.Text = dr["Genre"].ToString();
                    DateTime publicationDate;
                    if (DateTime.TryParse(dr["PublicationDate"].ToString(), out publicationDate))
                    {
                        TextBox4.Text = publicationDate.ToString("yyyy-MM-dd");
                    }
                    CheckBox1.Checked = (bool)dr["IsPopular"];
                    DropDownList1.SelectedValue = dr["RackNo"].ToString();
                    TextBox5.Text = dr["Quantity"].ToString();
                    TextBox6.Text = dr["MaximumDays"].ToString();
                    Image1.ImageUrl = ResolveUrl("~/Uploads/" + dr["BookImage"].ToString());
                }
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {

                SqlCommand command = new SqlCommand("InsertBook", Dbcon.GetCon());
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Title", TextBox1.Text);
                command.Parameters.AddWithValue("@Author", TextBox2.Text);
                command.Parameters.AddWithValue("@Genre", TextBox3.Text);
                command.Parameters.AddWithValue("@PublicationDate", TextBox4.Text);
                command.Parameters.AddWithValue("@IsPopular", CheckBox1.Checked);
                command.Parameters.AddWithValue("@RackNo", DropDownList1.SelectedValue);

                if (FileUpload1.HasFile)
                {
                    string fileName = Path.GetFileName(FileUpload1.FileName);
                    string uniqueFileName = Guid.NewGuid().ToString() + Path.GetExtension(fileName);
                    string filePath = Server.MapPath("~/Uploads/" + uniqueFileName);
                    FileUpload1.SaveAs(filePath);
                    command.Parameters.AddWithValue("@BookImage", uniqueFileName); 
                }


                command.Parameters.AddWithValue("@Quantity", TextBox5.Text);
                command.Parameters.AddWithValue("@MaximumDays", TextBox6.Text);

                Dbcon.OpenCon();
                command.ExecuteNonQuery();
                clearData();
                GetData();
            }
            catch (SqlException ex)
            {
                lblinserterror.Text = ex.Message;
            }
            finally
            {
                Dbcon.CloseCon();
            }
        }

    

        protected void btndelete_Click(object sender, EventArgs e)
        {
            
            try
            {
                LinkButton btn = (LinkButton)sender;
                int id = Convert.ToInt32(btn.CommandArgument);

                if (IsBookDeleted(id))
                {
                    SqlCommand cmd = new SqlCommand("DeleteBook", Dbcon.GetCon());
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BookID", id);
                    Dbcon.OpenCon();
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Book Already Deleted');", true);
                }
             
            }
            catch (Exception ex) 
            {
                Console.WriteLine(ex.Message.ToString());
            }
            finally
            {
                Dbcon.CloseCon();
            }
        }
        private bool IsBookDeleted(int id)
        {
            SqlCommand cmd = new SqlCommand("Select BookId from Books where @id = DelUID", Dbcon.GetCon());
            cmd.Parameters.AddWithValue("@id", id);
            Dbcon.OpenCon();
            SqlDataReader reader = cmd.ExecuteReader();
            if(reader.HasRows)
            {
                Dbcon.CloseCon();
                reader.Close();

                return false;

            }
            else
            {
                Dbcon.CloseCon();
                reader.Close();

                return true;
            }
           
          
        }
    }
}