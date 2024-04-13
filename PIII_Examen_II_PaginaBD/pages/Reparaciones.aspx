<%@ Page Title="Reparaciones" Language="C#" MasterPageFile="~/Menu.Master" AutoEventWireup="true" CodeBehind="Reparaciones.aspx.cs" Inherits="PIII_Examen_II_PaginaBD.pages.Reparaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            height: 16px;
            text-align: left;
        }

        .auto-style5 {
            height: 16px;
            color: #FFFFFF;
            text-align: left;
        }

        .auto-style6 {
            padding: 3em;
            height: 174px;
            margin: 0 auto;
        }

        .auto-style7 {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../css/RolStyle.css" rel="stylesheet" />
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <div class="RolContainer">
        <div class="FormularioRoles">
            <h1>CONTROL DE REPARACIONES</h1>
            <div class="Datos">
                <table class="auto-style6" align="center">
                    <tr>
                        <td class="auto-style5"><strong>Reparacion ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </strong></td>
                        <td class="auto-style3">
                            <asp:TextBox ID="txtIDReparacion" runat="server" Height="30px" TextMode="Number" Width="249px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="auto-style5"><strong>Equipo ID: </strong></td>
                        <td class="auto-style7">
                            <asp:DropDownList ID="DropListEquipos" runat="server" Height="30px" TextMode="Number" Width="249px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style5"><strong>Fecha de Solicitud:</strong></td>
                        <td class="auto-style3">
                            <asp:TextBox ID="txtFecha" runat="server" Height="30px" Width="249px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style5"><strong>Estado Reparacion: </strong></td>
                        <td class="auto-style7">
                            <asp:DropDownList ID="DropListEstado" runat="server" Height="30px" TextMode="Number" Width="249px">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>I</asp:ListItem>
                                <asp:ListItem>P</asp:ListItem>
                                <asp:ListItem>C</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="Buttons">
                <br />
                <br />
                <asp:Button ID="btnAgregarReparacion" class="btn btn-primary" runat="server" Text="Agregar" Style="margin: 4px" OnClick="btnAgregarReparacion_Click" />
                <asp:Button ID="btnConsultarReparacion" class="btn btn-info" runat="server" Text="Consultar" Style="margin: 4px" OnClick="btnConsultarReparacion_Click" />
                <asp:Button ID="btnActualizarReparacion" class="btn btn-warning" runat="server" Text="Actualizar" Style="margin: 4px" OnClick="btnActualizarReparacion_Click" />
                <br />
                <br />
            </div>
            <div class="GridView">
                <asp:GridView ID="DGReparaciones" class="myGridClass" runat="server"></asp:GridView>
            </div>
        </div>


        <div class="FormularioRoles">
            <h1>CONTROL DE ASIGNACIONES</h1>
            <div class="Datos">
                <table class="auto-style6" align="center">
                    <tr>
                        <td class="auto-style5"><strong>ID Asignación:</strong></td>
                        <td class="auto-style3">
                            <asp:TextBox ID="txtIDAsignacion" runat="server" Height="30px" Width="249px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style5"><strong>Reparación ID:<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </strong></td>
                        <td class="auto-style7">
                            <asp:DropDownList ID="DropListReparacionID" runat="server" Height="30px" TextMode="Number" Width="249px">
                            </asp:DropDownList>
                    </tr>
                    <tr>
                        <td class="auto-style5"><strong>Tecnico: </strong></td>
                        <td class="auto-style7">
                            <asp:DropDownList ID="DropListTecnicos" runat="server" Height="30px" TextMode="Number" Width="249px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style5"><strong>Fecha de Asignacion: </strong></td>
                        <td class="auto-style3">
                            <asp:TextBox ID="txtFechaAsignacion" runat="server" Height="30px" Width="249px" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>

                </table>
            </div>
            <div class="Buttons">
                <br />
                <br />
                <asp:Button ID="btnAsignar" class="btn btn-primary" runat="server" Text="Asignar" Style="margin: 4px" OnClick="btnAsignar_Click" />
                <asp:Button ID="btnConsultarAsignacion" class="btn btn-info" runat="server" Text="Consultar" Style="margin: 4px" OnClick="btnConsultarAsignacion_Click" />
                <asp:Button ID="btnModificarAsignacion" class="btn btn-warning" runat="server" Text="Modificar" Style="margin: 4px" OnClick="btnActualizarAsignacion_Click" />
                <br />
                <br />
            </div>
            <div class="GridView">
                <asp:GridView ID="DGAsignaciones" class="myGridClass" runat="server"></asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>
