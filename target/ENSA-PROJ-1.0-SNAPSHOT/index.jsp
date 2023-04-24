
<head>
        <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet">

</head>
<%@include file="Components/Header.jspf" %>
<%@include file="Components/Navigation-Bar.jspf" %>

<body class="p-6">
<div class="p-40 pt-0 m-10 mt-0" style=" display: flex; justify-content: center">
<div id="bodyContainer">
        <div id="cards">
                <div id="filiereCard" class="card">
                        <div id="filiereLogo">
                                <img src="${pageContext.request.contextPath}/certificate.png" style ="width:150px; margin-top: 40px;" alt="">
                        </div>
                        <div class="links">
                                <ul>
                                        <li><a href="${pageContext.request.contextPath}/Filiere/AjouterFiliere.jsp"><h2 style="margin-bottom: 60px;">Ajouter un filiere</h2></a></li>
                                        <li><a href="${pageContext.request.contextPath}/FiliereServlet" ><h2>Afficher les filieres</h2></a></li>
                                </ul>
                        </div>

                </div>
                <div id="etudiantCard" class="card">
                        <div id="etudiantLogo">
                                <img src="${pageContext.request.contextPath}/graduation.png" style ="height:150px; margin-top: 40px;" alt="">
                        </div>
                        <div class="links">
                                <ul>
                                        <li><a href="${pageContext.request.contextPath}/Etudiant/AjouterEtudiant.jsp"><h2 style="margin-bottom: 60px;">Ajouter un etudiant</h2></a></li>
                                        <li><a href="${pageContext.request.contextPath}/EtudiantServlet"><h2>Afficher les etudiants</h2></a></li>
                                </ul>
                        </div>

                </div>
        </div>
        <img src="${pageContext.request.contextPath}/ENSAT.png" alt="" id="bgEnsat">
</div>

        <%@include file="Components/Footer.jspf" %>
    </div>
</div>
</body>
