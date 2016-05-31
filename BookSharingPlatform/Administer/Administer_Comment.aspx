﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Administer/Administer.master" AutoEventWireup="true" CodeFile="Administer_Comment.aspx.cs" Inherits="Administer_Administer_Comment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="content">
                
                <div class="page-header">
                    <div class="icon">
                        <span class="ico-arrow-right"></span>
                    </div>
                    <h1>书评管理</h1>
                </div>
                <div class="block">
                    <div class="data-fluid" align="right">
                                <button id="DAL" runat="Server" onserverclick="DAL_onclick" class="btn btn-danger">批量删除<span class="ico-cancel"></span></button>
                                <br \>
                            </div> 
                            <div class="head blue">
                                <div class="icon"><span class="ico-user"></span></div>
                                <h2>书评列表</h2>                                                             
                            </div>              
                             
                            <div class="data-fluid">
                                  <asp:GridView ID="GridView1" runat="server" cellpadding="0" width="100%" 
                                    class="table table-hover" AutoGenerateColumns="False" DataKeyNames="UserID"
                                    DataSourceID="SqlDataSource1" OnRowCommand="GridView1_RowCommand"
                                    GridLines="None" AllowPaging="True">
                                    <Columns>
                                        
                                        <asp:TemplateField HeaderText="测试">
                                            <HeaderTemplate>
                                               <input id="cbHeaderChecked" name="cbHeaderChecked" onclick="return SelectChecked()" type="checkbox" /><!--在头部增加CheckBox全选/全消选择框-->
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                               <input id="cbChecked" runat="server" name="cbChecked" type="checkbox" /><!--为绑定的每一行增加选择框-->
                                               <input id="HiddenSysCode" runat="server" style="width: 193px" type="hidden" value='<%# Eval("BookReviewID")%>' /><!--这行很重要，它在一个隐藏控件里放置了一个字段的值，该字段的值将会在按钮事件处理CheckBox选中项的操作中用到-->
                                               <input id="UserID_h" runat="server" style="width: 193px" type="hidden" value='<%# Eval("UserID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="class1" />
                                        </asp:TemplateField>

                                        <asp:HyperLinkField DataNavigateUrlFields="BookReviewID" 
                                                 DataNavigateUrlFormatString="../PersonalWeb_other/ScanInfo.aspx?HostID={0}" 
                                                 DataTextField="Content" HeaderText="内容"> 
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="class1"/>
                                        </asp:HyperLinkField>
                                        
                                        <asp:BoundField DataField="DateTime" HeaderText="日期" 
                                            SortExpression="DateTime" >
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="class1"/>
                                        </asp:BoundField>
                                       
                                        <asp:BoundField DataField="Title" HeaderText="图书名" 
                                            SortExpression="[Book].Title">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="class1" />
                                        </asp:BoundField>
                                        
                                        <asp:BoundField DataField="Name" HeaderText="作者" 
                                            SortExpression="Name">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="class1" />
                                        </asp:BoundField>

                                        <asp:TemplateField ShowHeader="False">
                                             <ItemTemplate>  
                                                <asp:Button ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Del"  
                                                       Text="删除" CssClass="btn btn_success" CommandArgument= '<%#Eval("BookReviewID")%>'></asp:Button>  
                                                </ItemTemplate>  
                                             <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="class1"/>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                             <ItemTemplate>  
                                                <asp:Button ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Scan"  
                                                       Text="查看详细信息" CssClass="btn" CommandArgument= '<%#Eval("BookReviewID")%>'></asp:Button>  
                                                </ItemTemplate>  
                                             <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="class1"/>
                                        </asp:TemplateField>
                                        
                                    </Columns>
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <PagerTemplate>
         <br />
         <div class="span10">
         <div class="block">
         <asp:Label ID="lblPage" runat="server" CssClass="class3" Text='<%# "第" + (((GridView)Container.NamingContainer).PageIndex + 1)  + "页/共" + (((GridView)Container.NamingContainer).PageCount) + "页" %> '></asp:Label>
         <asp:LinkButton ID="lbnFirst" runat="Server" Text="首页"  Enabled='<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>' CommandName="Page" CommandArgument="First" ></asp:LinkButton>
        <asp:LinkButton ID="lbnPrev" runat="server" Text="上一页" Enabled='<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>' CommandName="Page" CommandArgument="Prev"  ></asp:LinkButton>
        <asp:LinkButton ID="lbnNext" runat="Server" Text="下一页" Enabled='<%# ((GridView)Container.NamingContainer).PageIndex != (((GridView)Container.NamingContainer).PageCount - 1) %>' CommandName="Page" CommandArgument="Next" ></asp:LinkButton>
         <asp:LinkButton ID="lbnLast" runat="Server" Text="尾页" Enabled='<%# ((GridView)Container.NamingContainer).PageIndex != (((GridView)Container.NamingContainer).PageCount - 1) %>' CommandName="Page" CommandArgument="Last" ></asp:LinkButton>
         到第
         
         <asp:TextBox runat="server" ID="inPageNum" CssClass="class2" Width="10%"></asp:TextBox>
         页<asp:Button ID="Button1" Text="Go" CssClass="btn" CommandName="go" runat="server" />
         </div>
         </div>
         </div>
         <br />
     </PagerTemplate>
     </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:BookSharingPlatformConnectionString %>" 
           SelectCommand="SELECT * FROM [User],[Book],[BookReview] WHERE [User].[UserID] = [BookReview].[UserID] AND [Book].[BookID] = [BookReview].[BookID]">
     </asp:SqlDataSource>
                            </div> 
                        
                        </div> 
                
            </div>

</asp:Content>

