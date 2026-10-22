<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Autoesindus.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>Autod</h2>
<p>
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:DataList ID="DataList1" runat="server">
    </asp:DataList>
    </p>
    </main>
</asp:Content>
