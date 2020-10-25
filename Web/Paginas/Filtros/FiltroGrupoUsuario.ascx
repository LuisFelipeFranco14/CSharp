<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FiltroGrupoUsuario.ascx.cs" Inherits="Web.Paginas.Filtros.FiltroGrupoUsuario" %>
<div id="divFiltroGrupoUsuario" style="display: none;">
    <div id="divContentFinder" runat="server" class="panel panel-default motivo" style="top: 5%; left: 16%; position: fixed; border: 1px solid #000; border-radius: 5px; padding: 5px; background: white; z-index: 999999; width: 70%;">
        <header class="panel-heading">
            <div style="text-align: right;">
                <label style="float: left; position: absolute; left: 10px;" >Grupo de Usuário</label>       
            <img runat="server" src="~/Imagens/excluir.png" onclick="jsCloseFiltroGrupoUsuarios(this)"
                style="width: 16px; height: 16px; cursor: pointer;" alt="Fechar" title="Fechar" />
            </div>
        </header>
        <section class="panel" style="padding: 10px">
            teste
        </section>
    </div>
    <input type="hidden" id="hfIdLabelFiltroGrupoUsuarios" />
    <input type="hidden" id="hfIdHiddenFiltroGrupoUsuarios" />
</div>

