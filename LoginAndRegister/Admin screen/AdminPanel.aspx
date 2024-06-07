<%@ Page Title="UserManagement" Language="C#" MasterPageFile="~/Admin screen/AdminMaster.Master" UnobtrusiveValidationMode="none" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="LoginAndRegister.Admin_screen.AdminPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:Label runat="server" Text="" ID="lblinfo"></asp:Label>

        <div class="card" style="flex-direction: row">
            <div class="card text-white bg-primary mb-3" style="width: 25%; margin-right: 10px;">
                <div class="card-body">
                    <h5 class="card-title">Total Active Users</h5>
                    <p class="card-text">
                        <asp:Label ID="lblTotalactive" runat="server" Text=""></asp:Label>
                    </p>
                </div>
            </div>
            <div class="card text-white bg-secondary mb-3" style="width: 25%; margin-right: 10px; margin-left: 10px;">
                <div class="card-body">
                    <h5 class="card-title">Total InActive Users</h5>
                    <p class="card-text">
                        <asp:Label ID="lblTotalinactive" runat="server" Text=""></asp:Label>
                    </p>
                </div>
            </div>
            <div class="card text-white bg-success mb-3" style="width: 25%; margin-left: 10px;">
                <div class="card-body">
                    <h5 class="card-title">Total Users</h5>
                    <p class="card-text">
                        <asp:Label ID="lblTotalusers" runat="server" Text=""></asp:Label>
                    </p>
                </div>
            </div>
        </div>

        <div>
            <div class="card shadow border-0 mt-4">

                <div class="card-header bg-secondary bg-gradient mt-0 py-3">
                    <div class="row">
                        <div class="col-12 text-center">
                            <h2 class="text-white py-2">User Details</h2>
                        </div>
                    </div>
                </div>

                <div class="card-body p-4">

                    <div class="row">
                        <div class="col-10">
                            <div class="border p-3">
                                <asp:Label ID="lblinserterror" runat="server" Text=""></asp:Label>

                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <asp:TextBox runat="server" ID="txtName" CssClass="form-control border-0 shadow"></asp:TextBox>
                                        <label class="control-label mb-3">Name</label>

                                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator1" 
                                            ControlToValidate="txtname" ForeColor="Red" Display="Dynamic" ValidationGroup="update" EnableViewState="False">
                                        </asp:RequiredFieldValidator>
                                      
                                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter Valid Name" Display="Dynamic" ControlToValidate="txtname"
                                            ID="RegularExpressionValidator2" ValidationGroup="update" ForeColor="#0066FF" 
                                            ValidationExpression="^(?:[A-Za-z]{1,30})(?: [A-Za-z]{1,30})?$"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="col-md-6">
                                        <asp:TextBox runat="server" CssClass="form-control border-0 shadow" TextMode="Number" ID="txtmobile"></asp:TextBox>
                                        <label class="control-label mb-3">MobileNo</label>

                                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator6" ControlToValidate="txtmobile" 
                                            ForeColor="Red" Display="Dynamic" ValidationGroup="update" EnableViewState="False"></asp:RequiredFieldValidator>

                                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter Valid Number" Display="Dynamic" ControlToValidate="txtmobile" 
                                            ID="RegularExpressionValidator3" ForeColor="#0066FF" ValidationExpression="^[6-9]\d{9}$" ValidationGroup="update">

                                        </asp:RegularExpressionValidator><asp:Label runat="server" ID="Label1" Text=""></asp:Label>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-6">
                                        <asp:TextBox runat="server" ID="txtemail" CssClass="form-control border-0 shadow"></asp:TextBox>
                                        <label class="control-label mb-3">Email ID</label>

                                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator3" ControlToValidate="txtemail" 
                                            ForeColor="Red" Display="Dynamic" ValidationGroup="update"></asp:RequiredFieldValidator>

                                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter Valid Email" Display="Dynamic" ControlToValidate="txtemail"
                                            ID="valemail" ForeColor="#0066FF" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="update">
                                        </asp:RegularExpressionValidator><asp:Label runat="server" ID="libEmailid" Text=""></asp:Label>
                                    </div>

                                    <div class="col-md-6">
                                        <asp:TextBox runat="server" ID="txtcity" CssClass="form-control border-0 shadow"></asp:TextBox>
                                        <label class="control-label mb-3">City</label>
                                    </div>
                                </div>
                                <div class="form-floating py-2 col-12">
                                    <asp:TextBox runat="server" ID="txtAddres" CssClass="form-control border-0 shadow"></asp:TextBox>
                                    <label class="control-label mb-3">Address</label>
                                </div>
                                <div class="row ">
                                    <div class="col-md-4">
                                        <asp:DropDownList ID="userType" runat="server" DataTextField="Text" DataValueField="Value">
                                            <asp:ListItem Text="Select User Type" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                                            <asp:ListItem Text="User" Value="User"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator4" ControlToValidate="userType"
                                            ForeColor="Red" Display="Dynamic" ValidationGroup="update"></asp:RequiredFieldValidator>

                                        <label class="control-label mb-3">User Type</label>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-inline" ValidationGroup="update" />
                                        <label class="control-label mb-3">IsActive</label>


                                    </div>
                                    <div class="col-md-4">
                                        <asp:RadioButtonList ID="btngender" runat="server" CssClass="form-check-inline" RepeatDirection="Horizontal" ValidationGroup="update">
                                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>

                                </div>
                                <div class="row pt-2">
                                    <div class="col-6 col-md-3">
                                        <asp:Button ID="btnUpd" runat="server" Text="Update" ValidationGroup="update" class="btn btn-success" OnClick="btnUpd_Click" />
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-outline-secondary border form-control" OnClick="btnCancel_Click" />

                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>


        <div class="col-md-8 col-md-offset-2">
            <asp:GridView ID="empgrid" runat="server" Class="table table-hover"
                AutoGenerateColumns="false" DataKeyNames="SlNo"
                OnRowCommand="empgrid_RowCommand" OnSelectedIndexChanged="empgrid_SelectedIndexChanged" OnRowDeleting="empgrid_RowDeleting">
                <Columns>
                    <asp:TemplateField HeaderText="Remove">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Delete" CommandArgument='<%# Eval("SlNo") %>'
                                Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?');"
                                CssClass="btn btn-danger" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowSelectButton="true" SelectText="Edit" HeaderText="Update" ControlStyle-CssClass="btn btn-success" />
                    <asp:BoundField HeaderText="SlNo" DataField="SlNo" ReadOnly="true" />
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Address">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("City") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MobileNo">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("EmailId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gender">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblGender" Text='<%# Eval("Gender") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="UserType">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("UserType") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DateOfBirth">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("DateOfBirth ","{0:d}")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Is Active">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Username">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Username") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Password" DataField="Password" ReadOnly="true" />
                    <asp:BoundField HeaderText="CreateUID" DataField="CreateUID" ReadOnly="true" />
                    <asp:BoundField HeaderText="CreateDt" DataField="CreateDt" ReadOnly="true" />
                    <asp:BoundField HeaderText="LModifyUID" DataField="LModifyUID" ReadOnly="true" />
                    <asp:BoundField HeaderText="LModifyDt" DataField="LModifyDt" ReadOnly="true" />
                    <asp:BoundField HeaderText="DelUID" DataField="DelUID" ReadOnly="true" />
                    <asp:BoundField HeaderText="DelDt" DataField="DelDt" ReadOnly="true" />
                    <asp:BoundField HeaderText="LogNo" DataField="LogNo" ReadOnly="true" />
                    <asp:BoundField HeaderText="UniqueKey" DataField="UniqueKey" ReadOnly="true" />
                </Columns>
            </asp:GridView>
        </div>



    </div>


</asp:Content>





<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="LoginAndRegister.Admin_screen.AdminPanel" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>

<body style="background-color: antiquewhite">
    <form id="form1" runat="server">
   
    
    </form>
</body>
</html>--%>
