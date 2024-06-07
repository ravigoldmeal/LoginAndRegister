<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" UnobtrusiveValidationMode="none" Inherits="LoginAndRegister.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/toastr.min.css" rel="stylesheet" />
    <script src="css/toastr.min.js"></script>
    <link href="css/site.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <table align="center" style="border: 2px solid #990099; border-collapse: collapse; background-color: #ccffff">
                <tr>
                    <td>
                        <h3>Registration Form</h3>
                    </td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td>
                        <asp:TextBox ID="txtname"  runat="server"   CssClass="form-control" EnableViewState="False"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="valname" ControlToValidate="txtname" ForeColor="Red" 
                            Display="Dynamic" ValidationGroup="registration" EnableViewState="False"></asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter Valid Name" Display="Dynamic" ControlToValidate="txtname"
                            ID="RegularExpressionValidator1" ForeColor="#0066FF" ValidationExpression="^(?:[A-Za-z]{1,30})(?: [A-Za-z]{1,30})?$" 
                            ValidationGroup="registration"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td>
                        <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" EnableViewState="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>City</td>
                    <td>
                        <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" EnableViewState="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Mobile No</td>
                    <td>
                        <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator1" ControlToValidate="txtmobile" ForeColor="Red" Display="Dynamic" ValidationGroup="registration" EnableViewState="False"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter Valid Number" Display="Dynamic" ControlToValidate="txtmobile" ID="valmobileno" ForeColor="#0066FF" ValidationExpression="^[6-9]\d{9}$" ValidationGroup="registration"></asp:RegularExpressionValidator><asp:Label runat="server" ID="libMobileNo" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Email ID</td>
                    <td>
                        <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" EnableViewState="False"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator2" ControlToValidate="txtemail" ForeColor="Red" Display="Dynamic" ValidationGroup="registration"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter Valid Email" Display="Dynamic" ControlToValidate="txtemail" ID="valemail" ForeColor="#0066FF" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="registration"></asp:RegularExpressionValidator><asp:Label runat="server" ID="libEmailid" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>User Type </td>
                    <td>
                        <asp:DropDownList ID="userType" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Select User Type" Value=""></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                            <asp:ListItem Text="User" Value="User"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator3" ControlToValidate="userType" ForeColor="Red" Display="Dynamic" ValidationGroup="registration"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Gender</td>
                    <td>
                        <asp:RadioButtonList ID="gender" runat="server" CssClass="form-check-inline" RepeatDirection="Horizontal" ValidationGroup="registration">
                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator4" ControlToValidate="gender" ForeColor="Red" Display="Dynamic" ValidationGroup="registration"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Date of Birth </td>
                    <td>
                        <asp:TextBox ID="dob" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator5" ControlToValidate="dob" ForeColor="Red" ValidationGroup="registration"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <%-- <tr>
                    <td>Is Active</td>
                    <td>
                        <asp:CheckBox ID="isActive" runat="server" ValidationGroup="registration"></asp:CheckBox>
                    </td>
                </tr>--%>
                <tr>
                    <td>Username</td>
                    <td>
                        <asp:TextBox ID="txtusername" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtusername" ValidationGroup="registration" ValidationExpression="^.{4,}$" Display="Dynamic" ForeColor="#0066FF" ID="RegularExpressionValidator2" ErrorMessage="Enter in valid format"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator6" ControlToValidate="txtusername" ForeColor="Red" Display="Dynamic" ValidationGroup="registration" EnableViewState="False"></asp:RequiredFieldValidator><asp:Label runat="server" ID="libusername" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>
                        <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" TextMode="Password" ValidationGroup="registration"></asp:TextBox>
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtpassword" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$" ValidationGroup="registration" Display="Dynamic" ForeColor="#0066FF" ID="valpass" ErrorMessage="Enter in valid format"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ID="RequiredFieldValidator7" ControlToValidate="txtpassword" ForeColor="Red" ValidationGroup="registration"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="Submit" runat="server" Text="Submit" BorderColor="Red" ForeColor="#0066FF" BackColor="#CCFFFF" OnClick="Submit_Click" ValidationGroup="registration" />
                        <asp:Button ID="Login" runat="server" Text="Login" OnClick="Login_Click" />
                        <asp:Label runat="server" Text="" ID="lblinfo"></asp:Label>
                </tr>
            </table>
        </div>
    

    </form>
</body>

</html>
