<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vendor.aspx.cs" Inherits="vendor" %>

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
                        [ <a href="editproducts.aspx" runat="server">Edit my products</a> ]
                    </AnonymousTemplate>
                                  </asp:LoginView>
               </div>

              <div>
                <asp:LoginView ID="LoginView2" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        [ <a href="post.aspx" runat="server">Post a product</a> ]
                    </AnonymousTemplate>
                                  </asp:LoginView>
               </div>
            <p>
                                <asp:Label ID="Telephonenumber" runat="server" AssociatedControlID="phone">Telephone number</asp:Label>
                                <asp:TextBox ID="phone" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="fnameRequired" runat="server" ControlToValidate="phone" 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button1" runat="server" CommandName="MoveNext" Text="add" OnClick="addphone"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                            </p>


           <p>
                                <asp:Label ID="Label1" runat="server" AssociatedControlID="Label1">Offer amount:</asp:Label>
                                <asp:TextBox ID="amount" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="amount" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>

                 <asp:Label ID="Label2" runat="server" AssociatedControlID="Label2"> Expirydate:</asp:Label>
                                <asp:TextBox ID="date" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="date" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button2" runat="server" CommandName="MoveNext" Text="Create" OnClick="addoffer"
                                 ValidationGroup="RegisterUserValidationGroup2"/>
                            </p>


             <p>
                                <asp:Label ID="Label3" runat="server" AssociatedControlID="Label3">Offer id:</asp:Label>
                                <asp:TextBox ID="offer" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="offer" 
                                     ValidationGroup="RegisterUserValidationGroup3">*</asp:RequiredFieldValidator>

                 <asp:Label ID="Label4" runat="server" AssociatedControlID="Label4">Serial:</asp:Label>
                                <asp:TextBox ID="serial" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="serial" 
                                     ValidationGroup="RegisterUserValidationGroup3">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button3" runat="server" CommandName="MoveNext" Text="apply" OnClick="applyoffer"
                                 ValidationGroup="RegisterUserValidationGroup3"/>
                            </p>
             

                   <p>
                                <asp:Label ID="Label5" runat="server" AssociatedControlID="Label5">Offer id:</asp:Label>
                                <asp:TextBox ID="id" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="id" 
                                     ValidationGroup="RegisterUserValidationGroup4">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button4" runat="server" CommandName="MoveNext" Text="check" OnClick="checkoffer"
                                 ValidationGroup="RegisterUserValidationGroup4"/>
                            </p>



            <h1>Your products</h1>
        </div>
    </form>
</body>
</html>
