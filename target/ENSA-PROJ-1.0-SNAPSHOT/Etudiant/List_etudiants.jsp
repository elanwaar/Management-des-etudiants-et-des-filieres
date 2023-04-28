<%@ page import="ensat.dca.Model.Etudiant" %>
<%@ page import="ensat.dca.Model.Filiere" %>
<%@ page import="java.util.List" %>
<%@ page import="ensat.dca.Services.FiliereService" %>

<%@include file="../Components/Header.jspf" %>
<%@include file="../Components/Navigation-Bar.jspf" %>

<%List<Etudiant> list_etudiant= (List<Etudiant>) request.getAttribute("list_Etudiants");%>
<%int noOfPages = Integer.parseInt(request.getAttribute("noOfPages").toString());%>
<%int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());%>

<body class="p-6">

<div class="p-40 pt-0 m-10 mt-0" >
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


    <nav aria-label="Page navigation example" class="mt-10">
        <ul class="pagination justify-content-center">
            <%
                //For displaying Previous link except for the 1st page
            if (currentPage > 1){ %>
            <li class="page-item enabled">
                <a class="page-link" href="/EtudiantServlet?page=<%=currentPage-1%>">Previous</a>
            </li>
            <%}else{%>
            <li class="page-item disabled">
                <a class="page-link" href="/EtudiantServlet?page=<%=currentPage-1%>">Previous</a>
            </li>
            <%}
                for(int i=1;i<=noOfPages;i++){
                    if(currentPage == i){%>
            <li class="page-link page-item active"><%=i%></li>

            <%} else{%><li class="page-item"><a class="page-link" href="/EtudiantServlet?page=<%=i%>"><%=i%></a></li><%}}%>

            <%if(currentPage != noOfPages){%>
            <li class="page-item">
                <a class="page-link" href="/EtudiantServlet?page=<%=currentPage+1%>">Next</a>
            </li>
            <%}
            else{%>
            <li class="page-item disabled">
                <a class="page-link" href="/EtudiantServlet?page=<%=currentPage+1%>">Next</a>
            </li>
            <%}%>
        </ul>
    </nav>
</div>

<%@include file="../Components/Footer.jspf" %>

