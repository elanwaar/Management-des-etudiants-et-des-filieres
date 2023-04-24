<%@ page import="ensat.dca.Model.Etudiant" %>
<%@ page import="ensat.dca.Services.EtudiantService" %>
<%@ page import="ensat.dca.Services.FiliereService" %>
<%@ page import="ensat.dca.Model.Filiere" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="ensat.dca.Controleurs.FiliereServlet" %>
<%--
  Created by IntelliJ IDEA.
  User: anwar
  Date: 4/9/2023
  Time: 3:03 PM
  To change this template use File | Settings | File Templates.
--%>

<%@include file="../Components/Header.jspf" %>
<%@include file="../Components/Navigation-Bar.jspf" %>

<body class="p-6">
<div class="p-40 pt-0 m-10" style="display: flex; align-items: center; flex-direction: column">
    <div id="liveAlertPlaceholder" style="width: 60%;"></div>
    <div class="card p-10" style="width: 60%;">
<form id="formId" class="mt-10" method="post" action="${pageContext.request.contextPath}/EtudiantServlet?action=edit&id=<%=request.getAttribute("id")%>">
    <%
        EtudiantService etudiantService = new EtudiantService();
        Etudiant etudiant = etudiantService.FindById(Integer.parseInt(request.getAttribute("id").toString()));

    %>
    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-2">ID de l'etudiant:</label>
        <div class="col-sm-4">
            <input class="form-control" type="text" name="idEtu" value="<%=etudiant.getIdE()%>" disabled>
        </div>

    </div>

    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-2">Nom:</label>
        <div class="col-sm-4">
            <input id="nom" class="form-control" type="text" name="nom" value="<%=etudiant.getNom()%>">
        </div>

    </div>

    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-2">Prenom:</label>
        <div class="col-sm-4">
            <input id="prenom" class="form-control" type="text" name="prenom" value="<%=etudiant.getPrenom()%>"/>
        </div>


    </div>
    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-2">Sexe:</label>
        <div class="col-sm-4">
            <% String sexe =etudiant.getSexe();
            %>
            <input type="radio" name="sexe" class="form-check-input" value="male" id="male">
            <label class="form-check-label">Male</label>
            <input type="radio" name="sexe" class="form-check-input" value="female" id="female">
            <label class="form-check-label">Female</label>
        </div>


    </div>
    <div class="row-mb-3 flex mb-4">
        <label class="col-form-label col-sm-2">Filiere:</label>
        <div class="col-sm-4">
            <select name="idFil" class="form-select">
                <%
                    FiliereService filiereService = new FiliereService();
                    int noOfRecords = filiereService.getNoOfRecords();
                    List<Filiere> list = filiereService.FindAll(0, noOfRecords);
                    try{
                        Collections.swap(list, 0, list.indexOf(filiereService.FindById(etudiant.getIdF())));
                    }catch(Exception ex){
                        System.out.println(filiereService.getNoOfRecords());
                    }

                    for(Filiere filiere : list){
                %>
                <option value="<%=filiere.getIdFil()%>"><%=filiere.getNomFil()%></option>
                <%
                    }
                %>
            </select>
        </div>

    </div>

    <button class="btn btn-primary" type="submit" value="">Submit</button>


</form>
</div>
</div>
</body>
<script>

    const prenom = document.getElementById("prenom");
    const nom = document.getElementById("nom");
    const form = document.getElementById("formId");
    const male = document.getElementById("male")
    const female = document.getElementById("female")


    window.onload = ()=>{
        const sexe = '<%=sexe%>'
        if(sexe === "male")
        {
            male.checked = true
        }
        else if(sexe === "female"){
            female.checked = true;
        }


    }

    const alertPlaceholder = document.getElementById('liveAlertPlaceholder')
    async function appendAlert (event) {

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

