<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddAuthorRelated.aspx.cs" Inherits="CMSFormControls_Manatt_Newsletters_AddAuthorRelated" Theme="Default" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="server">
    <div class="form-horizontal" style="align-items: center;">
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblAuthor" runat="server" CssClass="form-control-text" />
            </div>
            <div class="editing-form-value-cell">
                <asp:DropDownList ID="ddlAuthor" runat="server"></asp:DropDownList>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
</asp:Content>
