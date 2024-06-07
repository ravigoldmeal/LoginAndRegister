using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNetCore.Authorization;
using System.Drawing;
using static System.Net.Mime.MediaTypeNames;

namespace LoginAndRegister.Admin_screen
{
    [Authorize]
    public partial class AdminPanel : System.Web.UI.Page
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

            SqlParameter totalactive = new SqlParameter("@ActiveUsersCount", SqlDbType.Int);
            totalactive.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalactive);
            SqlParameter totalinactive = new SqlParameter("@InactiveUsersCount", SqlDbType.Int);
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

            SqlCommand cmd = new SqlCommand("ShowDataForAdmin", dbcon.GetCon());
            dbcon.OpenCon();
            empgrid.DataSource = cmd.ExecuteReader();
            empgrid.DataBind();
            dbcon.CloseCon();

            getUserStatus();
        }
        protected void empgrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                if (IsUserActive(id))
                {
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
                        lblinfo.Text = "Record Deleted"; 
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User Already Deleted');", true);
                }
            }
        }

        private bool IsUserActive(int id)
        {
            SqlCommand cmd = new SqlCommand("Select Username from Users where IsActive = 1 and SlNo = @id", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@id", id);
            dbcon.OpenCon();
            SqlDataReader reader = cmd.ExecuteReader();
            bool isActive = reader.HasRows;
            reader.Close();
            dbcon.CloseCon();
            return isActive;
        }


        protected void empgrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = empgrid.SelectedRow;
            int selectedUserId = Convert.ToInt32(empgrid.DataKeys[row.RowIndex].Value);

            ViewState["SlNo"] = selectedUserId;
            string query = "SELECT * FROM Users WHERE SlNo = @SlNo";
            SqlDataAdapter da = new SqlDataAdapter(query, dbcon.GetCon());
            da.SelectCommand.Parameters.AddWithValue("@SlNo", selectedUserId);

            DataSet ds = new DataSet();
            da.Fill(ds, "user");

            if (ds.Tables.Count > 0)
            {
                DataTable dt = ds.Tables["user"];


                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];

                    txtName.Text = dr["Name"].ToString();
                    txtAddres.Text = dr["Address"].ToString();
                    txtcity.Text = dr["City"].ToString();
                    txtmobile.Text = dr["MobileNo"].ToString();
                    txtemail.Text = dr["EmailId"].ToString();
                    userType.SelectedValue = dr["UserType"].ToString();
                    btngender.SelectedValue = dr["Gender"].ToString() ;
                    chkIsActive.Checked = dr["IsActive"].ToString().Equals("True");

                }
            }

        }
        private void clearData()
        {
            txtName.Text = string.Empty;
            txtAddres.Text = string.Empty;
            txtcity.Text = string.Empty;
            txtmobile.Text = string.Empty;
            txtemail.Text = string.Empty;
            userType.ClearSelection();
            btngender.ClearSelection();
            chkIsActive.Checked = false;

        }

        protected void btnUpd_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("UpdateUserData", dbcon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@SlNo", (int)ViewState["SlNo"]);
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Address", txtAddres.Text);
                cmd.Parameters.AddWithValue("@City", txtcity.Text);
                cmd.Parameters.AddWithValue("@MobileNo", txtmobile.Text);
                cmd.Parameters.AddWithValue("@Email", txtemail.Text);
                cmd.Parameters.AddWithValue("@UserType", userType.SelectedValue);
                cmd.Parameters.AddWithValue("@Gender", btngender.SelectedValue);
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);

                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                lblinfo.Text = "Record updated";
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2601 || ex.Number == 2627)
                {

                    string duplicateColumn = "";
                    string[] duplicateColumns = { "Email", "MobileNo" };

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
                getData();
                clearData();
                ViewState.Clear();
               
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

            ViewState.Clear();
            clearData();

        }

        protected void empgrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
    }
}
    