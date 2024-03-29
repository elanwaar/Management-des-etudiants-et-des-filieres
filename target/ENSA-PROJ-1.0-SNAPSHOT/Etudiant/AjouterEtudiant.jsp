<%@ page import="ensat.dca.Model.Filiere" %>
<%@ page import="ensat.dca.Services.FiliereService" %>
<%@ page import="java.util.List" %>

<head>
    <link href="${pageContext.request.contextPath}/ajouterEtudiant.css" rel="stylesheet">

</head>
<%@include file="../Components/Header.jspf" %>
<%@include file="../Components/Navigation-Bar.jspf" %>

<body class="p-6">

<div class="p-40 pt-0 m-10" style=" display: flex; align-items: center; flex-direction: column">

    <!-- le message d'error si le champ nom ou prénom est vide -->
    <div id="liveAlertPlaceholder" style="width: 60%;"></div>

<div class="card p-5" style="width: 60%;" id="bodyContainer">

<form id="formId" method="post" class="mt-10 p-10" style="display: flex; flex-direction: column" method="post" action="${pageContext.request.contextPath}/EtudiantServlet?action=ajouter">

    <div class="row mb-3" style="display: flex; justify-content: center;">
        <label class="col-sm-2 col-form-label" >Nom:</label>
        <div class="col-sm-10">
            <input id="nom" type="text" name="nom" placeholder="Nom" class="form-control"/>
        </div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Prenom:</label>
        <div class="col-sm-10">
            <input id="prenom" type="text" name="prenom" placeholder="Prenom" class="form-control"/>
        </div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label" >Sexe:</label>
        <div class="col-sm-10">
            <input type="radio" name="sexe" class="form-check-input" value="male" id="male" checked>
            <label class="form-check-label">Male</label>
            <input type="radio" name="sexe" class="form-check-input" value="female" id="female">
            <label class="form-check-label">Female</label></div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Filiere:</label>
        <div class="col-sm-10">
            <select name="idFil" class="form-select">
                <%
                    FiliereService filiereService = new FiliereService();
                    int noOfRecords = filiereService.getNoOfRecords();
                    List<Filiere> list = filiereService.FindAll(0, noOfRecords);
                    for(Filiere filiere : list){
                %>
                <option value="<%=filiere.getIdFil()%>"><%=filiere.getNomFil()%></option>
                <%
                    }
                %>
            </select>
        </div>
    </div>

    <button type="submit" class="btn btn-primary" >Submit</button>

</form>
</div>
</div>
</body>

<script>

    const prenom = document.getElementById("prenom");
    const nom = document.getElementById("nom");
    const male = document.getElementById("male");
    const female = document.getElementById("female");
    const form = document.getElementById("formId");

    const alertPlaceholder = document.getElementById('liveAlertPlaceholder')
    async function appendAlert (event) {
        if(alertPlaceholder.innerHTML!=""){
            alertPlaceholder.innerHTML = "";
        }
        if(prenom.value === "" || nom.value === ""){

            event.preventDefault()
            const wrapper = document.createElement('div')
            wrapper.innerHTML = [
                `<div class="alert alert-danger alert-dismissible" role="alert">`,
                `   <div>Veuillez entrer le nom et prenom!</div>`,
                '   <button id="closeBtn" type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
                '</div>'
            ].join('')

            alertPlaceholder.append(wrapper)
        }

    }
    form.addEventListener('submit', appendAlert);

</script>
<%@include file="../Components/Footer.jspf" %>
