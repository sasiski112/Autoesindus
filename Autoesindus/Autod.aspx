<%@ Page Title="Autod" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Autod.aspx.cs" Inherits="Autoesindus.Autod" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-head">
        <div>
            <h1>Kõik autod</h1>
            <p class="sub">Salongis saadaolevate autode nimekiri</p>
        </div>
        <a class="btn btn-primary" href="<%= ResolveUrl("~/LisaAuto") %>">+ Lisa auto</a>
    </div>

    <asp:Label ID="lblMsg" runat="server" Visible="false" />

    <div class="card">
        <div class="form-grid cols-4">
            <div class="field"><label>Otsing</label><asp:TextBox ID="txtOtsi" runat="server" placeholder="Mudel või mark" /></div>
            <div class="field"><label>Mark</label><asp:DropDownList ID="ddlMark" runat="server" /></div>
            <div class="field"><label>Kategooria</label><asp:DropDownList ID="ddlKat" runat="server" /></div>
            <div class="field"><label>Sorteeri</label>
                <asp:DropDownList ID="ddlSort" runat="server">
                    <asp:ListItem Value="" Text="Mark ja mudel" />
                    <asp:ListItem Value="hind_asc" Text="Hind: odavamad enne" />
                    <asp:ListItem Value="hind_desc" Text="Hind: kallimad enne" />
                    <asp:ListItem Value="mudel" Text="Mudel A–Z" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="filter-actions">
            <asp:Button ID="btnFilter" runat="server" Text="Filtreeri" CssClass="btn btn-primary" OnClick="btnFilter_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Tühista filtrid" CssClass="btn btn-light" OnClick="btnReset_Click" />
            <span class="count"><asp:Literal ID="litCount" runat="server" /></span>
        </div>
    </div>

    <div class="tbl-wrap">
        <asp:Repeater ID="rep" runat="server" OnItemCommand="rep_ItemCommand">
            <HeaderTemplate>
                <table class="tbl">
                    <thead><tr>
                        <th>Mark</th><th>Mudel</th><th>Kategooria</th><th>Lisavarustus</th><th class="num">Hind</th><th></th>
                    </tr></thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><b><%#: Eval("Mark") %></b></td>
                    <td><%#: Eval("Mudel") %><div class="muted"><%#: Eval("kirjeldus") %></div></td>
                    <td><%#: Eval("Kat") %></td>
                    <td class="muted"><%#: Eval("Extras") %></td>
                    <td class="num"><b><%#: Eval("Hind") %></b></td>
                    <td class="actions">
                        <a class="act" href="<%# ResolveUrl("~/LisaAuto") %>?id=<%# Eval("Id") %>">Muuda</a>
                        <asp:LinkButton ID="btnDel" runat="server" Text="Kustuta" CssClass="act danger"
                            CommandName="kustuta" CommandArgument='<%# Eval("Id") %>'
                            OnClientClick="return confirm('Kas oled kindel, et soovid selle auto kustutada?');" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate></tbody></table></FooterTemplate>
        </asp:Repeater>
        <asp:Panel ID="pnlTuhi" runat="server" Visible="false" CssClass="empty">Ühtegi autot ei leitud.</asp:Panel>
    </div>
</asp:Content>
