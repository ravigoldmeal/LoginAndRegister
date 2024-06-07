<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Admin screen/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminReport.aspx.cs" Inherits="LoginAndRegister.Admin_screen.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div>

            <div class="container">
                <div class="row">
                    <div class="card text-white bg-secondary mb-3" style="width: 25%; margin-right: 10px; margin-left: 10px;">
                        <div class="card-body">
                            <h5 class="card-title">Total Fine Collected </h5>
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
        </div>
        </div>
        <div class="card shadow border-0 mt-2">

            <div class="card-header bg-secondary bg-gradient mt-0 py-3">
                <div class="row">
                    <div class="col-12 text-center">
                        <h2 class="text-white py-2">Pending BookRequest</h2>
                    </div>
                </div>
            </div>

            <div class="card-body p-4">

                <div class="row">
                    <div class="col-10">
                        <div class="border p-3">

                            <asp:GridView ID="bookrequest" runat="server" Class="table table-hover"
                                AutoGenerateColumns="false" DataKeyNames="Sino" OnSelectedIndexChanged="bookgrid_SelectedIndexChanged" EmptyDataText="No new requests"
                                OnRowDeleting="bookgrid_RowDeleting">
                                <Columns>
                                    <asp:BoundField HeaderText="RequestId" DataField="Sino" />
                                    <asp:BoundField HeaderText="BookId" DataField="BookId" />
                                    <asp:BoundField HeaderText="Username" DataField="Username" />
                                    <asp:BoundField HeaderText="RequestDate" DataField="RequestDate" />
                                    <asp:CommandField ShowSelectButton="true" SelectText="Approve" HeaderText="Action" ControlStyle-CssClass="btn btn-success" />
                                    <asp:CommandField ShowDeleteButton="true" DeleteText="Reject" HeaderText="Reject" ControlStyle-CssClass="btn btn-danger" />

                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="col-2">
                        <div>

                            <asp:Image ID="Image1" runat="server" Width="100%" Style="border-radius: 5px; border: 1px solid" ImageUrl='<%# ResolveUrl("~/Uploads/" + Eval("BookImage")) %>' />
                        </div>
                        <div>
                            <div class="card text-white bg-success mt-4 mb-3" style="width: 100%; margin-right: 10px;">
                                <div class="card-body">
                                    <h5 class="card-title " style="align-content: center">Approved Requests</h5>
                                    <p class="card-text">
                                        <asp:Label ID="lblApprovedrequests" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="card text-white bg-secondary mb-3" style="width: 100%; margin-right: 10px; margin-left: 10px;">
                                <div class="card-body">
                                    <h5 class="card-title" style="align-content: center">Rejected Requests</h5>
                                    <p class="card-text">
                                        <asp:Label ID="lblrejectedrequests" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="card text-white bg-primary mb-3" style="width: 100%; margin-left: 10px;">
                                <div class="card-body">
                                    <h5 class="card-title" style="align-content: center">Total Requests</h5>
                                    <p class="card-text">
                                        <asp:Label ID="lbltotalrequests" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>

    </div>

    </div>
    <script type="text/javascript">
        toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };
        function showToast() {
            toastr.success('Your request is approved!', 'Success');
        }
        function showErrorToast() {
            toastr.error('Your request is rejected!', 'Error');
        }
 </script>
    <style>
        /* Custom Toastr CSS */
        .toast-success {
            background-color: #28a745 !important; /* Custom green color for success */
        }

        .toast-error {
            background-color: #dc3545 !important; /* Custom red color for error */
        }
    </style>
</asp:Content>
