var arr;

function jsPageMethods(wsName, params, callBackFunction) {

    if (params != null)
        strParams = JSON.stringify(params);
    else
        strParams = '';

    var obj;

    $.ajax({
        type: 'POST',
        url: wsName,
        data: strParams,
        contentType: 'application/json; charset=utf-8',
        beforeSend: function () {
            jsLoading(true);

        },
        success: function (data) {

            if (data != null) {

                if (jsValidaJSON(data.d)) {

                    obj = JSON.parse(data.d);

                } else {

                    obj = data.d;

                }
            }

        },
        complete: function () {

            if (callBackFunction) {

                callBackFunction(obj);

            } else {

                jsLoading(false);

            }
        }
    })
}

function jsAutoComplete(objId, wsName, params, column, callBackFunction, selectedFunction) {

    if (params != null)
        strParams = JSON.stringify(params);
    else
        strParams = '';

    $.ajax({
        type: 'POST',
        url: wsName,
        data: strParams,
        contentType: 'application/json; charset=utf-8',
        beforeSend: function () {
            jsLoading(true);
        },
        success: function (data) {

            if (data.d != null)
                obj = JSON.parse(data.d);
            else
                obj = data;

            if (column == null) {

                column = 'rotulo';

            }

            arr = new Array();

            for (i = 0; i < obj.length; i++) {
                arr[i] = eval('obj[i].' + column + '') + "";
            }

            jsBindAutoComplete(objId, arr);

            if (selectedFunction) {

                $('#' + objId).result(function (event, dados, formatted) {

                    selectedFunction(dados[0]);

                    return false;

                });

            }
        },
        complete: function () {
            if (callBackFunction)
                callBackFunction();
            else
                jsLoading(false);
        }
    })
}

function jsBindAutoComplete(objId, arrData) {

    $('#' + objId).autocomplete(arrData, {
        minChars: 3,
        max: 100
    });

}

function jsDropDown(objId, wsName, params, dataTextField, dataValueField, labelText, callBackFunction, separadorConcat, separadorSplit) {

    if (params != null)
        strParams = JSON.stringify(params);
    else
        strParams = '';

    $.ajax({
        type: 'POST',
        url: wsName,
        data: strParams,
        contentType: 'application/json; charset=utf-8',
        beforeSend: function () {
            jsLoading(true);
        },
        success: function (data) {
            
            if (data != null) {
                if (data.d != null) {
                    if (jsValidaJSON(data.d)) {

                        obj = JSON.parse(data.d);

                    } else {

                        obj = data.d;

                    }

                    document.getElementById(objId).length = 0;

                    if (labelText != null) {

                        jsAppendOption(objId, labelText, '0');

                    }
                    
                    for (i = 0; i < obj.length; i++) {

                        var dataValue = null;
                        var dataText = null;

                        if (separadorSplit != null) {

                            var elements = dataTextField.split(separadorSplit);

                            for (x = 0; x < elements.length; x++) {

                                if (dataText != null) {

                                    dataText = dataText + separadorConcat + eval('obj[i].' + elements[x] + '');

                                } else {

                                    dataText = eval('obj[i].' + elements[x] + '');
                                }

                            }

                            var elements = dataValueField.split(separadorSplit);

                            for (x = 0; x < elements.length; x++) {

                                if (dataValue != null) {

                                    dataValue = dataValue + separadorConcat + eval('obj[i].' + elements[x] + '');

                                } else {

                                    dataValue = eval('obj[i].' + elements[x] + '');
                                }

                            }

                        } else {

                            dataValue = eval('obj[i].' + dataValueField + '');
                            dataText = eval('obj[i].' + dataTextField + '')
                        }
                        
                        jsAppendOption(objId, dataText, dataValue);

                    }
                } else {
                    if (labelText != null) {

                        jsAppendOption(objId, labelText, '0');

                    }
                }
            } else {
                if (labelText != null) {

                    jsAppendOption(objId, labelText, '0');

                }
            }
        },
        complete: function () {
            if (callBackFunction)
                callBackFunction();
            else
                jsLoading(false);
        }
    })

}

function jsAppendOption(objIdSelect, strText, strValue) {

    elOptNew = document.createElement('option');
    elOptNew.text = strText;
    elOptNew.value = strValue;
    elSel = document.getElementById(objIdSelect);

    try {
        elSel.add(elOptNew, null); // standards compliant; doesn't work in IE
    }
    catch (ex) {
        elSel.add(elOptNew); // IE only
    }

}

function jsLoading(show) {

    var objDivLoad = document.getElementById('divLoad');
    var objDivLoad2 = document.getElementById('divLoad2');

    if (objDivLoad != null) {
        if (show) {
            objDivLoad.style.display = '';
            if (objDivLoad2) {
                objDivLoad2.style.display = '';
            }
        }
        else {
            objDivLoad.style.display = 'none';
            if (objDivLoad2) {
                objDivLoad2.style.display = 'none';
            }
        }
    }
}


function jsValidaJSON(data) {

    if (typeof (data) == 'object') {

        return false;

    } else if (typeof (data) == 'boolean') {

        return false;

    } else if (typeof (data) == 'number') {

        return false;

    } else {

        if (data.indexOf('[') >= 0) {

            return true;

        } else {

            return false;

        }
    }
}

function removeAllChilds(obj) {

    if (obj.hasChildNodes()) {
        while (obj.childNodes.length >= 1) {
            obj.removeChild(obj.firstChild);
        }
    }

}

function replaceAll(str, de, para) {

    var pos = str.toString().indexOf(de);
    while (pos > -1) {
        str = str.replace(de, para);
        pos = str.indexOf(de);
    }
    return (str);
}

function isCpf(cpf) {

    cpf = replaceAll(replaceAll(replaceAll(cpf, '.', ''), '-', ''), '/', '');

    var soma;
    var resto;
    var i;

    if ((cpf.length != 11) ||
        (cpf == "00000000000") || (cpf == "11111111111") ||
        (cpf == "22222222222") || (cpf == "33333333333") ||
        (cpf == "44444444444") || (cpf == "55555555555") ||
        (cpf == "66666666666") || (cpf == "77777777777") ||
        (cpf == "88888888888") || (cpf == "99999999999")) {
        return false;
    }

    soma = 0;

    for (i = 1; i <= 9; i++) {
        soma += Math.floor(cpf.charAt(i - 1)) * (11 - i);
    }

    resto = 11 - (soma - (Math.floor(soma / 11) * 11));

    if ((resto == 10) || (resto == 11)) {
        resto = 0;
    }

    if (resto != Math.floor(cpf.charAt(9))) {
        return false;
    }

    soma = 0;

    for (i = 1; i <= 10; i++) {
        soma += cpf.charAt(i - 1) * (12 - i);
    }

    resto = 11 - (soma - (Math.floor(soma / 11) * 11));

    if ((resto == 10) || (resto == 11)) {
        resto = 0;
    }

    if (resto != Math.floor(cpf.charAt(10))) {
        return false;
    }

    return true;
}

function isCnpj(s) {

    s = replaceAll(replaceAll(replaceAll(s, '.', ''), '-', ''), '/', '');

    var i;
    var c = s.substr(0, 12);
    var dv = s.substr(12, 2);
    var d1 = 0;

    for (i = 0; i < 12; i++) {
        d1 += c.charAt(11 - i) * (2 + (i % 8));
    }

    if (d1 == 0) return false;

    d1 = 11 - (d1 % 11);

    if (d1 > 9) d1 = 0;
    if (dv.charAt(0) != d1) {
        return false;
    }

    d1 *= 2;

    for (i = 0; i < 12; i++) {
        d1 += c.charAt(11 - i) * (2 + ((i + 1) % 8));
    }

    d1 = 11 - (d1 % 11);

    if (d1 > 9) d1 = 0;
    if (dv.charAt(1) != d1) {
        return false;
    }

    return true;
}

function jsConfirmAlert(msg) {

    if (confirm(msg)) {
        return true;
    } else {
        return false;
    }

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

function jsSomenteTelefone(e) {
    var tecla = (window.event) ? event.keyCode : e.which;
    if ((tecla > 47 && tecla < 58)) return true;
    else {
        if (tecla == 8 || tecla == 0 || tecla == 40 || tecla == 41 || tecla == 45 || tecla == 32 || tecla == 59) return true;
        else return false;
    }
}

function isEmail(email) {
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    if (!emailReg.test(email)) {
        return false;
    } else {
        return true;
    }
}

function jsSecondsToTime(secs) {
    if (secs > 0) {
        var t = new Date(1970, 0, 1);
        t.setSeconds(secs);
        var s = t.toTimeString().substr(0, 5);
        if (secs > 86399)
            s = Math.floor((t - Date.parse("1/1/70")) / 3600000) + s.substr(2);
        return s;
    } else {
        return null;
    }
}