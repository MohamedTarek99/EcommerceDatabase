<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">


            <p>
                                <asp:Label ID="Telephonenumber" runat="server" AssociatedControlID="phone">Telephone number</asp:Label>
                                <asp:TextBox ID="phone" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="fnameRequired" runat="server" ControlToValidate="phone" 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button1" runat="server" CommandName="MoveNext" Text="add" OnClick="addphone"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                            </p>


        <div>
            
            <p>
                                <asp:Label ID="Label1" runat="server" AssociatedControlID="Label1">Vendor username:</asp:Label>
                                <asp:TextBox ID="username" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="username" 
                                     ValidationGroup="RegisterUserValidationGroup1">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button2" runat="server" CommandName="MoveNext" Text="Activate" OnClick="activate"
                                 ValidationGroup="RegisterUserValidationGroup1"/>
                            </p>

             <p>
                                <asp:Label ID="Label2" runat="server" AssociatedControlID="Label2">Order ID:</asp:Label>
                                <asp:TextBox ID="order_id" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="order_id" 
                                     ValidationGroup="RegisterUserValidationGroup2">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button3" runat="server" CommandName="MoveNext" Text="Update" OnClick="update"
                                 ValidationGroup="RegisterUserValidationGroup2"/>
                            </p>

             <p>
                                <asp:Label ID="Label3" runat="server" AssociatedControlID="Label3">Deal amount:</asp:Label>
                                <asp:TextBox ID="amount" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="amount" 
                                     ValidationGroup="RegisterUserValidationGroup3">*</asp:RequiredFieldValidator>

                 <asp:Label ID="Label4" runat="server" AssociatedControlID="Label4"> Expirydate:</asp:Label>
                                <asp:TextBox ID="date" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="date" 
                                     ValidationGroup="RegisterUserValidationGroup3">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button4" runat="server" CommandName="MoveNext" Text="Create" OnClick="createDeal"
                                 ValidationGroup="RegisterUserValidationGroup3"/>
                            </p>


             <p>
                                <asp:Label ID="Label5" runat="server" AssociatedControlID="Label3">Deal id:</asp:Label>
                                <asp:TextBox ID="deal" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="deal" 
                                     ValidationGroup="RegisterUserValidationGroup4">*</asp:RequiredFieldValidator>

                 <asp:Label ID="Label6" runat="server" AssociatedControlID="Label4">Serial:</asp:Label>
                                <asp:TextBox ID="serial" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="serial" 
                                     ValidationGroup="RegisterUserValidationGroup4">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button5" runat="server" CommandName="MoveNext" Text="Add" OnClick="addDeal"
                                 ValidationGroup="RegisterUserValidationGroup4"/>
                            </p>
             

                   <p>
                                <asp:Label ID="Label7" runat="server" AssociatedControlID="Label5">Deal id:</asp:Label>
                                <asp:TextBox ID="id" runat="server" CssClass="textEntry"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="id" 
                                     ValidationGroup="RegisterUserValidationGroup5">*</asp:RequiredFieldValidator>
              
                            <asp:Button ID="Button6" runat="server" CommandName="MoveNext" Text="check" OnClick="checkdeal"
                                 ValidationGroup="RegisterUserValidationGroup5"/>
                            </p>

          
        </div>
    </form>
</body>
</html>
