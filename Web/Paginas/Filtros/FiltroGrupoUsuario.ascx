﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FiltroGrupoUsuario.ascx.cs" Inherits="Web.Paginas.Filtros.FiltroGrupoUsuario" %>

<script type="text/javascript">
    var Acao = "";
    var GrupoUserSelecionados = [];
    var GrupoUserSelecionadosdesc_grupo = [];

    $(document).ready(function () {
        Acao = "Iniciar";
        jsBloqueio();

        var oTable = $('#tbDadosFiltroGrupoUsuario').DataTable({
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

    function jsSelecionaGrupoUser(id, desc_grupo, cb) {

        if (cb.checked) {
            GrupoUserSelecionados.push(id);
            GrupoUserSelecionadosdesc_grupo.push(desc_grupo);
        }
        else {
            var index = GrupoUserSelecionados.indexOf(id);
            var indexdesc_grupo = GrupoUserSelecionadosdesc_grupo.indexOf(desc_grupo);
            GrupoUserSelecionados.splice(index, 1);
            GrupoUserSelecionadosdesc_grupo.splice(indexdesc_grupo, 1);
        }

        jsPreencheLabelGrupoUser();
        SelecionarGrupoUser();
    }

    function jsPreencheLabelGrupoUser() {
        var label = document.getElementById('lblGrupoUserSelecionados');
        label.innerHTML = "";
        var hfgrupoUser = document.getElementById('<%=hfgrupoUser.ClientID %>');
        hfgrupoUser.value = "";

        for (var i = 0; i < GrupoUserSelecionadosdesc_grupo.length; i++) {
            label.innerHTML += GrupoUserSelecionadosdesc_grupo[i];
            hfgrupoUser.value += GrupoUserSelecionados[i];

            if (i !== GrupoUserSelecionados.length - 1) {
                label.innerHTML += ", ";
                hfgrupoUser.value += "-";
            }
        }

    }

    function SelecionarGrupoUser() {
        $('#ContentPlaceHolder1_GrupoUser').val($('#lblGrupoUserSelecionados').text());
    }

    function jsAbrirModalInserirFiltroGrupoUsuarios() {
        Acao = "Inserir";
        $('#InserirModalFiltroGrupoUsuarios').modal('show');
    }

    function jsfecharModalInserirFiltroGrupoUsuarios() {
        $('#InserirModalFiltroGrupoUsuarios').modal('hide');
    }

    function jsValidarFiltroGrupoUsuarios() {
        var Desc_grupo = "";
        if (Acao == "Inserir") {
            if ($('#ContentPlaceHolder1_ctrFiltroGrupoUsuario_txtDesc_grupo').val() == "") {
                alert("Por favor informe a Descrição do Grupo");
                $('#ContentPlaceHolder1_ctrFiltroGrupoUsuario_txtDesc_grupo').focus();
            } else Desc_grupo = $('#ContentPlaceHolder1_ctrFiltroGrupoUsuario_txtDesc_grupo').val();
        }
        else if (Acao == "Alterar") {
            if ($('#ContentPlaceHolder1_AlttxtDesc_grupo').val() == "") {
                alert("Por favor informe a Descrição do Grupo");
                $('#ContentPlaceHolder1_AlttxtDesc_grupo').focus();
            } else Desc_grupo = $('#ContentPlaceHolder1_AlttxtDesc_grupo').val();
        }

        if (Desc_grupo != "") {

            var param = {
                desc_grupo: Desc_grupo,
                acao: Acao,
                id_alt: $('#ContentPlaceHolder1_hfgrupoUser').val()
            };

            jsPageMethods(ResolveUrl("~/Paginas/Filtros/FiltroGrupoUsuario.ascx.cs/GravarRegistro"), param, function (result) {

            });

        }

    }

</script>

<div id="divFiltroGrupoUsuario" style="display: none;">
    <div id="divContentFinder" runat="server" class="panel panel-default motivo" style="top: 5%; left: 16%; position: fixed; border: 1px solid #000; border-radius: 5px; padding: 5px; background: white; z-index: 999999; width: 70%;">
        <header class="panel-heading">
            <div style="text-align: right;">
                <label style="float: left; position: absolute; left: 10px;">Grupo de Usuário</label>
                <img runat="server" src="~/Imagens/excluir.png" onclick="jsCloseFiltroGrupoUsuarios(this)"
                    style="width: 16px; height: 16px; cursor: pointer;" alt="Fechar" title="Fechar" />
            </div>
        </header>
        <asp:HiddenField runat="server" ID="hfgrupoUser" />
        <input type="hidden" id="hfIdLabelFiltroGrupoUsuarios" />
        <input type="hidden" id="hfIdHiddenFiltroGrupoUsuarios" />

        <section class="panel" style="padding: 10px">

            <div runat="server" class="row" id="divTabela">

                <div class="col-sm-12">
                    <div class="panel">

                        <div class="panel-body">
                            <button type="button" id="ModalInserirFiltroGrupoUsuarios" class="btn btn-success" onclick="jsAbrirModalInserirFiltroGrupoUsuarios();">ADICIONAR REGISTRO</button>
                        </div>

                        <div class="panel-body">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <label class="col-sm-2 control-label"><b>SELECIONADOS:</b></label>
                                        <label class="col-sm-8 control-label" id="lblGrupoUserSelecionados"></label>
                                        <asp:HiddenField runat="server" ID="GrupoUserSelecionados" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <section class="panel" runat="server" id="divResultado" visible="true">
                            <div class="panel-body table-responsive-md">
                                <asp:Repeater runat="server" ID="rptTabela">
                                    <HeaderTemplate>
                                        <table class="table table-striped table-advance table-hover dataTable" id="tbDadosFiltroGrupoUsuario">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center;">Selec. </th>
                                                    <th>Código  </th>
                                                    <th>Descrição do Grupo  </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td runat="server" id="tdCheckbox" align="center">
                                                <input type="checkbox" runat="server" id="chkAni" class="checkboxdahora" onclick='<%# "return jsSelecionaGrupoUser(" + Eval("id") + ", \"" + Eval("desc_grupo") + "\", this);" %>' visible="true" />
                                            </td>
                                            <td class="center">
                                                <asp:Label ID="lblId" CssClass="lbCodigo" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                                            </td>
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


            <div class="modal fade" tabindex="-1" id="InserirModalFiltroGrupoUsuarios" role="dialog" aria-hidden="true" style="opacity: 1">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Inserir Registro</h5>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">

                                <label class="col-sm-4" id="lbDesc_grupo">
                                    Descrição do Grupo:
                                </label>

                                <div class="col-sm-6">
                                    <input runat="server" type="text" id="txtDesc_grupo" placeholder="Digite a descrição do Grupo " class="form-control" />
                                    <input type="hidden" runat="server" id="hftxtDesc_grupo" />
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <input type="button" id="btnInserir" value="Inserir" runat="server" class="btn btn-success" />
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>


        </section>
    </div>
</div>

