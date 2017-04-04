<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddPracticeRelatedClient.aspx.cs" Inherits="CMSFormControls_Manatt_Practice_AddPracticeRelatedClient" Theme="Default" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="server">
    <div class="form-horizontal" style="align-items:center;">
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblClientName" runat="server" CssClass="form-control-text" /> </div>      
            <div class="editing-form-value-cell"> 
                <asp:TextBox ID="txtClientName" runat="server" CssClass="form-control-text" Width="300" />
            </div>
        </div>    
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblClientLogo" runat="server" CssClass="form-control-text" /> 
                </div>      
            <div class="editing-form-value-cell">         
                <cms:MediaSelector ID="mediaSelector" runat="server" ShowClearButton="true"/>
            </div>
        </div>    
    </div>
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
</asp:Content>
