<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AuthorSelector.ascx.cs" Inherits="CMSFormControls_Manatt_Insight_AuthorSelector" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>

<div class="cms-bootstrap">
    <asp:Label runat="server" ID="lblInfo" EnableViewState="false" Visible="false" />
    <asp:Button runat="server" ID="btnAddRelationship" Text="Add Author" CssClass="btn btn-default" />
    <div style="height: 10px;"></div>
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <cms:UniGrid ID="AuthorGrid" runat="server">
                <GridActions>
                    <ug:Action Name="delete" Caption="$General.Delete$" FontIconClass="icon-bin" FontIconStyle="critical" Confirmation="$General.ConfirmDelete$" />
                </GridActions>
                <GridColumns>
                    <ug:Column Source="AuthorName" Caption="Author" Width="20%" />
                    <ug:Column Source="AuthorRole" Caption="Role" Width="30%" />
                    <ug:Column Source="PrimaryPractice" Caption="Primary Practice" Width="50%" />
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <asp:Label runat="server" ID="labelForm" Visible="false"></asp:Label>
</div>