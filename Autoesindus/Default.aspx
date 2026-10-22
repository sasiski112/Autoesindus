<%@ Page Title="Avaleht" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Autoesindus._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="intro">
        <h1>Tere tulemast Autoesindusse</h1>
        <p class="sub">Siit leiad autod, kliendid ja tellimused ühes kohas.</p>
    </div>

    <div class="stats">
        <div class="stat"><b><asp:Literal ID="litAutod" runat="server" Text="–" /></b><small>Autot salongis</small></div>
        <div class="stat"><b><asp:Literal ID="litMargid" runat="server" Text="–" /></b><small>Margid</small></div>
        <div class="stat"><b><asp:Literal ID="litKliendid" runat="server" Text="–" /></b><small>Klienti</small></div>
        <div class="stat"><b><asp:Literal ID="litTellimused" runat="server" Text="–" /></b><small>Tellimust</small></div>
    </div>

    <div class="links">
        <a class="link-card" href="<%= ResolveUrl("~/Autod") %>"><h3>Kõik autod</h3><p>Vaata, otsi ja filtreeri salongi autosid.</p></a>
        <a class="link-card" href="<%= ResolveUrl("~/LisaAuto") %>"><h3>Lisa auto</h3><p>Lisa uus auto koos lisavarustusega.</p></a>
        <a class="link-card" href="<%= ResolveUrl("~/Kliendid") %>"><h3>Kliendid</h3><p>Kliendibaas, lisamine ja otsing.</p></a>
        <a class="link-card" href="<%= ResolveUrl("~/Tellimused") %>"><h3>Tellimused</h3><p>Uute tellimuste vormistamine ja staatused.</p></a>
    </div>
</asp:Content>
