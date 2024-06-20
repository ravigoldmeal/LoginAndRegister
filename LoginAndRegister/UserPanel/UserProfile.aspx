<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/User.Master" AutoEventWireup="true" UnobtrusiveValidationMode="none" CodeBehind="UserProfile.aspx.cs" Inherits="LoginAndRegister.UserPanel.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript">
      function validateInput(event) {
          var input = event.target;
          var value = input.value;
          input.value = value.replace(/[^a-zA-Z]/g, '');
          if (input.value.length > 20) {
              input.value = input.value.slice(0, 20);
          }
      }
      function validateMobileNo(event) {
          var input = event.target;
          var value = input.value;
          input.value = value.replace(/[^0-9]/g, '');
          if (input.value.length > 10) {
              input.value = input.value.slice(0, 10);
          }
      }
      function validatemaxlength12(event) {
          var input = event.target;
          var value = input.value;
  
          if (input.value.length > 12) {
              input.value = input.value.slice(0, 12);
          }
      }
      function validatemaxlength15(event) {
          var input = event.target;
          var value = input.value;
        
          if (input.value.length > 15) {
              input.value = input.value.slice(0, 15);
          }
      }
      function validatemaxlength50(event) {
          var input = event.target;
          var value = input.value;
   
          if (input.value.length > 50) {
              input.value = input.value.slice(0, 50);
          }
      }

  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Update Password</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"></span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="txtpassword" onInput="validatemaxlength15(event)" runat="server" CssClass="form-control border-0 shadow" TextMode="Password" placeholder="Enter new Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpassword" ErrorMessage="Enter password"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please Enter password in a Valid Format" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$" ControlToValidate="txtpassword"></asp:RegularExpressionValidator>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnsavechanges" runat="server" CssClass="btn btn-primary" Text="update" OnClick="btnsavechanges_Click" />
                </div>
            </div>
        </div>
    </div>



    <div class="card shadow border-0 mt-4">

        <div class="card-header bg-secondary bg-gradient mt-0 py-3">
            <div class="row">
                <div class="col-12 text-center">
                    <h2 class="text-white py-2">Update User's Profile </h2>
                </div>
            </div>
        </div>

        <div class="card-body p-4">

            <div class="row">
                <div class="col-10">
                    <div class="border p-3">
                        <asp:Label ID="lblinserterror" runat="server" Text=""></asp:Label>
                        <div class="row">
                            <div class="form-floating py-2 col-5">
                                <asp:TextBox runat="server" ID="txtname" onInput="validateInput(event)" CssClass="form-control border-0 shadow"></asp:TextBox>
                                <label class="control-label mb-3">Name</label>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationGroup="Update" ValidationExpression="^([A-Za-z]{1,25}|[A-Za-z]{1,12} [A-Za-z]{1,12})$"
                                    ControlToValidate="txtname" Display="Dynamic" ForeColor="red" ErrorMessage="Enter in valid formate"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required title" ValidationGroup="Update" ControlToValidate="txtname" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-floating py-2 ml-3 col-5">
                                <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control border-0 shadow"></asp:TextBox>
                                <label class="control-label mb-3">Address</label>
                            </div>
                        </div>
                        <div class="row">

                            <div class="form-floating py-2 col-5">
                                <asp:TextBox runat="server" CssClass="form-control border-0 shadow" onInput="validatemaxlength15(event)" ID="txtcity"></asp:TextBox>
                                <label class="control-label mb-3">City</label>

                            </div>
                            <div class="form-floating py-2 ml-3 col-5">
                                <asp:TextBox runat="server" CssClass="form-control border-0 shadow" ID="txtmobileno" ReadOnly="true"></asp:TextBox>
                                <label class="control-label mb-3">Mobile No.</label>

                            </div>
                        </div>
                        <div class="row">
                            <div class="form-floating py-2 col-5">
                                <asp:TextBox runat="server" CssClass="form-control border-0 shadow" ID="txtemail" ReadOnly="true"></asp:TextBox>
                                <label class="control-label mb-3">EmailID</label>

                            </div>

                            <div class="form-floating py-2 ml-3 col-5">
                                <asp:TextBox runat="server" CssClass="form-control border-0 shadow" ID="txtusername" ReadOnly="true"></asp:TextBox>
                                <label class="control-label mb-3">Username</label>

                            </div>
                        </div>
                        <div class="row">
                        </div>
                        <div class="form-floating py-2 col-5">
                            <asp:TextBox runat="server" CssClass="form-control border-0 shadow" ID="txtdob" TextMode="Date" ReadOnly="true"></asp:TextBox>
                            <label class="control-label mb-3">DOB</label>
                        </div>
                        <asp:Button ID="btnupdate" runat="server" OnClick="btnupdate_Click" ValidationGroup="Update" CssClass="btn btn-primary ml-3" Text="Update" />
                     
                        <button type="button" class="btn btn-primary" data-toggle="modal"  data-target="#exampleModalLong">
                            Create New Password
                        </button>


                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
