<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="CadPessoa.aspx.cs" Inherits="Web.Paginas.CadPessoa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
        var validar_pessoa = "";
        var pessoasSelecionados = [];
        var pessoasSelecionadosCPF = [];

        $(document).ready(function () {
            Acao = "Iniciar";
            validar_pessoa = "Fisica";
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
            $("#GroupNomeFantasia").css("display", "none");
            $("#linhabrancaNomeFantasia").css("display", "none");
        }

        function jsSelecionaPessoas(id, cpf, cb) {

            if (cb.checked) {
                pessoasSelecionados.push(id);
                pessoasSelecionadosCPF.push(cpf);
            }
            else {
                var index = pessoasSelecionados.indexOf(id);
                var indexCpf = pessoasSelecionadosCPF.indexOf(cpf);
                pessoasSelecionados.splice(index, 1);
                pessoasSelecionadosCPF.splice(indexCpf, 1);
            }

            jsPreencheLabelpessoas();
            SelecionarPessoa();
        }

        function jsPreencheLabelpessoas() {
            var label = document.getElementById('lblPessoaSelecionados');
            label.innerHTML = "";
            var hfpessoas = document.getElementById('<%=hfpessoas.ClientID %>');
            hfpessoas.value = "";

            for (var i = 0; i < pessoasSelecionadosCPF.length; i++) {
                label.innerHTML += pessoasSelecionadosCPF[i];
                hfpessoas.value += pessoasSelecionados[i];

                if (i !== pessoasSelecionados.length - 1) {
                    label.innerHTML += ", ";
                    hfpessoas.value += "-";
                }
            }

        }

        function SelecionarPessoa() {
            $('#ContentPlaceHolder1_PessoaSelecionados').val($('#lblPessoaSelecionados').text());
        }

        function jsAbrirModalInserir() {
            Acao = "Inserir";
            $('#InserirModal').modal('show');
        }

        function jsfecharModalInserir() {
            $('#InserirModal').modal('hide');
        }

        function jsAbrirModalAlterar() {
            if ($('#lblPessoaSelecionados').text() == "") {
                alert("Selecione o registro.");
            } else if ($('#lblPessoaSelecionados').text().indexOf(',') != -1) {
                alert("Selecione apenas um registro");
            } else {
                Acao = "Alterar";
                jsMontarPessoaAlt();
                $('#AlterarModal').modal('show');
            }
        }

        function jsfecharModalAlterar() {
            $('#AlterarModal').modal('hide');
        }

        function jsMontarPessoaAlt() {
            var parametro = $('#ContentPlaceHolder1_hfpessoas').val();

            $.ajax({
                type: "POST",
                url: "CadPessoa.aspx/montarPessoa",
                data: "{'id':'" + parametro + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                traditional: true,
                async: false,
                success: function (result) {
                    if (result.d) {

                        if (result.d[0].flag_pessoa == "F") {
                            tipo_pessoa_fisica();
                            $('#AltidFisica').prop("checked", true);
                            $('#AltidJuridica').prop("checked", false);
                        } else if (result.d[0].flag_pessoa == "J") {
                            tipo_pessoa_juridica();
                            $('#AltidFisica').prop("checked", false);
                            $('#AltidJuridica').prop("checked", true);
                            $('#ContentPlaceHolder1_AlttxtNomeFantasia').val(result.d[0].Nome_fantasia);
                        }

                        $('#ContentPlaceHolder1_AlttxtNome').val(result.d[0].Nome_razao_social);
                        $('#ContentPlaceHolder1_AlttxtTelefone').val(result.d[0].telefone);
                        $('#ContentPlaceHolder1_AlttxtCelular').val(result.d[0].celular);
                        $('#ContentPlaceHolder1_AlttxtEmail').val(result.d[0].email);
                        $('#ContentPlaceHolder1_AlttxtNumero').val(result.d[0].numero);
                        $('#ContentPlaceHolder1_AlttxtComplemento').val(result.d[0].complemento);
                        $('#ContentPlaceHolder1_AlttxtCEP').val(result.d[0].CEP);
                        $('#ContentPlaceHolder1_AlttxtCPF').val(result.d[0].CNPJ_CPF);
                        $("#ContentPlaceHolder1_AlttxtCPF").prop("disabled", true);

                        $('#<%= AlttxtEndereco.ClientID %>').val(result.d[0].Logradouro);
                        $('#<%= AlttxtBairro.ClientID %>').val(result.d[0].Bairro);
                        $('#<%= AlttxtCidade.ClientID %>').val(result.d[0].Cidade);
                        var AltddlEstado = $('#<%= AltddlEstado.ClientID %>');
                        AltddlEstado.val(result.d[0].UF).change();
                        AltddlEstado.trigger("chosen:updated");


                        $('#ContentPlaceHolder1_AlttxtDataNasc').val(result.d[0].dt_nascimento);



                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function tipo_pessoa_fisica() {
            if (Acao == "Inserir") {
                validar_pessoa = "Fisica";
                var lbComplemento = document.getElementById('lbComplemento');
                $('#ContentPlaceHolder1_txtNome').val('');
                $('#ContentPlaceHolder1_txtCPF').val('');
                $('#ContentPlaceHolder1_txtDataNasc').val('');


                $('#lbNome').text("Nome:");
                $('#lbNome').text($('#lbNome').text().trim());
                $('#lbCPF').text("CPF:");
                $('#lbCPF').text($('#lbCPF').text().trim());
                $('#lbDtNasc').text("Data de Nascimento:");
                $('#lbDtNasc').text($('#lbDtNasc').text().trim());

                $('#ContentPlaceHolder1_txtCPF').val('').attr('placeholder', "Digite o CPF ");
                $('#ContentPlaceHolder1_txtNome').val('').attr('placeholder', "Digite o nome da Pessoa ");

                $("#GroupNomeFantasia").css("display", "none");
                $("#linhabrancaNomeFantasia").css("display", "none");
            } else if (Acao == "Alterar") {
                validar_pessoa = "Fisica";
                var lbComplemento = document.getElementById('AltlbComplemento');
                $('#ContentPlaceHolder1_AlttxtNome').val('');
                $('#ContentPlaceHolder1_AlttxtCPF').val('');
                $('#ContentPlaceHolder1_AlttxtDataNasc').val('');


                $('#AltlbNome').text("Nome:");
                $('#AltlbNome').text($('#AltlbNome').text().trim());
                $('#AltlbCPF').text("CPF:");
                $('#AltlbCPF').text($('#AltlbCPF').text().trim());
                $('#AltlbDtNasc').text("Data de Nascimento:");
                $('#AltlbDtNasc').text($('#AltlbDtNasc').text().trim());

                $('#ContentPlaceHolder1_AlttxtCPF').val('').attr('placeholder', "Digite o CPF ");
                $('#ContentPlaceHolder1_AlttxtNome').val('').attr('placeholder', "Digite o nome da Pessoa ");

                $("#AltGroupNomeFantasia").css("display", "none");
                $("#AltlinhabrancaNomeFantasia").css("display", "none");
            }

        }

        function tipo_pessoa_juridica() {
            if (Acao == "Inserir") {
                validar_pessoa = "Juridica";
                var lbComplemento = document.getElementById('lbComplemento');
                $('#ContentPlaceHolder1_txtNome').val('');
                $('#ContentPlaceHolder1_txtCPF').val('');
                $('#ContentPlaceHolder1_txtDataNasc').val('');

                $('#lbNome').text("Razão Social:");
                $('#lbNome').text($('#lbNome').text().trim());
                $('#lbCPF').text("CNPJ:");
                $('#lbCPF').text($('#lbCPF').text().trim());
                $('#lbDtNasc').text("Data de Criação:");
                $('#lbDtNasc').text($('#lbDtNasc').text().trim());

                $('#ContentPlaceHolder1_txtCPF').val('').attr('placeholder', "Digite o CNPJ ");
                $('#ContentPlaceHolder1_txtNome').val('').attr('placeholder', "Digite a Razão Social ");

                $("#GroupNomeFantasia").css("display", "block");
                $("#linhabrancaNomeFantasia").css("display", "block");
            } else if (Acao == "Alterar") {
                validar_pessoa = "Juridica";
                var lbComplemento = document.getElementById('AltlbComplemento');
                $('#ContentPlaceHolder1_AlttxtNome').val('');
                $('#ContentPlaceHolder1_AlttxtCPF').val('');
                $('#ContentPlaceHolder1_AlttxtDataNasc').val('');

                $('#AltlbNome').text("Razão Social:");
                $('#AltlbNome').text($('#AltlbNome').text().trim());
                $('#AltlbCPF').text("CNPJ:");
                $('#AltlbCPF').text($('#AltlbCPF').text().trim());
                $('#AltlbDtNasc').text("Data de Criação:");
                $('#AltlbDtNasc').text($('#AltlbDtNasc').text().trim());

                $('#ContentPlaceHolder1_AlttxtCPF').val('').attr('placeholder', "Digite o CNPJ ");
                $('#ContentPlaceHolder1_AlttxtNome').val('').attr('placeholder', "Digite a Razão Social ");

                $("#AltGroupNomeFantasia").css("display", "block");
                $("#AltlinhabrancaNomeFantasia").css("display", "block");
            }

        }

        function mascara_cpf_cnpj(e) {
            if (Acao == "Inserir") {
                if ($('#lbCPF').text().trim().replace(':', '') == "CPF") {
                    $(e).mask('000.000.000-00');
                }
                else if ($('#lbCPF').text().trim().replace(':', '') == "CNPJ") {
                    $(e).mask('00.000.000/0000-00');
                }
            } else if (Acao == "Alterar") {
                if ($('#ALtlbCPF').text().trim().replace(':', '') == "CPF") {
                    $(e).mask('000.000.000-00');
                }
                else if ($('#ALtlbCPF').text().trim().replace(':', '') == "CNPJ") {
                    $(e).mask('00.000.000/0000-00');
                }

            }

        }

        function SomenteNumero(e) {
            var tecla = (window.event) ? event.keyCode : e.whitch;
            if ((tecla > 47 && tecla < 58)) {
                return true;

            } else if (tecla == 8 || tecla == 0) {
                return true;

            } else {
                return false;
            }
        }

        function GetDateToday() {
            var data = new Date();
            var dia = data.getDate();
            var mes = data.getMonth();
            var ano = data.getFullYear();

            if (dia < 10) { dia = '0' + dia; }
            if (mes < 10) { mes = mes + 1; }

            var str_data = ano + '-' + mes + '-' + dia;
            return str_data;
        }

        function jsCarregarDadosCEP(txtCep) {
            var cep = "";
            if (Acao == "Inserir") {
                cep = txtCep.value;
            } else if (Acao == "Alterar") {
                cep = AlttxtCEP.value;
            }

            if (cep.trim() != "") {
                var parametro = cep;
                $.ajax({
                    type: "POST",
                    url: "CadPessoa.aspx/RetornarDadosCEP",
                    data: "{'CEP':'" + parametro + "'}",
                    contentType: 'application/json; charset=utf-8',
                    dataType: "json",
                    traditional: true,
                    async: false,
                    success: function (data) {
                        if (Acao == "Inserir") {
                            if (data.d[0].address != null) {
                                $('#<%= txtEndereco.ClientID %>').val(data.d[0].address);
                                $('#<%= txtBairro.ClientID %>').val(data.d[0].district);
                                $('#<%= txtCidade.ClientID %>').val(data.d[0].city);
                                var ddlEstado = $('#<%= ddlEstado.ClientID %>');
                                ddlEstado.val(data.d[0].state).change();
                                ddlEstado.trigger("chosen:updated");
                                $('#ContentPlaceHolder1_txtNumero').focus();
                            } else {
                                $('#<%= txtEndereco.ClientID %>').val("");
                                $('#<%= txtBairro.ClientID %>').val("");
                                $('#<%= txtCidade.ClientID %>').val("");
                                var ddlEstado = $('#<%= ddlEstado.ClientID %>');
                                ddlEstado.val(0).change();
                                ddlEstado.trigger("chosen:updated");
                                alert("O CEP informado não foi encontrado.");
                                $('#ContentPlaceHolder1_txtCEP').val("");
                                $('#ContentPlaceHolder1_txtCEP').focus();
                            }
                        } else if (Acao == "Alterar") {
                            if (data.d[0].address != null) {
                                $('#<%= AlttxtEndereco.ClientID %>').val(data.d[0].address);
                                $('#<%= AlttxtBairro.ClientID %>').val(data.d[0].district);
                                $('#<%= AlttxtCidade.ClientID %>').val(data.d[0].city);
                                var AltddlEstado = $('#<%= AltddlEstado.ClientID %>');
                                AltddlEstado.val(data.d[0].state).change();
                                AltddlEstado.trigger("chosen:updated");
                                $('#ContentPlaceHolder1_AlttxtNumero').focus();
                            } else {
                                $('#<%= AlttxtEndereco.ClientID %>').val("");
                                $('#<%= AlttxtBairro.ClientID %>').val("");
                                $('#<%= AlttxtCidade.ClientID %>').val("");
                                var AltddlEstado = $('#<%= AltddlEstado.ClientID %>');
                                AltddlEstado.val(0).change();
                                AltddlEstado.trigger("chosen:updated");
                                alert("O CEP informado não foi encontrado.");
                                $('#ContentPlaceHolder1_AlttxtCEP').val("");
                                $('#ContentPlaceHolder1_AlttxtCEP').focus();
                            }
                        }


                    },
                    error: function (error) {
                        console.log(error);
                    }
                });

            }
        }

        function jsValidarCPF_CNPJ(CPF_CNPJ) {
            var validarCPF_CNPJ = false;
            $.ajax({
                type: "POST",
                url: "CadPessoa.aspx/validarCPFCNPJ",
                data: "{'CNPJ_CPF':'" + CPF_CNPJ + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                traditional: true,
                async: false,
                success: function (data) {

                    validarCPF_CNPJ = data.d;

                },
                error: function (error) {
                    console.log(error);
                }
            });

            return validarCPF_CNPJ;
        }

        function jsValidar() {
            var nome_RazaoSocial = "";
            var nomeFantasia = "";
            var cpf_cnpj = "";
            var dataNasc = "";
            var telefone = "";
            var celular = "";
            var email = "";
            var cep = "";
            var Estado = "";
            var Cidade = "";
            var Bairro = "";
            var Endereco = "";
            var Numero = "";
            var Complemento = "";

            if (Acao == "Inserir") {
                if ($('#ContentPlaceHolder1_txtNome').val().trim() == "") {
                    alert("Por favor informe o Nome ou Razão Social.");
                    $('#ContentPlaceHolder1_txtNome').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtCPF').val().trim() == "") {
                    alert("Por favor informe o CPF ou CNPJ.");
                    $('#ContentPlaceHolder1_txtCPF').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtDataNasc').val().trim() == "") {
                    alert("Por favor informe a Data de Nascimento.");
                    $('#ContentPlaceHolder1_txtDataNasc').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtTelefone').val().trim() == "") {
                    alert("Por favor informe o Telefone.");
                    $('#ContentPlaceHolder1_txtTelefone').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtCelular').val().trim() == "") {
                    alert("Por favor informe o Celular.");
                    $('#ContentPlaceHolder1_txtCelular').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtEmail').val().trim() == "") {
                    alert("Por favor informe o Email.");
                    $('#ContentPlaceHolder1_txtEmail').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtCEP').val().trim() == "") {
                    alert("Por favor informe o CEP.");
                    $('#ContentPlaceHolder1_txtCEP').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_ddlEstado').val().trim() == "0") {
                    alert("Por favor informe o Estado.");
                    $('#ContentPlaceHolder1_ddlEstado').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtCidade').val().trim() == "") {
                    alert("Por favor informe a Cidade.");
                    $('#ContentPlaceHolder1_txtCidade').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtBairro').val().trim() == "") {
                    alert("Por favor informe o Bairro.");
                    $('#ContentPlaceHolder1_txtBairro').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtEndereco').val().trim() == "") {
                    alert("Por favor informe o Endereço.");
                    $('#ContentPlaceHolder1_txtEndereco').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_txtNumero').val().trim() == "") {
                    alert("Por favor informe o Número.");
                    $('#ContentPlaceHolder1_txtNumero').focus();
                    return false;
                }

                if (validar_pessoa == "Fisica") {
                    if ($('#ContentPlaceHolder1_txtCPF').val().replace('.', '').replace('.', '').replace('-', '').length != 11) {
                        alert("Por favor informe o CPF correto.");
                        $('#ContentPlaceHolder1_txtCPF').focus();
                        return false;
                    }
                } else if (validar_pessoa == "Juridica") {
                    if ($('#ContentPlaceHolder1_txtCPF').val().replace('.', '').replace('.', '').replace('-', '').replace('/', '').length != 14) {
                        alert("Por favor informe o CNPJ correto.");
                        $('#ContentPlaceHolder1_txtCPF').focus();
                        return false;
                    }
                }

                const DateToday = GetDateToday();
                var txtDataNascimento = $('#ContentPlaceHolder1_txtDataNasc').val();
                if (Date.parse(txtDataNascimento) > Date.parse(DateToday)) {
                    alert("Data de Nascimento não pode ser maior do que a Data Atual.");
                    $('#ContentPlaceHolder1_txtDataNasc').focus();
                    return false;
                }

                if ($('#ContentPlaceHolder1_txtTelefone').val().replace('(', '').replace(')', '').replace('-', '').length != 10) {
                    alert("Por favor informe o telefone correto.");
                    $('#ContentPlaceHolder1_txtTelefone').focus();
                    return false;
                }

                if ($('#ContentPlaceHolder1_txtCelular').val().replace('(', '').replace(')', '').replace('-', '').length != 11) {
                    alert("Por favor informe o celular correto.");
                    $('#ContentPlaceHolder1_txtCelular').focus();
                    return false;
                }

                if ($('#ContentPlaceHolder1_txtCEP').val().replace('-', '').length != 8) {
                    alert("Por favor informe o CEP correto.");
                    $('#ContentPlaceHolder1_txtCEP').focus();
                    return false;
                }

                nome_RazaoSocial = $('#ContentPlaceHolder1_txtNome').val();
                nomeFantasia = $('#ContentPlaceHolder1_txtNomeFantasia').val();

                if (validar_pessoa == "Fisica") {
                    cpf_cnpj = $('#ContentPlaceHolder1_txtCPF').val().replace('.', '').replace('.', '').replace('-', '');

                } else if (validar_pessoa == "Juridica") {
                    cpf_cnpj = $('#ContentPlaceHolder1_txtCPF').val().replace('.', '').replace('.', '').replace('-', '').replace('/', '');
                }

                if (jsValidarCPF_CNPJ(cpf_cnpj)) {
                    if (validar_pessoa == "Fisica") {
                        alert("Esse CPF Já foi registrado.");
                    } else if (validar_pessoa == "Juridica") {
                        alert("Esse CNPJ Já foi registrado.");
                    }

                    $('#ContentPlaceHolder1_txtCPF').focus();
                    return false;
                }

                dataNasc = $('#ContentPlaceHolder1_txtDataNasc').val();
                telefone = $('#ContentPlaceHolder1_txtTelefone').val().replace('(', '').replace(')', '').replace('-', '');
                celular = $('#ContentPlaceHolder1_txtCelular').val().replace('(', '').replace(')', '').replace('-', '');
                email = $('#ContentPlaceHolder1_txtEmail').val();
                cep = $('#ContentPlaceHolder1_txtCEP').val().replace('-', '');
                Estado = $('#ContentPlaceHolder1_ddlEstado').val();
                Cidade = $('#ContentPlaceHolder1_txtCidade').val();
                Bairro = $('#ContentPlaceHolder1_txtBairro').val();
                Endereco = $('#ContentPlaceHolder1_txtEndereco').val();
                Numero = $('#ContentPlaceHolder1_txtNumero').val();
                Complemento = $('#ContentPlaceHolder1_txtComplemento').val();

            } else if (Acao == "Alterar") {
                if ($('#ContentPlaceHolder1_AlttxtNome').val().trim() == "") {
                    alert("Por favor informe o Nome ou Razão Social.");
                    $('#ContentPlaceHolder1_AlttxtNome').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtCPF').val().trim() == "") {
                    alert("Por favor informe o CPF ou CNPJ.");
                    $('#ContentPlaceHolder1_AlttxtCPF').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtDataNasc').val().trim() == "") {
                    alert("Por favor informe a Data de Nascimento.");
                    $('#ContentPlaceHolder1_AlttxtDataNasc').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtTelefone').val().trim() == "") {
                    alert("Por favor informe o Telefone.");
                    $('#ContentPlaceHolder1_AlttxtTelefone').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtCelular').val().trim() == "") {
                    alert("Por favor informe o Celular.");
                    $('#ContentPlaceHolder1_AlttxtCelular').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtEmail').val().trim() == "") {
                    alert("Por favor informe o Email.");
                    $('#ContentPlaceHolder1_AlttxtEmail').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtCEP').val().trim() == "") {
                    alert("Por favor informe o CEP.");
                    $('#ContentPlaceHolder1_AlttxtCEP').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AltddlEstado').val().trim() == "0") {
                    alert("Por favor informe o Estado.");
                    $('#ContentPlaceHolder1_AltddlEstado').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtCidade').val().trim() == "") {
                    alert("Por favor informe a Cidade.");
                    $('#ContentPlaceHolder1_AlttxtCidade').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtBairro').val().trim() == "") {
                    alert("Por favor informe o Bairro.");
                    $('#ContentPlaceHolder1_AlttxtBairro').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtEndereco').val().trim() == "") {
                    alert("Por favor informe o Endereço.");
                    $('#ContentPlaceHolder1_AlttxtEndereco').focus();
                    return false;
                } else if ($('#ContentPlaceHolder1_AlttxtNumero').val().trim() == "") {
                    alert("Por favor informe o Número.");
                    $('#ContentPlaceHolder1_AlttxtNumero').focus();
                    return false;
                }

                if (validar_pessoa == "Fisica") {
                    if ($('#ContentPlaceHolder1_AlttxtCPF').val().replace('.', '').replace('.', '').replace('-', '').length != 11) {
                        alert("Por favor informe o CPF correto.");
                        $('#ContentPlaceHolder1_AlttxtCPF').focus();
                        return false;
                    }
                } else if (validar_pessoa == "Juridica") {
                    if ($('#ContentPlaceHolder1_AlttxtCPF').val().replace('.', '').replace('.', '').replace('-', '').replace('/', '').length != 14) {
                        alert("Por favor informe o CNPJ correto.");
                        $('#ContentPlaceHolder1_AlttxtCPF').focus();
                        return false;
                    }
                }

                const DateToday = GetDateToday();
                var txtDataNascimento = $('#ContentPlaceHolder1_AlttxtDataNasc').val();
                if (Date.parse(txtDataNascimento) > Date.parse(DateToday)) {
                    alert("Data de Nascimento não pode ser maior do que a Data Atual.");
                    $('#ContentPlaceHolder1_AlttxtDataNasc').focus();
                    return false;
                }

                if ($('#ContentPlaceHolder1_AlttxtTelefone').val().replace('(', '').replace(')', '').replace('-', '').length != 10) {
                    alert("Por favor informe o telefone correto.");
                    $('#ContentPlaceHolder1_AlttxtTelefone').focus();
                    return false;
                }

                if ($('#ContentPlaceHolder1_AlttxtCelular').val().replace('(', '').replace(')', '').replace('-', '').length != 11) {
                    alert("Por favor informe o celular correto.");
                    $('#ContentPlaceHolder1_AlttxtCelular').focus();
                    return false;
                }

                if ($('#ContentPlaceHolder1_AlttxtCEP').val().replace('-', '').length != 8) {
                    alert("Por favor informe o CEP correto.");
                    $('#ContentPlaceHolder1_AlttxtCEP').focus();
                    return false;
                }

                nome_RazaoSocial = $('#ContentPlaceHolder1_AlttxtNome').val();
                nomeFantasia = $('#ContentPlaceHolder1_AlttxtNomeFantasia').val();

                if (validar_pessoa == "Fisica") {
                    cpf_cnpj = $('#ContentPlaceHolder1_AlttxtCPF').val().replace('.', '').replace('.', '').replace('-', '');

                } else if (validar_pessoa == "Juridica") {
                    cpf_cnpj = $('#ContentPlaceHolder1_AlttxtCPF').val().replace('.', '').replace('.', '').replace('-', '').replace('/', '');
                }

                dataNasc = $('#ContentPlaceHolder1_AlttxtDataNasc').val();
                telefone = $('#ContentPlaceHolder1_AlttxtTelefone').val().replace('(', '').replace(')', '').replace('-', '');
                celular = $('#ContentPlaceHolder1_AlttxtCelular').val().replace('(', '').replace(')', '').replace('-', '');
                email = $('#ContentPlaceHolder1_AlttxtEmail').val();
                cep = $('#ContentPlaceHolder1_AlttxtCEP').val().replace('-', '');
                Estado = $('#ContentPlaceHolder1_AltddlEstado').val();
                Cidade = $('#ContentPlaceHolder1_AlttxtCidade').val();
                Bairro = $('#ContentPlaceHolder1_AlttxtBairro').val();
                Endereco = $('#ContentPlaceHolder1_AlttxtEndereco').val();
                Numero = $('#ContentPlaceHolder1_AlttxtNumero').val();
                Complemento = $('#ContentPlaceHolder1_AlttxtComplemento').val();
            }

            $.ajax({
                type: "post",
                url: "CadPessoa.aspx/GravarRegistro",
                data: JSON.stringify({
                    nome_RazaoSocial: nome_RazaoSocial,
                    nomeFantasia: nomeFantasia,
                    cpf_cnpj: cpf_cnpj,
                    dataNasc: dataNasc,
                    telefone: telefone,
                    celular: celular,
                    email: email,
                    cep: cep,
                    Estado: Estado,
                    Cidade: Cidade,
                    Bairro: Bairro,
                    Endereco: Endereco,
                    Numero: Numero,
                    Complemento: Complemento,
                    acao: Acao,
                    validar_pessoa: validar_pessoa,
                    id_alt: $('#ContentPlaceHolder1_hfpessoas').val()
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
            if ($('#lblPessoaSelecionados').text() == "") {
                alert("Selecione ao menos um registro.");
                return false;
            }
            else
                if ($('#lblPessoaSelecionados').text().indexOf(',') == -1) {
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

        function jsRelatorio() {
            if ($('#lblPessoaSelecionados').text() == "") {
                alert("Selecione o registro.");
            } else {
                Acao = "Relatorio";
                var parametro = $('#ContentPlaceHolder1_hfpessoas').val();
                $.ajax({
                    type: "POST",
                    url: "CadPessoa.aspx/relatorio",
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
                                    { title: "Nome/Razão Social" },
                                    { title: "CPF/CNPJ" },
                                    { title: "Data de Nascimento" },
                                    { title: "CEP" },
                                    { title: "Endereço" },
                                    { title: "Localização" },
                                    { title: "Contatos" },
                                    { title: "E-mail" },
                                    { title: "Tipo Pessoa" }
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

                                                return '<span class="label ' + label + '" style="color: black; font-size: 13px;">' + data + '</span>';
                                            }
                                            return data;
                                        }
                                    },
                                    {
                                        targets: 5,
                                        render: function (data, type, row, meta) {
                                            if (type === 'display') {
                                                var label = 'label-font';

                                                if (data == '' || data == null || data == '0') {
                                                    data = 'N/A';
                                                    label = 'label-default';
                                                }

                                                return '<span class="label ' + label + '" style="color: black;">' + data + '</span>';
                                            }
                                            return data;
                                        }
                                    },
                                    {
                                        targets: 6,
                                        render: function (data, type, row, meta) {
                                            if (type === 'display') {
                                                var label = 'label-font';

                                                if (data == '' || data == null || data == '0') {
                                                    data = 'N/A';
                                                    label = 'label-default';
                                                }

                                                return '<span class="label ' + label + '" style="color: black;">' + data + '</span>';
                                            }
                                            return data;
                                        }
                                    },
                                    {
                                        targets: 7,
                                        render: function (data, type, row, meta) {
                                            if (type === 'display') {
                                                var label = 'label-font';

                                                if (data == '' || data == null || data == '0') {
                                                    data = 'N/A';
                                                    label = 'label-default';
                                                }

                                                return '<span class="label ' + label + '" style="color: black;">' + data + '</span>';
                                            }
                                            return data;
                                        }
                                    },
                                    {
                                        targets: 8,
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
                                        targets: 9,
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

    <asp:HiddenField runat="server" ID="hfpessoas" />
    <section id="main-content">
        <section class="wrapper">

            <div runat="server" class="row" id="divTabela">

                <div class="col-sm-12">
                    <div class="panel">
                        <header class="panel-heading">
                            Pessoa      
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
                                        <label class="col-sm-8 control-label" id="lblPessoaSelecionados"></label>
                                        <asp:HiddenField runat="server" ID="PessoaSelecionados" />
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
                                                    <th>Nome    </th>
                                                    <th>Cpf     </th>
                                                    <th>Telefone</th>
                                                    <th>Celular</th>
                                                    <th>Endereço</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td runat="server" id="tdCheckbox" align="center">
                                                <input type="checkbox" runat="server" id="chkAni" class="checkboxdahora" onclick='<%# "return jsSelecionaPessoas(" + Eval("id") + ", \"" + Eval("CNPJ_CPF") + "\", this);" %>' visible="true" />
                                            </td>
                                            <td class="center">
                                                <asp:Label ID="lblId" CssClass="lbCodigo" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("Nome_razao_social") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("CNPJ_CPF") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("telefone") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("celular") %></td>
                                            <td class="center" style="font-size: 11px;"><%# Eval("Logradouro") %>, <%# Eval("numero") %>, <%# Eval("Bairro")  %><%# Eval("complemento")  %></td>
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

            <div class="modal fade" tabindex="-1" id="InserirModal" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Inserir Registro</h5>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">

                                <div class="col-sm-1">
                                    <div class="form-check">
                                        <input class="form-check-input" onchange="tipo_pessoa_fisica();" type="radio" name="exampleRadios" id="idFisica" value="option1" checked>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <label class="form-check-label" for="idFisica">
                                        Física
                                    </label>
                                </div>

                                <div class="col-sm-1">
                                    <div class="form-check">
                                        <input class="form-check-input" onchange="tipo_pessoa_juridica();" type="radio" name="exampleRadios" id="idJuridica" value="option2">
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <label class="form-check-label" for="idJuridica">
                                        Júridica
                                    </label>
                                </div>
                            </div>

                            <br />

                            <div class="form-group">

                                <label class="col-sm-3" id="lbNome">
                                    Nome:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="txtNome" placeholder="Digite o nome da Pessoa " class="form-control" style="width: 634px; float: left; position: absolute; left: -49px;" />
                                    <input type="hidden" runat="server" id="hftxtNome" />
                                </div>
                            </div>

                            <br />
                            <div class="form-group">
                                <label class="col-sm-2" id="lbCPF">
                                    CPF:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="txtCPF" placeholder="Digite o CPF " class="form-control" style="width: 165px; float: left; text-transform: uppercase" onkeypress="mascara_cpf_cnpj(this);" />
                                    <input type="hidden" runat="server" id="hftxtCPF" />
                                </div>

                                <label class="col-sm-3" id="lbDtNasc">
                                    Data de Nascimento:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="date" id="txtDataNasc" placeholder="Digite a Data de Nascimento" class="form-control" style="width: 248px; float: left;" />
                                    <input type="hidden" runat="server" id="hftxtDataNasc" />
                                </div>
                            </div>
                            <br id="linhabrancaNomeFantasia" />
                            <div class="form-group" id="GroupNomeFantasia">
                                <label class="col-sm-3">
                                    Nome Fantasia:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="txtNomeFantasia" placeholder="Digite o nome Fantásia " class="form-control" style="width: 630px; float: left; position: absolute; left: -48px;" />
                                    <input type="hidden" runat="server" id="hftxtNomeFantasia" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-2">
                                    Telefone:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="txtTelefone" placeholder="Digite o Telefone" class="form-control" style="width: 165px; float: left; text-transform: uppercase" onkeypress="$(this).mask('(00)0000-0000');" />
                                    <input type="hidden" runat="server" id="hftxtTelefone" />
                                </div>

                                <label class="col-sm-2">
                                    Celular:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="txtCelular" placeholder="Digite o Celular " class="form-control" style="width: 165px; float: left; position: absolute; left: 79px; text-transform: uppercase" onkeypress="$(this).mask('(00)00000-0000');" />
                                    <input type="hidden" runat="server" id="hftxtCelular" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    E-mail:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="txtEmail" placeholder="Digite o E-mail " class="form-control" style="width: 634px; float: left; position: absolute; left: -49px;" />
                                    <input type="hidden" runat="server" id="hftxtEmail" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-2">
                                    CEP:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="txtCEP" placeholder="Digite o CEP " class="form-control" style="width: 165px; float: left; text-transform: uppercase" onkeypress="$(this).mask('00000-000');" onblur="jsCarregarDadosCEP(this)" />
                                    <input type="hidden" runat="server" id="hftxtCEP" />
                                </div>

                                <label class="col-sm-2 control-label">ESTADO: </label>
                                <div class="col-sm-3">
                                    <select runat="server" id="ddlEstado" class="form-control" style="width: 248px; height: 32px; float: left; position: absolute; left: 79px; text-transform: uppercase">
                                        <option selected="selected" value="0">SELECIONE O ESTADO </option>
                                        <option value="AC">Acre</option>
                                        <option value="AL">Alagoas</option>
                                        <option value="AP">Amapá</option>
                                        <option value="AM">Amazonas</option>
                                        <option value="BA">Bahia</option>
                                        <option value="CE">Ceára</option>
                                        <option value="DF">Distrito Federal</option>
                                        <option value="ES">Espirito Santo</option>
                                        <option value="GP">Goiás</option>
                                        <option value="MA">Maranhão</option>
                                        <option value="MT">Mato Grosso</option>
                                        <option value="MS">Mato Grosso do Sul</option>
                                        <option value="MG">Minas Gerais</option>
                                        <option value="PA">Pará</option>
                                        <option value="PB">Paraíba</option>
                                        <option value="PR">Paraná</option>
                                        <option value="PE">Pernambuco</option>
                                        <option value="PI">Piauí</option>
                                        <option value="RJ">Rio de Janeiro</option>
                                        <option value="RN">Rio Grande do Norte</option>
                                        <option value="RS">Rio Grande do Sul</option>
                                        <option value="RO">Rondonia</option>
                                        <option value="RR">Roraima</option>
                                        <option value="SC">Santa Catarina</option>
                                        <option value="SP">São Paulo</option>
                                        <option value="SE">Sergipe</option>
                                        <option value="TO">Tocantins</option>
                                    </select>
                                </div>

                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-2">
                                    Cidade:
                                </label>
                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="txtCidade" placeholder="Digite a Cidade " class="form-control" style="width: 265px; float: left; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hftxtCidade" />
                                </div>
                                <label class="col-sm-2" id="lbBairro" style="width: 30px; float: left; position: absolute; left: 437px;">
                                    Bairro:
                                </label>
                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="txtBairro" placeholder="Digite o Bairro " class="form-control" style="width: 250px; float: left; position: absolute; left: 206px; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hftxtBairro" />
                                </div>

                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-2">
                                    Endereço:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="txtEndereco" placeholder="Digite o Endereço " class="form-control" />
                                    <input type="hidden" runat="server" id="hftxtEndereco" />
                                </div>

                                <label class="col-sm-2" style="float: left; position: absolute; left: 700px;">
                                    N°:
                                </label>
                                <div class="col-sm-2">
                                    <input runat="server" type="text" id="txtNumero" class="form-control" style="width: 55px; float: left; position: absolute; left: 720px; top: -35px;" onkeypress="return SomenteNumero(event);" />
                                    <input type="hidden" runat="server" id="hftxtNumero" />
                                </div>

                            </div>

                            <br />
                            <div class="form-group">
                                <label class="col-sm-3" id="lbComplemento">
                                    Complemento:
                                </label>


                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="txtComplemento" placeholder="Digite o complemento " class="form-control" style="width: 635px; float: left; position: absolute; left: -50px;" />
                                    <input type="hidden" runat="server" id="hftxtComplemento" />
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

                                <div class="col-sm-1">
                                    <div class="form-check">
                                        <input class="form-check-input" onchange="tipo_pessoa_fisica();" type="radio" name="exampleRadios" id="AltidFisica" value="option1">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <label class="form-check-label" for="AltidFisica">
                                        Física
                                    </label>
                                </div>

                                <div class="col-sm-1">
                                    <div class="form-check">
                                        <input class="form-check-input" onchange="tipo_pessoa_juridica();" type="radio" name="exampleRadios" id="AltidJuridica" value="option2">
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <label class="form-check-label" for="AltidJuridica">
                                        Júridica
                                    </label>
                                </div>
                            </div>

                            <br />

                            <div class="form-group">

                                <label class="col-sm-3" id="AltlbNome">
                                    Nome:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="AlttxtNome" placeholder="Digite o nome da Pessoa " class="form-control" style="width: 634px; float: left; position: absolute; left: -49px;" />
                                    <input type="hidden" runat="server" id="hfAlttxtNome" />
                                </div>
                            </div>

                            <br />
                            <div class="form-group">
                                <label class="col-sm-2" id="AltlbCPF">
                                    CPF:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="AlttxtCPF" placeholder="Digite o CPF " class="form-control" style="width: 165px; float: left; text-transform: uppercase" onkeypress="mascara_cpf_cnpj(this);" />
                                    <input type="hidden" runat="server" id="hfAlttxtCPF" />
                                </div>

                                <label class="col-sm-3" id="AltlbDtNasc">
                                    Data de Nascimento:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="date" id="AlttxtDataNasc" placeholder="Digite a Data de Nascimento" class="form-control" style="width: 248px; float: left;" />
                                    <input type="hidden" runat="server" id="hfAlttxtDataNasc" />
                                </div>
                            </div>
                            <br id="AltlinhabrancaNomeFantasia" />
                            <div class="form-group" id="AltGroupNomeFantasia">
                                <label class="col-sm-3">
                                    Nome Fantasia:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="AlttxtNomeFantasia" placeholder="Digite o nome Fantásia " class="form-control" style="width: 630px; float: left; position: absolute; left: -48px;" />
                                    <input type="hidden" runat="server" id="hfAlttxtNomeFantasia" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-2">
                                    Telefone:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="AlttxtTelefone" placeholder="Digite o Telefone" class="form-control" style="width: 165px; float: left; text-transform: uppercase" onkeypress="$(this).mask('(00)0000-0000');" />
                                    <input type="hidden" runat="server" id="hfAlttxtTelefone" />
                                </div>

                                <label class="col-sm-2">
                                    Celular:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="AlttxtCelular" placeholder="Digite o Celular " class="form-control" style="width: 165px; float: left; position: absolute; left: 79px; text-transform: uppercase" onkeypress="$(this).mask('(00)00000-0000');" />
                                    <input type="hidden" runat="server" id="hfAlttxtCelular" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">

                                <label class="col-sm-3">
                                    E-mail:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="AlttxtEmail" placeholder="Digite o E-mail " class="form-control" style="width: 634px; float: left; position: absolute; left: -49px;" />
                                    <input type="hidden" runat="server" id="hfAlttxtEmail" />
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-2">
                                    CEP:
                                </label>

                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="AlttxtCEP" placeholder="Digite o CEP " class="form-control" style="width: 165px; float: left; text-transform: uppercase" onkeypress="$(this).mask('00000-000');" onblur="jsCarregarDadosCEP(this)" />
                                    <input type="hidden" runat="server" id="hfAlttxtCEP" />
                                </div>

                                <label class="col-sm-2 control-label">ESTADO: </label>
                                <div class="col-sm-3">
                                    <select runat="server" id="AltddlEstado" class="form-control" style="width: 248px; height: 32px; float: left; position: absolute; left: 79px; text-transform: uppercase">
                                        <option selected="selected" value="0">SELECIONE O ESTADO </option>
                                        <option value="AC">Acre</option>
                                        <option value="AL">Alagoas</option>
                                        <option value="AP">Amapá</option>
                                        <option value="AM">Amazonas</option>
                                        <option value="BA">Bahia</option>
                                        <option value="CE">Ceára</option>
                                        <option value="DF">Distrito Federal</option>
                                        <option value="ES">Espirito Santo</option>
                                        <option value="GP">Goiás</option>
                                        <option value="MA">Maranhão</option>
                                        <option value="MT">Mato Grosso</option>
                                        <option value="MS">Mato Grosso do Sul</option>
                                        <option value="MG">Minas Gerais</option>
                                        <option value="PA">Pará</option>
                                        <option value="PB">Paraíba</option>
                                        <option value="PR">Paraná</option>
                                        <option value="PE">Pernambuco</option>
                                        <option value="PI">Piauí</option>
                                        <option value="RJ">Rio de Janeiro</option>
                                        <option value="RN">Rio Grande do Norte</option>
                                        <option value="RS">Rio Grande do Sul</option>
                                        <option value="RO">Rondonia</option>
                                        <option value="RR">Roraima</option>
                                        <option value="SC">Santa Catarina</option>
                                        <option value="SP">São Paulo</option>
                                        <option value="SE">Sergipe</option>
                                        <option value="TO">Tocantins</option>
                                    </select>
                                </div>

                            </div>
                            <br />
                            <div class="form-group">
                                <label class="col-sm-2">
                                    Cidade:
                                </label>
                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="AlttxtCidade" placeholder="Digite a Cidade " class="form-control" style="width: 265px; float: left; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hfAlttxtCidade" />
                                </div>
                                <label class="col-sm-2" id="AltlbBairro" style="width: 30px; float: left; position: absolute; left: 437px;">
                                    Bairro:
                                </label>
                                <div class="col-sm-3">
                                    <input runat="server" type="text" id="AlttxtBairro" placeholder="Digite o Bairro " class="form-control" style="width: 250px; float: left; position: absolute; left: 206px; text-transform: uppercase" />
                                    <input type="hidden" runat="server" id="hfAlttxtBairro" />
                                </div>

                            </div>

                            <br />
                            <div class="form-group">
                                <label class="col-sm-2">
                                    Endereço:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="AlttxtEndereco" placeholder="Digite o Endereço " class="form-control" />
                                    <input type="hidden" runat="server" id="hfAlttxtEndereco" />
                                </div>

                                <label class="col-sm-2" style="float: left; position: absolute; left: 700px;">
                                    N°:
                                </label>
                                <div class="col-sm-2">
                                    <input runat="server" type="text" id="AlttxtNumero" class="form-control" style="width: 55px; float: left; position: absolute; left: 720px; top: -35px;" onkeypress="return SomenteNumero(event);" />
                                    <input type="hidden" runat="server" id="hfAlttxtNumero" />
                                </div>

                            </div>

                            <br />
                            <div class="form-group">
                                <label class="col-sm-3" id="AltlbComplemento">
                                    Complemento:
                                </label>


                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="AlttxtComplemento" placeholder="Digite o complemento " class="form-control" style="width: 635px; float: left; position: absolute; left: -50px;" />
                                    <input type="hidden" runat="server" id="hfAlttxtComplemento" />
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
