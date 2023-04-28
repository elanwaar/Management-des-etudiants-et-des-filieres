package ensat.dca.dao;

import java.sql.*;
import java.util.List;

public interface IDAO <T> {

    boolean Create(T o) throws SQLException;

    boolean Update(T o) throws SQLException;

    boolean Delete(T o) throws SQLException;

    // on a ajouté 'offset' et 'noOfRecords' pour la pagination
    List<T> FindAll(int offset, int noOfRecords) throws SQLException;

    T FindById(int id) throws SQLException;

}