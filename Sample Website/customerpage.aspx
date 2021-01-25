<%@ Page Language="C#" AutoEventWireup="true" CodeFile="customerpage.aspx.cs" Inherits="CUSTOM" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
         
    <form id="form1" runat="server">


          <div>
                <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        [ <a href="cartpage.aspx" runat="server">My cart</a> ]
                    </AnonymousTemplate>
                                  </asp:LoginView>
               </div>


        
          <div >
                <asp:LoginView ID="LoginView1" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        [ <a href="orderpage.aspx" runat="server">My orders</a> ]
                    </AnonymousTemplate>
                                  </asp:LoginView>
               </div>

        <div> 

            <p>
                                <asp:Label ID="Telephonenumber" runat="server" AssociatedControlID="phone">Telephone number</asp:Label>
                                <asp:TextBox ID="phone" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="fnameRequired" runat="server" ControlToValidate="phone" 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button1" runat="server" CommandName="MoveNext" Text="add" OnClick="addphone"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                            </p>
            <p>
                                <asp:Label ID="wishlist" runat="server" AssociatedControlID="wish">Create a new wishlist:</asp:Label>
                                <asp:TextBox ID="wish" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="wish" 
                                     ValidationGroup="RegisterUserValidationGroup1">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button2" runat="server" CommandName="MoveNext" Text="create" OnClick="createwishlist"
                                 ValidationGroup="RegisterUserValidationGroup1"/>
                            </p>

             <p>
                                <asp:Label ID="creditcard" runat="server" AssociatedControlID="creditnumber">Card number</asp:Label>
                                <asp:TextBox ID="creditnumber" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="creditnumber" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>

                  <asp:Label ID="Label1" runat="server" AssociatedControlID="cvv">cvv</asp:Label>
                                <asp:TextBox ID="cvv" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cvv" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>
                 <asp:Label ID="Label2" runat="server" AssociatedControlID="date">expiry_date</asp:Label>
                                <asp:TextBox ID="date" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="date" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>

              
                            <asp:Button ID="Button3" runat="server" CommandName="MoveNext" Text="add" OnClick="addcreditcard"
                                 ValidationGroup="RegisterUserValidationGroup2"/>
                            </p>

        </div>
                 <p>
                                <asp:Label ID="Label3" runat="server" AssociatedControlID="wishlistdesired">Wishlist name that you want to add/remove a product to/from</asp:Label>
                                <asp:TextBox ID="wishlistdesired" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="wishlistdesired" 
                                     ValidationGroup="RegisterUserValidationGroup3">*</asp:RequiredFieldValidator>
              
                           
                            </p>
    </form>
</body>
</html>
