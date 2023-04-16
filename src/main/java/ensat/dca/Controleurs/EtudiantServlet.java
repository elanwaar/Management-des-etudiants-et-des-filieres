package ensat.dca.Controleurs;
import ensat.dca.Model.Etudiant;
import ensat.dca.Model.Filiere;
import ensat.dca.Services.EtudiantService;
import ensat.dca.dao.DAO;
import ensat.dca.dao.IDAO;
import lombok.SneakyThrows;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;



@WebServlet(name = "EtudiantServlet", value = "/EtudiantServlet")
public class EtudiantServlet extends HttpServlet {

    //Connection connexion = DAO.getConnection();
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
            else if(req.getParameter("action").equals("ajouter")){

            }

        }

        else if(req.getParameter("action")==null){

            List<Etudiant> List_Etudiants = etudiantService.FindAll(1, 2);
            req.setAttribute("list_Etudiants", List_Etudiants);
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

        else if(req.getParameter("action").equals("Lister")){

        }
    }

}
