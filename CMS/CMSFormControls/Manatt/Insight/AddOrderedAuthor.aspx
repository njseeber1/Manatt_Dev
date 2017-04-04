<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddOrderedAuthor.aspx.cs" Inherits="CMSFormControls_Manatt_Insight_AddOrderedAuthor" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master" Theme="Default" %>

<%@ Register Src="~/CMSAdminControls/UI/UniSelector/UniSelector.ascx" TagName="UniSelector" TagPrefix="cms" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="server">
    <div class="form-horizontal" style="align-items: center;">
        <div class="form-group">
            <div class="editing-form-label-cell">
                <asp:Label ID="lblAuthor" runat="server" CssClass="control-label editing-form-label" />
            </div>
            <div class="editing-form-value-cell">
                <cms:UniSelector ID="UserSelector" ValuesSeparator="~" runat="server" ObjectType="CMS.Document" ObjectSiteName="Manatt" WhereCondition="ClassName='Manatt.People'" OrderBy="DocumentName" SelectionMode="SingleDropDownList" ReturnColumnName="DocumentID" />
            </div>
        </div>
        <div class="form-group">
            <div class="editing-form-label-cell">
                <asp:Label ID="lblOrder" runat="server" CssClass="control-label editing-form-label" />
            </div>
            <div class="editing-form-value-cell">
                <asp:TextBox runat="server" ID="txtOrderNumber" TextMode="Number" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
</asp:Content>
