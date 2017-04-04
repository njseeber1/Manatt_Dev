<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddRelatedOtherClient.aspx.cs" Inherits="CMSFormControls_Manatt_Client_AddRelatedOtherClient" Theme="Default" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="server">
    <div class="form-horizontal" style="align-items:center;">
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblOtherClientName" runat="server" CssClass="form-control-text" /> </div>      
            <div class="editing-form-value-cell"> 
                <asp:TextBox ID="txtOtherClientName" runat="server" CssClass="form-control-text" Width="300" />
            </div>
        </div>    
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblOtherClientLogo" runat="server" CssClass="form-control-text" /> 
                </div>      
            <div class="editing-form-value-cell">         
                <cms:MediaSelector ID="mediaSelectorOther" runat="server" ShowClearButton="true"/>                
            </div>
        </div>    
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblOtherClientURL" runat="server" CssClass="form-control-text" /> 
                </div>      
            <div class="editing-form-value-cell">         
                <cms:UrlSelector ID="urlSelectorOther" runat="server" ShowClearButton="true"/>                
            </div>
        </div>    
    </div>
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
</asp:Content>
