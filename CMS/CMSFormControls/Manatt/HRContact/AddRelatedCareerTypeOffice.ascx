<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddRelatedCareerTypeOffice.ascx.cs" Inherits="CMSFormControls_Manatt_HRContact_AddRelatedCareerTypeOffice" %>

<asp:Panel runat="server" ID="pnlContainer">    
    <cms:MessagesPlaceHolder ID="plcMess" runat="server" />
    <div class="form-horizontal">
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblCareer" runat="server" CssClass="form-control-text" />
                <asp:DropDownList ID="ddlCareer" runat="server"></asp:DropDownList>
            </div>
        </div>        
        <%--<div class="form-group">
            <div class="editing-form-value-cell editing-form-value-cell-offset">
                <cms:LocalizedButton ID="btnSwitchSides" runat="server" ButtonStyle="Default"
                    OnClientClick="SwitchSides();return false;" ResourceString="Relationship.SwitchSides" />
                <cms:FormSubmitButton ID="btnOk" runat="server" OnClick="btnOk_Click" />
            </div>
        </div>--%>
    </div>
    <asp:HiddenField ID="hdnSelectedNodeId" runat="server" Value="" />
    <asp:HiddenField ID="hdnCurrentOnLeft" runat="server" Value="true" />
</asp:Panel>
