<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login Page.aspx.cs" Inherits="LoginAndRegister.Login_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <link href="css/site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table align="center" style="border: 2px solid #990099; border-collapse: collapse; background-color: #ccffff">

                <tr>
                    <td>
                        <h3>Login Form </h3>

                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Label ID="lblError" runat="server" class="btn btn-outline-warning" Text=""></asp:Label></td>
                </tr>
                <tr>
                </tr>

                <tr>
                    <td>Username : </td>
                    <td>
                        <asp:TextBox ID="txtusername" runat="server"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td>
                        <asp:TextBox ID="txtpassword" TextMode="Password" runat="server"></asp:TextBox></td>

                </tr>

                <tr>
                    <td>
                        <asp:CheckBox ID="chkRemember" runat="server" Text="Remember me" /></td>
                    <td>
                        <asp:Button runat="server" Text="Login" ID="btnlogin" OnClick="btnlogin_Click" />
                        <asp:Button runat="server" Text="Register" ID="btnregister" OnClick="btnregister_Click" /></td>
                </tr>
            </table>
        </div>
    </form>
    <script>
        function showNotification() {
            toastr.success('New User Created');
        }

        <% if (Session["JavaScriptFunction"] != null)
        { %>
            <%= Session["JavaScriptFunction"] %>
            <% Session.Remove("JavaScriptFunction"); %>
        <% } %>
</script>
</body>
</html>


