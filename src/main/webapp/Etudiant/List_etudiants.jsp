<%@ page import="ensat.dca.Model.Etudiant" %>
<%@ page import="ensat.dca.Model.Filiere" %>
<%@ page import="java.util.List" %>
<%@ page import="ensat.dca.Services.FiliereService" %><%--
  Created by IntelliJ IDEA.
  User: anwar
  Date: 4/9/2023
  Time: 3:04 PM
  To change this template use File | Settings | File Templates.
--%>

<%@include file="../Components/Header.jspf" %>
<%@include file="../Components/Navigation-Bar.jspf" %>

<%List<Etudiant> list_etudiant= (List<Etudiant>) request.getAttribute("list_Etudiants");%>
<body class="p-6">
<div class="p-40 pt-0 m-10 mt-0" style=" display: flex; justify-content: center">
<div class="card card p-10 mt-10">
<table class="table table-bordered mt-10">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Prenom</th>
        <th>Sexe</th>
        <th>Filiere</th>
        <th>Actions</th>


    </tr>
    <%for (Etudiant etd: list_etudiant) {%>
    <tr>
        <td><%=etd.getIdE()%></td>
        <td><%=etd.getNom()%></td>
        <td><%=etd.getPrenom()%></td>
        <td><%=etd.getSexe()%></td>
        <td><%
            FiliereService filiereService = new FiliereService();
            Filiere filiere = filiereService.FindById(etd.getIdF());
        %>
        <%=filiere.getNomFil()%></td>
        <td class="d-flex flex-row mb-2 justify-content-center">
            <a href="${pageContext.request.contextPath}/EtudiantServlet?action=edit&id=<%=etd.getIdE()%>" class="btn btn-success mr-2">Edit</a>
            <form method="post" action="${pageContext.request.contextPath}/EtudiantServlet?action=delete&id=<%=etd.getIdE()%>">
                <button class="btn btn-danger" type="submit">
                    Delete
                </button>
            </form>
        </td>
    </tr>
    <%}%>

</table>
</div>
</div>
</body>
<%@include file="../Components/Footer.jspf" %>

