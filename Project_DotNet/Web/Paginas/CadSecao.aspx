<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="CadSecao.aspx.cs" Inherits="Web.Paginas.CadSecao" %>

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

    <script type="text/javascript">


        var Acao = "";
        var secaoSelecionados = [];
        var secaoSelecionadosdescricao_sem_caracter = [];

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

        function jsSelecionaSecao(id, descricao_sem_caracter, cb) {

            if (cb.checked) {
                secaoSelecionados.push(id);
                secaoSelecionadosdescricao_sem_caracter.push(descricao_sem_caracter);
            }
            else {
                var index = secaoSelecionados.indexOf(id);
                var indexdescricao_sem_caracter = secaoSelecionadosdescricao_sem_caracter.indexOf(descricao_sem_caracter);
                secaoSelecionados.splice(index, 1);
                secaoSelecionadosdescricao_sem_caracter.splice(indexdescricao_sem_caracter, 1);
            }

            jsPreencheLabelsecoes();
            SelecionarSecao();
        }

        function jsPreencheLabelsecoes() {
            var label = document.getElementById('lblSecaoSelecionados');
            label.innerHTML = "";
            var hfsecoes = document.getElementById('<%=hfsecoes.ClientID %>');
            hfsecoes.value = "";

            for (var i = 0; i < secaoSelecionadosdescricao_sem_caracter.length; i++) {
                label.innerHTML += secaoSelecionadosdescricao_sem_caracter[i];
                hfsecoes.value += secaoSelecionados[i];

                if (i !== secaoSelecionados.length - 1) {
                    label.innerHTML += ", ";
                    hfsecoes.value += "-";
                }
            }

        }

        function SelecionarSecao() {
            $('#ContentPlaceHolder1_Secoes').val($('#lblSecaoSelecionados').text());
        }

        function jsAbrirModalInserir() {
            Acao = "Inserir";
            $('#InserirModal').modal('show');
        }

        function jsfecharModalInserir() {
            $('#InserirModal').modal('hide');
        }

        function jsAbrirModalAlterar() {
            if ($('#lblSecaoSelecionados').text() == "") {
                alert("Selecione o registro.");
            } else if ($('#lblSecaoSelecionados').text().indexOf(',') != -1) {
                alert("Selecione apenas um registro");
            } else {
                Acao = "Alterar";
                jsMontarSecaoAlt();
                $('#AlterarModal').modal('show');
            }
        }

        function jsfecharModalAlterar() {
            $('#AlterarModal').modal('hide');
        }

        function jsMontarSecaoAlt() {
            var parametro = $('#ContentPlaceHolder1_hfsecoes').val();

            $.ajax({
                type: "POST",
                url: "CadSecao.aspx/montarSecao",
                data: "{'id':'" + parametro + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                traditional: true,
                async: false,
                success: function (result) {
                    if (result.d) {
                        $('#ContentPlaceHolder1_AlttxtDescricao_sem_caracter').val(result.d[0].descricao_sem_caracter);
                        $('#ContentPlaceHolder1_AlttxtDescricao_com_caracter').val(result.d[0].descricao_com_caracter);
                        $('#ContentPlaceHolder1_AlttxtIcon').val(result.d[0].icon);
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function jsValidarDelete() {
            if ($('#lblSecaoSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
                return false;
            }
            else
                if ($('#lblSecaoSelecionados').text().indexOf(',') == -1) {
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

        function jsValidar() {
            var Descricao_sem_caracter = "";
            var Descricao_com_caracter = "";
            var Icon = "";
            if (Acao == "Inserir") {
                var alphaExp = /^[a-zA-Z]+$/;
                if ($('#ContentPlaceHolder1_txtDescricao_sem_caracter').val().trim() == "") {
                    alert("Por favor informe a Descrição sem Caracteres.");
                    $('#ContentPlaceHolder1_txtDescricao_sem_caracter').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtDescricao_com_caracter').val().trim() == "") {
                    alert("Por favor informe a Descrição com Caracteres.");
                    $('#ContentPlaceHolder1_txtDescricao_com_caracter').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtIcon').val().trim() == "") {
                    alert("Por favor informe a Data de Nascimento.");
                    $('#ContentPlaceHolder1_txtIcon').focus();
                    return false;
                } else if (!$('#ContentPlaceHolder1_txtDescricao_sem_caracter').val().match(alphaExp)) {
                    alert("Por favor informe sem Caracteres.");
                    $('#ContentPlaceHolder1_txtDescricao_sem_caracter').focus();
                    return false;
                }

                Descricao_sem_caracter = $('#ContentPlaceHolder1_txtDescricao_sem_caracter').val();
                Descricao_com_caracter = $('#ContentPlaceHolder1_txtDescricao_com_caracter').val();
                Icon = $('#ContentPlaceHolder1_txtIcon').val();
                

            } else if (Acao == "Alterar") {
                var alphaExp = /^[a-zA-Z]+$/;
                if ($('#ContentPlaceHolder1_AlttxtDescricao_sem_caracter').val().trim() == "") {
                    alert("Por favor informe a Descrição sem Caracteres.");
                    $('#ContentPlaceHolder1_AlttxtDescricao_sem_caracter').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtDescricao_com_caracter').val().trim() == "") {
                    alert("Por favor informe a Descrição com Caracteres.");
                    $('#ContentPlaceHolder1_AlttxtDescricao_com_caracter').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtIcon').val().trim() == "") {
                    alert("Por favor informe a Data de Nascimento.");
                    $('#ContentPlaceHolder1_AlttxtIcon').focus();
                    return false;
                } else if (!$('#ContentPlaceHolder1_AlttxtDescricao_sem_caracter').val().match(alphaExp)) {
                    alert("Por favor informe sem Caracteres.");
                    $('#ContentPlaceHolder1_AlttxtDescricao_sem_caracter').focus();
                    return false;
                }

                Descricao_sem_caracter = $('#ContentPlaceHolder1_AlttxtDescricao_sem_caracter').val();
                Descricao_com_caracter = $('#ContentPlaceHolder1_AlttxtDescricao_com_caracter').val();
                Icon = $('#ContentPlaceHolder1_AlttxtIcon').val();
            }

            $.ajax({
                type: "post",
                url: "CadSecao.aspx/GravarRegistro",
                data: JSON.stringify({
                    descricao_sem_caracter: Descricao_sem_caracter,
                    descricao_com_caracter: Descricao_com_caracter,
                    icon: Icon,
                    acao: Acao,
                    id_alt: $('#ContentPlaceHolder1_hfsecoes').val()
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
            if ($('#lblSecaoSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
            } else {
                Acao = "Relatorio";
                var parametro = $('#ContentPlaceHolder1_hfsecoes').val();
                $.ajax({
                    type: "POST",
                    url: "CadSecao.aspx/relatorio",
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
                                    { title: "Descrição sem Caracteres" },
                                    { title: "Descrição com Caracteres" },
                                    { title: "Icone" }
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
            min-width: 900px;
        }

        .relatorio {
            width: 1500px;
            font-size: 14px;
            left: -350px;
        }

    </style>

    <asp:HiddenField runat="server" ID="hfsecoes" />
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
                                        <label class="col-sm-8 control-label" id="lblSecaoSelecionados"></label>
                                        <asp:HiddenField runat="server" ID="SecaoSelecionados" />
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
                                                    <th>Descrição sem Caracter  </th>
                                                    <th>Descrição com Caracter  </th>
                                                    <th>Icones  </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td runat="server" id="tdCheckbox" align="center">
                                                <input type="checkbox" runat="server" id="chkAni" class="checkboxdahora" onclick='<%# "return jsSelecionaSecao(" + Eval("id") + ", \"" + Eval("descricao_sem_caracter") + "\", this);" %>' visible="true" />
                                            </td>
                                            <td class="center">
                                                <asp:Label ID="lblId" CssClass="lbCodigo" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("descricao_sem_caracter") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("descricao_com_caracter") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("icon") %></td>
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

            <div class="modal fade" tabindex="-1" id="InserirModal" role="dialog" aria-hidden="true" style="opacity:1">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Inserir Registro</h5>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">

                                <label class="col-sm-4" id="lbDescricao_sem_caracter">
                                    Descrição Sem Caracteres:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="txtDescricao_sem_caracter" placeholder="Digite a descrição sem caracteres " class="form-control" />
                                    <input type="hidden" runat="server" id="hftxtDescricao_sem_caracter" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-4" id="lbDescricao_com_caracter">
                                    Descrição Com Caracteres:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="txtDescricao_com_caracter" placeholder="Digite a descrição com caracteres " class="form-control" />
                                    <input type="hidden" runat="server" id="hftxtDescricao_com_caracter" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-4" id="lbIcon">
                                    Icone:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="txtIcon" placeholder="Digite a descrição do Icon " class="form-control" />
                                    <input type="hidden" runat="server" id="hftxtIcon" />
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

                                <label class="col-sm-4" id="AltlbDescricao_sem_caracter">
                                    Descrição Sem Caracteres:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="AlttxtDescricao_sem_caracter" placeholder="Digite a descrição sem caracteres " class="form-control" />
                                    <input type="hidden" runat="server" id="hfAlttxtDescricao_sem_caracter" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-4" id="lbAltDescricao_com_caracter">
                                    Descrição Com Caracteres:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="AlttxtDescricao_com_caracter" placeholder="Digite a descrição com caracteres " class="form-control" />
                                    <input type="hidden" runat="server" id="hfAlttxtDescricao_com_caracter" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-4" id="lbAltIcon">
                                    Icone:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="AlttxtIcon" placeholder="Digite a descrição do Icon " class="form-control" />
                                    <input type="hidden" runat="server" id="hfAlttxtIcon" />
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
