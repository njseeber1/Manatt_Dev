﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddInsightCateogry.aspx.cs" Inherits="CMSFormControls_Manatt_Insight_AddInsightCateogry"  Theme="Default" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="server">
    <div class="form-horizontal" style="align-items: center;">
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblCategory" runat="server" CssClass="form-control-text" />
            </div>
            <div class="editing-form-value-cell">
                <asp:DropDownList ID="ddlCategory" runat="server"></asp:DropDownList>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
</asp:Content>
