<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="lbl_username" runat="server" Text="Username: "></asp:Label>
    
        <asp:TextBox ID="txt_username" runat="server"></asp:TextBox>
    
        <br />
    
        <br />
        <asp:Label ID="lbl_password" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox ID="txt_password" runat="server" TextMode="Password"></asp:TextBox>
    
        <br />
    
        <br />
        <asp:Button ID="btn_login" runat="server" Text="Login" Width="90px" OnClick="login"/>
    
    </div>
    </form>
    <h2>
     
        <asp:HyperLink ID="RegistervendorHyperLink" runat="server" EnableViewState="false">Register as a vendor.</asp:HyperLink>
        </h2>

    <h2>
     
        <asp:HyperLink ID="RegistercustomerHyperLink" runat="server" EnableViewState="false">Register as a customer.</asp:HyperLink>
        </h2>


</body>
</html>
