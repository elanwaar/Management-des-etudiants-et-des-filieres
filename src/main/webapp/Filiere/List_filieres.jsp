<%@ page import="ensat.dca.Model.Filiere" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: anwar
  Date: 4/9/2023
  Time: 11:14 AM
  To change this template use File | Settings | File Templates.
--%>

<%@include file="../Components/Header.jspf" %>
<%@include file="../Components/Navigation-Bar.jspf" %>

<%List<Filiere> list_filiere= (List<Filiere>) request.getAttribute("list_filiere");%>
<%int noOfPages = Integer.parseInt(request.getAttribute("noOfPages").toString());%>
<%int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());%>

<body class="p-6">
<div class="p-40 pt-0 m-10 mt-0">
<div id="content" class="mt-10 card card p-10">
    <table class="table table-bordered">
        <tr>
            <th>ID</th>
            <th>Nom du filiere</th>
            <th>Actions</th>
        </tr>
        <%for(Filiere fil: list_filiere){%>
                <tr>
                <td><%=fil.getIdFil()%></td>
                <td><%=fil.getNomFil()%></td>
                <td>
                    <div class="flex justify-content-center">
                    <a href="${pageContext.request.contextPath}/FiliereServlet?action=edit&id=<%=fil.getIdFil()%>" class="btn btn-success mr-2">Edit</a>
                    <form method="post" action="${pageContext.request.contextPath}/FiliereServlet?action=delete&id=<%=fil.getIdFil()%>">
                        <button type="submit" class="btn btn-danger">
                        Delete
                        </button>
                    </form>
                    </div>
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
                        <a class="page-link" href="/FiliereServlet?page=<%=currentPage-1%>" onclick="loadDoc()">Previous</a>
                    </li>
            <%}else{%>
                <li class="page-item disabled">
                    <a class="page-link" href="/FiliereServlet?page=<%=currentPage-1%>">Previous</a>
                </li>
            <%}
                for(int i=1;i<=noOfPages;i++){
                    if(currentPage == i){%>
                        <li class="page-link page-item active"><%=i%></li>

            <%} else{%><li class="page-item"><a class="page-link" href="/FiliereServlet?page=<%=i%>"><%=i%></a></li><%}}%>

            <%if(currentPage != noOfPages){%>
                <li class="page-item">
                    <a class="page-link" href="/FiliereServlet?page=<%=currentPage+1%>">Next</a>
                </li>
            <%}
            else{%>
                <li class="page-item disabled">
                    <a class="page-link" href="/FiliereServlet?page=<%=currentPage+1%>">Next</a>
                </li>
            <%}%>


        </ul>
    </nav>
</body>
<script>

    function loadDoc() {
        const xhttp = new XMLHttpRequest();
        xhttp.onload = function() {
            document.getElementById("content").innerHTML = this.responseText;
        }
        xhttp.open("GET", "/Services/FiliereService", true);
        xhttp.send();
    }

</script>








<%@include file="../Components/Footer.jspf" %>
