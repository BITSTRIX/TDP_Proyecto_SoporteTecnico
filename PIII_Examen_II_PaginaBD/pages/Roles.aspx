<%@ Page Title="Roles" Language="C#" MasterPageFile="~/Menu.Master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="PIII_Examen_II_PaginaBD.pages.Roles" %>

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
            <h1>CONTROL DE ROLES</h1>
            <div class="Datos">
                <table class="auto-style6" align="center">
                    <tr>
                        <td class="auto-style5"><strong>ID del Rol:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </strong></td>
                        <td class="auto-style3">
                            <asp:TextBox ID="txtIdRol" runat="server" Height="30px" TextMode="Number" Width="249px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style5"><strong>Nombre del Rol:</strong></td>
                        <td class="auto-style3">
                            <asp:TextBox ID="txtNombreRol" runat="server" Height="30px" Width="249px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="Buttons">
                <br />
                <br />
                <asp:Button ID="btnAgregarRol" class="btn btn-primary" runat="server" Text="Agregar" OnClick="btnAgregarRol_Click" Style="margin: 4px" />
                <asp:Button ID="btnConsultarRol" class="btn btn-info" runat="server" Text="Consultar" OnClick="btnConsultarRol_Click" Style="margin: 4px" />
                <asp:Button ID="btnModificarRol" class="btn btn-warning" runat="server" Text="Modificar" OnClick="btnModificarRol_Click" Style="margin: 4px" />
                <asp:Button ID="btnEliminarRol" class="btn btn-danger" runat="server" Text="Eliminar" OnClick="btnEliminarRol_Click" Style="margin: 4px" />
                <br />
                <br />
            </div>
            <div class="GridView">
                <asp:GridView ID="datagridRol" class="myGridClass" runat="server"></asp:GridView>
            </div>
        </div>


        <div class="FormularioRoles">
            <h1>CONTROL DE ROLES DE USUARIOS</h1>
            <div class="Datos">
                <table class="auto-style6" align="center">
                    <tr>
                        <td class="auto-style5">Rol<strong>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </strong></td>
                        <td class="auto-style7">
                            <asp:DropDownList ID="DropListRoles" runat="server" Height="30px" TextMode="Number" Width="249px">
                            </asp:DropDownList>
                    </tr>
                    <tr>
                        <td class="auto-style5"><strong>Usuario Sistema: </strong></td>
                        <td class="auto-style7">
                            <asp:DropDownList ID="DropListUsuarioSistema" runat="server" Height="30px" TextMode="Number" Width="249px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="Buttons">
                <br />
                <br />
                <asp:Button ID="btnAgregarRolUser" class="btn btn-primary" runat="server" Text="Agregar" OnClick="btnAgregarRolUser_Click" Style="margin: 4px" />
                <asp:Button ID="btnConsultarRolUser" class="btn btn-info" runat="server" Text="Consultar" OnClick="btnConsultarRolUser_Click" Style="margin: 4px" />
                <asp:Button ID="btnModificarRolUser" class="btn btn-warning" runat="server" Text="Modificar" OnClick="btnModificarRolUser_Click" Style="margin: 4px" />
                <asp:Button ID="btnEliminarRolUser" class="btn btn-danger" runat="server" Text="Eliminar" OnClick="btnEliminarRolUser_Click" Style="margin: 4px" />
                <br />
                <br />
            </div>
            <div class="GridView">
                <asp:GridView ID="datagrid1" class="myGridClass" runat="server"></asp:GridView>
            </div>
        </div>

    </div>

</asp:Content>
