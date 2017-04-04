<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CompanyAdminUsers.aspx.cs" Inherits="CMSModules_ManattAdmin_CompanyAdminUsers" %>

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
            <h3>Manatt Client Admin Users</h3>
            <div><asp:Button ID="btnNew" runat="server" Text="New Admin User" OnClick="btnNew_Click" CssClass="btn btn-primary"/></div>
            <br />
            <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
            <cms:UniGrid ID="UserGrid" runat="server" OrderBy="UserName">
                <GridActions>
                    <ug:Action Name="edit" Caption="$General.Edit$" FontIconClass="icon-edit" FontIconStyle="allow" />
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="allow" Confirmation="$General.ConfirmDelete$" />
                </GridActions>
                <GridColumns>
                    <ug:Column Source="UserName" Caption="$general.username$" Width="20%" />
                    <ug:Column Source="FullName" Caption="$general.fullname$" Width="20%" />
                    <ug:Column Source="Email" Caption="$general.email$" Width="20%" />
                    <ug:Column Source="UserEnabled" Caption="User Enabled" Width="40%" />
                </GridColumns>
            </cms:UniGrid>
        </div>
    </form>
</body>
</html>
