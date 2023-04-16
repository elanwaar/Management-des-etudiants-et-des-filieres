package ensat.dca.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {

    static Connection connexion = null;
    static final String driver = "com.mysql.cj.jdbc.Driver";
    static final String url = "jdbc:mysql://localhost:3306/management_etudiants";
    static final String user = "root";
    static final String password = "";


    public static void seConnecter() {
        try {

            System.out.println("Start of Connection, Loading Driver ... ");
            Class.forName(driver);
            System.out.println(" Driver upload successful");
            connexion = DriverManager.getConnection(url, user, password);
            System.out.println("Connection established .. ");
        } catch (ClassNotFoundException ex) {
            System.out.println("Driver loading problem");
        } catch (SQLException ex) {
            System.out.println("Connection problem URL Login or Password incorrect, Connection Failure !!!");
        }
    }

    public static Connection getConnection() {
        if (connexion == null)
            seConnecter();
        return connexion;
    }

}
