<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditClientUser.aspx.cs" Inherits="CMSModules_ManattAdmin_EditClientUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="userForm" runat="server">
        <div class="cms-bootstrap">
            <div>
                <h3><asp:Label runat="server" ID="lblTitle"></asp:Label></h3>
            </div>
            <div>
                <asp:Button runat="server" ID="btnNewAdmin" CssClass="btn btn-primary" OnClick="btnNewAdmin_Click" Text="Save" />
            </div>
            <br />
            <div class="form-horizontal">
                <div class="form-group">
                    <div class="editing-form-label-cell">
                        <label class="control-label">User name:<span class="required-mark">*</span></label>
                    </div>
                    <div class="editing-form-label-cell">
                        <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control" ></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <div class="editing-form-label-cell">
                        <label class="control-label">First Name:<span class="required-mark">*</span></label>
                    </div>
                    <div class="editing-form-label-cell">
                        <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" ></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <div class="editing-form-label-cell">
                        <label class="control-label">Last Name:<span class="required-mark">*</span></label>
                    </div>
                    <div class="editing-form-label-cell">
                        <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" ></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <div class="editing-form-label-cell">
                        <label class="control-label">Email:<span class="required-mark">*</span></label>
                    </div>
                    <div class="editing-form-label-cell">
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" ></asp:TextBox>
                    </div>
                </div> 
                 <div class="form-group">
                    <div class="editing-form-label-cell">
                        <label class="control-label">Enabled:<span class="required-mark">*</span></label>
                    </div>
                    <div class="editing-form-label-cell">
                        <asp:CheckBox runat="server" ID="cbEnabled" Checked="true"></asp:CheckBox>
                    </div>
                </div>               
            </div>
            <div>
                <asp:Button runat="server" ID="btnResetPassword" CssClass="btn btn-danger" Text="Reset Password" OnClientClick="return clientClick();" OnClick="btnResetPassword_Click" />
                <asp:Button runat="server" ID="btnBack" CssClass="btn btn-red" OnClick="btnBack_Click" Text="Back" />
            </div>
            <br />
            <div id="success" class="alert-success alert" runat="server" style="opacity: 1; position: absolute;" visible="false">
                <span class="alert-icon"><i class="icon-check-circle"></i><span class="sr-only">Success</span></span><div class="alert-label"><asp:Label runat="server" ID="lblSuccess"></asp:Label></div>
            </div>
            <div id="error" class="alert-error alert" runat="server" style="opacity: 1; position: absolute;" visible="false">
                <span class="alert-icon"><i class="icon-check-circle"></i><span class="sr-only">Error</span></span><div class="alert-label"><asp:Label runat="server" ID="lblError"></asp:Label></div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hiddenType" />
    </form>
    <script>
        function clientClick() {
            if (confirm("Are you sure you want to reset password?")) {                
                return true;
            }
            return false;
        }
    </script>
</body>
</html>
