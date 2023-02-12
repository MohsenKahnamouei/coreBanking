package com.coreBanking.deposit;

import com.coreBanking.db.DbManeger;

import java.sql.SQLException;

public class Currency {
    DbManeger dbManeger = new DbManeger();


    public int findCurrencyById(int id) {
        int currency = 0;
        dbManeger.excuteQuery("select a.id from mysql.currency a where a.id=?");
        dbManeger.setInt(1, id);
        try {
            currency = Integer.parseInt(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return currency;

    }

    public Object findCurrencyById2(int id) {
        Object currency = null;
        dbManeger.excuteQuery("select * from mysql.currency a where a.id=?");
        dbManeger.setInt(1, id);
        try {
            currency = dbManeger.executeResults(2);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return currency;

    }
}


