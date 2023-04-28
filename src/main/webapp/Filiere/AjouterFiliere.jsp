<%@include file="../Components/Header.jspf" %>
<%@include file="../Components/Navigation-Bar.jspf" %>

<body class="p-6">

<div class="p-40 pt-0 m-10" style=" display: flex; align-items: center; flex-direction: column">

    <!-- le message d'error si le champ nom ou prénom est vide -->
    <div id="liveAlertPlaceholder" style="width: 60%;"></div>

<div class="card card p-10" style="width: 60%;">

<form id="formId" class="mt-10 p-10" style="display: flex; flex-direction: column;" method="post" action="${pageContext.request.contextPath}/FiliereServlet?action=ajouter">

    <div class="row-mb-3" style="display: flex; justify-content: center;">
        <label class="col-form-label col-sm-3">Nom de Filiere:</label>
        <div class="col-sm-10">
            <input id="nom" class="form-control" type="text" name="nom" placeholder="Nom" />
        </div>
    </div>

    <button type="submit" value="" class="btn btn-primary col-sm-4 mt-10" style="align-self: center">Submit</button>


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
