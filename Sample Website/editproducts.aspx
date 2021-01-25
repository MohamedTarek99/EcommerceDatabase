<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editproducts.aspx.cs" Inherits="editproducts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div>
                <asp:LoginView ID="LoginView1" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        [ <a href="vendor.aspx" runat="server">Home</a> ]
                    </AnonymousTemplate>
                                  </asp:LoginView>
               </div>


                  <p>
                                <asp:Label ID="serialno" runat="server" AssociatedControlID="serialno">Serial:</asp:Label>
                                <asp:TextBox ID="serial" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="serial" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>

                  <asp:Label ID="name" runat="server" AssociatedControlID="name">Product name:</asp:Label>
                                <asp:TextBox ID="productname" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="productname" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>

                 <asp:Label ID="desc" runat="server" AssociatedControlID="desc">Description:</asp:Label>
                                <asp:TextBox ID="description" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="description" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>

                          <asp:Label ID="col" runat="server" AssociatedControlID="col">Color:</asp:Label>
                                <asp:TextBox ID="color" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="color" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>

                          <asp:Label ID="Label4" runat="server" AssociatedControlID="Label4">Category</asp:Label>
                                <asp:TextBox ID="category" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="category" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>

                          <asp:Label ID="Label5" runat="server" AssociatedControlID="Label5">Price:</asp:Label>
                                <asp:TextBox ID="price" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="price" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>


              
                            <asp:Button ID="Button3" runat="server" CommandName="MoveNext" Text="Edit" OnClick="edit"
                                 ValidationGroup="RegisterUserValidationGroup2"/>
                            </p>

        </div>
    </form>
</body>
</html>
