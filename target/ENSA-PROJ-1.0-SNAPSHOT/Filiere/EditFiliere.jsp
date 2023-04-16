<%@ page import="ensat.dca.Services.FiliereService" %>
<%@ page import="ensat.dca.Model.Filiere" %><%--
  Created by IntelliJ IDEA.
  User: anwar
  Date: 4/9/2023
  Time: 10:21 AM
  To change this template use File | Settings | File Templates.
--%>

<%@include file="../Components/Header.jspf" %>
<%@include file="../Components/Navigation-Bar.jspf" %>
<%@include file="../Components/body.jspf" %>

<div id="liveAlertPlaceholder"></div>

<form id="formId" method="post" action="${pageContext.request.contextPath}/FiliereServlet?action=edit&id=<%=request.getAttribute("id")%>">
    <%
        FiliereService filiereService = new FiliereService();
        Filiere filiere = filiereService.FindById(Integer.parseInt(request.getAttribute("id").toString()));
    %>
    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-2">ID de Filiere:</label>
        <div class="col-sm-4">
            <input class="form-control" type="text" name="idFil" value="<%=filiere.getIdFil()%>" disabled/>
        </div>
    </div>

    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-2">Nom de Filiere:</label>
        <div class="col-sm-4">
            <input class="form-control" id="nom" type="text" name="nom" value="<%=filiere.getNomFil()%>"/>
        </div>
    </div>
    <button class="btn btn-primary" type="submit" value="">Submit</button>

</form>



<script>

    const nom = document.getElementById("nom");
    const form = document.getElementById("formId");

    const alertPlaceholder = document.getElementById('liveAlertPlaceholder')
    async function appendAlert (event) {
        if(nom.value === ""){
            event.preventDefault()
            const wrapper = document.createElement('div')
            wrapper.innerHTML = [
                `<div class="alert alert-danger alert-dismissible" role="alert">`,
                `   <div>Veuillez entrer le nom du filiere</div>`,
                '   <button id="closeBtn" type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
                '</div>'
            ].join('')

            alertPlaceholder.append(wrapper)
        }

    }
    form.addEventListener('submit', appendAlert);

</script>

<%@include file="../Components/Footer.jspf" %>
