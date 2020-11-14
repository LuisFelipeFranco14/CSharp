<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FiltroPessoa.ascx.cs" Inherits="Web.Paginas.Filtros.FiltroPessoa" %>

<script type="text/javascript">

    function filtro() {

        if (($('#ContentPlaceHolder1_ctrFiltroPessoa_txtRazaoSocial').val().trim() != '') || ($('#ContentPlaceHolder1_ctrFiltroPessoa_txtNomeFantasia').val().trim() != '') ||
            ($('#ContentPlaceHolder1_ctrFiltroPessoa_txtCNPJ').val().trim() != '')) {

            var service = $('#<%=hfService.ClientID %>').val().trim();

            var param = JSON.stringify({
                Razoasocial: $('#<%=txtRazaoSocial.ClientID %>').val().trim(),
                NomeFantasia: $('#<%=txtNomeFantasia.ClientID %>').val().trim(),
                CNPJ: $('#<%=txtCNPJ.ClientID %>').val().trim()
            });

            var tableObject = document.getElementById('<%=tablePessoasFiltro.ClientID %>');
            removeAllChilds(tableObject);

            var imgSelecionar = '<%=ResolveUrl("~/Imagens/check.png") %>';

            if (tableObject.tHead == null) {
                var listaColunas = ["SELECIONAR", "CNPJ", "Razão Social", "Endereço"];
                jsAdicionarCabecalhoTabela(tableObject, listaColunas);
            }

            jsPageMethods(service, param, function (result) {
                var tbody = jsAdicionarCorpoTabela(tableObject);

                for (i = 0; i < result.length; i++) {

                    var tr = document.createElement('tr');
                    var tdAcoes = document.createElement('td');
                    var td1 = document.createElement('td');
                    var td2 = document.createElement('td');
                    var td3 = document.createElement('td');

                    tdAcoes.style.width = "5px";
                    td1.style.width = "10px";
                    td2.style.width = "260px";
                    td3.style.width = "260px";


                    tdAcoes.innerHTML = '<center>' +
                        '<img src="' + imgSelecionar + '" Style="border: none; width: 30px; padding-right:10px;cursor:pointer;" ' +
                        'onclick="jsSelecionarPessoa(' + result[i].id+',\'' + result[i].CNPJ_CPF + '\', \'' + result[i].Nome_razao_social + '\', \'' + result[i].endereco+'\');"/></img>' +
                        '</center>';
                    td1.innerHTML = result[i].CNPJ_CPF;
                    td2.innerHTML = result[i].Nome_razao_social;
                    td3.innerHTML = result[i].endereco;
                    
                    var listaColunas = [tdAcoes, td1, td2, td3];

                jsAdicionarLinhaTabela(listaColunas, tr);
                tbody.appendChild(tr);
            }

                document.getElementById('divPesquisa').style.display = "block";
            });

        } else {
            alert("Por favor insira algum campo.");
            var tableObject = document.getElementById('<%=tablePessoasFiltro.ClientID %>');
            removeAllChilds(tableObject);
        }

        return false;
    }

</script>

<div id="divFiltroPessoa" style="display: none;">
    <div id="divContentFinder" runat="server" class="panel panel-default motivo" style="top: 5%; left: 16%; position: fixed; border: 1px solid #000; border-radius: 5px; padding: 5px; background: white; z-index: 999999; width: 70%;">
        <header class="panel-heading">
            <div style="text-align: right;">
                <label style="float: left; position: absolute; left: 10px;">Pessoa</label>
                <img runat="server" src="~/Imagens/excluir.png" onclick="jsCloseFiltroPessoas(this)"
                    style="width: 16px; height: 16px; cursor: pointer;" alt="Fechar" title="Fechar" />
            </div>
        </header>
        <asp:HiddenField runat="server" ID="hfPessoa" />

        <section class="panel" style="padding: 10px">

            <div class="form-group">
                <div class="col-sm-12">
                    <label class="col-sm-2 control-label ">
                        Razão Social</label>
                    <div class="col-sm-4">
                        <asp:TextBox runat="server" ID="txtRazaoSocial" class="form-control"></asp:TextBox>
                    </div>
                    <label class="col-sm-2 control-label ">
                        Nome Fantásia</label>
                    <div class="col-sm-4">
                        <asp:TextBox runat="server" ID="txtNomeFantasia" class="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-12">
                    <label class="col-sm-2 control-label ">
                        CNPJ</label>
                    <div class="col-sm-4">
                        <asp:TextBox runat="server" ID="txtCNPJ" class="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            <asp:Button runat="server" ID="btnConsultar" class="btn btn-primary"  OnClientClick="return filtro();" Text="CONSULTAR" />

        </section>

         <div style="width: 100%; height: 180px; overflow: scroll" id="divPesquisa">
                <table id="tablePessoasFiltro" runat="server" class="table table-striped table-bordered bootstrap-datatable" style="font-size: 10pt;">
                    <thead>
                        <tr>
                            <th> SELECIONAR </th>
                            <th> CNPJ </th>
                            <th> Razão Social </th>
                            <th> Endereço </th>
                        </tr>
                    </thead>
                </table>
            </div>

    </div>
</div>
<input type="hidden" id="hfService" runat="server" />
