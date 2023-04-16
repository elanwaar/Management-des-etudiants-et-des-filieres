<%--
  Created by IntelliJ IDEA.
  User: anwar
  Date: 4/9/2023
  Time: 6:12 AM
  To change this template use File | Settings | File Templates.
--%>




<%@include file="../Components/Header.jspf" %>
<%@include file="../Components/Navigation-Bar.jspf" %>
<%@include file="../Components/body.jspf" %>

<div id="liveAlertPlaceholder"></div>

<form id="formId" method="post" action="${pageContext.request.contextPath}/FiliereServlet?action=ajouter">

    <div class="row-mb-3">
        <label class="col-form-label col-sm-2">Nom de Filiere:</label>
        <div class="col-sm-10">
            <input id="nom" class="form-control" type="text" name="nom" placeholder="Nom" />
        </div>
    </div>

    <button type="submit" value="" class="btn btn-primary">Submit</button>


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
