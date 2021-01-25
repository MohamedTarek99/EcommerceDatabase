<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cartpage.aspx.cs" Inherits="cartpage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cart">
                <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        [ <a href="customerpage.aspx" runat="server">home</a> ]
                    </AnonymousTemplate>
                                  </asp:LoginView>

            <p class="Button">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Make order"  OnClick="makeorder"
                                 />



                            
                            </p>
               </div>
        <div>
        </div>
    </form>
</body>
</html>
