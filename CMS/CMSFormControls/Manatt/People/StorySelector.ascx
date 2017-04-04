<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StorySelector.ascx.cs" Inherits="CMSFormControls_Manatt_People_StorySelector" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>

<div class="cms-bootstrap">
    <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <asp:Button runat="server" ID="btnAddRelationship" Text="Add Story" CssClass="btn btn-default" />
            <div style="height: 10px;"></div>
            <cms:UniGrid ID="StoryGrid" runat="server">
                <GridActions>
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />
                </GridActions>
                <GridColumns>
                    <ug:Column Source="Story" Caption="Story" Width="100%" />                    
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <asp:Label runat="server" ID="labelForm" Visible="false"></asp:Label>
</div>

