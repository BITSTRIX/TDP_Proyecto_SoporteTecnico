<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Menu.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="PIII_Examen_II_PaginaBD.pages.Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            color:aliceblue;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../css/StyleInicio.css" rel="stylesheet" />
    <div>
        <svg>
            <text x="50%" y="50%" dy=".35em" text-anchor="middle">
			BIENVENIDO AL SISTEMA 
		</text>
        </svg>
    </div>
    <div class="Nombre">
    <strong>
    <asp:Label ID="lblNombre" runat="server" Text="Label" CssClass="auto-style1"></asp:Label>
        <br />
        <asp:Label ID="lblRol" runat="server" Text="Label" CssClass="auto-style1"></asp:Label>
    </strong>
        <br />
        </div class="Nombre">
    <div class ="Creditos">
        <text>Desarrollado por: </text>
        <br />
        <text>Jose Antonio Valerio  & Luis Bolaños Dixon</text>
        <br />
        <text>TECNICAS DE PROGRAMACION</text>
    </div>
</asp:Content>
