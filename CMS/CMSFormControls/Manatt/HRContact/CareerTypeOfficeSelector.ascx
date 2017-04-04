<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CareerTypeOfficeSelector.ascx.cs" Inherits="CMSFormControls_Manatt_HRContact_CareerTypeOfficeSelector" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>

<div class="cms-bootstrap">
    <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
    <asp:Button runat="server" ID="btnAddRelationship" Text="Add Career Type / Office" CssClass="btn btn-default" OnClientClick="modalDialog('/CMSFormControls/Manatt/HRContact/AddCareerTypeOfficeRelated.aspx', 'AddCareerTypeOfficeRelated', '900', '315'); return false;" />
    <div style="height: 10px;"></div>
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <cms:UniGrid ID="HRContactGrid" runat="server">
                <GridActions>
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />
                </GridActions>
                <GridColumns>
                    <ug:Column Source="CareerType" Caption="Career" Width="20%" />
                    <ug:Column Source="Office" Caption="Office" Width="80%" />
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <asp:Label runat="server" ID="labelForm"></asp:Label>
</div>
