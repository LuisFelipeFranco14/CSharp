<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FiltroSecao.ascx.cs" Inherits="Web.Paginas.Filtros.FiltroSecao" %>

<script type="text/javascript">
    var Acao = "";
    var SecaoSelecionados = [];
    var SecaoSelecionadosdescricao_com_caracter = [];

    $(document).ready(function () {
        Acao = "Iniciar";
        jsBloqueio();

        var oTable = $('#tbDadosFiltroSecao').DataTable({
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

    function jsSelecionaSecao(id, descricao_com_caracter, cb) {

        if (cb.checked) {
            SecaoSelecionados.push(id);
            SecaoSelecionadosdescricao_com_caracter.push(descricao_com_caracter);
        }
        else {
            var index = SecaoSelecionados.indexOf(id);
            var indexdescricao_com_caracter = SecaoSelecionadosdescricao_com_caracter.indexOf(descricao_com_caracter);
            SecaoSelecionados.splice(index, 1);
            SecaoSelecionadosdescricao_com_caracter.splice(indexdescricao_com_caracter, 1);
        }

        jsPreencheLabelSecao();
        SelecionarSecao();
    }

    function jsPreencheLabelSecao() {
        var label = document.getElementById('lblSecaoSelecionados');
        label.innerHTML = "";
        var hfSecao = document.getElementById('<%=hfSecao.ClientID %>');
        hfSecao.value = "";

        for (var i = 0; i < SecaoSelecionadosdescricao_com_caracter.length; i++) {
            label.innerHTML += SecaoSelecionadosdescricao_com_caracter[i];
            hfSecao.value += SecaoSelecionados[i];

            if (i !== SecaoSelecionados.length - 1) {
                label.innerHTML += ", ";
                hfSecao.value += "-";
            }
        }

    }

    function SelecionarSecao() {
        $('#ContentPlaceHolder1_Secao').val($('#lblSecaoSelecionados').text());
        jsCloseFiltroSecaos();
    }

</script>

<div id="divFiltroSecao" style="display: none;">
    <div id="divContentFinder" runat="server" class="panel panel-default motivo" style="top: 5%; left: 16%; position: fixed; border: 1px solid #000; border-radius: 5px; padding: 5px; background: white; z-index: 999999; width: 70%;">
        <header class="panel-heading">
            <div style="text-align: right;">
                <label style="float: left; position: absolute; left: 10px;">Seção</label>
                <img runat="server" src="~/Imagens/excluir.png" onclick="jsCloseFiltroSecaos(this)"
                    style="width: 16px; height: 16px; cursor: pointer;" alt="Fechar" title="Fechar" />
            </div>
        </header>
        <asp:HiddenField runat="server" ID="hfSecao" />

        <section class="panel" style="padding: 10px">

            <div runat="server" class="row" id="divTabela">

                <div class="col-sm-12">
                    <div class="panel">

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
                                        <table class="table table-striped table-advance table-hover dataTable" id="tbDadosFiltroSecao">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center;">Selec. </th>
                                                    <th>Código  </th>
                                                    <th>Descrição sem Caracteres  </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td runat="server" id="tdCheckbox" align="center">
                                                <input type="checkbox" runat="server" id="chkSecao" class="checkboxdahora" onclick='<%# "return jsSelecionaSecao(" + Eval("id") + ", \"" + Eval("descricao_com_caracter") + "\", this);" %>' visible="true" />
                                            </td>
                                            <td class="center">
                                                <asp:Label ID="lblId" CssClass="lbCodigo" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("descricao_com_caracter") %></td>
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


        </section>
    </div>
</div>