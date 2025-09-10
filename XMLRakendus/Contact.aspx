<%@ Page Title="Oma ylesanne" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.vb" Inherits="XMLRakendus.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
     <main>
     <h1>XML katsetamine: Minu sugupuu</h1>

     <div>
         <asp:Xml runat="server"
             DocumentSource="~/MinuSugupuu.xml"
             TransformSource="~/Minu2paring.xslt">

         </asp:Xml>
     </div>
 </main>
</asp:Content>
