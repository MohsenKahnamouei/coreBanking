package com.coreBanking.db;

import java.sql.*;


public class DbManeger {

    private static final String CONNECTION_URL = "jdbc:mysql://localhost:3306";
    private static final String Connection_USER = "root";
    private static final String connection_password = "1234";
    PreparedStatement preparedStatement;

    public DbManeger() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    Connection getConnection() throws SQLException {
        return DriverManager.getConnection(CONNECTION_URL, Connection_USER, connection_password);
    }





    public void excuteQuery(String query) throws SQLException {
        try {
            preparedStatement = getConnection().prepareStatement(query);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }

    public ResultSet executeQuery2() throws SQLException{
        return preparedStatement.executeQuery();
    }



    public Object executeResults(int column) throws SQLException {
        ResultSet rs = preparedStatement.executeQuery();

        if (rs.next()) {
            return rs.getString(column);
        } else {
            int x = 0;
            return x;

        }


    }


    public void executeUpdate(String query) throws SQLException {
        try {
            preparedStatement = getConnection().prepareStatement(query);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }

    public void DMLUpdade() {
        try {
            int rs = preparedStatement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }

    public void setString(int index, String param) {
        try {
            preparedStatement.setString(index, param);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }

    public void setInt(int index, int param) {
        try {
            preparedStatement.setInt(index, param);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public void setlong(int index, long param) {
        try {
            preparedStatement.setLong(index, param);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public void setDate(int index, Date date) {
        try {
            preparedStatement.setDate(index, date);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
    }

    public void setfloat(int index, float param) {
        try {
            preparedStatement.setFloat(index, param);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
    }




}


