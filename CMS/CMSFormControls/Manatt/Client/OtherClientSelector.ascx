<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OtherClientSelector.ascx.cs" Inherits="CMSFormControls_Manatt_Client_OtherClientSelector" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>

<div class="cms-bootstrap">
    <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
    <asp:Button runat="server" ID="btnAddRelationshipOtherClient" Text="Add Other Client" CssClass="btn btn-default" />
    <div style="height: 10px;"></div>
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <cms:UniGrid ID="OtherClientGrid" runat="server">
                <GridActions>
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />
                </GridActions>
                <GridColumns>
                    <ug:Column Source="ClientName" Caption="Name" Width="20%" />
                    <ug:Column Source="ClientLogo" Caption="Logo" Width="50%" externalsourcename="#htmlencode" runat="server"/>
                    <ug:Column Source="Clienturl" Caption="URL" Width="30%" externalsourcename="#htmlencode" runat="server"/>
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <asp:Label runat="server" ID="labelForm" Visible="false"></asp:Label>
</div>