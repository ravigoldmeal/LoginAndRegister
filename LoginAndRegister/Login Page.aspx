<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login Page.aspx.cs" Inherits="LoginAndRegister.Login_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <link href="css/site.css" rel="stylesheet" />
    <script>
        function validateInput(event) {
            var input = event.target;
            var value = input.value;
            input.value = value.replace(/[^a-zA-Z\s]/g, '');
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
                        <asp:TextBox ID="txtusername" onInput="validatemaxlength15(event)" runat="server"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td>
                        <asp:TextBox ID="txtpassword" onInput="validatemaxlength15(event)" TextMode="Password" runat="server"></asp:TextBox></td>

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


