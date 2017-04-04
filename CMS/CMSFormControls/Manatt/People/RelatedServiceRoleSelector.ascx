<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RelatedServiceRoleSelector.ascx.cs" Inherits="CMSFormControls_Manatt_People_RelatedServiceRoleSelector" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>

<div class="cms-bootstrap">
    <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <asp:Button runat="server" ID="btnAddRelationshipService" Text="Add Related Service / Role" CssClass="btn btn-default" />
            <div style="height: 10px;"></div>
            <cms:UniGrid ID="PeopleRelatedServiceGrid" runat="server">
                <GridActions>
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />
                </GridActions>
                <GridColumns>
                    <ug:Column Source="RelatedService" Caption="Related Service" Width="40%" />
                    <ug:Column Source="Role" Caption="Role" Width="50%" />
                    <ug:Column Source="OrderNumber" Caption="Order Number" Width="10%" />
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <asp:Label runat="server" ID="labelForm" Visible="false"></asp:Label>
</div>
