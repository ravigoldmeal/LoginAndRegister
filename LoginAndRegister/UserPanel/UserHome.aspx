<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/User.Master" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="LoginAndRegister.UserPanel.UserHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row pb-3">
        <asp:Repeater ID="BookRepeater" runat="server">
            <ItemTemplate>
                <div class="col-lg-3 col-sm-6">
                    <div class="row p-2">
                        <div class="col-12 p-1">
                            <div class="card border-0 p-3 shadow border-top border-5 rounded">

                                <div class="d-flex justify-content-center">
                                    <img src='<%# ResolveUrl("~/Uploads/" + Eval("BookImage")) %>'class="card-img-top rounded" style="width: 320px; height: 250px;" />
                                </div>
                                <div class="card-body">
                                    <div class="pl-1">
                                        <p class="card-title h5 text-dark opacity-75 text-uppercase text-center"><%# Eval("Title") %></p>
                                        <p class="card-title text-warning text-center">by <b><%# Eval("Author") %></b></p>
                                    </div>
                                    <div class="pl-1">
                                        <p class="text-dark text-opacity-75 text-center mb-0">
                                            <span class="text-decoration-line-through"><%# Eval("Genre").ToString().Length > 50 ? Eval("Genre").ToString().Substring(0, 50) + "..." : Eval("Genre") %></span>
                                        </p>
                                    </div>
                                    <div class="pl-1">
                                        <p class="text-dark text-opacity-75 text-center">Available Quantity: <span><%# Eval("Quantity") %></span></p>

                                    </div>
                                </div>
                                <div>
                                    <asp:LinkButton ID='LinkButton1' runat="server" CommandArgument='<%# Eval("BookID") %>' Text="Request Book" CssClass="btn btn-primary bg-gradient border-0 form-control" OnClick="LinkButton1_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
