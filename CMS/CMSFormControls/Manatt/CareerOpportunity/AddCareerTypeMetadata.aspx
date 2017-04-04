<%@ Page Language="C#" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master" AutoEventWireup="true" CodeFile="AddCareerTypeMetadata.aspx.cs" Theme="Default" Inherits="CMSFormControls_Manatt_CareerOpportunity_AddCareerTypeMetadata" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="server">
    <div class="form-horizontal" style="align-items:center;">
        <div class="form-group">
            <div class="editing-form-value-cell">
                <asp:Label ID="lblName" runat="server" CssClass="form-control-text" Text="Name: " />
                <asp:TextBox MaxLength="300" runat="server" ID="txtName"></asp:TextBox>
            </div>
            <div class="editing-form-value-cell">
                <asp:Label ID="Label1" runat="server" CssClass="form-control-text" Text="Content: " />
               <%--<cms:CMSEditableRegion ID="CMSEditableRegion1" runat="server" RegionTitle="Content" DialogHeight="400" RegionType="HTMLEditor"  />      --%>
                <asp:TextBox runat="server" ID="txtContent" TextMode="MultiLine"></asp:TextBox>
                                     
            </div>
        </div>              
    </div>
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
    <script src="//cdn.ckeditor.com/4.5.9/standard-all/ckeditor.js"></script>
    <script>
        CKEDITOR.replace('m_c_txtContent', {
			height: 400
		} );
	</script>
</asp:Content>


