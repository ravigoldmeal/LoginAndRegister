<%@ Page Title="" Language="C#" MasterPageFile="~/Admin screen/AdminMaster.Master" AutoEventWireup="true" UnobtrusiveValidationMode="none" CodeBehind="CirculationManagement.aspx.cs" Inherits="LoginAndRegister.Admin_screen.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-5 card shadow border-0" style="height: 330px">
            <div class="row ml-1">

                <div class="col-md-3">
                    <div class="row">
                        <div>
                            <img src="../images/book.png" class="card-img" alt="...">
                        </div>
                        <div class="text-secondary">
                            <h5>“A reader lives a thousand lives before he dies" </h5>
                        </div>
                    </div>

                </div>
                <div class="col-md-9">
                    <div class="card-body ">
                        <div class="row">
                            <asp:Label ID="lblerror1" class="control-label mb-3"  Font-Size="X-Small" runat="server" ForeColor="red"  Text=""></asp:Label>

                        </div>

                        <div class="row mt-3 mb-3">
                            <div class="col-md-6">
                         
                                <asp:TextBox ID="txtusername" CssClass="form-control border-0 shadow" placeholder="UserName" runat="server"></asp:TextBox>
                                       <asp:Label ID="lblusername" runat="server" Font-Size="X-Small" ForeColor="red" Text=""></asp:Label>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtusername" runat="server" Display="Dynamic" ValidationGroup="s1" ValidationExpression="^(?=(?:\D*\d){0,10}\D*$)[a-zA-Z0-9\s]{0,10}$"
                                    ErrorMessage="Enter a valid userid"></asp:RegularExpressionValidator>

                            </div>
                            <div class="col-md-6">
                                <asp:TextBox ID="txtbookid" CssClass="form-control border-0 shadow" placeholder="BookID" runat="server"></asp:TextBox>
                                <asp:Label ID="lblbookid" runat="server"  Font-Size="X-Small" ForeColor="red" Text=""></asp:Label>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtbookid" runat="server" Display="Dynamic" ValidationGroup="s1" ValidationExpression="^\d{4}$" ErrorMessage="Enter a valid Bookid"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col text-center mb-3">
                                <asp:Button ID="btnsearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnsearch_Click" ValidationGroup="s1" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <asp:RequiredFieldValidator ID="Required" runat="server" ErrorMessage="Please provide Issue Date" Font-Size="Smaller" ControlToValidate="txtissuedate" ForeColor="red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtissuedate" runat="server" CssClass="form-control border-0 shadow" TextMode="Date"></asp:TextBox>
                                <asp:Label ID="lblissuedate" class="control-label mb-3" runat="server" Text="Issue Date"></asp:Label>
                            </div>
                            <div class="col-md-6">
                                <asp:RequiredFieldValidator ID="RequiredFie" runat="server" ErrorMessage="Please provide Due Date" Font-Size="Smaller" ControlToValidate="txtduedate" ForeColor="red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtduedate" ControlToCompare="txtissuedate" ErrorMessage="Due date must Be greater than issue date" Font-Size="Smaller" ForeColor="red" Display="Dynamic" Operator="GreaterThan"></asp:CompareValidator>
                                <asp:TextBox ID="txtduedate" runat="server" CssClass="form-control border-0 shadow" TextMode="Date"></asp:TextBox>
                                <asp:Label ID="lblduedate" class="control-label mb-3" runat="server" Text="Due Date"></asp:Label>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-6 mb-3">
                                <asp:Button ID="btnissue" runat="server" Text="Issue" CssClass="btn btn-success" OnClick="btnissue_Click" />
                            </div>
                            <div class="col-6 mb-3">
                                <asp:Button ID="btnsubmit" runat="server" Text="Return" CssClass="btn btn-warning" OnClick="btnsubmit_Click" />
                            </div>
                        </div>
                        <div>
                            <asp:Label ID="lblError" runat="server" Text=""></asp:Label>

                        </div>

                    </div>

                </div>

            </div>



        </div>
        <div class="col-7">
            <asp:GridView ID="transition" runat="server" AutoGenerateColumns="false" CssClass="table" EmptyDataText="No record foune......">
                <Columns>
                    <asp:BoundField DataField="TID" HeaderText="SiNo" />
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="BookName" HeaderText="Book Name" />
                    <asp:BoundField DataField="BookId" HeaderText="Book ID" />
                    <asp:BoundField DataField="IsSubmited" HeaderText="Submitted" />
                    <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" />
                    <asp:BoundField DataField="Fine" HeaderText="Fine" />
                    <asp:BoundField DataField="LModifyUID" HeaderText="Last Modified By" />

                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
