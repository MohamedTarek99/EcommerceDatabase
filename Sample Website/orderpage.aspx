<%@ Page Language="C#" AutoEventWireup="true" CodeFile="orderpage.aspx.cs" Inherits="orderpage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

         <div class="order">
                <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        [ <a href="customerpage.aspx" runat="server">home</a> ]
                    </AnonymousTemplate>
                                  </asp:LoginView>


               </div>
        <div>
             <p>
                                <asp:Label ID="cashl" runat="server" AssociatedControlID="cashl">Cash Amount:</asp:Label>
                                <asp:TextBox ID="cash" runat="server" CssClass="int"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="cashRequired" runat="server" ControlToValidate="cash" 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>


                  <asp:Label ID="Label1" runat="server" AssociatedControlID="cashl">Order number:</asp:Label>
                                <asp:TextBox ID="orderc" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="orderc" 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button1" runat="server" CommandName="MoveNext" Text="pay" OnClick="paycash"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                            </p>
        </div>



        <div>



             <p>


                 
                  <asp:Label ID="Label4" runat="server" AssociatedControlID="cashl">Card number:</asp:Label>
                                <asp:TextBox ID="cardnumber" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cardnumber" 
                                     ValidationGroup="RegisterUserValidationGroup1">*</asp:RequiredFieldValidator>



                                <asp:Label ID="Label2" runat="server" AssociatedControlID="cashl">Credit Amount:</asp:Label>
                                <asp:TextBox ID="credit" runat="server" CssClass="int"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="credit" 
                                     ValidationGroup="RegisterUserValidationGroup1">*</asp:RequiredFieldValidator>


                  <asp:Label ID="Label3" runat="server" AssociatedControlID="cashl">Order number:</asp:Label>
                                <asp:TextBox ID="ordercr" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ordercr" 
                                     ValidationGroup="RegisterUserValidationGroup1">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button2" runat="server" CommandName="MoveNext" Text="pay" OnClick="paycredit"
                                 ValidationGroup="RegisterUserValidationGroup1"/>
                            </p>
        </div>
    </form>
</body>
</html>
