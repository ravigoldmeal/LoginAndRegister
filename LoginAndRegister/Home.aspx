<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LoginAndRegister.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>

<body style="background-color:antiquewhite">
    <form id="form1" runat="server">
        <div>
            <asp:Label runat="server" Text="" ID="lblinfo"></asp:Label>

            <div class="card" style="flex-direction:row; background-color:antiquewhite"  >
                <div class="card text-white bg-primary mb-3" style="width:25% ;margin-right: 10px;">
                    <div class="card-body">
                        <h5 class="card-title">Total Active Users</h5>
                        <p class="card-text">
                            <asp:Label ID="lblTotalactive" runat="server" Text=""></asp:Label></p>
                    </div>
                </div>
                <div class="card text-white bg-secondary mb-3" style="width:25% ; margin-right: 10px; margin-left: 10px;">
                    <div class="card-body">
                        <h5 class="card-title">Total InActive Users</h5>
                        <p class="card-text">
                            <asp:Label ID="lblTotalinactive" runat="server" Text=""></asp:Label></p>
                    </div>
                </div>
                <div class="card text-white bg-success mb-3" style="width:25% ; margin-left: 10px;">
                    <div class="card-body">
                        <h5 class="card-title">Total Users</h5>
                        <p class="card-text">
                            <asp:Label ID="lblTotalusers" runat="server" Text=""></asp:Label></p>
                    </div>
                </div>
            </div>



            <div class="col-md-8 col-md-offset-2">
                <asp:GridView ID="empgrid" runat="server" Class="table table-hover"
                    AutoGenerateColumns="false" OnRowDeleting="empgrid_RowDeleting" DataKeyNames="SlNo" OnRowEditing="empgrid_RowEditing" OnRowUpdating="empgrid_RowUpdating" OnRowCancelingEdit="empgrid_RowCancelingEdit">
                    <Columns>
                        <asp:BoundField HeaderText="SlNo" DataField="SlNo" ReadOnly="true" />
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Address">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="City">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("City") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="MobileNo">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtmobile" runat="server" Text='<%# Bind("MobileNo") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("EmailId") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("EmailId") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%--       <asp:TemplateField HeaderText="Gender">
                  <ItemTemplate>
                      <asp:Label runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                  </ItemTemplate>
                  <EditItemTemplate>                      
                      <asp:RadioButtonList ID="gender" runat="server" SelectedValue='<%# Bind("Gender") %>'>
                          <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                          <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                      </asp:RadioButtonList>

                  </EditItemTemplate>

              </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Gender">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblGender" Text='<%# Eval("Gender") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlGender" runat="server">
                                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>




                        <asp:TemplateField HeaderText="UserType">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("UserType") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="userType" runat="server" DataTextField='<%# Bind("UserType") %>'>
                                    <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                                    <asp:ListItem Text="User" Value="User"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="DateOfBirth">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval( "DateOfBirth","{0:d}")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="dob" runat="server" Text='<%# Bind("DateOfBirth" ,"{0:d}") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Is Active">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="isActive" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsActive")) %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Username">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("Username") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUsername" runat="server" Text='<%# Bind("Username") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Password" DataField="Password" ReadOnly="true" />
                        <%-- <asp:TemplateField HeaderText="Password">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("Password") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:BoundField HeaderText="CreateUID" DataField="CreateUID" ReadOnly="true" />
                        <asp:BoundField HeaderText="CreateDt" DataField="CreateDt" ReadOnly="true" />
                        <asp:BoundField HeaderText="LModifyUID" DataField="LModifyUID" ReadOnly="true" />
                        <asp:BoundField HeaderText="LModifyDt" DataField="LModifyDt" ReadOnly="true" />
                        <asp:BoundField HeaderText="DelUID" DataField="DelUID" ReadOnly="true" />
                        <asp:BoundField HeaderText="DelDt" DataField="DelDt" ReadOnly="true" />
                        <asp:BoundField HeaderText="LogNo" DataField="LogNo" ReadOnly="true" />
                        <asp:BoundField HeaderText="UniqueKey" DataField="UniqueKey" ReadOnly="true" />
                        <asp:CommandField ShowDeleteButton="true" HeaderText="Remove" ControlStyle-CssClass="btn btn-danger" />
                        <asp:CommandField ShowEditButton="true" HeaderText="Edit" ControlStyle-CssClass="btn btn-success" />


                    </Columns>

                </asp:GridView>
            </div>

            <div>
                <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-danger" Text="Logout" OnClick="btnLogout_Click" Style="position: center" />
            </div>

        </div>
    </form>
</body>
</html>
