<%@ Page Title="Contact" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.vb" Inherits="XMLRakendus.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
     <main>
     <h1>XML katsetamine: Elizaveta II sugupuu</h1>

     <div>
         <asp:Xml runat="server"
             DocumentSource="~/MinuSugupuu.xml"
             TransformSource="~/Minu2paring.xslt">

         </asp:Xml>
     </div>
 </main>
</asp:Content>
