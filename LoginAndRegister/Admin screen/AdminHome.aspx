<%@ Page Title="Home" Language="C#" MasterPageFile="~/Admin screen/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="LoginAndRegister.Admin_screen.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row pb-3">
        <% List<Book> books = ViewState["Books"] as List<Book>; %>
        <% if (books != null)
            { %>
        <% foreach (Book book in books)

            { %>
        <div class="col-lg-3 col-sm-6">
            <div class="row p-2">
                <div class="col-12 p-1">
                    <div class="card border-0 p-3 shadow border-top border-5 rounded">
                        <div class="d-flex justify-content-center">
                            <img src="<%=ResolveUrl("~/Uploads/" + book.BookImage) %>" class="card-img-top rounded" style="width: 320px; height: 250px;" />
                        </div>
                        <div class="card-body">
                            <div class="pl-1">
                                <p class="card-title h5 text-dark opacity-75 text-uppercase text-center"><%= book.Title %></p>
                                <p class="card-title text-warning text-center">by <b><%= book.Author %></b></p>
                            </div>
                            <div class="pl-1">
                                <p class="text-dark text-opacity-75 text-center mb-0">
                                    <span class="text-decoration-line-through"><%= book.Genre.Length > 50 ? book.Genre.Substring(0, 50) + "..." : book.Genre %></span>
                                </p>
                            </div>
                            <div class="pl-1">
                                <p class="text-dark text-opacity-75 text-center">Available Quantity: <span><%= book.Quantity %></span></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>




        <% } %>
        <% } %>
    </div>
</asp:Content>
