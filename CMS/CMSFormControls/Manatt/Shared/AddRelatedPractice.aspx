<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddRelatedPractice.aspx.cs" Inherits="CMSFormControls_Manatt_Shared_AddRelatedPractice" Theme="Default" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master"  %>

<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="server">
    <div class="form-horizontal" style="align-items:center;">
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblRelatedPractice" runat="server" CssClass="form-control-text" />
                <asp:DropDownList ID="ddlRelatedPractice" runat="server"></asp:DropDownList>
            </div>
        </div>            
    </div>
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
</asp:Content>
