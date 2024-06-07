using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Security;
using System.Web.UI;

using System.Web.UI.WebControls;

namespace LoginAndRegister
{
   
    public partial class Home : System.Web.UI.Page
    {

        DBConnect dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getData();
              getUserStatus();

            }

        }
        
       private void getUserStatus()
        {
            SqlCommand cmd = new SqlCommand("Userstatus", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter totalactive  = new SqlParameter("@ActiveUsersCount" , SqlDbType.Int);
            totalactive.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalactive);
            SqlParameter totalinactive = new SqlParameter("@InactiveUsersCount",SqlDbType.Int);
            totalinactive.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalinactive);
            SqlParameter totalusers = new SqlParameter("@TotalUsersCount", SqlDbType.Int);
            totalusers.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalusers);

            dbcon.OpenCon();
            empgrid.DataSource = cmd.ExecuteReader();
            lblTotalactive.Text = totalactive.Value.ToString();
            lblTotalinactive.Text = totalinactive.Value.ToString();
            lblTotalusers.Text = totalusers.Value.ToString();
           

            dbcon.CloseCon();

        }
        private void getData()
        {
            SqlCommand cmd = new SqlCommand("UserData", dbcon.GetCon());
            cmd.CommandType= CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Username", User.Identity.Name);
            dbcon.OpenCon();
            empgrid.DataSource = cmd.ExecuteReader();
            empgrid.DataBind();

            dbcon.CloseCon();
        }
   
        protected void empgrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(empgrid.DataKeys[e.RowIndex].Value);

            try
            {
                SqlCommand cmd = new SqlCommand("DeleteUser", dbcon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SlNo", id);
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();


            }
            catch (Exception ex)
            {

                lblinfo.Text = "An error occurred: " + ex.Message;
            }
            finally
            {
                dbcon.CloseCon();
                getData();
                getUserStatus();

                lblinfo.Text = "Record Deleted";
            }
        }


        protected void empgrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            empgrid.EditIndex = e.NewEditIndex;
            getData();
            
            //// Find the DropDownList control in edit mode
            //DropDownList ddlGender = empgrid.Rows[e.NewEditIndex].FindControl("ddlGender") as DropDownList;
            //if (ddlGender != null)
            //{
            //    // Retrieve the current gender value from the Label control
            //    Label lblGender = empgrid.Rows[e.NewEditIndex].FindControl("lblGender") as Label;
            //    if (lblGender != null)
            //    {
            //        string genderValue = lblGender.Text;
            //        // Set the selected value of the DropDownList
            //        ddlGender.SelectedValue = genderValue;
            //    }
            //}
        }


        protected void empgrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            empgrid.EditIndex = -1;
            getData();
        }

        protected void empgrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("UpdateUserData", dbcon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@SlNo", empgrid.DataKeys[e.RowIndex].Value);
                cmd.Parameters.AddWithValue("@Name", (empgrid.Rows[e.RowIndex].FindControl("txtName") as TextBox).Text);
                cmd.Parameters.AddWithValue("@Address", (empgrid.Rows[e.RowIndex].FindControl("txtAddress") as TextBox).Text);
                cmd.Parameters.AddWithValue("@City", (empgrid.Rows[e.RowIndex].FindControl("txtCity") as TextBox).Text);
                cmd.Parameters.AddWithValue("@MobileNo", (empgrid.Rows[e.RowIndex].FindControl("txtmobile") as TextBox).Text);
                cmd.Parameters.AddWithValue("@Email", (empgrid.Rows[e.RowIndex].FindControl("txtEmail") as TextBox).Text);
                cmd.Parameters.AddWithValue("@UserType", (empgrid.Rows[e.RowIndex].FindControl("userType") as DropDownList).SelectedValue);
                cmd.Parameters.AddWithValue("@Gender", (empgrid.Rows[e.RowIndex].FindControl("ddlGender") as DropDownList).SelectedValue);
                cmd.Parameters.AddWithValue("@DateOfBirth", (empgrid.Rows[e.RowIndex].FindControl("dob") as TextBox).Text);
                cmd.Parameters.AddWithValue("@IsActive", (empgrid.Rows[e.RowIndex].FindControl("isActive") as CheckBox).Checked ? 1 : 0);
                cmd.Parameters.AddWithValue("@Username", (empgrid.Rows[e.RowIndex].FindControl("txtUsername") as TextBox).Text);
     

                dbcon.OpenCon();
                cmd.ExecuteNonQuery();

                lblinfo.Text = "Record updated";
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2601 || ex.Number == 2627)
                {
                    
                    string duplicateColumn = "";
                    string[] duplicateColumns = { "Email", "MobileNo", "Username" };

                    foreach (string column in duplicateColumns)
                    {
                        if (ex.Message.Contains(column))
                        {
                            duplicateColumn = column;
                            break;
                        }
                    }

                    lblinfo.Text = $"Duplicate entry error: The value for {duplicateColumn} already exists. Please ensure it is unique.";
                }
                else
                {
                    lblinfo.Text = "An error occurred: " + ex.Message;
                }
            }

            finally
            {
                dbcon.CloseCon();
                empgrid.EditIndex = -1;
                getData();
                getUserStatus();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("Login Page.aspx");
        }
    }
}