package ensat.dca.Controleurs;
import ensat.dca.Model.Filiere;
import ensat.dca.Services.FiliereService;
import ensat.dca.dao.DAO;
import ensat.dca.dao.IDAO;
import lombok.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "FiliereServlet", value = "/FiliereServlet")
public class FiliereServlet extends HttpServlet {

    //Connection connexion = DAO.getConnection();
    FiliereService filiereService=new FiliereService();

    @SneakyThrows
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if(req.getParameter("action") != null)
        {

            if(req.getParameter("action").equals("edit")){
                RequestDispatcher dispatcher = req.getRequestDispatcher("/Filiere/EditFiliere.jsp");
                req.setAttribute("id", req.getParameter("id"));
                dispatcher.forward(req, resp);
            }
        }

        else if(req.getParameter("action")==null){

            //List<Filiere> list_filieres = filiereService.FindAll();
            //req.setAttribute("list_filieres", list_filieres);
            //RequestDispatcher dispatcher = req.getRequestDispatcher("/Filiere/List_filieres.jsp");
            //dispatcher.forward(req, resp);

            int page = 1;
            int recordsPerPage = 5;
            if (req.getParameter("page") != null)
                page = Integer.parseInt(
                        req.getParameter("page"));
            FiliereService filiereService = new FiliereService();
            List<Filiere> list = filiereService.FindAll(
                    (page - 1) * recordsPerPage,
                    recordsPerPage);
            int noOfRecords = filiereService.getNoOfRecords();
            int noOfPages = (int)Math.ceil(noOfRecords * 1.0
                    / recordsPerPage);
            req.setAttribute("list_filiere", list);
            req.setAttribute("noOfPages", noOfPages);
            req.setAttribute("currentPage", page);
            RequestDispatcher view
                    = req.getRequestDispatcher("/Filiere/List_filieres.jsp");
            view.forward(req, resp);
        }
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if(req.getParameter("action").equals("edit")){
            int idF = Integer.parseInt(req.getParameter("id"));
            Filiere filiere = filiereService.FindById(idF);
            filiere.setNomFil(req.getParameter("nom"));
            filiereService.Update(filiere);
            resp.sendRedirect("FiliereServlet");
        }
        else if(req.getParameter("action").equals("ajouter")){

            Filiere filiere = new Filiere();
            filiere.setNomFil(req.getParameter("nom"));
            filiereService.Create(filiere);
            resp.sendRedirect("index.jsp");

        }
        else if(req.getParameter("action").equals("delete")){

            Filiere filiere = filiereService.FindById(Integer.parseInt(req.getParameter("id")));
            filiereService.Delete(filiere);
            resp.sendRedirect("FiliereServlet");
        }

        else if(req.getParameter("action").equals("Lister")){

        }
    }

}
