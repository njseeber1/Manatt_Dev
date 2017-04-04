<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderedAuthorSelector.ascx.cs" Inherits="CMSFormControls_Manatt_Insight_OrderedAuthorSelector" %>
<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>

<div class="cms-bootstrap">
    <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <asp:Button runat="server" ID="btnAddAuthor" Text="Add Author" CssClass="btn btn-default" />
            <div style="height: 10px;"></div>
            <cms:UniGrid ID="ugAuthors" runat="server">
                <GridActions>
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />
                </GridActions>
                <GridColumns>
                    <ug:Column Source="FullName" Caption="Name" />
                    <ug:Column Source="ItemOrder" Caption="Order Number" />
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <asp:Label runat="server" ID="labelForm" Visible="false"></asp:Label>
</div>
