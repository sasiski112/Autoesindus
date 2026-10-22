<%@ Page Title="Tellimused" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tellimused.aspx.cs" Inherits="Autoesindus.Tellimused" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-head">
        <div>
            <h1>Tellimused</h1>
            <p class="sub">Tellimuste nimekiri ja uue tellimuse vormistamine</p>
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server" Visible="false" />

    <div class="tbl-wrap">
        <asp:Repeater ID="rep" runat="server" OnItemCommand="rep_ItemCommand">
            <HeaderTemplate>
                <table class="tbl">
                    <thead><tr>
                        <th>Nr</th><th>Aeg</th><th>Klient</th><th>Salong</th><th>Autod</th><th class="num">Summa</th><th>Staatus</th><th></th>
                    </tr></thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><b>#<%#: Eval("Id") %></b></td>
                    <td><%#: Eval("Aeg") %></td>
                    <td><%#: Eval("KlientNimi") %></td>
                    <td><%#: Eval("Salong") %></td>
                    <td class="muted"><%#: Eval("Autod") %></td>
                    <td class="num"><b><%#: Eval("Summa") %></b></td>
                    <td><span class='badge <%# Eval("Klass") %>'><%#: Eval("Staatus") %></span></td>
                    <td class="actions">
                        <asp:LinkButton runat="server" Text="Kinnita" CssClass="act" CommandName="staatus" CommandArgument='<%# Eval("Id") + "|Kinnitatud" %>' />
                        <asp:LinkButton runat="server" Text="Valmis" CssClass="act" CommandName="staatus" CommandArgument='<%# Eval("Id") + "|Valmis" %>' />
                        <asp:LinkButton runat="server" Text="Tühista" CssClass="act" CommandName="staatus" CommandArgument='<%# Eval("Id") + "|Tühistatud" %>' />
                        <asp:LinkButton runat="server" Text="Kustuta" CssClass="act danger" CommandName="kustuta" CommandArgument='<%# Eval("Id") %>'
                            OnClientClick="return confirm('Kas oled kindel, et soovid tellimuse kustutada?');" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate></tbody></table></FooterTemplate>
        </asp:Repeater>
        <asp:Panel ID="pnlTuhi" runat="server" Visible="false" CssClass="empty">Tellimusi veel ei ole.</asp:Panel>
    </div>

    <div class="card">
        <h2>Uus tellimus</h2>
        <div class="form-grid cols-3">
            <div class="field"><label>Klient</label><asp:DropDownList ID="ddlKlient" runat="server" /></div>
            <div class="field"><label>Salong</label><asp:DropDownList ID="ddlSalong" runat="server" /></div>
            <div class="field"><label>Staatus</label>
                <asp:DropDownList ID="ddlStaatus" runat="server">
                    <asp:ListItem Text="Uus" Value="Uus" />
                    <asp:ListItem Text="Kinnitatud" Value="Kinnitatud" />
                    <asp:ListItem Text="Valmis" Value="Valmis" />
                </asp:DropDownList>
            </div>
            <div class="field"><label>Kuupäev</label><asp:TextBox ID="txtKuup" runat="server" TextMode="Date" /></div>
            <div class="field"><label>Kellaaeg</label><asp:TextBox ID="txtKell" runat="server" TextMode="Time" /></div>
        </div>
        <div class="field" style="margin-bottom: 18px;">
            <label>Autod (vali üks või mitu)</label>
            <asp:CheckBoxList ID="cblAutod" runat="server" RepeatLayout="UnorderedList" CssClass="checks" />
        </div>
        <asp:Button ID="btnSave" runat="server" Text="Salvesta tellimus" CssClass="btn btn-primary" OnClick="btnSave_Click" />
    </div>
</asp:Content>
