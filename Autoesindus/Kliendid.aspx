<%@ Page Title="Kliendid" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Kliendid.aspx.cs" Inherits="Autoesindus.Kliendid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-head">
        <div>
            <h1>Kliendid</h1>
            <p class="sub">Salongi kliendibaas</p>
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server" Visible="false" />

    <div class="card">
        <div class="form-grid cols-3">
            <div class="field" style="grid-column: span 2;"><label>Otsing</label><asp:TextBox ID="txtOtsi" runat="server" placeholder="Nimi või telefon" /></div>
            <div class="field" style="align-self: end;">
                <asp:Button ID="btnOtsi" runat="server" Text="Otsi" CssClass="btn btn-primary" OnClick="btnOtsi_Click" />
                <asp:Button ID="btnTuhista" runat="server" Text="Tühista" CssClass="btn btn-light" OnClick="btnTuhista_Click" />
            </div>
        </div>
        <span class="count"><asp:Literal ID="litCount" runat="server" /></span>
    </div>

    <div class="tbl-wrap">
        <asp:Repeater ID="rep" runat="server" OnItemCommand="rep_ItemCommand">
            <HeaderTemplate>
                <table class="tbl">
                    <thead><tr><th>Eesnimi</th><th>Perenimi</th><th>Telefon</th><th class="num">Tellimusi</th><th></th></tr></thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><b><%#: Eval("eesnimi") %></b></td>
                    <td><%#: Eval("perenimi") %></td>
                    <td><%#: Eval("telefon") %></td>
                    <td class="num"><%#: Eval("Tellimusi") %></td>
                    <td class="actions">
                        <asp:LinkButton ID="btnDel" runat="server" Text="Kustuta" CssClass="act danger"
                            CommandName="kustuta" CommandArgument='<%# Eval("Id") %>'
                            OnClientClick="return confirm('Kas oled kindel, et soovid kliendi kustutada?');" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate></tbody></table></FooterTemplate>
        </asp:Repeater>
        <asp:Panel ID="pnlTuhi" runat="server" Visible="false" CssClass="empty">Ühtegi klienti ei leitud.</asp:Panel>
    </div>

    <div class="card">
        <h2>Lisa uus klient</h2>
        <div class="form-grid cols-3">
            <div class="field"><label>Eesnimi</label><asp:TextBox ID="txtEes" runat="server" /></div>
            <div class="field"><label>Perenimi</label><asp:TextBox ID="txtPere" runat="server" /></div>
            <div class="field"><label>Telefon</label><asp:TextBox ID="txtTel" runat="server" placeholder="+372 5555 5555" /></div>
        </div>
        <asp:Button ID="btnAdd" runat="server" Text="Lisa klient" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
    </div>
</asp:Content>
