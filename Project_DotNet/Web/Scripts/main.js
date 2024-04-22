function mtel(v) {
    v = v.replace(/\D/g, "");             //Remove tudo o que não é dígito
    v = v.replace(/^(\d{2})(\d)/g, "($1) $2"); //Coloca parênteses em volta dos dois primeiros dígitos
    v = v.replace(/(\d)(\d{4})$/, "$1-$2");    //Coloca hífen entre o quarto e o quinto dígitos
    return v;
}

function initializeJS() {

    //Chosen in selects
    var listSelect = $(document).find("select");

    for (var x = 0; x < listSelect.length; x++) {
        if (listSelect[x].id != null) {
            if (listSelect[x].getAttribute('class') != null) {
                if (listSelect[x].getAttribute('class').indexOf('form-control') >= 0) {
                    $(listSelect[x]).chosen();
                }
            }
        }
    }

    //tool tips
    jQuery('.tooltips').tooltip();

    //popovers
    jQuery('.popovers').popover();

    //add switch
    $(".iphone-toggle").each(function () {
        $(this).bootstrapSwitch();
    });

    //add mask datepicker
    $(".datepicker").each(function () {
        $(this).mask("99/99/9999");
        $(this).datepicker();
    });

    //add mask datepicker max day: today
    $(".datepickerToday").each(function () {
        $(this).mask("99/99/9999");
        $(this).datepicker({
            maxDate: new Date()
        });
    });

    //add mask datepicker min day: today
    $(".datepickerFuture").each(function () {
        $(this).mask("99/99/9999");
        $(this).datepicker({
            minDate: new Date()
        });
    });

    //add phoneNumber
    $(".phoneNumber").each(function () {
        $(this).mask("(99) 99999-9999");
    });

    //add maskCPF
    $(".maskCPF").each(function () {
        $(this).mask("999.999.999-99");
        $(this).on('blur', function () {
            if (jsValidaCPF($(this).val()) == false) {
                OpenAlert('Erro!', 'CPF invalido', 'danger');
                $(this).val('');
            }
        });
    });

    //add maskCNPJ
    $(".maskCNPJ").each(function () {
        $(this).mask("99.999.999/9999-99");
        $(this).on('blur', function () {
            if (jsValidaCNPJ($(this).val()) == false) {
                OpenAlert('Erro!', 'CNPJ invalido', 'danger');
                $(this).val('');
            }
        });
    });

    //add maskCEP
    $(".maskCEP").each(function () {
        $(this).mask("99999-999");
    });

    //Mascara com ER para telefones com 8 e 9 digitos
    $(".maskFixoCel").keyup(function () {
        var input = $(this).val();
        
        input = input.replace(/\D/g, "");             //Remove tudo o que não é dígito
        input = input.replace(/^(\d{2})(\d)/g, "($1)$2"); //Coloca parênteses em volta dos dois primeiros dígitos
        input = input.replace(/(\d)(\d{4})$/, "$1-$2");    //Coloca hífen entre o quarto e o quinto dígitos
        
        $(this).val(input);
    });

    //add maskTel
    $(".maskTel").each(function () {
        $(this).mask("(99)99999-9999");
    });

    //add maskTelFixo
    $(".maskTelFixo").each(function () {
        $(this).mask("(99)9999-9999");
    });

    //add maskTime
    $(".maskTime").each(function () {
        $(this).mask("99:99");
    });

    //add maskTime
    $(".maskPhone8").each(function () {
        $(this).mask("(99) 9999-9999");
    });

    //add maskTime
    $(".maskPhone").each(function () {
        $(this).mask("(99) 99999-9999");
    });

    //add maskPlaca
    $(".maskPlaca").each(function () {
        $(this).mask("aaa-9999");
    });

    //add dataTable
    $(".dataTable").each(function () {
        $(this).dataTable();
    });

    //add maskMoney
    $(".maskMoney").each(function () {
        $(this).maskMoney({ decimal: ",", thousands: "." });
    });

    //add toUpper
    $("input[type=text]").blur(function (e) {

        this.value = this.value.toUpperCase();

    });

    //custom scrollbar
        //for html
    jQuery("html").niceScroll({styler:"fb",cursorcolor:"#007AFF", cursorwidth: '10', cursorborderradius: '10px', background: '#F7F7F7', cursorborder: '', zindex: '1000'});
        //for sidebar
    jQuery("#sidebar").niceScroll({styler:"fb",cursorcolor:"#007AFF", cursorwidth: '3', cursorborderradius: '10px', background: '#F7F7F7', cursorborder: ''});
        // for scroll panel
    jQuery(".scroll-panel").niceScroll({styler:"fb",cursorcolor:"#007AFF", cursorwidth: '3', cursorborderradius: '10px', background: '#F7F7F7', cursorborder: ''});
    
    //sidebar dropdown menu
    jQuery('#sidebar .sub-menu > a').click(function () {
        var last = jQuery('.sub-menu.open', jQuery('#sidebar'));        
        jQuery('.menu-arrow').removeClass('arrow_carrot-right');
        jQuery('.sub', last).slideUp(200);
        var sub = jQuery(this).next();
        if (sub.is(":visible")) {
            jQuery('.menu-arrow').addClass('arrow_carrot-right');            
            sub.slideUp(200);
        } else {
            jQuery('.menu-arrow').addClass('arrow_carrot-down');            
            sub.slideDown(200);
        }
        var o = (jQuery(this).offset());
        diff = 200 - o.top;
        if(diff>0)
            jQuery("#sidebar").scrollTo("-="+Math.abs(diff),500);
        else
            jQuery("#sidebar").scrollTo("+="+Math.abs(diff),500);
    });

    // sidebar menu toggle
    jQuery(function () {
        function responsiveView() {
            var wSize = jQuery(window).width();
            if (wSize <= 768) {
                jQuery('#container').addClass('sidebar-close');
                jQuery('#sidebar > ul').hide();
            }

            if (wSize > 768) {
                jQuery('#container').removeClass('sidebar-close');
                jQuery('#sidebar > ul').show();
            }
        }
        //jQuery(window).on('load', responsiveView);
        jQuery(window).on('resize', responsiveView);
    });

    jQuery('.toggle-nav').click(function () {
        if (jQuery('#sidebar > ul').is(":visible") === true) {
            jQuery('#main-content').css({
                'margin-left': '0px'
            });
            jQuery('#sidebar').css({
                'margin-left': '-400px'
            });
            jQuery('#sidebar > ul').hide();
            jQuery("#container").addClass("sidebar-closed");
        } else {
            jQuery('#main-content').css({
                'margin-left': '400px'
            });
            jQuery('#sidebar > ul').show();
            jQuery('#sidebar').css({
                'margin-left': '0'
            });
            jQuery("#container").removeClass("sidebar-closed");
        }
    });

    //bar chart
    if (jQuery(".custom-custom-bar-chart")) {
        jQuery(".bar").each(function () {
            var i = jQuery(this).find(".value").html();
            jQuery(this).find(".value").html("");
            jQuery(this).find(".value").animate({
                height: i
            }, 2000)
        })
    }

}

jQuery(document).ready(function(){
    initializeJS();
});
