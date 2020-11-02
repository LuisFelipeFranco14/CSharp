<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="CadParametro.aspx.cs" Inherits="Web.Paginas.CadParametro" %>

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
        var parametroSelecionados = [];
        var parametroSelecionadosdesc_parametro = [];

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

        function jsSelecionaParametro(id, desc_parametro, cb) {

            if (cb.checked) {
                parametroSelecionados.push(id);
                parametroSelecionadosdesc_parametro.push(desc_parametro);
            }
            else {
                var index = parametroSelecionados.indexOf(id);
                var indexdesc_parametro = parametroSelecionadosdesc_parametro.indexOf(desc_parametro);
                parametroSelecionados.splice(index, 1);
                parametroSelecionadosdesc_parametro.splice(indexdesc_parametro, 1);
            }

            jsPreencheLabelparametros();
            SelecionarParametro();
        }

        function jsPreencheLabelparametros() {
            var label = document.getElementById('lblParametroSelecionados');
            label.innerHTML = "";
            var hfparametros = document.getElementById('<%=hfparametros.ClientID %>');
            hfparametros.value = "";

            for (var i = 0; i < parametroSelecionadosdesc_parametro.length; i++) {
                label.innerHTML += parametroSelecionadosdesc_parametro[i];
                hfparametros.value += parametroSelecionados[i];

                if (i !== parametroSelecionados.length - 1) {
                    label.innerHTML += ", ";
                    hfparametros.value += "-";
                }
            }

        }

        function SelecionarParametro() {
            $('#ContentPlaceHolder1_Parametros').val($('#lblParametroSelecionados').text());
        }

        function jsValidarDelete() {
            if ($('#lblParametroSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
                return false;
            }
            else {
                if ($('#lblParametroSelecionados').text().indexOf(',') == -1) {
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

        function jsAbrirModalInserir() {
            Acao = "Inserir";
            $('#InserirModal').modal('show');
        }

        function jsfecharModalInserir() {
            $('#InserirModal').modal('hide');
        }

        function jsAbrirModalAlterar() {
            if ($('#lblParametroSelecionados').text() == "") {
                alert("Selecione o registro.");
            } else if ($('#lblParametroSelecionados').text().indexOf(',') != -1) {
                alert("Selecione apenas um registro");
            } else {
                Acao = "Alterar";
                jsMontarParametroAlt();
                $('#AlterarModal').modal('show');
            }
        }

        function jsfecharModalAlterar() {
            $('#AlterarModal').modal('hide');
        }

        function jsMontarParametroAlt() {
            var parametro = $('#ContentPlaceHolder1_hfparametros').val();

            $.ajax({
                type: "POST",
                url: "CadParametro.aspx/montarParametro",
                data: "{'id':'" + parametro + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                traditional: true,
                async: false,
                success: function (result) {
                    if (result.d) {
                        $('#ContentPlaceHolder1_AlttxtDesc_parametro').val(result.d[0].desc_parametro);
                        if (result.d[0].flg_acesso_desenvolvimento == 'Sim') {
                            document.getElementById('AltckAcessoDesenvolvimento').switchButton('on', true);
                        } else {
                            document.getElementById('AltckAcessoDesenvolvimento').switchButton('off', true);
                        }
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function jsValidar() {
            var Desc_parametro = "";
            var Flg_acesso_desenvolvimento = "";

            if (Acao == "Inserir") {
                if ($('#ContentPlaceHolder1_txtDesc_parametro').val().trim() == '') {
                    alert("Por favor informe a Descrição do Parâmetro.");
                    $('#ContentPlaceHolder1_txtDesc_parametro').focus();
                    return false;
                }
                Desc_parametro = $('#ContentPlaceHolder1_txtDesc_parametro').val();

                if (document.getElementById('ckAcessoDesenvolvimento').checked) {
                    Flg_acesso_desenvolvimento = 'S';
                } else {
                    Flg_acesso_desenvolvimento = 'N';
                }

            } else if (Acao == "Alterar") {
                if ($('#ContentPlaceHolder1_AlttxtDesc_parametro').val().trim() == '') {
                    alert("Por favor informe a Descrição do Parâmetro.");
                    $('#ContentPlaceHolder1_AlttxtDesc_parametro').focus();
                    return false;
                }
                Desc_parametro = $('#ContentPlaceHolder1_AlttxtDesc_parametro').val();

                if (document.getElementById('AltckAcessoDesenvolvimento').checked) {
                    Flg_acesso_desenvolvimento = 'S';
                } else {
                    Flg_acesso_desenvolvimento = 'N';
                }
            }

            $.ajax({
                type: "post",
                url: "CadParametro.aspx/GravarRegistro",
                data: JSON.stringify({
                    desc_parametro: Desc_parametro,
                    flg_acesso_desenvolvimento: Flg_acesso_desenvolvimento,
                    acao: Acao,
                    id_alt: $('#ContentPlaceHolder1_hfparametros').val()
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

        function jsRelatorio() {
            if ($('#lblParametroSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
            } else {
                Acao = "Relatorio";
                var parametro = $('#ContentPlaceHolder1_hfparametros').val();
                $.ajax({
                    type: "POST",
                    url: "CadParametro.aspx/relatorio",
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
                                    { title: "Acesso ao Desenvolvimento" }
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


    <asp:HiddenField runat="server" ID="hfparametros" />

    <section id="main-content">
        <section class="wrapper">
            <div runat="server" class="row" id="divTabela">

                <div class="col-sm-12">
                    <div class="panel">

                        <header class="panel-heading">
                            Seção      
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
                                        <label class="col-sm-8 control-label" id="lblParametroSelecionados"></label>
                                        <asp:HiddenField runat="server" ID="ParametroSelecionados" />
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
                                                    <th>Acesso ao Desenvolvimento  </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td runat="server" id="tdCheckbox" align="center">
                                                <input type="checkbox" runat="server" id="chkAni" class="checkboxdahora" onclick='<%# "return jsSelecionaParametro(" + Eval("id") + ", \"" + Eval("desc_parametro") + "\", this);" %>' visible="true" />
                                            </td>
                                            <td class="center">
                                                <asp:Label ID="lblId" CssClass="lbCodigo" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("desc_parametro") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("flg_acesso_desenvolvimento") %></td>
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

            <div class="modal fade" tabindex="-1" id="InserirModal" role="dialog" aria-hidden="true" style="opacity: 1">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Inserir Registro</h5>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-sm-4" id="lbDesc_parametro">
                                    Descrição Do Parâmetro:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="txtDesc_parametro" placeholder="Digite a descrição " class="form-control" />
                                    <input type="hidden" runat="server" id="hftxtDesc_parametro" />
                                </div>
                            </div>

                            <br />
                            <div class="form-group">

                                <label class="col-sm-4">
                                    Acesso ao Desenvolvimento:
                                </label>

                                <div class="col-sm-6">

                                    <input id="ckAcessoDesenvolvimento" type="checkbox"
                                        data-toggle="switchbutton" checked data-width="60" data-height="40" data-onlabel="Sim" data-offlabel="Não">
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnInserir" CssClass="btn btn-success" Text="Inserir" OnClick="btnInserir_Click" OnClientClick="return jsValidar()" />
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
                                <label class="col-sm-4" id="AltlbDesc_parametro">
                                    Descrição Do Parâmetro:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="AlttxtDesc_parametro" placeholder="Digite a descrição " class="form-control" />
                                    <input type="hidden" runat="server" id="hfAlttxtDesc_parametro" />
                                </div>
                            </div>
							
							<br />
							<div class="form-group">

                                <label class="col-sm-4">
                                    Acesso ao Desenvolvimento:
                                </label>

                                <div class="col-sm-6">

                                    <input id="AltckAcessoDesenvolvimento" type="checkbox"
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


</asp:Content>
