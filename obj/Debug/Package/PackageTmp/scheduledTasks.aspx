<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="scheduledTasks.aspx.cs" Inherits="SbirkaPrikladuEU.scheduledTasks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
        <div class="row"><div class="well"><h1>Automatická denní údržba systému <small>Automaticky se provádí denně v 0:00 CET</small></h1></div></div>
        <div class="row">
            <div class="well">
                <h2>User Management</h2>
                <ul id="userManagementUL" class="unstyled" runat="server"></ul>
                <br />
                <h2>Systém souborů</h2>
                <ul id="fileSystemUL" class="unstyled" runat="server"></ul>
            </div>        
        </div>
</asp:Content>