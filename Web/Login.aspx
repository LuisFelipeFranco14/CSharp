<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Web.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <meta charset="utf-8" />
    <script type="text/javascript">
        var validarLogin = false;
        $(document).ready(function () {



        });

        function jsAbrirModalEsqueceSenha() {
            $('#EsqueceSenhaModal').modal('show');
        }

        function jsValidarEsqueceuSenha() {

            if ($('#txtLogin').val().trim() == "") {
                alert("Por favor informe o Login.");
                $('#txtLogin').focus();
                return false;
            }


            if ($('#txtEmail').val().trim() == "") {
                alert("Por favor informe o Email.");
                $('#txtEmail').focus();
                return false;
            }

            return true;
        }

        function jsValidaLogin() {

            if ($('#<%=txtUsuario.ClientID %>').val().trim() == '') {
                alert("O campo Usuário deve ser preenchido.");
                $('#<%=txtUsuario.ClientID %>').focus();
                //OpenAlert('Atenção!', 'O campo Usuário deve ser preenchido.', 'danger');
                return false;
            }
            else if ($('#<%=txtSenha.ClientID %>').val().trim() == '') {
                alert("O campo Senha deve ser preenchido.");
                $('#<%=txtSenha.ClientID %>').focus();
                //OpenAlert('Atenção!', 'O campo Senha deve ser preenchido.', 'danger');
                return false;
            } else {

                $.ajax({
                    type: "POST",
                    url: "Login.aspx/BuscarUsuario",
                    data: JSON.stringify({ login: $('#<%=txtUsuario.ClientID %>').val(), senha: $('#<%=txtSenha.ClientID %>').val() }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: "json",
                    traditional: true,
                    async: false,
                    success: function (result) {
                        console.log(result.d);
                        validarLogin = result.d;


                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }

            if (!validarLogin) {
                alert("Usuário ou Senha inválido");
            }

            return validarLogin;

        }



    </script>
    <style>
        html {
            background-color: #56baed;
        }

        body {
            font-family: "Poppins", sans-serif;
            height: 100vh;
        }

        a {
            color: #92badd;
            display: inline-block;
            text-decoration: none;
            font-weight: 400;
        }

        h2 {
            text-align: center;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            display: inline-block;
            margin: 40px 8px 10px 8px;
            color: #cccccc;
        }



        /* STRUCTURE */

        .wrapper {
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: center;
            width: 100%;
            min-height: 100%;
            padding: 20px;
        }

        #formContent {
            -webkit-border-radius: 10px 10px 10px 10px;
            border-radius: 10px 10px 10px 10px;
            background: #fff;
            padding: 30px;
            width: 90%;
            max-width: 450px;
            position: relative;
            padding: 0px;
            -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
            box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
            text-align: center;
        }

        #formFooter {
            background-color: #f6f6f6;
            border-top: 1px solid #dce8f1;
            padding: 25px;
            text-align: center;
            -webkit-border-radius: 0 0 10px 10px;
            border-radius: 0 0 10px 10px;
        }



        /* TABS */

        h2.inactive {
            color: #cccccc;
        }

        h2.active {
            color: #0d0d0d;
            border-bottom: 2px solid #5fbae9;
        }



        /* FORM TYPOGRAPHY*/

        input[type=button], input[type=submit], input[type=reset] {
            background-color: #56baed;
            border: none;
            color: white;
            padding: 15px 80px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            text-transform: uppercase;
            font-size: 13px;
            -webkit-box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
            box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
            -webkit-border-radius: 5px 5px 5px 5px;
            border-radius: 5px 5px 5px 5px;
            margin: 5px 20px 40px 20px;
            -webkit-transition: all 0.3s ease-in-out;
            -moz-transition: all 0.3s ease-in-out;
            -ms-transition: all 0.3s ease-in-out;
            -o-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
        }

            input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover {
                background-color: #39ace7;
            }

            input[type=button]:active, input[type=submit]:active, input[type=reset]:active {
                -moz-transform: scale(0.95);
                -webkit-transform: scale(0.95);
                -o-transform: scale(0.95);
                -ms-transform: scale(0.95);
                transform: scale(0.95);
            }

        input[type=text] {
            background-color: #f6f6f6;
            border: none;
            color: #0d0d0d;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 5px;
            width: 85%;
            border: 2px solid #f6f6f6;
            -webkit-transition: all 0.5s ease-in-out;
            -moz-transition: all 0.5s ease-in-out;
            -ms-transition: all 0.5s ease-in-out;
            -o-transition: all 0.5s ease-in-out;
            transition: all 0.5s ease-in-out;
            -webkit-border-radius: 5px 5px 5px 5px;
            border-radius: 5px 5px 5px 5px;
        }

            input[type=text]:focus {
                background-color: #fff;
                border-bottom: 2px solid #5fbae9;
            }

            input[type=text]:placeholder {
                color: #cccccc;
            }


        input[type=password] {
            background-color: #f6f6f6;
            border: none;
            color: #0d0d0d;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 5px;
            width: 85%;
            border: 2px solid #f6f6f6;
            -webkit-transition: all 0.5s ease-in-out;
            -moz-transition: all 0.5s ease-in-out;
            -ms-transition: all 0.5s ease-in-out;
            -o-transition: all 0.5s ease-in-out;
            transition: all 0.5s ease-in-out;
            -webkit-border-radius: 5px 5px 5px 5px;
            border-radius: 5px 5px 5px 5px;
        }

            input[type=password]:focus {
                background-color: #fff;
                border-bottom: 2px solid #5fbae9;
            }

            input[type=password]:placeholder {
                color: #cccccc;
            }



        /* ANIMATIONS */

        /* Simple CSS3 Fade-in-down Animation */
        .fadeInDown {
            -webkit-animation-name: fadeInDown;
            animation-name: fadeInDown;
            -webkit-animation-duration: 1s;
            animation-duration: 1s;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
        }

        @-webkit-keyframes fadeInDown {
            0% {
                opacity: 0;
                -webkit-transform: translate3d(0, -100%, 0);
                transform: translate3d(0, -100%, 0);
            }

            100% {
                opacity: 1;
                -webkit-transform: none;
                transform: none;
            }
        }

        @keyframes fadeInDown {
            0% {
                opacity: 0;
                -webkit-transform: translate3d(0, -100%, 0);
                transform: translate3d(0, -100%, 0);
            }

            100% {
                opacity: 1;
                -webkit-transform: none;
                transform: none;
            }
        }

        /* Simple CSS3 Fade-in Animation */
        @-webkit-keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @-moz-keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        .fadeIn {
            opacity: 0;
            -webkit-animation: fadeIn ease-in 1;
            -moz-animation: fadeIn ease-in 1;
            animation: fadeIn ease-in 1;
            -webkit-animation-fill-mode: forwards;
            -moz-animation-fill-mode: forwards;
            animation-fill-mode: forwards;
            -webkit-animation-duration: 1s;
            -moz-animation-duration: 1s;
            animation-duration: 1s;
        }

            .fadeIn.first {
                -webkit-animation-delay: 0.4s;
                -moz-animation-delay: 0.4s;
                animation-delay: 0.4s;
            }

            .fadeIn.second {
                -webkit-animation-delay: 0.6s;
                -moz-animation-delay: 0.6s;
                animation-delay: 0.6s;
            }

            .fadeIn.third {
                -webkit-animation-delay: 0.8s;
                -moz-animation-delay: 0.8s;
                animation-delay: 0.8s;
            }

            .fadeIn.fourth {
                -webkit-animation-delay: 1s;
                -moz-animation-delay: 1s;
                animation-delay: 1s;
            }

        /* Simple CSS3 Fade-in Animation */
        .underlineHover:after {
            display: block;
            left: 0;
            bottom: -10px;
            width: 0;
            height: 2px;
            background-color: #56baed;
            content: "";
            transition: width 0.2s;
        }

        .underlineHover:hover {
            color: #0d0d0d;
        }

            .underlineHover:hover:after {
                width: 100%;
            }



        /* OTHERS */

        *:focus {
            outline: none;
        }

        .btn-primary {
            position: absolute;
            top: 188px;
            left: 155px;
            height: 40px;
            
        }

        .modal-content {
            height: 250px;
        }
    </style>
    <title>Login

    </title>
</head>
<body>
    <form id="Idlogin" runat="server">
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div class="wrapper fadeInDown">
            <div id="formContent">
                <!-- Tabs Titles -->

                <!-- Icon -->
                <div class="fadeIn first">
                    <h1>Adaptus</h1>
                </div>


                <input runat="server" type="text" id="txtUsuario" class="fadeIn second" name="login" placeholder="login">
                <input runat="server" type="password" id="txtSenha" class="fadeIn third" name="login" placeholder="senha">
                <asp:Button runat="server" class="fadeIn fourth" ID="btnLogin" Text="LOGIN" OnClientClick="return jsValidaLogin();" OnClick="btnLogin_Click" />

                <!-- Remind Passowrd -->
                <div id="formFooter">
                    <a class="underlineHover" href="javascript:;" onclick="jsAbrirModalEsqueceSenha();">Esqueceu Senha?</a>
                </div>

            </div>
        </div>

        <div class="modal" tabindex="-1" role="dialog" id="EsqueceSenhaModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Esqueceu Senha?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="form-group">
                            <label class="col-sm-3" style="float: left; position: absolute; left: 1px; top: 20px">
                                    Login:
                            </label>

                            <div class="col-sm-9">
                                    <input runat="server" type="text" id="txtLogin" placeholder="Digite o Login " class="form-control" style="width: 410px; height: 40px; float: left; position: absolute; left: 55px; top: -5px" />
                                    <input type="hidden" runat="server" id="hftxtLogin" />
                                </div>

                        </div>

                        <div class="form-group">

                                <label class="col-sm-3" style="float: left; position: absolute; left: 1px; top: 70px">
                                    E-mail:
                                </label>

                                <div class="col-sm-9">
                                    <input runat="server" type="text" id="txtEmail" placeholder="Digite o E-mail " class="form-control" style="width: 410px; height: 40px; float: left; position: absolute; left: 55px; top: 25px" />
                                    <input type="hidden" runat="server" id="hftxtEmail" />
                                </div>
                            </div>


                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" ID="btnEnviar" CssClass="btn btn-primary" Text="Enviar" OnClick="btnEnviar_Click" OnClientClick="return jsValidarEsqueceuSenha();" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                    </div>
                </div>
            </div>
        </div>


    </form>
</body>
</html>
