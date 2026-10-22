<%@ Page Title="Lisa auto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LisaAuto.aspx.cs" Inherits="Autoesindus.LisaAuto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-head">
        <div>
            <h1><asp:Literal ID="litPealkiri" runat="server" Text="Lisa uus auto" /></h1>
            <p class="sub">Täida andmed ja vali soovi korral lisavarustus</p>
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server" Visible="false" />

    <div class="card">
        <div class="form-grid cols-2">
            <div class="field"><label>Mark</label><asp:DropDownList ID="ddlMark" runat="server" /></div>
            <div class="field"><label>Mudel</label><asp:TextBox ID="txtNimi" runat="server" /></div>
            <div class="field"><label>Kategooria</label><asp:DropDownList ID="ddlKat" runat="server" /></div>
            <div class="field"><label>Hind (€)</label><asp:TextBox ID="txtHind" runat="server" /></div>
            <div class="field span-all"><label>Kirjeldus</label><asp:TextBox ID="txtKirj" runat="server" TextMode="MultiLine" Rows="3" /></div>
            <div class="field span-all"><label>Lisavarustus</label><asp:CheckBoxList ID="cblLisa" runat="server" RepeatLayout="UnorderedList" CssClass="checks" /></div>
        </div>
        <div class="form-actions">
            <asp:Button ID="btnSave" runat="server" Text="Salvesta" CssClass="btn btn-primary" OnClick="btnSave_Click" />
            <a class="btn btn-light" href="<%= ResolveUrl("~/Autod") %>">Tühista</a>
        </div>
    </div>
</asp:Content>
