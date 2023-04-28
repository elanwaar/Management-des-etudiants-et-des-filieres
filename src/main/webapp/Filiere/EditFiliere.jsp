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

<body class="p-6">

<div class="p-40 pt-0 m-10 " style="display: flex; align-items: center; flex-direction: column">

    <!-- le message d'error si le champ nom ou prénom est vide -->
    <div id="liveAlertPlaceholder" style="width: 60%;"></div>

<div class="card card p-10 " style="width: 60%;">

<form id="formId" class="mt-10" method="post" action="${pageContext.request.contextPath}/FiliereServlet?action=edit&id=<%=request.getAttribute("id")%>">
    <%
        FiliereService filiereService = new FiliereService();
        Filiere filiere = filiereService.FindById(Integer.parseInt(request.getAttribute("id").toString()));
    %>
    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-3">ID de Filiere:</label>
        <div class="col-sm-4">
            <input class="form-control" type="text" name="idFil" value="<%=filiere.getIdFil()%>" disabled/>
        </div>
    </div>

    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-3">Nom de Filiere:</label>
        <div class="col-sm-4">
            <input class="form-control" id="nom" type="text" name="nom" value="<%=filiere.getNomFil()%>"/>
        </div>
    </div>
    <button class="btn btn-primary" type="submit" value="">Submit</button>

</form>
</div>
</div>
</body>

<script>

    const nom = document.getElementById("nom");
    const form = document.getElementById("formId");

    const alertPlaceholder = document.getElementById('liveAlertPlaceholder')
    async function appendAlert (event) {
        if(alertPlaceholder.innerHTML!=""){
            alertPlaceholder.innerHTML = "";
        }
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
