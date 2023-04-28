package ensat.dca.Controleurs;

import ensat.dca.Model.Etudiant;
import ensat.dca.Model.Filiere;
import ensat.dca.Services.EtudiantService;
import ensat.dca.Services.FiliereService;
import lombok.SneakyThrows;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;



@WebServlet(name = "EtudiantServlet", value = "/EtudiantServlet")
public class EtudiantServlet extends HttpServlet {

    EtudiantService etudiantService = new EtudiantService();

    @SneakyThrows
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if(req.getParameter("action") != null)
        {
            if(req.getParameter("action").equals("edit")){

                RequestDispatcher dispatcher = req.getRequestDispatcher("/Etudiant/EditEtudiant.jsp");
                req.setAttribute("id", req.getParameter("id"));
                dispatcher.forward(req, resp);
            }
        }

        else if(req.getParameter("action")==null){

            int page = 1;
            int recordsPerPage = 5;

            if (req.getParameter("page") != null)
                page = Integer.parseInt(req.getParameter("page"));

            EtudiantService etudiantService = new EtudiantService();
            List<Etudiant> list = etudiantService.FindAll(
                    (page - 1) * recordsPerPage, recordsPerPage);

            int noOfRecords = etudiantService.getNoOfRecords();
            int noOfPages = (int)Math.ceil(noOfRecords * 1.0 / recordsPerPage);

            req.setAttribute("list_Etudiants", list);
            req.setAttribute("noOfPages", noOfPages);
            req.setAttribute("currentPage", page);

            RequestDispatcher dispatcher = req.getRequestDispatcher("/Etudiant/List_etudiants.jsp");
            dispatcher.forward(req, resp);
        }
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if(req.getParameter("action").equals("edit")){

            int idEtu = Integer.parseInt(req.getParameter("id"));
            Etudiant etudiant = etudiantService.FindById(idEtu);


                etudiant.setNom(req.getParameter("nom"));
                etudiant.setPrenom(req.getParameter("prenom"));
                etudiant.setSexe(req.getParameter("sexe"));
                etudiant.setIdF(Integer.parseInt(req.getParameter("idFil")));


            etudiantService.Update(etudiant);
            resp.sendRedirect("EtudiantServlet");
        }

        else if(req.getParameter("action").equals("ajouter")){

            Etudiant Etudiant = new Etudiant();

            if(req.getParameter("idFil")!=""){
                Etudiant.setIdF(Integer.parseInt(req.getParameter("idFil")));
            }
            else{
                Etudiant.setIdF(20);
            }

            Etudiant.setNom(req.getParameter("nom"));
            Etudiant.setPrenom(req.getParameter("prenom"));
            Etudiant.setSexe(req.getParameter("sexe"));
            etudiantService.Create(Etudiant);
            resp.sendRedirect("EtudiantServlet");
        }

        else if(req.getParameter("action").equals("delete")){

            Etudiant Etudiant = etudiantService.FindById(Integer.parseInt(req.getParameter("id")));
            etudiantService.Delete(Etudiant);
            resp.sendRedirect("EtudiantServlet");
        }
    }

}
