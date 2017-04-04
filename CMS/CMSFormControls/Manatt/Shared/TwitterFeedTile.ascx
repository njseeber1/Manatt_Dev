<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TwitterFeedTile.ascx.cs" Inherits="CMSFormControls_Manatt_Shared_TwitterFeedTile" %>

<asp:Repeater runat="server" ID="rptTwitterFeed">
    <ItemTemplate>
         <div class="item clearfix <%# Container.ItemIndex == 0 ? "active":"" %>">
        <article class="tile small hover no-desc no-desc col-md-12 col-sm-12 col-xs-12">            
            <section class="caption-box animated-fast">
                <a href="<%#Eval("Link") %>" target="_blank">
                    <p class="lead serif"><%#Eval("Text") %></p>
                    <p class="date"><%#Eval("DateText") %></p>
                </a>
            </section>           
        </article>
             </div>
    </ItemTemplate>
</asp:Repeater>
<asp:Label runat="server" ID="lblError" Visible="false"></asp:Label>