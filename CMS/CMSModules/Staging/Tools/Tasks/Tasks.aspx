<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CMSMasterPages/UI/SimplePage.master"
    Title="Staging - Tasks" Inherits="CMSModules_Staging_Tools_Tasks_Tasks" Theme="Default"
     CodeFile="Tasks.aspx.cs" %>

<%@ Register Src="~/CMSModules/Staging/FormControls/ServerSelector.ascx" TagName="ServerSelector"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>
<%@ Register Src="~/CMSAdminControls/AsyncLogDialog.ascx" TagName="AsyncLog"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSAdminControls/Basic/DisabledModuleInfo.ascx" TagPrefix="cms"
    TagName="DisabledModule" %>

<asp:Content ID="cntHeader" runat="server" ContentPlaceHolderID="plcSiteSelector">
    <div class="form-horizontal form-filter">
        <div class="form-group">
            <div class="filter-form-label-cell">
                <cms:LocalizedLabel CssClass="control-label" ID="lblServers" runat="server" EnableViewState="false" ResourceString="Tasks.SelectServer" />
            </div>
            <div class="filter-form-value-cell-wide">
                <cms:ServerSelector ID="selectorElem" runat="server" IsLiveSite="false" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="cntBody" ContentPlaceHolderID="plcContent" runat="server">
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Label ID="lblInfo" runat="server" CssClass="InfoLabel" EnableViewState="false"
                Visible="false" />
            <asp:Panel runat="server" ID="pnlLog" Visible="false">
                <cms:AsyncLog ID="ctlAsyncLog" runat="server" ProvideLogContext="true" LogContextNames="Synchronization" />
            </asp:Panel>
            <asp:Panel runat="server" ID="pnlNotLogged">
                <cms:DisabledModule runat="server" ID="ucDisabledModule" />
            </asp:Panel>
            <asp:PlaceHolder ID="plcContent" runat="server">
                <asp:Panel ID="pnlTasksGrid" runat="server" Visible="true">
                    <cms:UniGrid ID="tasksUniGrid" runat="server" IsLiveSite="false" OrderBy="TaskTime, TaskID" ExportFileName="staging_task">
                        <GridActions>
                            <ug:action name="view" externalsourcename="view" caption="$General.View$" fonticonclass="icon-eye" fonticonstyle="allow" />
                            <ug:action name="synchronize" caption="$general.synchronize$" fonticonclass="icon-rotate-double-right" />
                            <ug:action name="delete" caption="$General.Delete$" fonticonclass="icon-bin" fonticonstyle="critical" confirmation="$Tasks.ConfirmDelete$" />
                        </GridActions>
                        <GridColumns>
                            <ug:Column source="##ALL##" externalsourcename="TaskTitle" caption="$tasks.headertitle$" sort="TaskTitle" wrap="false" cssclass="main-column-100" >
                              <ug:Tooltip source="TaskTitle" width="0" />
                            </ug:Column>
                            <ug:Column source="TaskType" caption="$Tasks.HeaderType$" externalsourcename="TaskType" wrap="false" />
                            <ug:Column source="TaskTime" caption="$tasks.headertime$" wrap="false" />
                            <ug:Column source="##ALL##" caption="$tasks.headerresult$" externalsourcename="TaskResult" />
                        </GridColumns>
                        <GridOptions ShowSelection="true" SelectionColumn="TaskID" DisplayFilter="true" FilterPath="~/CMSModules/Staging/Tools/Controls/StagingTasksFilter.ascx"/>   
                    </cms:UniGrid>
                </asp:Panel>
                <br />
                <asp:Panel ID="pnlFooter" runat="server" CssClass="Clear">
                    <table class="Table100">
                        <tr>
                            <td>
                                <cms:LocalizedButton runat="server" ID="btnSyncSelected" ButtonStyle="Default" OnClick="btnSyncSelected_Click"
                                    ResourceString="Tasks.SyncSelected" EnableViewState="false" />
                                <cms:LocalizedButton runat="server" ID="btnSyncAll" ButtonStyle="Default" OnClick="btnSyncAll_Click"
                                    ResourceString="Tasks.SyncAll" EnableViewState="false" />
                            </td>
                            <td class="TextRight">
                                <cms:LocalizedButton runat="server" ID="btnDeleteSelected" ButtonStyle="Default"
                                    OnClick="btnDeleteSelected_Click" ResourceString="Tasks.DeleteSelected" EnableViewState="false" />
                                <cms:LocalizedButton runat="server" ID="btnDeleteAll" ButtonStyle="Default" OnClick="btnDeleteAll_Click"
                                    ResourceString="Tasks.DeleteAll" EnableViewState="false" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </asp:PlaceHolder>
            <cms:CMSButton ID="btnSyncComplete" runat="server" Visible="false" ButtonStyle="Primary" />
            <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
        </ContentTemplate>
    </cms:CMSUpdatePanel>
</asp:Content>
