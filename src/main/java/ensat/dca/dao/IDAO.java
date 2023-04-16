package ensat.dca.dao;

import ensat.dca.Model.Etudiant;
import ensat.dca.Model.Filiere;
import ensat.dca.Services.EtudiantService;
import ensat.dca.Services.FiliereService;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Type;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public interface IDAO <T> {

    boolean Create(T o) throws SQLException;

    boolean Update(T o) throws SQLException;

    boolean Delete(T o) throws SQLException;

    List<T> FindAll(int offset, int noOfRecords) throws SQLException;

    T FindById(int id) throws SQLException;

}