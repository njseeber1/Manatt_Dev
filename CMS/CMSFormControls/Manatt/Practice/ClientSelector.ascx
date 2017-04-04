<%@ Control Language="C#" AutoEventWireup="true" CodeFile="~/CMSFormControls/Manatt/Practice/ClientSelector.ascx.cs" Inherits="CMSFormControls_Manatt_Practice_ClientSelector" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>

<div class="cms-bootstrap">
    <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
    <asp:Button runat="server" ID="btnAddRelationship" Text="Add Practice Client & Logo" CssClass="btn btn-default" OnClientClick="modalDialog('/CMSFormControls/Manatt/Practice/AddPracticeRelatedClient.aspx', 'AddPracticeRelatedClient', '500', '300'); return false;" />
    <div style="height: 10px;"></div>
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <cms:UniGrid ID="PracticeClientGrid" runat="server">
                <GridActions>
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />
                </GridActions>
                <GridColumns>
                    <ug:Column Source="ClientName" Caption="Name" Width="30%" />
                    <ug:Column Source="ClientLogo" Caption="Logo" Width="70%" externalsourcename="#htmlencode" runat="server"/>
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <asp:Label runat="server" ID="labelForm" Visible="false"></asp:Label>
</div>
