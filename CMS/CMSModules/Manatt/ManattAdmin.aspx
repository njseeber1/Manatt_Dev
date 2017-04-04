<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManattAdmin.aspx.cs" Inherits="CMSModules_ManattAdmin_ManattAdmin" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cms-bootstrap">
            <ajaxToolkit:ToolkitScriptManager ID="manScript" runat="server" EnableViewState="false" />
            <div>
                <asp:Button ID="btnNew" runat="server" Text="New Admin User" OnClick="btnNew_Click" CssClass="btn btn-primary" /></div>
            <br />
            <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
            <cms:UniGrid ID="UserGrid" runat="server" OrderBy="UserName">
                <gridactions>
                    <ug:Action Name="edit" Caption="$General.Edit$" FontIconClass="icon-edit" FontIconStyle="allow" />
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />
                </gridactions>
                <gridcolumns>
                    <ug:Column Source="UserName" Caption="$general.username$" Width="20%" />
                    <ug:Column Source="FullName" Caption="$general.fullname$" Width="20%" />
                    <ug:Column Source="Email" Caption="$general.email$" Width="20%" />
                    <ug:Column Source="UserEnabled" Caption="User Enabled" Width="40%" />
                </gridcolumns>
            </cms:UniGrid>
            <div id="success" class="alert-success alert" runat="server" style="opacity: 1; position: absolute;" visible="false">
                <span class="alert-icon"><i class="icon-check-circle"></i><span class="sr-only">Success</span></span><div class="alert-label">
                    <asp:Label runat="server" ID="lblSuccess"></asp:Label></div>
            </div>
            <div id="error" class="alert-error alert" runat="server" style="opacity: 1; position: absolute;" visible="false">
                <span class="alert-icon"><i class="icon-times-circle"></i><span class="sr-only">Error</span></span><div class="alert-label">
                    <asp:Label runat="server" ID="lblError"></asp:Label></div>
            </div>
        </div>
    </form>
</body>
</html>
