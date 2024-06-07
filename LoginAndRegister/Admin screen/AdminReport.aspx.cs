using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace LoginAndRegister.Admin_screen
{
    [Authorize]
    public partial class WebForm3 : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();
                getRequestReport();
                GetUserBookStats();
            }

        }
        private void getRequestReport()
        {
            SqlCommand cmd = new SqlCommand("Request_Status", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter totalApproved = new SqlParameter("@TotalApproved", SqlDbType.Int);
            totalApproved.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalApproved);

            SqlParameter totalRejected = new SqlParameter("@TotalRejected", SqlDbType.Int);
            totalRejected.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalRejected);

            SqlParameter totalRequests = new SqlParameter("@TotalRequests", SqlDbType.Int);
            totalRequests.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalRequests);

            dbcon.OpenCon();
            try
            {
                cmd.ExecuteNonQuery();

                
                lblApprovedrequests.Text = totalApproved.Value.ToString();
                lblrejectedrequests.Text = totalRejected.Value.ToString();
                lbltotalrequests.Text = totalRequests.Value.ToString();
            }
            catch (SqlException ex)
            {
             
                Response.Write("SQL Error: " + ex.Message);
            }
            finally
            {
                dbcon.CloseCon();
            }
        }
        private void GetData()
        {
            SqlCommand cmd = new SqlCommand("select r.Sino, r.BookID, u.Username ,r.RequestDate from BookRequests as r join Users as u on  u.SlNo = r.UserId where status='pending'", dbcon.GetCon());
            dbcon.OpenCon();
            bookrequest.DataSource = cmd.ExecuteReader();
            bookrequest.DataBind();
            dbcon.CloseCon();
            
        }
        protected void bookgrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            int Sino = Convert.ToInt32(bookrequest.DataKeys[bookrequest.SelectedIndex].Value);
            SqlCommand cmd = new SqlCommand("Approve_request",dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Sino", Sino);
            dbcon.OpenCon();
            cmd.ExecuteNonQuery();
            dbcon.CloseCon();
            string script = "showToast();";
            ClientScript.RegisterStartupScript(this.GetType(), "showToastScript", script, true);
            GetData();
        }



        protected void bookgrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int Sino = Convert.ToInt32(bookrequest.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("Reject_request", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Sino", Sino);
            dbcon.OpenCon();
            cmd.ExecuteNonQuery();
            dbcon.CloseCon();
            string script = "showErrorToast();";
            ClientScript.RegisterStartupScript(this.GetType(), "showToastScript", script, true);
            GetData();
        }
        private void GetUserBookStats()
        {

            SqlCommand cmd = new SqlCommand("GetFineStatus", dbcon.GetCon());

            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter totalFineCollected = new SqlParameter("@totalFineCollected", SqlDbType.Decimal);
            totalFineCollected.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalFineCollected);

            SqlParameter pendingFineParam = new SqlParameter("@pendingFine", SqlDbType.Decimal);
            pendingFineParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(pendingFineParam);

            dbcon.OpenCon();

            try
            {

                cmd.ExecuteNonQuery();
          
                lblpaidfine.Text = cmd.Parameters["@totalFineCollected"].Value.ToString();
                lblpendingfine.Text = cmd.Parameters["@pendingFine"].Value.ToString();
            }
            catch (Exception ex)
            {

                throw;
            }
            finally
            {
                dbcon.CloseCon();
            }

        }
    }
}