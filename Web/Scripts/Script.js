document.onkeydown = function (e) {
    if (e == null) {
        keycode = event.keyCode;
    }
    else {
        keycode = e.which;
    }

    if (keycode == 27) {

        CloseAlert();

    }

}

function jsCloseMenu() {

    $('#DivUlOpen').fadeOut('fast');

    $('#DivMenuLateral').animate({

        width: "30px"

    });

    $('#DivMenuLateral').parent().animate({

        width: "100px"

    });

    $('#DivUlClose').fadeIn('fast');

}

function jsOpenMenu() {

    $('#DivUlClose').fadeOut('fast');

    $('#DivMenuLateral').animate({

        width: "180px"

    });

    $('#DivMenuLateral').parent().animate({

        width: "220px"

    });

    $('#DivUlOpen').fadeIn('fast');

}

var focusedBeforeAlert;

//Type - danger, info, warning, success
function OpenAlert(title, content, type) {

    focusedBeforeAlert = document.activeElement;

    if (navigator.appName == 'Microsoft Internet Explorer') {

        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);

        if (rv == '10') {
            alert(content);
        } else {
            $('#spanModalTitle').html(title);
            $('#spanModalContent').html(content);
            $('#divModalGeral').attr('class', '');
            $('#divModalGeral').addClass('alert alert-' + type + ' alert-dismissable');
            $('#divModalGeral').modal('show');
            $('#btnModalCancel').css('display', 'none');
        }

    } else {
        $('#spanModalTitle').html(title);
        $('#spanModalContent').html(content);
        $('#divModalGeral').attr('class', '');
        $('#divModalGeral').addClass('alert alert-' + type + ' alert-dismissable');
        $('#divModalGeral').modal('show');
        $('#btnModalCancel').css('display', 'none');
    }

}

function CloseAlert() {

    if (focusedBeforeAlert)
        focusedBeforeAlert.focus();

    $('#divModalGeral').modal('hide');
}

function OpenConfirmAlert(title, content) {

    if (navigator.appName == 'Microsoft Internet Explorer') {

        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);

        if (rv == '10') {
            if (confirm(content)) {
                return true

            } else {
                return false;
            }
        } else {
            $('#modalValidateTitle').html(title);
            $('#modalValidateText').html(content);
            $('#myModalValidate').modal('show');
            $('#btnModalCancel').css('display', '');

            $('#btnModalCancel').click(function () {
                return false;
            });

            $('#btnModalValidate').click(function () {
                return true;
            });
        }

    } else {
        $('#modalValidateTitle').html(title);
        $('#modalValidateText').html(content);
        $('#myModalValidate').modal('show');
        $('#btnModalCancel').css('display', '');

        $('#btnModalCancel').click(function () {
            return false;
        });

        $('#btnModalValidate').click(function () {
            return true;
        });
    }
}

function jsValidaEmail() {

    if ($('#txtEmailEsqueciSenha').val() == '') {

        OpenAlert("Atenção", "O campo Email deve ser preenchido.");
        return false;

    } else {

        var params = {
            email: $('#txtEmailEsqueciSenha').val()
        };

        jsPageMethods('Login.aspx/EnviarEmail', params, function (data) {

            if (data == '') {

                OpenAlert("Atenção", "Sua nova senha foi enviada para o email cadastrado.");

            } else {

                OpenAlert("Atenção", data);
                $('#txtEmailEsqueciSenha').focus();

            }

            jsLoading(false);

        });

    }

    return true;
}

function ValidaData(data) {
    if (data.length == 10) {
        er = /(0[0-9]|[12][0-9]|3[01])[-\.\/](0[0-9]|1[012])[-\.\/][0-9]{4}/;
        if (er.exec(data)) {
            return true;
        } else {
            return false;
        }

    } else {
        return false;
    }
}

function jsLogin() {

    if ($('#txtUser').val() == '') {

        OpenAlert("Atenção", "O campo Usuário deve ser preenchido.");
        $('#txtUser').focus();

    } else if ($('#txtPassword').val() == '') {

        OpenAlert("Atenção", "O campo Senha deve ser preenchido.");
        $('#txtPassword').focus();

    } else {
        var params = {
            usuario: $('#txtUser').val(),
            senha: $('#txtPassword').val()
        };

        OpenAlert("Atenção", "Usuário e/ou senha inválido.");
        //        jsPageMethods('Login.aspx/GetLogin', params, function (data) {

        //            var inf = data.split('§');

        //            if (inf[0] == 'true') {

        //                if (inf[1] == 'ok') {
        //                    location.href = "Default.aspx";
        //                } else {
        //                    location.href = "Geral/AlterarSenha.aspx";
        //                }

        //            } else {

        //                OpenAlert("Atenção", "Usuário e/ou senha inválido.");

        //            }

        jsLoading(false);

        //        });
    }
}

function OpenEsqueciSenha() {

    if ($('#DivEsqueciSenha').css('display') == 'block') {

        $('#DivEsqueciSenha').modal('hide');

    } else {

        $('#DivEsqueciSenha').modal('show');

    }

    setTimeout(function () {

        document.getElementById('chkEsqueciSenha').checked = false;
        document.getElementById('chkEsqueciSenha').parentNode.setAttribute('class', '');

    }, 500);
}

function jsCloseAddAgendamento() {

    $('#ContentPlaceHolder1_ctrlAgendamento_hiddenFlag').val('');

    $('#ContentPlaceHolder1_ctrlAgendamento_divAddEvent').css('display', 'none');

}

function jsCloseAddAgendamentoTimer() {

    setTimeout(function () {
        jsCloseAddAgendamento();
    }, 100);

}

function jsLimparEvent() {

    $('#ContentPlaceHolder1_ctrlAddEvent_ddlEmpresa').val('0');
    $('#ContentPlaceHolder1_ctrlAddEvent_ddlEmpresa').chosen().change();
    $('#ContentPlaceHolder1_ctrlAddEvent_ddlEmpresa').trigger('liszt:updated');

    $('#ContentPlaceHolder1_ctrlAddEvent_ddlProjeto').val('0');
    $('#ContentPlaceHolder1_ctrlAddEvent_ddlProjeto').chosen().change();
    $('#ContentPlaceHolder1_ctrlAddEvent_ddlProjeto').trigger('liszt:updated');

    $('#ContentPlaceHolder1_ctrlAddEvent_ddlTipoEvento').val('0');
    $('#ContentPlaceHolder1_ctrlAddEvent_ddlTipoEvento').chosen().change();
    $('#ContentPlaceHolder1_ctrlAddEvent_ddlTipoEvento').trigger('liszt:updated');

    $('#ContentPlaceHolder1_ctrlAddEvent_txtDataInicio').val('');
    $('#ContentPlaceHolder1_ctrlAddEvent_txtDataTermino').val('');
    $('#ContentPlaceHolder1_ctrlAddEvent_txtNota').val('');

    $('#ContentPlaceHolder1_ctrlAddEvent_hiddenFlag').val('');
}

function jsGetColor(status) {

    var color;

    if (status == "PC") {
        color = "#ff9933";
    } else if (status == "PI") {
        color = "#006699";
    } else if (status == "AP") {
        color = "#006600";
    } else if (status == "RE") {
        color = "#FF5353";
    }

    return color;
}

function jsAddRemoveNumber(id, type) {

    var value = $('#' + id).val();

    if (value == '') {
        value = 0;
    }

    if (type == 'mais') {

        value = parseInt(value) + 1;

    } else {
        value = parseInt(value) - 1;
    }

    if (value < 0) {
        value = 0;
    }
    $('#' + id).val(value);
}

function jsConfirmaAlert(mensagem) {
    if (confirm(mensagem)) {
        return true;
    }
    return false;
}

function jsValidaCPF(cpf) {
    cpf = cpf.replace(/[^\d]+/g, '');
    if (cpf == '') return false;
    // Elimina CPFs invalidos conhecidos    
    if (cpf.length != 11 ||
        cpf == "00000000000" ||
        cpf == "11111111111" ||
        cpf == "22222222222" ||
        cpf == "33333333333" ||
        cpf == "44444444444" ||
        cpf == "55555555555" ||
        cpf == "66666666666" ||
        cpf == "77777777777" ||
        cpf == "88888888888" ||
        cpf == "99999999999")
        return false;
    // Valida 1o digito 
    add = 0;
    for (i = 0; i < 9; i++)
        add += parseInt(cpf.charAt(i)) * (10 - i);
    rev = 11 - (add % 11);
    if (rev == 10 || rev == 11)
        rev = 0;
    if (rev != parseInt(cpf.charAt(9)))
        return false;
    // Valida 2o digito 
    add = 0;
    for (i = 0; i < 10; i++)
        add += parseInt(cpf.charAt(i)) * (11 - i);
    rev = 11 - (add % 11);
    if (rev == 10 || rev == 11)
        rev = 0;
    if (rev != parseInt(cpf.charAt(10)))
        return false;
    return true;
}

function jsValidaCNPJ(cnpj) {

    cnpj = cnpj.replace(/[^\d]+/g, '');

    if (cnpj == '') return false;

    if (cnpj.length != 14)
        return false;

    // Elimina CNPJs invalidos conhecidos
    if (cnpj == "00000000000000" ||
        cnpj == "11111111111111" ||
        cnpj == "22222222222222" ||
        cnpj == "33333333333333" ||
        cnpj == "44444444444444" ||
        cnpj == "55555555555555" ||
        cnpj == "66666666666666" ||
        cnpj == "77777777777777" ||
        cnpj == "88888888888888" ||
        cnpj == "99999999999999")
        return false;

    // Valida DVs
    tamanho = cnpj.length - 2
    numeros = cnpj.substring(0, tamanho);
    digitos = cnpj.substring(tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (i = tamanho; i >= 1; i--) {
        soma += numeros.charAt(tamanho - i) * pos--;
        if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(0))
        return false;

    tamanho = tamanho + 1;
    numeros = cnpj.substring(0, tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (i = tamanho; i >= 1; i--) {
        soma += numeros.charAt(tamanho - i) * pos--;
        if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(1))
        return false;

    return true;

}

function jsAbrirEditarAfixo() {

    $('#divEditarAfixo').css('display', 'block');

}

function jsFecharEditarAfixo() {

    $('#hfCodigoAfixo').val('');
    $('#divEditarAfixo').css('display', 'none');

}

function jsAbrirEditarEmbriao() {

    $('#divEditarEmbriao').css('display', 'block');

}

function jsFecharEditarEmbriao() {

    $('#hfCodigoEmbriao').val('');
    $('#divEditarEmbriao').css('display', 'none');

}

function jsAbrirRecebimentoFatura() {

    $('#divFaturaRecebidos').css('display', 'block');
    $('#divResultado').css('display', 'none');

}

function jsFecharRecebimentoFatura() {

    $('#hfCodigoFatura').val('');
    $('#divFaturaRecebidos').css('display', 'none');
    $('#divResultado').css('display', 'block');

}

function jsAbrirReprovacaoSuperIntendencia() {

    $('#divReprovacaoSup').css('display', 'block');

}

function jsFecharReprovacaoSuperIntendencia() {

    $('#hfCodigoReprovacao').val('');
    $('#divReprovacaoSup').css('display', 'none');

}

function jsAbrirGeraBoletoFatura() {

    $('#divGeraBoletoFatura').css('display', 'block');
    $('#divResultado').css('display', 'none');

}

function jsFecharGeraBoletoFatura() {

    $('#hfCodigoFatura').val('');
    $('#divGeraBoletoFatura').css('display', 'none');
    $('#divResultado').css('display', 'block');
}

function jsAbrirEditarCorrecao() {

    $('#divEditarCorrecao').css('display', 'block');

}

function jsFecharEditarCorrecao() {

    $('hfCodigoSolicitacao').val('');
    $('#divEditarCorrecao').css('display', 'none');

}

function jsAbrirEmbriao() {

    $('#divEmbriao').css('display', 'block');

}

function jsFecharEmbriao() {

    $('#hfCodigoEmbriao').val('');
    $('#divEmbriao').css('display', 'none');

}

function jsFecharCadastroDNA() {

    $('#hfCodigoDNA').val('');
    $('#divCadastroDNA').css('display', 'none');

}

function jsAbrirEdicaoAnimal() {

    $('#divEditarAnimal').css('display', 'block');

}

function jsAbrirCadastroDNA() {

    $('#divCadastroDNA').css('display', 'block');

}

function jsAbrirComunicarFIV() {

    $('#divComunicarFIV').css('display', 'block');

}

//function jsFecharComunicarFIV() {

//    $('#hfCodigoComunicadoFIV').val('');
//    $('#divComunicarFIV').css('display', 'none');
//    $('#divComunicarCob').css('display', 'block');
//    $('#tbResultado').css('display', 'block');

//}

function jsFecharAtualizaDiagFIV() {

    $('#hfCodigoInfoFIV').val('');
    $('#divAtualizaDiagFiv').css('display', 'none');

}

function jsAbrirComunicarTE() {

    $('#divComunicarTE').css('display', 'block');

}

function jsAbrirEdicaoServico() {

    $('#divEditarServico').css('display', 'block');

}

function jsFecharEdicaoServico() {

    $('#divEditarServico').css('display', 'none');

}

function jsFecharComunicarTE() {

    $('#hfCodigoComunicadoTE').val('');
    $('#divComunicarTE').css('display', 'none');

}

function jsFecharEdicaoAnimal() {

    $('#hfCodigosAnimais').val('');
    $('#divEditarAnimal').css('display', 'none');

}

function jsAbrirComunicarNascimento() {

    $('#divComunicarNascimento').css('display', 'block');
    $('#divRptEmbrioesFiv').css('display', 'none');
}

function jsFecharComunicarNascimento() {
    $('#hfCodigo').val('');
    $('#divComunicarNascimento').css('display', 'none');
    $('#divRptEmbrioesFiv').css('display', 'block');

}

function jsAbrirEnviarDocumentos() {
    $('#modalEnviarDocumentos').show();
}

function jsFecharEnviarDocumentos() {
    $('#hfCodigoComunicadoNascimentoEnviarDocumentos').val('');
    $('#modalEnviarDocumentos').hide();
}

function jsSomenteNumero(e) {
    var tecla = (window.event) ? event.keyCode : e.which;
    if ((tecla > 47 && tecla < 58)) return true;
    else {
        if (tecla == 8 || tecla == 0) return true;
        else return false;
    }
}

function jsSomenteNumeroVirgula(e) {
    var tecla = (window.event) ? event.keyCode : e.which;
    if ((tecla > 47 && tecla < 58)) return true;
    else {
        if (tecla == 8 || tecla == 0 || tecla == 44) return true;
        else return false;
    }
}

function jsSomenteDecimal(e) {
    var tecla = (window.event) ? event.keyCode : e.which;
    if ((tecla > 47 && tecla < 58)) return true;
    else {
        if (tecla == 8 || tecla == 0 || tecla == 46 || tecla == 44) return true;
        else return false;
    }
}

// dataStr => String
// dataLimiteStr => String
//
// dataStr = dataLimiteStr : retorna "igual"
// dataStr > dataLimiteStr : retorna "maior"
// dataStr < dataLimiteStr : retorna "menor"
function jsComparaDatas(dataStr, dataLimiteStr) {

    var data = dataStr.split('/');
    var d = parseInt(data[0], 10);
    var m = parseInt(data[1], 10);
    var y = parseInt(data[2], 10);
    var date = new Date(y, m - 1, d, 6, 0, 0);

    var dataLimite = dataLimiteStr.split('/');
    var dL = parseInt(dataLimite[0], 10);
    var mL = parseInt(dataLimite[1], 10);
    var yL = parseInt(dataLimite[2], 10);
    var dateLimit = new Date(yL, mL - 1, dL, 6, 0, 0);

    if (date.getDate() == dateLimit.getDate() &&
        date.getMonth() == dateLimit.getMonth() &&
        date.getFullYear() == dateLimit.getFullYear()) {

        return "igual";

    } else if (date > dateLimit) {
        return "maior";

    } else if (date < dateLimit) {
        return "menor";
    }

    return "erro";
}

// Retorna Data de Hoje como String
function jsDataHojeStr() {

    // Data temporária
    var dataTemp = new Date();
    var ddTemp = dataTemp.getDate();
    var mmTemp = dataTemp.getMonth();
    var yyyyTemp = dataTemp.getFullYear();

    var today = new Date(yyyyTemp, mmTemp, ddTemp, 6, 0, 0, 0); // Evita problema do Horário de Verão

    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }

    return dd + '/' + mm + '/' + yyyy;
}

// Parametro => data (string)
function jsDataValida(data) {
    var comp = data.split('/');
    var m = parseInt(comp[1], 10);
    var d = parseInt(comp[0], 10);
    var y = parseInt(comp[2], 10);
    var date = new Date(y, m - 1, d, 6, 0, 0);

    if (data.value != '') {
        if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
            return true;
        } else {
            return false;
        }
    }
}

// Parametro => data (string)
//              dias: quantidade de dias para somar na data
// Retorno => data (string)
function jsSomaDiasNaData(data, dias) {

    var dataArray = data.split('/');
    var d = parseInt(dataArray[0], 10);
    var m = parseInt(dataArray[1], 10);
    var y = parseInt(dataArray[2], 10);
    var date = new Date(y, m - 1, d, 6, 0, 0);

    date.setTime(date.getTime() + dias * 86400000);

    var dd = date.getDate();
    var mm = date.getMonth() + 1; //January is 0!
    var yyyy = date.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }

    return dd + '/' + mm + '/' + yyyy;
}

function jsCheckAll(nameTable, obj, nameClass) {

    var rows = $("#" + nameTable).dataTable().fnGetNodes();

    for (var i = 0; i < rows.length; i++) {

        var checkBox = $(rows[i]).find('.' + nameClass);

        if ($(checkBox).attr('id') != $(obj).attr("id")) {

            if ($(checkBox).attr('disabled') != 'disabled' && $(obj).prop('checked') == true) {
                $(checkBox).prop('checked', true);
            } else {
                $(checkBox).prop('checked', false);
            }

        }

    }

}

function jsOpenFinderAnimais(idLabel, idHidden) {
    $('#hfIdLabelFinderAnimais').val(idLabel);
    $('#hfIdHiddenFinderAnimais').val(idHidden);
    $('#divFinderAnimais').fadeIn();
}

function jsOpenFinderAnimais2(idLabel, idHidden) {
	$('#hfIdLabelFinderAnimais2').val(idLabel);
	$('#hfIdHiddenFinderAnimais2').val(idHidden);
	$('#divFinderAnimais2').fadeIn();
}

function jsCloseFinderAnimais(obj) {
    $(obj).parent().parent().parent().fadeOut();
}

function jsOpenFinderCidades(idLabel, idHidden) {
    $('#hfIdLabelFinderCidades').val(idLabel);
    $('#hfIdHiddenFinderCidades').val(idHidden);
    $('#divFinderCidades').fadeIn();
}

function jsCloseFinderCidades(obj) {
    $(obj).parent().parent().parent().fadeOut();
}

//ADICIONA CABEÇALHO EM UMA TABELA DINÂMICA
function jsAdicionarCabecalhoTabela(tabelaInserida, listaColunas, styleAtt) {

    removeAllChilds(tabelaInserida);

    var thead = document.createElement('thead');

    if (styleAtt != undefined) {
        thead.setAttribute("style", styleAtt);
    }

    tabelaInserida.appendChild(thead);

    var cabecalho = tabelaInserida.tHead;

    var trCabecalho = document.createElement('tr');

    for (var i = 0; i < listaColunas.length; i++) {
        var th = document.createElement('th');
        th.innerHTML = listaColunas[i];
        trCabecalho.appendChild(th);
    }

    cabecalho.appendChild(trCabecalho);

}

//ADICIONA COLUNAS NA LINHA DA TABELA DINÂMICA
function jsAdicionarLinhaTabela(listaColunas, linha, idObjeto, dsIdentificador) {

    var linhaCorrente = document.getElementById(idObjeto + dsIdentificador);

    if (linhaCorrente != null) {

        OpenAlert('Atenção', 'Não é possível inserir este registro, pois já está adicionado.');
        return false;

    } else {

        for (var i = 0; i < listaColunas.length; i++) {
            linha.appendChild(listaColunas[i]);
        }
    }
}

//ADICIONA CORPO NA TABELA
function jsAdicionarCorpoTabela(tabelaInserida) {

    var tbody = tabelaInserida.tBodies;

    if (tbody[0] == null) {
        tbody = document.createElement('tbody');

        tabelaInserida.appendChild(tbody);
    } else {
        tbody = tbody[0];
    }

    return tbody;

}

function jsCountChar(str, c) {

    var count = 0;
    for (var i = 0; i < str.length; i++) {
        if (str[i] == c) {
            count++;
        }
    }

    return count;
}

function jsArrayContainsValue(array, value) {

    if (!array) return false;

    var count = array.length;

    for (var i = 0; i < count; i += 1) {
        var v = array[i];
        if (v == value) {
            return true;
        }
    }

    return false;
}

Number.prototype.formatMoney = function (c, d, t) {
    var n = this,
        c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "," : d,
        t = t == undefined ? "." : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};

//poe ele aqui
function jsCarrega() {
    $('#ModalLoad').modal('show');
}

function jsCloseLoading() {
    $('#ModalLoad').modal('hide');
}