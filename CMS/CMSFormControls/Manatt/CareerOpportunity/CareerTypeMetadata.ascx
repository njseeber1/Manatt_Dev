<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CareerTypeMetadata.ascx.cs" Inherits="CMSFormControls_Manatt_CareerOpportunity_CareerTypeMetadata" %>
<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>
<div class="cms-bootstrap">
    <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <asp:Button runat="server" ID="btnAddMetadata" Text="Add Content" CssClass="btn btn-default" />
            <div style="height: 10px;"></div>
            <cms:UniGrid ID="metadataUniGrid" runat="server">
                <GridActions>
                    <ug:Action Name="edit" ExternalSourceName="editaction" Caption="$General.Edit$" FontIconClass="icon-edit" FontIconStyle="Allow" />
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />                    
                </GridActions>
                <GridColumns>                                     
                    <ug:Column Source="Name" Caption="Content Name" Width="100%" />                    
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <asp:Label runat="server" ID="labelForm"></asp:Label>
</div>