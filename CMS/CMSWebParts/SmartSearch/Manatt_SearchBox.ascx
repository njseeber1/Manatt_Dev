<%@ Control Language="C#" AutoEventWireup="true"
    Inherits="CMSWebParts_SmartSearch_Manatt_SearchBox"  CodeFile="~/CMSWebParts/SmartSearch/Manatt_SearchBox.ascx.cs" %>
<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnImageButton" CssClass="searchBox" EnableViewState="false">
    <cms:LocalizedLabel DisplayColon="true" ID="lblSearch" runat="server" AssociatedControlID="txtWord" EnableViewState="false" />
    <span class="search-inputtext"><cms:CMSTextBox ID="txtWord" runat="server" EnableViewState="false"  MaxLength="1000" ProcessMacroSecurity="false" /></span>
    <cms:CMSButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" EnableViewState="false" ButtonStyle="Default" />
    <asp:ImageButton ID="btnImageButton" runat="server" Visible="false" OnClick="btnImageButton_Click"
        EnableViewState="false" />
    <asp:Panel ID="pnlPredictiveResultsHolder" runat="server" CssClass="predictiveSearchHolder" EnableViewState="false" />
</asp:Panel>
