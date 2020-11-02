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

        function jsAbrirModalAlterar() {
            if ($('#lblUsuarioSelecionados').text() == "") {
                alert("Selecione o registro.");
            } else if ($('#lblUsuarioSelecionados').text().indexOf(',') != -1) {
                alert("Selecione apenas um registro");
            } else {
                Acao = "Alterar";
                jsMontarUsuarioAlt();
                $('#AlterarModal').modal('show');
            }
        }

        function jsMontarUsuarioAlt() {
            var parametro = $('#ContentPlaceHolder1_hfusuarios').val();

            $.ajax({
                type: "POST",
                url: "CadUsuario.aspx/montarUsuario",
                data: "{'id':'" + parametro + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                traditional: true,
                async: false,
                success: function (result) {
                    if (result.d) {
                        $('#ContentPlaceHolder1_AlttxtLogin').val(result.d[0].login);
                        $('#ContentPlaceHolder1_hfAltGrupoUsuario').val(result.d[0].id_grupo_usuario);
                        $('#ContentPlaceHolder1_AlttxtGrupoUsuario').val(result.d[0].desc_grupo);

                        if (result.d[0].flg_ativo == 'Sim') {
                            document.getElementById('AltckAtivo').switchButton('on', true);
                        } else {
                            document.getElementById('AltckAtivo').switchButton('off', true);
                        }
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function jsfecharModalAlterar() {
            $('#AlterarModal').modal('hide');
        }

        function jsAbrirFiltroGrupoUsuarios() {
            $('#divFiltroGrupoUsuario').modal('show');
            $('#divFiltroGrupoUsuario').fadeIn();
        }

        function jsCloseFiltroGrupoUsuarios() {
            $('#ContentPlaceHolder1_hfGrupoUsuario').val("");
            $('#ContentPlaceHolder1_txtGrupoUsuario').text("");
            $('#ContentPlaceHolder1_txtGrupoUsuario').val("");

            if (Acao == "Inserir") {
                $('#ContentPlaceHolder1_hfGrupoUsuario').val($('#ContentPlaceHolder1_ctrFiltroGrupoUsuario_hfgrupoUser').val());
                $('#ContentPlaceHolder1_txtGrupoUsuario').val($('#lblGrupoUserSelecionados').text());
            }

            $('#ContentPlaceHolder1_ctrFiltroGrupoUsuario_hfgrupoUser').val("");
            $('#lblGrupoUserSelecionados').text("");
            GrupoUserSelecionados = [];
            GrupoUserSelecionadosdesc_grupo = [];

            var rows = $("#tbDadosFiltroGrupoUsuario").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++) {
                var checkBox = $(rows[i]).find('.checkboxdahora');
                $(checkBox).prop('checked', false);
            }

            $('#divFiltroGrupoUsuario').modal('hide');
        }

        function jsValidar() {
            var Login = "";
            var Senha = "";
            var Flag_Ativo = "";
            var validarLogin = false;
            var usu_grupo_id = "";

            if (Acao == "Inserir") {
                if ($('#ContentPlaceHolder1_txtLogin').val().trim() == '') {
                    alert("Por favor informe o Login.");
                    $('#ContentPlaceHolder1_txtLogin').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtSenha').val().trim() == '') {
                    alert("Por favor informe a senha.");
                    $('#ContentPlaceHolder1_txtSenha').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtSenhaNovamente').val().trim() == '') {
                    alert("Por favor informe a senha novamente.");
                    $('#ContentPlaceHolder1_txtSenhaNovamente').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtSenhaNovamente').val() != $('#ContentPlaceHolder1_txtSenha').val()) {
                    alert("Senha não está batendo");
                    $('#ContentPlaceHolder1_txtSenhaNovamente').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_hfGrupoUsuario').val().trim() == '') {
                    alert("Por favor informe o Grupo do Usuário");
                    return false;
                } else {
                    $.ajax({
                        type: "post",
                        url: "CadUsuario.aspx/validarLogin",
                        data: "{'login':'" + $('#ContentPlaceHolder1_txtLogin').val() + "'}",
                        async: false,
                        contentType: 'application/json; charset=utf-8',
                        dataType: "json",
                        traditional: true,
                        success: function (result) {
                            if (result.d) {
                                
                                validarLogin = true;
                            }
                        },
                        error: function (error) {
                            validarLogin = true;
                        }
                    });
                }

                if (validarLogin) {
                    alert("Esse login já foi usado.");
                    $('#ContentPlaceHolder1_txtLogin').focus();
                    return false;
                }

                if (document.getElementById('ckAtivo').checked) {
                    Flag_Ativo = 'S';
                } else {
                    Flag_Ativo = 'N'
                }

                Login = $('#ContentPlaceHolder1_txtLogin').val();
                Senha = $('#ContentPlaceHolder1_txtSenha').val();
                usu_grupo_id = $('#ContentPlaceHolder1_hfGrupoUsuario').val();

            } else if (Acao == "Alterar") {
                if ($('#ContentPlaceHolder1_AlttxtLogin').val().trim() == '') {
                    alert("Por favor informe o Login.");
                    $('#ContentPlaceHolder1_AlttxtLogin').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtSenha').val().trim() == '') {
                    alert("Por favor informe a senha.");
                    $('#ContentPlaceHolder1_AlttxtSenha').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtSenhaNovamente').val().trim() == '') {
                    alert("Por favor informe a senha novamente.");
                    $('#ContentPlaceHolder1_AlttxtSenhaNovamente').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtSenhaNovamente').val() != $('#ContentPlaceHolder1_AlttxtSenha').val()) {
                    alert("Senha não está batendo");
                    $('#ContentPlaceHolder1_AlttxtSenhaNovamente').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_hfAltGrupoUsuario').val().trim() == '') {
                    alert("Por favor informe o Grupo do Usuário");
                    return false;
                }

                if (document.getElementById('AltckAtivo').checked) {
                    Flag_Ativo = 'S';
                } else {
                    Flag_Ativo = 'N'
                }

                Login = $('#ContentPlaceHolder1_AlttxtLogin').val();
                Senha = $('#ContentPlaceHolder1_AlttxtSenha').val();
                usu_grupo_id = $('#ContentPlaceHolder1_hfAltGrupoUsuario').val();
            }

            $.ajax({
                type: "post",
                url: "CadUsuario.aspx/GravarRegistro",
                data: JSON.stringify({
                    login: Login,
                    senha: Senha,
                    flag_Ativo: Flag_Ativo,
                    usu_grupo_id: usu_grupo_id,
                    acao: Acao,
                    id_alt: $('#ContentPlaceHolder1_hfusuarios').val()
                }),
                async: false,
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                traditional: true,
                success: function (result) {
                    if (result.d) {
                        return true;
                    }
                },
                error: function (error) {
                    return false;
                }
            });

        }

        function jsValidarDelete() {
            if ($('#lblUsuarioSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
                return false;
            }
            else {
                if ($('#lblUsuarioSelecionados').text().indexOf(',') == -1) {
                    if (window.confirm("Deseja Realmente excluir esse registro?")) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    if (window.confirm("Deseja Realmente excluir esses registros?")) {
                        return true;
                    } else {
                        return false;
                    }
                }
            }
                
        }
        
        function jsvalidarPesqGrupoUsuario() {
            var txtGrupoUsuario = "";
            if (Acao == "Inserir") {
                txtGrupoUsuario = $('#ContentPlaceHolder1_txtGrupoUsuario').val();
            } else if (Acao == "Alterar") {
                
            }

            if (txtGrupoUsuario != "") {
                $.ajax({
                    type: "POST",
                    url: "CadUsuario.aspx/validarPesqGrupo_Usuario",
                    data: JSON.stringify({ GrupoUsuario: txtGrupoUsuario }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: "json",
                    traditional: true,
                    async: false,
                    success: function (result) {
                        if (Acao == "Inserir") {
                            $('#ContentPlaceHolder1_hfGrupoUsuario').val(result.d[0].id);
                            $('#ContentPlaceHolder1_txtGrupoUsuario').val(result.d[0].desc_grupo);
                        } else if (Acao == "Alterar") {

                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }

        }

        function jsRelatorio() {
            if ($('#lblUsuarioSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
            } else {
                Acao = "Relatorio";
                var parametro = $('#ContentPlaceHolder1_hfusuarios').val();
                $.ajax({
                    type: "POST",
                    url: "CadUsuario.aspx/relatorio",
                    data: JSON.stringify({ id: parametro }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: "json",
                    traditional: true,
                    async: false,
                    success: function (result) {

                        const jsonResult = JSON.parse(result.d);
                        const dataSet = jsonToArray(jsonResult);

                        $(document).ready(function () {
                            var table = $('#tbRelatorio').DataTable({
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
                                },
                                searching: true,
                                paging: true,
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
                                    }
                                ],
                                "destroy": true,
                                "data": dataSet,
                                "columns": [
                                    { title: "ID" },
                                    { title: "Login" },
                                    { title: "Grupo de Usuários" },
                                    { title: "Ativo" }
                                ],
                                "columnDefs": [
                                    {
                                        targets: 0,
                                        render: function (data, type, row, meta) {
                                            if (type === 'display') {
                                                var label = 'label-font';

                                                if (data == '' || data == null || data == '0') {
                                                    data = 'N/A';
                                                    label = 'label-default';
                                                }

                                                return '<span class="label ' + label + '" style="color: black; font-size: 11px;">' + data + '</span>';
                                            }
                                            return data;
                                        }
                                    },
                                    {
                                        targets: 1,
                                        render: function (data, type, row, meta) {
                                            if (type === 'display') {
                                                var label = 'label-font';

                                                if (data == '' || data == null || data == '0') {
                                                    data = 'N/A';
                                                    label = 'label-default';
                                                }

                                                return '<span class="label ' + label + '" style="color: black; font-size: 11px;">' + data + '</span>';
                                            }
                                            return data;
                                        }
                                    },
                                    {
                                        targets: 2,
                                        render: function (data, type, row, meta) {
                                            if (type === 'display') {
                                                var label = 'label-font';

                                                if (data == '' || data == null || data == '0') {
                                                    data = 'N/A';
                                                    label = 'label-default';
                                                }

                                                return '<span class="label ' + label + '" style="color: black; font-size: 11px;">' + data + '</span>';
                                            }
                                            return data;
                                        }
                                    },
                                    {
                                        targets: 3,
                                        render: function (data, type, row, meta) {
                                            if (type === 'display') {
                                                var label = 'label-font';

                                                if (data == '' || data == null || data == '0') {
                                                    data = 'N/A';
                                                    label = 'label-default';
                                                }

                                                return '<span class="label ' + label + '" style="color: black; font-size: 11px;">' + data + '</span>';
                                            }
                                            return data;
                                        }
                                    }

                                ]
                            });
                        });

                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
                $('#RelatorioModal').modal('show');
            }
        }

        function jsonToArray(json) {
            var dataSet = new Array

            $.each(json, function (index, value) {
                var tempArray = new Array
                for (var o in value) {
                    tempArray.push(value[o])
                }
                dataSet.push(tempArray)
            })
            return dataSet
        }

    </script>

    <style>
        .input-sm {
            min-width: 700px;
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
            width: 910px;
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
                                <label class="col-sm-1">
                                    Senha:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="password" id="txtSenhaNovamente" placeholder="Digite a Senha Novamente " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 10px; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hftxtSenhaNovamente" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    Grupo de Usuário:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="imgLupaGrupoUsuario" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="txtGrupoUsuario" placeholder="Digite Grupo de Usuario " class="form-control" style="width: 370px; float: left; text-transform: uppercase" onblur = "jsvalidarPesqGrupoUsuario();" />
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

            <div class="modal fade" tabindex="-1" id="AlterarModal" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Alterar Registro</h5>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">
                                <label class="col-sm-1">
                                    Login:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="AlttxtLogin" placeholder="Digite o Login " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 10px;" />
                                    <input type="hidden" runat="server" id="hfAlttxtLogin" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-1">
                                    Senha:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="password" id="AlttxtSenha" placeholder="Digite a Senha " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 10px; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hfAlttxtSenha" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-1">
                                    Senha:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="password" id="AlttxtSenhaNovamente" placeholder="Digite a Senha Novamente " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 10px; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hfAlttxtSenhaNovamente" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    Grupo de Usuário:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="AltimgLupaGrupoUsuario" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="AlttxtGrupoUsuario" placeholder="Digite Grupo de Usuario " class="form-control" style="width: 370px; float: left; text-transform: uppercase" onblur = "jsvalidarPesqGrupoUsuario();" />
                                    <input type="hidden" runat="server" id="hfAltGrupoUsuario" />
                                </div>

                                <label class="col-sm-1">
                                    Ativo:
                                </label>

                                <div class="col-sm-0">

                                    <input id="AltckAtivo" type="checkbox"
                                        data-toggle="switchbutton" checked data-width="60" data-height="40" data-onlabel="Sim" data-offlabel="Não">
                                </div>

                            </div>
    
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnAlterar" CssClass="btn btn-success" Text="Alterar" OnClick="btnAlterar_Click" OnClientClick="return jsValidar()" />
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade bd-example-modal-lg" tabindex="-1" id="RelatorioModal" role="dialog" aria-hidden="true" aria-labelledby="myExtraLargeModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content relatorio">

                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Relátorio</h5>
                        </div>

                        <div class="modal-body">
                            <table id="tbRelatorio" class="table table-striped table-advance"></table>
                        </div>


                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                        </div>

                    </div>
                </div>
            </div>

        </section>
    </section>


    <ctrl:FiltroGrupoUsuario runat="server" ID="ctrFiltroGrupoUsuario" />
</asp:Content>

