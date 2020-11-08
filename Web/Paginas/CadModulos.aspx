<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="CadModulos.aspx.cs" Inherits="Web.Paginas.CadModulos" %>

<%@ Register Src="~/Paginas/Filtros/FiltroGrupoUsuario.ascx" TagName="FiltroGrupoUsuario" TagPrefix="ctrl" %>
<%@ Register Src="~/Paginas/Filtros/FiltroSecao.ascx" TagName="FiltroSecao" TagPrefix="ctrl" %>

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
        var moduloSelecionados = [];
        var moduloSelecionadosdescr_modulo = [];

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

        function jsSelecionaModulo(id, descr_modulo, cb) {

            if (cb.checked) {
                moduloSelecionados.push(id);
                moduloSelecionadosdescr_modulo.push(descr_modulo);
            }
            else {
                var index = moduloSelecionados.indexOf(id);
                var indexlogin = moduloSelecionadosdescr_modulo.indexOf(descr_modulo);
                moduloSelecionados.splice(index, 1);
                moduloSelecionadosdescr_modulo.splice(indexlogin, 1);
            }

            jsPreencheLabelmodulos();
            SelecionarModulo();
        }

        function jsPreencheLabelmodulos() {
            var label = document.getElementById('lblModuloSelecionados');
            label.innerHTML = "";
            var hfmodulos = document.getElementById('<%=hfmodulos.ClientID %>');
            hfmodulos.value = "";

            for (var i = 0; i < moduloSelecionadosdescr_modulo.length; i++) {
                label.innerHTML += moduloSelecionadosdescr_modulo[i];
                hfmodulos.value += moduloSelecionados[i];

                if (i !== moduloSelecionados.length - 1) {
                    label.innerHTML += ", ";
                    hfmodulos.value += "-";
                }
            }

        }

        function SelecionarModulo() {
            $('#ContentPlaceHolder1_Modulos').val($('#lblModuloSelecionados').text());
        }

        function jsAbrirModalInserir() {
            Acao = "Inserir";
            $('#InserirModal').modal('show');
        }

        function jsfecharModalInserir() {
            $('#InserirModal').modal('hide');
        }

        function jsAbrirModalAlterar() {
            if ($('#lblModuloSelecionados').text() == "") {
                alert("Selecione o registro.");
            } else if ($('#lblModuloSelecionados').text().indexOf(',') != -1) {
                alert("Selecione apenas um registro");
            } else {
                Acao = "Alterar";
                jsMontarModuloAlt();
                $('#AlterarModal').modal('show');
            }
        }

        function jsMontarModuloAlt() {
            var parametro = $('#ContentPlaceHolder1_hfmodulos').val();

            $.ajax({
                type: "POST",
                url: "CadModulos.aspx/montarModulo",
                data: "{'id':'" + parametro + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                traditional: true,
                async: false,
                success: function (result) {
                    if (result.d) {
                        $('#ContentPlaceHolder1_AlttxtDescricao').val(result.d[0].descr_modulo);
                        $('#ContentPlaceHolder1_AlttxtCaminho').val(result.d[0].caminho);

                        $('#ContentPlaceHolder1_hfAltGrupoUsuario').val(result.d[0].id_grupo_usuario_fk);
                        $('#ContentPlaceHolder1_AlttxtGrupoUsuario').val(result.d[0].desc_grupo);

                        $('#ContentPlaceHolder1_hfAltSecao').val(result.d[0].id_secao_fk);
                        $('#ContentPlaceHolder1_AlttxtSecao').val(result.d[0].descricao_com_caracter);
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

        function jsValidarDelete() {
            if ($('#lblModuloSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
                return false;
            }
            else {
                if ($('#lblModuloSelecionados').text().indexOf(',') == -1) {
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

        function jsRelatorio() {
            if ($('#lblModuloSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
            } else {
                Acao = "Relatorio";
                var parametro = $('#ContentPlaceHolder1_hfmodulos').val();
                $.ajax({
                    type: "POST",
                    url: "CadModulos.aspx/relatorio",
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
                                    { title: "Descrição" },
                                    { title: "Caminho" },
                                    { title: "Descrição Seção" },
                                    { title: "Descrição Grupo de Usuário" }
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
                                    },
                                    {
                                        targets: 4,
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

        function jsvalidarPesqGrupoUsuario() {
            var txtGrupoUsuario = "";
            if (Acao == "Inserir") {
                txtGrupoUsuario = $('#ContentPlaceHolder1_txtGrupoUsuario').val();
            } else if (Acao == "Alterar") {
                txtGrupoUsuario = $('#ContentPlaceHolder1_AlttxtGrupoUsuario').val();
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
                            $('#ContentPlaceHolder1_hfAltGrupoUsuario').val(result.d[0].id);
                            $('#ContentPlaceHolder1_AlttxtGrupoUsuario').val(result.d[0].desc_grupo);
                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }

        }

        function jsAbrirFiltroSecoes() {
            $('#divFiltroSecao').modal('show');
            $('#divFiltroSecao').fadeIn();
        }

        function jsCloseFiltroSecaos() {
            $('#ContentPlaceHolder1_hfSecao').val("");
            $('#ContentPlaceHolder1_txtSecao').text("");
            $('#ContentPlaceHolder1_txtSecao').val("");

            if (Acao == "Inserir") {
                $('#ContentPlaceHolder1_hfSecao').val($('#ContentPlaceHolder1_ctrFiltroSecao_hfSecao').val());
                $('#ContentPlaceHolder1_txtSecao').val($('#lblSecaoSelecionados').text());
            }

            $('#ContentPlaceHolder1_ctrFiltroSecao_hfSecao').val("");
            $('#lblSecaoSelecionados').text("");
            SecaoSelecionados = [];
            SecaoSelecionadosdesc_grupo = [];

            var rows = $("#tbDadosFiltroSecao").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++) {
                var checkBox = $(rows[i]).find('.checkboxdahora');
                $(checkBox).prop('checked', false);
            }

            $('#divFiltroSecao').modal('hide');
        }

        function jsvalidarPesqSecao() {
            var txtSecao = "";
            if (Acao == "Inserir") {
                txtSecao = $('#ContentPlaceHolder1_txtSecao').val();
            } else if (Acao == "Alterar") {
                txtSecao = $('#ContentPlaceHolder1_AlttxtSecao').val();
            }

            if (txtSecao != "") {
                $.ajax({
                    type: "POST",
                    url: "CadModulos.aspx/validarPesqSecao",
                    data: JSON.stringify({ descricao_com_caracter: txtSecao }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: "json",
                    traditional: true,
                    async: false,
                    success: function (result) {
                        if (Acao == "Inserir") {
                            $('#ContentPlaceHolder1_hfSecao').val(result.d[0].id);
                            $('#ContentPlaceHolder1_txtSecao').val(result.d[0].descricao_com_caracter);
                        } else if (Acao == "Alterar") {
                            $('#ContentPlaceHolder1_hfAltSecao').val(result.d[0].id);
                            $('#ContentPlaceHolder1_AlttxtSecao').val(result.d[0].descricao_com_caracter);
                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }

        }

        function jsValidar() {
            var descr_modulo = "";
            var caminho = "";
            var secao_id = "";
            var usu_grupo_id = "";

            if (Acao == "Inserir") {
                if ($('#ContentPlaceHolder1_txtDescricao').val().trim() == '') {
                    alert("Por favor informe a descrição de módulos.");
                    $('#ContentPlaceHolder1_txtDescricao').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtCaminho').val().trim() == '') {
                    alert("Por favor informe o caminho.");
                    $('#ContentPlaceHolder1_txtCaminho').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_hfGrupoUsuario').val().trim() == '') {
                    alert("Por favor informe o Grupo do Usuário");
                    return false;
                } else if ($('#ContentPlaceHolder1_hfSecao').val().trim() == '') {
                    alert("Por favor informe a Seção");
                    return false;
                }

                descr_modulo = $('#ContentPlaceHolder1_txtDescricao').val();
                caminho = $('#ContentPlaceHolder1_txtCaminho').val();
                usu_grupo_id = $('#ContentPlaceHolder1_hfGrupoUsuario').val();
                secao_id = $('#ContentPlaceHolder1_hfSecao').val();

            } else if (Acao == "Alterar") {
                if ($('#ContentPlaceHolder1_AlttxtDescricao').val().trim() == '') {
                    alert("Por favor informe a descrição de módulos.");
                    $('#ContentPlaceHolder1_AlttxtDescricao').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtCaminho').val().trim() == '') {
                    alert("Por favor informe o caminho.");
                    $('#ContentPlaceHolder1_AlttxtCaminho').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_hfAltGrupoUsuario').val().trim() == '') {
                    alert("Por favor informe o Grupo do Usuário");
                    return false;
                } else if ($('#ContentPlaceHolder1_hfAltSecao').val().trim() == '') {
                    alert("Por favor informe a Seção");
                    return false;
                }


                descr_modulo = $('#ContentPlaceHolder1_AlttxtDescricao').val();
                caminho = $('#ContentPlaceHolder1_AlttxtCaminho').val();
                usu_grupo_id = $('#ContentPlaceHolder1_hfAltGrupoUsuario').val();
                secao_id = $('#ContentPlaceHolder1_hfAltSecao').val();
            }

            $.ajax({
                type: "post",
                url: "CadModulos.aspx/GravarRegistro",
                data: JSON.stringify({
                    descr_modulo: descr_modulo,
                    caminho: caminho,
                    secao_id: secao_id,
                    usu_grupo_id: usu_grupo_id,
                    acao: Acao,
                    id_alt: $('#ContentPlaceHolder1_hfmodulos').val()
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
    </style>

    <asp:HiddenField runat="server" ID="hfmodulos" />

    <section id="main-content">
        <section class="wrapper">

            <div runat="server" class="row" id="divTabela">

                <div class="col-sm-12">
                    <div class="panel">

                        <header class="panel-heading">
                            Módulos      
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
                                        <label class="col-sm-8 control-label" id="lblModuloSelecionados"></label>
                                        <asp:HiddenField runat="server" ID="ModuloSelecionados" />
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
                                                    <th>Descrição  </th>
                                                    <th>Caminho  </th>
                                                    <th>Descrição Seção  </th>
                                                    <th>Descrição Grupo de Usuário  </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td runat="server" id="tdCheckbox" align="center">
                                                <input type="checkbox" runat="server" id="chkAni" class="checkboxdahora" onclick='<%# "return jsSelecionaModulo(" + Eval("id") + ", \"" + Eval("descr_modulo") + "\", this);" %>' visible="true" />
                                            </td>
                                            <td class="center">
                                                <asp:Label ID="lblId" CssClass="lbCodigo" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("descr_modulo") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("caminho") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("descricao_com_caracter") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("desc_grupo") %></td>
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
                                    Descrição:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="txtDescricao" placeholder="Digite a descrição " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 42px;" />
                                    <input type="hidden" runat="server" id="hftxtDescricao" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-1">
                                    Caminho:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="txtCaminho" placeholder="Digite o Caminho " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 42px; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hftxtCaminho" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    Grupo de Usuário:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="imgLupaGrupoUsuario" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="txtGrupoUsuario" placeholder="Digite Grupo de Usuario " class="form-control" style="width: 370px; float: left; text-transform: uppercase" onblur="jsvalidarPesqGrupoUsuario();" />
                                    <input type="hidden" runat="server" id="hfGrupoUsuario" />
                                </div>
                            </div>

                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    Seção:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="imgLupaSecao" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="txtSecao" placeholder="Digite a descrição " class="form-control" style="width: 370px; float: left; text-transform: uppercase" onblur="jsvalidarPesqSecao();" />
                                    <input type="hidden" runat="server" id="hfSecao" />
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
                                    Descrição:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="AlttxtDescricao" placeholder="Digite a descrição " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 42px;" />
                                    <input type="hidden" runat="server" id="hfAlttxtDescricao" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-1">
                                    Caminho:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="AlttxtCaminho" placeholder="Digite o Caminho " class="form-control"
                                        style="width: 658px; float: left; position: absolute; left: 42px; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hfAlttxtCaminho" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    Grupo de Usuário:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="AltimgLupaGrupoUsuario" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="AlttxtGrupoUsuario" placeholder="Digite Grupo de Usuario " class="form-control" style="width: 370px; float: left; text-transform: uppercase" onblur="jsvalidarPesqGrupoUsuario();" />
                                    <input type="hidden" runat="server" id="hfAltGrupoUsuario" />
                                </div>
                            </div>

                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    Seção:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="AltimgLupaSecao" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="AlttxtSecao" placeholder="Digite a descrição " class="form-control" style="width: 370px; float: left; text-transform: uppercase" onblur="jsvalidarPesqSecao();" />
                                    <input type="hidden" runat="server" id="hfAltSecao" />
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
    <ctrl:FiltroSecao runat="server" ID="ctrFiltroSecao" />
</asp:Content>
