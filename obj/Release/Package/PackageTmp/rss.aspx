<%@ Page Language="C#" ContentType="text/xml" AutoEventWireup="false" CodeBehind="rss.aspx.cs" Inherits="SbirkaPrikladuEU.rss" Theme="" %>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>" SelectCommand="SELECT [id], [name], [enter], [ownerId], [insertingDate] FROM [examples] WHERE ([status] = @status AND [insertingDate] > DATEADD(d,-15,GETDATE())) ORDER BY [insertingDate] DESC">
<SelectParameters><asp:Parameter DefaultValue="Active" Name="status" Type="String" /></SelectParameters>
</asp:SqlDataSource>
<asp:Repeater id="rssRPT" runat="server" DataSourceID="SqlDataSource1">
  <HeaderTemplate>
    <rss version="2.0">
      <channel>
        <title>Novinky ze SbírkyPříkladů.eu</title>
        <link>http://www.sbirkaprikladu.eu</link>
        <description>
          RSS feed nejdůležitějších událostí na serveru.
        </description>
  </HeaderTemplate>
  <ItemTemplate>
        <item>
          <title><%# FormatForXML(DataBinder.Eval(Container.DataItem, "name")) %></title>
          <description><%# FormatForXML(DataBinder.Eval(Container.DataItem, "enter")) %></description>
          <link>http://www.sbirkaprikladu.eu/p/<%# DataBinder.Eval(Container.DataItem, "id") %></link><author><%# FormatForXML(SbirkaPrikladuEU.user.fullNameFromId(DataBinder.Eval(Container.DataItem, "ownerId").ToString())) %></author>
          <pubDate><%# String.Format("{0:R}", DataBinder.Eval(Container.DataItem, "insertingDate")) %>+2</pubDate>
          <guid><%# FormatForXML(DataBinder.Eval(Container.DataItem, "id")) %></guid>
        </item>
  </ItemTemplate>
  <FooterTemplate>
      </channel>
    </rss>  
  </FooterTemplate>
</asp:Repeater>