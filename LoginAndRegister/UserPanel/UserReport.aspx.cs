using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoginAndRegister.UserPanel
{
    [Authorize]
    public partial class UserReport : System.Web.UI.Page
    {
        DBConnect Dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();
                GetUserBookStats();
                UpdateFine();
            }
        }
        private void GetData()
        {
            SqlCommand cmd = new SqlCommand("SELECT Username, BookId, BookName,DueDate, IsSubmited, Fine FROM [Transaction] WHERE Username = @username order by IsSubmited ", Dbcon.GetCon());

            cmd.Parameters.AddWithValue("@username", HttpContext.Current.User.Identity.Name);
            Dbcon.OpenCon();
            ubookrecord.DataSource = cmd.ExecuteReader();
            ubookrecord.DataBind();
            Dbcon.CloseCon();
        }

        private void GetUserBookStats()
        {

            SqlCommand cmd = new SqlCommand("GetUserBookStats", Dbcon.GetCon());

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@username", HttpContext.Current.User.Identity.Name);
            SqlParameter totalBooksTakenParam = new SqlParameter("@totalBooksTaken", SqlDbType.Int);
            totalBooksTakenParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalBooksTakenParam);

            SqlParameter totalFinePaidParam = new SqlParameter("@totalFinePaid", SqlDbType.Decimal);
            totalFinePaidParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(totalFinePaidParam);

            SqlParameter pendingFineParam = new SqlParameter("@pendingFine", SqlDbType.Decimal);
            pendingFineParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(pendingFineParam);

            Dbcon.OpenCon();

            try
            {

                cmd.ExecuteNonQuery();
                lbltotalbooks.Text = cmd.Parameters["@totalBooksTaken"].Value.ToString();
                lblpaidfine.Text = cmd.Parameters["@totalFinePaid"].Value.ToString();
                lblpendingfine.Text = cmd.Parameters["@pendingFine"].Value.ToString();
            }
            catch (Exception ex)
            {

                throw;
            }
            finally
            {
                Dbcon.CloseCon();
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