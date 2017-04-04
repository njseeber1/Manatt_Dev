<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddPrimaryPracticeRoleRelated.aspx.cs" Inherits="CMSFormControls_Manatt_People_AddPrimaryPracticeRoleRelated" Theme="Default" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="server">
    <div class="form-horizontal" style="align-items: center;">
        <div class="form-group">
            <div class="editing-form-label-cell">
                <asp:Label ID="lblPrimaryPractice" runat="server" CssClass="control-label editing-form-label" />
            </div>
            <div class="editing-form-value-cell">
                <asp:DropDownList ID="ddlPractice" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <div class="editing-form-label-cell">
                <asp:Label ID="lblRole" runat="server" CssClass="control-label editing-form-label" /></div>
            <div class="editing-form-value-cell">
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <div class="editing-form-label-cell">
                <asp:Label ID="lblOrder" runat="server" CssClass="control-label editing-form-label" /></div>
            <div class="editing-form-value-cell">
                <asp:TextBox runat="server" ID="txtOrderNumber" TextMode="Number" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
</asp:Content>
