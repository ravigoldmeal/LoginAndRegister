<%@ Page Title="" Language="C#" MasterPageFile="~/Admin screen/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UserRoles.aspx.cs" Inherits="LoginAndRegister.Admin_screen.UserRoles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card shadow border-0 mt-2">
        <div class="card-header bg-secondary bg-gradient mt-0 py-3">
            <div class="row">
                <div class="col-12 text-center">
                    <h2 class="text-white py-2">User Roles</h2>
                </div>
            </div>
        </div>
        <div class="container">
            <table class="table table-hover">
                <thead style="background-color: aliceblue">
                    <tr>
                        <td>User Roles</td>
                        <td>Permissions</td>
                    </tr>
                </thead>
                <tr>
                    <td>Admin</td>
                    <td>
                        <asp:CheckBoxList ID="chkAdmin" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Enabled="false">Home</asp:ListItem>
                            <asp:ListItem Enabled="false">UserManagement</asp:ListItem>
                            <asp:ListItem Enabled="false">CatalogManagement</asp:ListItem>
                            <asp:ListItem Enabled="false">CirculationManagement</asp:ListItem>
                            <asp:ListItem Enabled="false">Report</asp:ListItem>
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td>Librarian</td>
                    <td>
                        <asp:CheckBoxList ID="chkLibrarian" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>Home</asp:ListItem>
                            <asp:ListItem>UserManagement</asp:ListItem>
                            <asp:ListItem>CatalogManagement</asp:ListItem>
                            <asp:ListItem>CirculationManagement</asp:ListItem>
                            <asp:ListItem>Report</asp:ListItem>
                        </asp:CheckBoxList>
                    </td>
                    <td>
                        <asp:Button ID="btnlibrarian" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnlibrarian_Click" />
                    </td>
                </tr>
                <tr>
                    <td>User</td>
                    <td>
                        <asp:CheckBoxList ID="chkUser" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>UserHome</asp:ListItem>
                            <asp:ListItem>UserProfile</asp:ListItem>
                            <asp:ListItem>UserReport</asp:ListItem>
                        </asp:CheckBoxList>
                    </td>
                    <td>
                        <asp:Button ID="brnuser" runat="server" CssClass="btn btn-success" Text="Update" OnClick="brnuser_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
