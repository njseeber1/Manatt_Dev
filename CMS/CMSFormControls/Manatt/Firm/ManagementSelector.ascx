<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ManagementSelector.ascx.cs" Inherits="CMSFormControls_Manatt_Firm_ManagementSelector" %>
<%@ Register Src="~/CMSAdminControls/UI/UniSelector/UniSelector.ascx" TagName="UniSelector" TagPrefix="cms" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>
<%@ Register Src="~/CMSAdminControls/UI/UniControls/UniButton.ascx" TagName="UniButton" TagPrefix="cms" %>

<div class="cms-bootstrap">

    <asp:Label ID="lblStatus" runat="server" EnableViewState="False" CssClass="form-control-text InfoLabel" />
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <cms:UniGrid ID="mgmtGrid" runat="server">
                <GridOptions ShowSelection="true" />                
                <GridColumns>                    
                    <ug:Column Source="PrimaryPracticeTitle" Caption="Primary Title" />
                    <ug:Column Source="FirstName" Caption="First Name" />
                    <ug:Column Source="MiddleName" Caption="Middle Name" />
                    <ug:Column Source="LastName" Caption="Last Name" />
                    <ug:Column Source="Email" Caption="Email Address" />
                </GridColumns>
            </cms:UniGrid>
        </ContentTemplate>
    </cms:CMSUpdatePanel>
    <div id="UniSelectorSpacer" runat="server" class="UniSelectorSpacer">
    </div>
    <div class="btn-actions keep-white-space-fixed">
        <cms:CMSMoreOptionsButton ID="btnRemove" runat="server" ButtonStyle="Default"
            EnableViewState="False" />
        <cms:LocalizedButton ID="btnAddItems" runat="server" ButtonStyle="Default"
            EnableViewState="False" />
        <asp:Button ID="btnRemoveSelected" runat="server" CssClass="HiddenButton" OnClick="btnRemoveSelected_Click" EnableViewState="False" />
        <cms:LocalizedLabel ID="lblDisabledAddButtonExplanationText" ShortID="ldbe" runat="server" CssClass="button-explanation-text" />
    </div>
</div>
<asp:HiddenField ID="hdnDialogSelect" runat="server" EnableViewState="false" />
<asp:HiddenField ID="hdnIdentifier" runat="server" EnableViewState="false" />
<asp:HiddenField ID="hiddenField" runat="server" />
<asp:HiddenField ID="hiddenSelected" runat="server" EnableViewState="false" />
<asp:HiddenField ID="hdnHash" runat="server" />
<asp:HiddenField ID="hdnValue" runat="server" />
