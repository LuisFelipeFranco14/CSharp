<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="CadUsuario.aspx.cs" Inherits="Web.Paginas.CadUsuario" %>

<%@ Register Src="~/Paginas/Filtros/FiltroGrupoUsuario.ascx" TagName="FiltroGrupoUsuario" TagPrefix="ctrl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="https://cdn.datatables.net/v/bs/dt-1.10.18/b-1.5.6/datatables.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/plug-ins/1.10.21/i18n/Portuguese-Brasil.json"></script>

    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.flash.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>

    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>

    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.print.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>

    <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/css/bootstrap-switch-button.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/dist/bootstrap-switch-button.min.js"></script>

    <script type="text/javascript">
        var Acao = "";
        var usuarioSelecionados = [];
        var usuarioSelecionadoslogin = [];

        $(document).ready(function () {
            Acao = "Iniciar";
            jsBloqueio();

            var oTable = $('#tbDados').DataTable({
                scrollCollapse: true,
                searching: true,
                paging: true,
                "destroy": true,
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'excelHtml5',
                        text: '<i class="btn btn-sm btn btn-success fa fa-file-excel-o"></i>',
                        titleAttr: 'Excel',
                    },
                    {
                        extend: 'copyHtml5',
                        text: '<i class="btn btn-sm btn btn-primary fa fa-files-o"></i>',
                        titleAttr: 'Copiar Registros'
                    },
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        pageSize: 'LEGAL',
                        text: '<i class="btn btn-sm btn btn-danger fa fa-file-pdf-o"></i>',
                        titleAttr: 'PDF'
                    }
                ],
                "oLanguage": {
                    "sProcessing": "Processando...",
                    "sLengthMenu": "Mostrar _MENU_ registros",
                    "sZeroRecords": "Não foram encontrados resultados",
                    "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                    "sInfoEmpty": "Mostrando de 0 até 0 de 0 registros",
                    "sSearch": "Buscar: ",
                    "oPaginate": {
                        "sFirst": "Primeiro",
                        "sPrevious": "Anterior",
                        "sNext": "Seguinte",
                        "sLast": "Último"
                    }
                }
            });

        });

        function jsBloqueio() {

        }

        function jsSelecionaUsuario(id, login, cb) {

            if (cb.checked) {
                usuarioSelecionados.push(id);
                usuarioSelecionadoslogin.push(login);
            }
            else {
                var index = usuarioSelecionados.indexOf(id);
                var indexlogin = usuarioSelecionadoslogin.indexOf(login);
                usuarioSelecionados.splice(index, 1);
                usuarioSelecionadoslogin.splice(indexlogin, 1);
            }

            jsPreencheLabelparametros();
            SelecionarUsuario();
        }

        function jsPreencheLabelparametros() {
            var label = document.getElementById('lblUsuarioSelecionados');
            label.innerHTML = "";
            var hfusuarios = document.getElementById('<%=hfusuarios.ClientID %>');
            hfusuarios.value = "";

            for (var i = 0; i < usuarioSelecionadoslogin.length; i++) {
                label.innerHTML += usuarioSelecionadoslogin[i];
                hfusuarios.value += usuarioSelecionados[i];

                if (i !== usuarioSelecionados.length - 1) {
                    label.innerHTML += ", ";
                    hfusuarios.value += "-";
                }
            }

        }

        function SelecionarUsuario() {
            $('#ContentPlaceHolder1_Usuarios').val($('#lblUsuariotroSelecionados').text());
        }

        function jsAbrirModalInserir() {
            Acao = "Inserir";
            $('#InserirModal').modal('show');
        }

        function jsfecharModalInserir() {
            $('#InserirModal').modal('hide');
        }

        function jsAbrirFiltroGrupoUsuarios(idLabel, idHidden) {
            $('#hfIdLabelFiltroGrupoUsuarios').val(idLabel);
            $('#hfIdHiddenFiltroGrupoUsuarios').val(idHidden);
            $('#divFiltroGrupoUsuario').modal('show');
            $('#divFiltroGrupoUsuario').fadeIn();
        }

        function jsCloseFiltroGrupoUsuarios(obj) {
            $('#divFiltroGrupoUsuario').modal('hide');
        }


    </script>

    <style>
        .input-sm {
            min-width: 900px;
        }

        .relatorio {
            width: 1500px;
            font-size: 14px;
            left: -350px;
        }

        .btn-outline-success {
            height: 20px;
            width: 30px;
        }

        .modal-content {
            width: 760px;
        }
    </style>


    <asp:HiddenField runat="server" ID="hfusuarios" />

    <section id="main-content">
        <section class="wrapper">

            <div runat="server" class="row" id="divTabela">

                <div class="col-sm-12">
                    <div class="panel">

                        <header class="panel-heading">
                            Usuário      
                        </header>

                        <div class="panel-body">
                            <button type="button" id="ModalInserir" class="btn btn-success" onclick="jsAbrirModalInserir();">ADICIONAR REGISTRO</button>
                            <button type="button" id="ModalAlterar" class="btn btn-warning" onclick="jsAbrirModalAlterar();">ALTERAR REGISTRO</button>
                            <asp:Button runat="server" ID="btnDeletar" class="btn btn-danger" OnClick="btnDeletar_Click" OnClientClick="return jsValidarDelete();" Text="EXCLUIR REGISTRO" />
                            <button type="button" id="relatorio" class="btn btn-primary" onclick="jsRelatorio();">CONSULTAR REGISTRO</button>
                        </div>

                        <div class="panel-body">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <label class="col-sm-2 control-label"><b>SELECIONADOS:</b></label>
                                        <label class="col-sm-8 control-label" id="lblUsuarioSelecionados"></label>
                                        <asp:HiddenField runat="server" ID="UsuarioSelecionados" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <section class="panel" runat="server" id="divResultado" visible="true">
                            <div class="panel-body table-responsive-md">
                                <asp:Repeater runat="server" ID="rptTabela">
                                    <HeaderTemplate>
                                        <table class="table table-striped table-advance table-hover dataTable" id="tbDados">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center;">Selec. </th>
                                                    <th>Código  </th>
                                                    <th>login  </th>
                                                    <th>Grupo de Usuário  </th>
                                                    <th>Ativo </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td runat="server" id="tdCheckbox" align="center">
                                                <input type="checkbox" runat="server" id="chkAni" class="checkboxdahora" onclick='<%# "return jsSelecionaUsuario(" + Eval("id") + ", \"" + Eval("login") + "\", this);" %>' visible="true" />
                                            </td>
                                            <td class="center">
                                                <asp:Label ID="lblId" CssClass="lbCodigo" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("login") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("desc_grupo") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("flg_ativo") %></td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                     </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </section>

                    </div>
                </div>

            </div>


            <div class="modal fade" tabindex="-1" id="InserirModal" role="dialog" aria-hidden="true" style="opacity: 1;">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Inserir Registro</h5>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">
                                <label class="col-sm-1">
                                    Login:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="txtLogin" placeholder="Digite o Login " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 10px;" />
                                    <input type="hidden" runat="server" id="hftxtLogin" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-1">
                                    Senha:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="password" id="txtSenha" placeholder="Digite a Senha " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 10px; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hftxtSenha" />
                                </div>
                            </div>

                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    Grupo de Usuário:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="imgLupaGrupoUsuario" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="txtGrupoUsuario" placeholder="Digite Grupo de Usuario " class="form-control" style="width: 370px; float: left; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hfGrupoUsuario" />
                                </div>
                                
                                <label class="col-sm-1">
                                    Ativo:
                                </label>

                                <div class="col-sm-0">

                                    <input id="ckAtivo" type="checkbox"
                                        data-toggle="switchbutton" checked data-width="60" data-height="40" data-onlabel="Sim" data-offlabel="Não">
                                </div>

                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnInserir" CssClass="btn btn-success" Text="Inserir" OnClick="btnInserir_Click" 
                                OnClientClick="return jsValidar()" />
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>

        </section>
    </section>

    
    <ctrl:FiltroGrupoUsuario runat="server" ID="ctrFiltroGrupoUsuario" />
</asp:Content>

