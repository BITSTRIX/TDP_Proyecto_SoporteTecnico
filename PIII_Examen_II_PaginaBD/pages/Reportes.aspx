<%@ Page Title="Reportes" Language="C#" MasterPageFile="~/Menu.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="PIII_Examen_II_PaginaBD.pages.Reportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../css/ReportesStyle.css" rel="stylesheet" />
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <div class="Formulario">
        <h2>REPORTE DE USUARIOS</h2>
        <div class="Data">
            <div class="RadioButtons">
                <asp:RadioButtonList ID="RadioButtonListUsuarios" runat="server" Width="185px">
                    <asp:ListItem>Nombre del Usuario</asp:ListItem>
                    <asp:ListItem>ID del Usuario</asp:ListItem>
                    <asp:ListItem>Correo</asp:ListItem>
                    <asp:ListItem>Telefono</asp:ListItem>
                </asp:RadioButtonList>
                <asp:Label ID="Label1" runat="server" Text="Ingrese su consulta: "></asp:Label>
                <br />
                <asp:TextBox ID="txtConsulta" runat="server" Width="168px" Height="26px"></asp:TextBox>
                <br />
                <br />
                <div class="Buttons">
                    <asp:Button ID="btnConsultar" class="btn btn-info" runat="server" Text="Consultar" Style="margin: 4px" OnClick="btnConsultar_Click" />
                </div>
            </div>
            <div class="GridView">
                <asp:GridView ID="datagridUsuarios" class="myGridClass" runat="server"></asp:GridView>
            </div>
        </div>
    </div>


    <div class="Formulario">
        <h2>REPORTE DE ACCESOS AL SISTEMA</h2>
        <div class="Data">
            <div class="RadioButtons">
                <asp:RadioButtonList ID="RadioButtonListAccesos" runat="server" Width="185px">
                    <asp:ListItem>Numero de Acceso</asp:ListItem>
                    <asp:ListItem>ID del Usuario</asp:ListItem>
                    <asp:ListItem>Nombre del Usuario</asp:ListItem>
                    <asp:ListItem>Correo</asp:ListItem>
                    <asp:ListItem>Rol</asp:ListItem>
                </asp:RadioButtonList>
                <asp:Label ID="Label2" runat="server" Text="Ingrese su consulta: "></asp:Label>
                <br />
                <asp:TextBox ID="txtConsultaAccesos" runat="server" Width="168px" Height="26px"></asp:TextBox>
                <br />
                <br />
                <div class="Buttons">
                    <asp:Button ID="btnConsultaAccesos" class="btn btn-info" runat="server" Text="Consultar" Style="margin: 4px" OnClick="btnConsultarAccesos_Click" />
                </div>
            </div>
            <div class="GridView">
                <asp:GridView ID="datagridAccesos" class="myGridClass" runat="server"></asp:GridView>
            </div>
        </div>
    </div>


    <div class="Formulario">
        <h2>REPORTE DE EQUIPOS</h2>
        <div class="Data">
            <div class="RadioButtons">
                <asp:RadioButtonList ID="RadioButtonListEquipos" runat="server" Width="185px">
                    <asp:ListItem>ID del Equipo</asp:ListItem>
                    <asp:ListItem>Tipo de Equipo</asp:ListItem>
                    <asp:ListItem>Modelo</asp:ListItem>
                    <asp:ListItem>Estado</asp:ListItem>
                    <asp:ListItem>ID Usuario</asp:ListItem>
                    <asp:ListItem>Nombre del Usuario</asp:ListItem>
                </asp:RadioButtonList>
                <asp:Label ID="Label3" runat="server" Text="Ingrese su consulta: "></asp:Label>
                <br />
                <asp:TextBox ID="txtConsultaEquipos" runat="server" Width="168px" Height="26px"></asp:TextBox>
                <br />
                <br />
                <div class="Buttons">
                    <asp:Button ID="btnConsultaEquipos" class="btn btn-info" runat="server" Text="Consultar" Style="margin: 4px" OnClick="btnConsultaEquipos_Click" />
                </div>
            </div>
            <div class="GridView">
                <asp:GridView ID="datagridEquipos" class="myGridClass" runat="server"></asp:GridView>
            </div>
        </div>
    </div>


    <div class="Formulario">
    <h2>REPORTE DE REPARACIONES</h2>
    <div class="Data">
        <div class="RadioButtons">
            <asp:RadioButtonList ID="RadioButtonListReparaciones" runat="server" Width="205px">
                <asp:ListItem>Dueño del equipo</asp:ListItem>
                <asp:ListItem>ID Equipo</asp:ListItem>
                <asp:ListItem>Tipo de Equipo</asp:ListItem>
                <asp:ListItem>Modelo de Equipo</asp:ListItem>
                <asp:ListItem>ID Reparacion</asp:ListItem>
                <asp:ListItem>Estado</asp:ListItem>
                <asp:ListItem>ID Asignacion</asp:ListItem>
                <asp:ListItem>ID Tecnico Asignado</asp:ListItem>
                <asp:ListItem>Descripcion Reparacion</asp:ListItem>
            </asp:RadioButtonList>
            <asp:Label ID="Label4" runat="server" Text="Ingrese su consulta: "></asp:Label>
            <br />
            <asp:TextBox ID="txtConsultaReparacion" runat="server" Width="168px" Height="26px"></asp:TextBox>
            <br />
            <br />
            <div class="Buttons">
                <asp:Button ID="btnConsultaReparacion" class="btn btn-info" runat="server" Text="Consultar" Style="margin: 4px" OnClick="btnConsultaReparacion_Click" />
            </div>
        </div>
        <div class="GridView">
            <asp:GridView ID="datagridReparaciones" class="myGridClass" runat="server"></asp:GridView>
        </div>
    </div>
</div>
</asp:Content>
