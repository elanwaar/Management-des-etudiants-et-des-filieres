package ensat.dca.Services;
import ensat.dca.Model.Etudiant;
import ensat.dca.Model.Filiere;
import ensat.dca.dao.IDAO;

import javax.servlet.RequestDispatcher;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static ensat.dca.dao.DAO.getConnection;

public class FiliereService implements IDAO<Filiere> {

    private static Connection connexion;
    Statement stmt;
    private int noOfRecords;

    public FiliereService(){
        connexion = getConnection();

    }

    public boolean Create(Filiere filiere) throws SQLException {

        String nomFil = filiere.getNomFil();
        PreparedStatement pst = connexion.prepareStatement("INSERT INTO Filiere (nomFil) VALUES (?)");
        pst.setString(1, nomFil);
        int rowsAffected = pst.executeUpdate();
        System.out.println("Rows Affected: "+rowsAffected);
        if(rowsAffected!=0) return true; else return false;
    }
    public boolean Update(Filiere filiere) throws SQLException {

        int idFil = filiere.getIdFil();
        String nomFil = filiere.getNomFil();
        System.out.println(nomFil);
        System.out.println(idFil);
        PreparedStatement pst = connexion.prepareStatement("UPDATE filiere SET nomFil = '" + nomFil +"' WHERE idFil= ?");
        pst.setInt(1, idFil);
        int rowsAffected = pst.executeUpdate();
        System.out.println("Rows Affected: "+rowsAffected);
        if(rowsAffected!=0) return true; else return false;
    }

    public boolean Delete(Filiere filiere) throws SQLException {

        int idFil = filiere.getIdFil();
        PreparedStatement pst = connexion.prepareStatement("DELETE FROM FILIERE WHERE idFil = ?");
        pst.setInt(1, idFil);
        boolean deleted = pst.execute();
        return deleted;
    }



    public List<Filiere> FindAll(int offset, int noOfRecords) throws SQLException {

        String query = "select SQL_CALC_FOUND_ROWS * from Filiere limit " + offset + ", " + noOfRecords;
        List<Filiere> list = new ArrayList<Filiere>();
        Filiere filiere = null;
        try {
            stmt = connexion.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                filiere = new Filiere();
                filiere.setIdFil(rs.getInt("idFil"));
                filiere.setNomFil(rs.getString("nomFil"));
                list.add(filiere);
            }

            rs.close();
            rs = stmt.executeQuery("SELECT FOUND_ROWS()");

            if (rs.next())
                this.noOfRecords = rs.getInt(1);
        }
        catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    //Retourne le nombre total des filieres. On l'utilise dans FiliereServlet pour décider le nombre des pages.
    public int getNoOfRecords() {
        String query = "select COUNT(*) from Filiere";
        int numberOfRecords = 0;
        try {
            stmt = connexion.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            if(rs.next()){
                numberOfRecords = rs.getInt("COUNT(*)");
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }

        return numberOfRecords;
    }

    public Filiere FindById(int id) throws SQLException {

        PreparedStatement pst = connexion.prepareStatement("SELECT *FROM FILIERE WHERE idFil= ?");
        pst.setInt(1, id);
        ResultSet rs = pst.executeQuery();
        Filiere fil = new Filiere();
        while (rs.next()) {
            fil.setIdFil(rs.getInt("idFil"));
            fil.setNomFil(rs.getString("nomFil"));
        }
        return fil;
    }
}
