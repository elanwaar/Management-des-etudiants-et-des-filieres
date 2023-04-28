package ensat.dca.Services;
import ensat.dca.Model.Etudiant;
import ensat.dca.Model.Filiere;
import ensat.dca.dao.IDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static ensat.dca.dao.DAO.getConnection;

public class  EtudiantService implements IDAO<Etudiant>{

    private static Connection connexion;
    Statement stmt;
    private int noOfRecords;

    public EtudiantService(){
        connexion = getConnection();
    }

    public boolean Create(Etudiant Etudiant) throws SQLException {

        String nom = Etudiant.getNom();
        String prenom = Etudiant.getPrenom();
        String sexe = Etudiant.getSexe();
        Integer idFil = Etudiant.getIdF();

        PreparedStatement pst = connexion.prepareStatement("INSERT INTO Etudiant (nom, prenom, sexe, idFil) VALUES (?,?,?,?)");
        pst.setString(1, nom);
        pst.setString(2, prenom);
        pst.setString(3, sexe);
        pst.setInt(4, idFil);

        int rowsAffected = pst.executeUpdate();
        System.out.println("Rows Affected: "+rowsAffected);
        if(rowsAffected!=0) return true; else return false;
    }

    public boolean Update(Etudiant etudiant) throws SQLException {

        int idEtu = etudiant.getIdE();
        String nom = etudiant.getNom();
        String prenom = etudiant.getPrenom();
        String sexe = etudiant.getSexe();
        int idFil = etudiant.getIdF();

        PreparedStatement pst = connexion.prepareStatement("UPDATE Etudiant SET nom = '" + nom +"', prenom='"+prenom+"', sexe= '"+sexe+"', idFil= '"+idFil+"' WHERE idetu= ?");
        pst.setInt(1, idEtu);

        int rowsAffected = pst.executeUpdate();
        System.out.println("Rows Affected: "+rowsAffected);
        if(rowsAffected!=0) return true; else return false;
    }

    public boolean Delete(Etudiant Etudiant) throws SQLException {

        int idEtu = Etudiant.getIdE();
        PreparedStatement pst = connexion.prepareStatement("DELETE FROM Etudiant WHERE idEtu = ?");
        pst.setInt(1, idEtu);
        boolean deleted = pst.execute();
        return deleted;
    }

    public List<Etudiant> FindAll(int offset, int noOfRecords) throws SQLException {

        String query = "select SQL_CALC_FOUND_ROWS * from Etudiant limit " + offset + ", " + noOfRecords;
        List <Etudiant> list_Etudiants = new ArrayList<>();
        try{
            stmt = connexion.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while(rs.next()){
                Etudiant etu = new Etudiant();
                etu.setIdE(rs.getInt("idEtu"));
                etu.setNom(rs.getString("nom"));
                etu.setPrenom(rs.getString("prenom"));
                etu.setSexe(rs.getString("sexe"));
                etu.setIdF(Integer.parseInt(rs.getString("idFil")));
                list_Etudiants.add(etu);
            }
            rs.close();
            rs = stmt.executeQuery("SELECT FOUND_ROWS()");

            if (rs.next())
                this.noOfRecords = rs.getInt(1);
        }

        catch (SQLException e) {
            e.printStackTrace();
        }

        return list_Etudiants;
    }

    //Retourne le nombre total des filieres. On l'utilise dans EtudiantServlet pour décider le nombre des pages.
    public int getNoOfRecords() {
        String query = "select COUNT(*) from Etudiant";
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

    public Etudiant FindById(int id) throws SQLException {

        PreparedStatement pst = connexion.prepareStatement("SELECT *FROM Etudiant WHERE idEtu= ?");
        pst.setInt(1, id);
        ResultSet rs = pst.executeQuery();
        Etudiant etu = new Etudiant();
        while (rs.next()) {
            etu.setIdE(rs.getInt("idEtu"));
            etu.setNom(rs.getString("nom"));
            etu.setPrenom(rs.getString("prenom"));
            etu.setSexe(rs.getString("sexe"));
            etu.setIdF(Integer.parseInt(rs.getString("idFil")));
        }
        return etu;
    }
}

