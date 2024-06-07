<%@ Page Title="Books Management" Language="C#" MasterPageFile="~/Admin screen/AdminMaster.Master" UnobtrusiveValidationMode="none" AutoEventWireup="true" CodeBehind="BookManagement.aspx.cs" Inherits="LoginAndRegister.Admin_screen.BookManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div>
            <div class="card shadow border-0 mt-4">

                <div class="card-header bg-secondary bg-gradient mt-0 py-3">
                    <div class="row">
                        <div class="col-12 text-center">
                            <h2 class="text-white py-2"><%= ViewState["BookID"] != null ? "Update" : "Insert" %> Books</h2>
                        </div>
                    </div>
                </div>

                <div class="card-body p-4">

                    <div class="row">
                        <div class="col-10">
                            <div class="border p-3">
                                <asp:Label ID="lblinserterror" runat="server" Text=""></asp:Label>

                                <div class="form-floating py-2 col-12">
                                    <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control border-0 shadow" ></asp:TextBox>
                                    <label class="control-label mb-3">Title</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="insert" runat="server" ErrorMessage="Required title" ControlToValidate="TextBox1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-floating py-2 col-12">
                                    <asp:TextBox runat="server" ID="TextBox2" CssClass="form-control border-0 shadow" ></asp:TextBox>
                                    <label class="control-label mb-3">Author</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="insert"  runat="server" ErrorMessage="Required Author" ControlToValidate="TextBox2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                </div>

                                <div class="form-floating py-2 col-12">
                                    <asp:TextBox runat="server" CssClass="form-control border-0 shadow" ID="TextBox3"></asp:TextBox>
                                    <label class="control-label mb-3">Genre</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3"  ValidationGroup="insert"  runat="server" ErrorMessage="Required Genre" ControlToValidate="TextBox3" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                </div>

                                <div class="form-floating py-2 col-12">
                                    <asp:TextBox runat="server" CssClass="form-control border-0 shadow" ID="TextBox4" TextMode="Date" ></asp:TextBox>
                                    <label class="control-label mb-3">PublicationDate</label>

                                </div>

                                <div class="form-floating py-2 col-12">
                                    <asp:CheckBox runat="server" ID="CheckBox1"  />
                                    <label class="control-label mb-3">IsPopular</label>
                                </div>

                                <div class="form-floating py-2 col-12">
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataTextField="Text" DataValueField="Value" >
                                        <asp:ListItem Text="A1" Value="101"></asp:ListItem>
                                        <asp:ListItem Text="A2" Value="102"></asp:ListItem>
                                        <asp:ListItem Text="A3" Value="103"></asp:ListItem>
                                        <asp:ListItem Text="B1" Value="104"></asp:ListItem>
                                        <asp:ListItem Text="B2" Value="105"></asp:ListItem>
                                        <asp:ListItem Text="B3" Value="106"></asp:ListItem>
                                        <asp:ListItem Text="C1" Value="107"></asp:ListItem>
                                        <asp:ListItem Text="C2" Value="108"></asp:ListItem>
                                        <asp:ListItem Text="C3" Value="109"></asp:ListItem>
                                    </asp:DropDownList>
                                    <label class="control-label mb-3">RackNo</label>
                                </div>

                                <div class="form-floating py-2 col-12">
                                    <asp:FileUpload ID="FileUpload1" CssClass="form-control border-0 shadow" runat="server" />
                                    <label class="control-label mb-3">BookImage</label>
                                    <%if (ViewState["BookID"] == null)
                                        {  %>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="insert"  runat="server" ErrorMessage="Required Image" ControlToValidate="FileUpload1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <%} %>
                                </div>

                                <div class="form-floating py-2 col-12">
                                    <asp:TextBox runat="server" CssClass="form-control border-0 shadow" ID="TextBox5" ></asp:TextBox>
                                    <label class="control-label mb-3">Quantity</label>
                                    <asp:RangeValidator ID="RangeValidator1" runat="server" MinimumValue="1" MaximumValue="50" ValidationGroup="insert"  Type="Integer" ErrorMessage="Quantity must range between 0 - 50" ControlToValidate="TextBox5" Display="Dynamic" ForeColor="Red"> </asp:RangeValidator>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="insert"  ErrorMessage="Required Available Quantity" ControlToValidate="TextBox5" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-floating py-2 col-12">
                                    <asp:TextBox runat="server" CssClass="form-control border-0 shadow" ID="TextBox6"></asp:TextBox>
                                    <label class="control-label mb-3">MaximumDays</label>
                                    <asp:RangeValidator ID="RangeValidator3" runat="server" ValidationGroup="insert"  MinimumValue="1" MaximumValue="13" Type="Integer" ErrorMessage="Max days should be between 1 and 12" ControlToValidate="TextBox6" Display="Dynamic" ForeColor="Red"> </asp:RangeValidator>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="insert"  ErrorMessage="Provide MaxDays book to allow" ControlToValidate="TextBox6" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>

                                <div class="row pt-2">
                                    <div class="col-6 col-md-3">
                                        <% if (ViewState["BookID"] != null)
                                            { %>
                                        <asp:Button ID="btnUpd" runat="server" Text="Update" ValidationGroup="insert"  class="btn btn-success" OnClick="btnUpd_Click" />
                                        <% }
                                            else
                                            { %>
                                        <asp:Button ID="btnInsert" runat="server" Text="Insert" ValidationGroup="insert"  class="btn btn-success" OnClick="btnInsert_Click" />
                                        <% } %>


                                    </div>
                                    <div class="col-6 col-md-3">
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-outline-secondary border form-control" OnClick="btnCancel_Click" />

                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-2">
                            <div>

                                <asp:Image ID="Image1" runat="server" Width="100%" Style="border-radius: 5px; border: 1px solid" ImageUrl='<%# ResolveUrl("~/Uploads/" + Eval("BookImage")) %>' />
                            </div>
                            <div>
                                <div class="card text-white bg-primary mt-4 mb-3" style="width: 100%; margin-right: 10px;">
                                    <div class="card-body">
                                        <h5 class="card-title " style="align-content: center">Popular Books</h5>
                                        <p class="card-text">
                                            <asp:Label ID="lblpopularbooks" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                </div>
                                <div class="card text-white bg-secondary mb-3" style="width: 100%; margin-right: 10px; margin-left: 10px;">
                                    <div class="card-body">
                                        <h5 class="card-title" style="align-content: center">Regular Books</h5>
                                        <p class="card-text">
                                            <asp:Label ID="lblreguarbooks" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                </div>
                                <div class="card text-white bg-success mb-3" style="width: 100%; margin-left: 10px;">
                                    <div class="card-body">
                                        <h5 class="card-title" style="align-content: center">Total Books</h5>
                                        <p class="card-text">
                                            <asp:Label ID="lbltotalbooks" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>

        </div>
        <asp:GridView ID="bookgrid" runat="server" Class="table table-hover"
            AutoGenerateColumns="false" DataKeyNames="BookID"
            OnRowDeleting="bookgrid_RowDeleting" 
            OnSelectedIndexChanged="bookgrid_SelectedIndexChanged">
            <Columns>
            
                <asp:TemplateField  HeaderText="Remove">
                    <ItemTemplate>
                        <asp:LinkButton ID="btndelete" OnClientClick="return confirm('Are you sure you want to delete this item?');" Text="Delete" runat="server" OnClick="btndelete_Click" CssClass="btn btn-danger" CommandName="Delete" CommandArgument='<%# Eval("BookID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowSelectButton="true" SelectText="Edit" HeaderText="Update" ControlStyle-CssClass="btn btn-success" />


                <asp:BoundField HeaderText="BookId" DataField="BookID" ReadOnly="true" />
                <asp:TemplateField HeaderText="Title">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Author">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Author") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Genre">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%#  Eval("Genre").ToString().Length >50 ? Eval("Genre").ToString().Substring(0,50)+"..." : Eval("Genre") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="PublicationDate">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("PublicationDate","{0:d}")%>'></asp:Label>

                    </ItemTemplate>

                </asp:TemplateField>


                <asp:TemplateField HeaderText="IsPopular">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("IsPopular") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>

                <asp:TemplateField HeaderText="RackNo">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("RackNo") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>

                <asp:TemplateField HeaderText="BookImage">
                    <ItemTemplate>
                        <!-- Display the image if available, otherwise display a placeholder -->
                        <asp:Image ID="imgGBook" runat="server" Width="75px" Height="75px"
                            ImageUrl='<%# ResolveUrl("~/Uploads/" + Eval("BookImage")) %>' />
                    </ItemTemplate>

                </asp:TemplateField>

                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>

                <asp:TemplateField HeaderText="MaximumDays">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("MaximumDays") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:BoundField HeaderText="CreateUID" DataField="CreateUID" ReadOnly="true" />
                <asp:BoundField HeaderText="CreateDt" DataField="CreateDt" ReadOnly="true" />
                <asp:BoundField HeaderText="LModifyUID" DataField="LModifyUID" ReadOnly="true" />
                <asp:BoundField HeaderText="LModifyDt" DataField="LModifyDt" ReadOnly="true" />
                <asp:BoundField HeaderText="DelUID" DataField="DelUID" ReadOnly="true" />
                <asp:BoundField HeaderText="DelDt" DataField="DelDt" ReadOnly="true" />
                <asp:BoundField HeaderText="LogNo" DataField="LogNo" ReadOnly="true" />
                <asp:BoundField HeaderText="UniqueKey" DataField="UniqueKey" ReadOnly="true" />



            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
