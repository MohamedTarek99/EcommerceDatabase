<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vendorRegister.aspx.cs" Inherits="vendorRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <p>
                                <asp:Label ID="fnameLabel" runat="server" AssociatedControlID="fname">First Name:</asp:Label>
                                <asp:TextBox ID="fname" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="fnameRequired" runat="server" ControlToValidate="fname" 
                                     CssClass="failureNotification" ErrorMessage="First name is required." ToolTip="First Name is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>

        <p>
                                <asp:Label ID="Label2" runat="server" AssociatedControlID="fname">Last Name:</asp:Label>
                                <asp:TextBox ID="lname" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="lnameRequired" runat="server" ControlToValidate="lname" 
                                     CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="Last Name is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
          

                            <p>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                     CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                                <asp:TextBox ID="Email" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" 
                                     CssClass="failureNotification" ErrorMessage="E-mail is required." ToolTip="E-mail is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                                     CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                                    <p>
                                <asp:Label ID="companylabel" runat="server" AssociatedControlID="Company">Company Name:</asp:Label>
                                <asp:TextBox ID="company" runat="server" CssClass="textEntry" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="company" 
                                     CssClass="failureNotification" ErrorMessage="Company name is required." ToolTip="company name is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                                    <p>
                                <asp:Label ID="bank" runat="server" AssociatedControlID="Bank">Bank Account Number:</asp:Label>
                                <asp:TextBox ID="bankacc" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="bankacc" 
                                     CssClass="failureNotification" ErrorMessage="Bank account number is required." ToolTip="Bank account numberr is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                      
                        <p class="submitButton">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Create User"  OnClick="register"
                                 ValidationGroup="RegisterUserValidationGroup"/>



                            
                            </p>

           <div class="loginDisplay">
                <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        [ <a href="Login.aspx" runat="server">Log In</a> ]
                    </AnonymousTemplate>
                                  </asp:LoginView>
               </div>

        </form>



  
</body>
</html>
