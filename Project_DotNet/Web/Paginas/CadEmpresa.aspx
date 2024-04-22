<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="CadEmpresa.aspx.cs" Inherits="Web.Paginas.CadEmpresa" %>

<%@ Register Src="~/Paginas/Filtros/FiltroPessoa.ascx" TagName="FiltroPessoa" TagPrefix="ctrl" %>

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
        var empresaSelecionados = [];
        var empresaSelecionadoscnpj = [];

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

        function jsSelecionaEmpresa(id, cnpj, cb) {

            if (cb.checked) {
                empresaSelecionados.push(id);
                empresaSelecionadoscnpj.push(cnpj);
            }
            else {
                var index = empresaSelecionados.indexOf(id);
                var indexcnpj = empresaSelecionadoscnpj.indexOf(cnpj);
                empresaSelecionados.splice(index, 1);
                empresaSelecionadoscnpj.splice(indexcnpj, 1);
            }

            jsPreencheLabelempresas();
            SelecionarEmpresa();
        }

        function jsPreencheLabelempresas() {
            var label = document.getElementById('lblEmpresaSelecionados');
            label.innerHTML = "";
            var hfempresas = document.getElementById('<%=hfempresas.ClientID %>');
            hfempresas.value = "";

            for (var i = 0; i < empresaSelecionadoscnpj.length; i++) {
                label.innerHTML += empresaSelecionadoscnpj[i];
                hfempresas.value += empresaSelecionados[i];

                if (i !== empresaSelecionados.length - 1) {
                    label.innerHTML += ", ";
                    hfempresas.value += "-";
                }
            }

        }

        function SelecionarEmpresa() {
            $('#ContentPlaceHolder1_Empresas').val($('#lblEmpresaSelecionados').text());
        }

        function jsValidarDelete() {
            if ($('#lblEmpresaSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
                return false;
            }
            else {
                if ($('#lblEmpresaSelecionados').text().indexOf(',') == -1) {
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
            if ($('#lblEmpresaSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
            } else {
                Acao = "Relatorio";
                var parametro = $('#ContentPlaceHolder1_hfempresas').val();
                $.ajax({
                    type: "POST",
                    url: "CadEmpresa.aspx/relatorio",
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
                                    { title: "Razão Social" },
                                    { title: "CNPJ" },
                                    { title: "Endereço" },
                                    { title: "Telefone" }
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

        function jsAbrirModalInserir() {
            Acao = "Inserir";
            $('#InserirModal').modal('show');
        }

        function jsfecharModalInserir() {
            $('#InserirModal').modal('hide');
        }

        function jsAbrirModalAlterar() {
            if ($('#lblEmpresaSelecionados').text() == "") {
                alert("Selecione o registro.");
            } else if ($('#lblEmpresaSelecionados').text().indexOf(',') != -1) {
                alert("Selecione apenas um registro");
            } else {
                Acao = "Alterar";
                jsMontarEmpresaAlt();
                $('#AlterarModal').modal('show');
            }
        }

        function jsfecharModalAlterar() {
            $('#AlterarModal').modal('hide');
        }

        function jsMontarEmpresaAlt() {
            var parametro = $('#ContentPlaceHolder1_hfempresas').val();

            $.ajax({
                type: "POST",
                url: "CadEmpresa.aspx/montarEmpresa",
                data: "{'id':'" + parametro + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                traditional: true,
                async: false,
                success: function (result) {
                    if (result.d) {
                        $('#ContentPlaceHolder1_AlttxtPessoa').val(result.d[0].Nome_razao_social);
                        $('#ContentPlaceHolder1_AlttxtCNPJ').val(result.d[0].CNPJ_CPF);
                        $('#ContentPlaceHolder1_AlttxtEndereco').val(result.d[0].endereco);
                        $('#ContentPlaceHolder1_AlthfPessoa').val(result.d[0].id);
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function jsAbrirFiltroPessoas() {
            document.getElementById('divPesquisa').style.display = "none";
            $('#divFiltroPessoa').modal('show');
            $('#divFiltroPessoa').fadeIn();
        }

        function jsCloseFiltroPessoas() {
            $('#divFiltroPessoa').modal('hide');
        }

        function jsSelecionarPessoa(id, CNPJ_CPF, Nome_razao_social, endereco) {
            if (Acao == "Inserir") {
                $('#ContentPlaceHolder1_txtPessoa').val(Nome_razao_social);
                $('#ContentPlaceHolder1_txtCNPJ').val(CNPJ_CPF);
                $('#ContentPlaceHolder1_txtEndereco').val(endereco);
                $('#ContentPlaceHolder1_hfPessoa').val(id);
            } else if (Acao == "Alterar") {
                $('#ContentPlaceHolder1_AlttxtPessoa').val(Nome_razao_social);
                $('#ContentPlaceHolder1_AlttxtCNPJ').val(CNPJ_CPF);
                $('#ContentPlaceHolder1_AlttxtEndereco').val(endereco);
                $('#ContentPlaceHolder1_AlthfPessoa').val(id);
            }
            $('#divFiltroPessoa').modal('hide');
        }

        function jsValidar() {
            var id_pessoa_juridica = "";

            if (Acao == "Inserir") {
                if ($('#ContentPlaceHolder1_hfPessoa').val().trim() == "") {
                    alert("Por favor informe a Pessoa Jurídica.");
                    $('#ContentPlaceHolder1_txtPessoa').focus();
                    return false;
                }

                id_pessoa_juridica = $('#ContentPlaceHolder1_hfPessoa').val();
            } else if (Acao == "Alterar") {
                if ($('#ContentPlaceHolder1_AlthfPessoa').val().trim() == "") {
                    alert("Por favor informe a Pessoa Jurídica.");
                    $('#ContentPlaceHolder1_AlttxtPessoa').focus();
                    return false;
                }

                id_pessoa_juridica = $('#ContentPlaceHolder1_AlthfPessoa').val();
            }

            $.ajax({
                type: "post",
                url: "CadEmpresa.aspx/GravarRegistro",
                data: JSON.stringify({
                    id_pessoa_juridica: id_pessoa_juridica,
                    acao: Acao,
                    id_alt: $('#ContentPlaceHolder1_hfempresas').val()
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

    <asp:HiddenField runat="server" ID="hfempresas" />
    <section id="main-content">
        <section class="wrapper">
            <div class="col-sm-12">

                <div class="panel">

                    <header class="panel-heading">
                        Empresa      
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
                                    <label class="col-sm-8 control-label" id="lblEmpresaSelecionados"></label>
                                    <asp:HiddenField runat="server" ID="EmpresaSelecionados" />
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
                                                <th>Razão Social  </th>
                                                <th>CNPJ  </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td runat="server" id="tdCheckbox" align="center">
                                            <input type="checkbox" runat="server" id="chkAni" class="checkboxdahora" onclick='<%# "return jsSelecionaEmpresa(" + Eval("id") + ", \"" + Eval("CNPJ_CPF") + "\", this);" %>' visible="true" />
                                        </td>
                                        <td class="center">
                                            <asp:Label ID="lblId" CssClass="lbCodigo" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                                        </td>
                                        <td class="center" style="font-size: 11px;"><%# Eval("Nome_razao_social") %></td>
                                        <td class="center" style="font-size: 11px;"><%# Eval("CNPJ_CPF") %></td>
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

            <div class="modal fade" tabindex="-1" id="InserirModal" role="dialog" aria-hidden="true" style="opacity: 1">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Inserir Registro</h5>
                        </div>
                        <div class="modal-body">
                            
                            <div class="form-group">

                                <label class="col-sm-2">
                                    Empresa:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="imgLupaPessoa" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="txtPessoa" placeholder="Digite Nome da Empresa " class="form-control" style="width: 370px; float: left; text-transform: uppercase" onblur = "jsvalidarPesqPessoa();" />
                                    <input runat="server" type="text" id="txtCNPJ" placeholder="CNPJ"  class="form-control" style="width: 170px; float: left; top: 0px; left: 410px; position: absolute; text-transform: uppercase" disabled/>
                                    <input type="hidden" runat="server" id="hfPessoa" />
                                </div>

                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-7">
                                    <input runat="server" type="text" id="txtEndereco" placeholder="Endereço"  class="form-control" style="position: relative; left: 150px; width: 545px;"  disabled/>
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

                                <label class="col-sm-2">
                                    Empresa:
                                </label>
                                <div class="col-sm-7">
                                    <img runat="server" src="~/Imagens/lupa.png" id="AltimgLupaPessoa" style="float: left; width: 22px; height: 30px;" />
                                    <input runat="server" type="text" id="AlttxtPessoa" placeholder="Digite Nome da Empresa " class="form-control" style="width: 370px; float: left; text-transform: uppercase" onblur = "jsvalidarPesqPessoa();" />
                                    <input runat="server" type="text" id="AlttxtCNPJ" placeholder="CNPJ"  class="form-control" style="width: 170px; float: left; top: 0px; left: 410px; position: absolute; text-transform: uppercase" disabled/>
                                    <input type="hidden" runat="server" id="AlthfPessoa" />
                                </div>

                            </div>
                            <br />
                            <div class="form-group">
                                <div class="col-sm-7">
                                    <input runat="server" type="text" id="AlttxtEndereco" placeholder="Endereço"  class="form-control" style="position: relative; left: 150px; width: 545px;"  disabled/>
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



        </section>
    </section>

    <ctrl:FiltroPessoa runat="server" ID="ctrFiltroPessoa" />
</asp:Content>
