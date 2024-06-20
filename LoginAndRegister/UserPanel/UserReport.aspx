<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/User.Master" AutoEventWireup="true" CodeBehind="UserReport.aspx.cs" Inherits="LoginAndRegister.UserPanel.UserReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card shadow border-0 mt-4">

        <div class="card-header bg-secondary bg-gradient mt-0 py-3">
            <div class="row">
                <div class="col-12 text-center">
                    <h2 class="text-white py-2">Book Report </h2>
                </div>
            </div>
        </div>

        <div class="card-body ">

            <div class="card" style="flex-direction: row">
                <div class="card text-white bg-primary mb-3" style="width: 25%; margin-right: 10px;">
                    <div class="card-body">
                        <h5 class="card-title">Books Taken</h5>
                        <p class="card-text">
                            <asp:Label ID="lbltotalbooks" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>
                <div class="card text-white bg-secondary mb-3" style="width: 25%; margin-right: 10px; margin-left: 10px;">
                    <div class="card-body">
                        <h5 class="card-title">Total Fine Paid </h5>
                        <p class="card-text">
                            <asp:Label ID="lblpaidfine" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>
                <div class="card text-white bg-success mb-3" style="width: 25%; margin-left: 10px;">
                    <div class="card-body">
                        <h5 class="card-title">Total Pending Fine</h5>
                        <p class="card-text">
                            <asp:Label ID="lblpendingfine" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="border p-3">
                        <asp:GridView ID="ubookrecord" AutoGenerateColumns="false" runat="server" CssClass="table table-dark" EmptyDataText="No record foune......">
                            <Columns>
                                <asp:BoundField DataField="Username" HeaderText="Username" />
                                <asp:BoundField DataField="BookId" HeaderText="Book ID" />
                                <asp:BoundField DataField="BookName" HeaderText="Book Name" />
                                <asp:BoundField DataField="IssueDate" HeaderText="IssueDate"
                                    DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" />
                                <asp:BoundField DataField="ReturnDate" HeaderText="ReturnDate"
                                    DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" />
                                <asp:BoundField DataField="DueDate" HeaderText="DueDate"
                                    DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" />

                                <asp:CheckBoxField DataField="IsSubmited" HeaderText="Is SUbmitted" />
                                <asp:BoundField DataField="Fine" HeaderText="Fine" />

                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
