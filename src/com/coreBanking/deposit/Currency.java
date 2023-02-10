package com.coreBanking.deposit;

import com.coreBanking.db.DbManeger;

import java.sql.SQLException;

public class Currency {
    DbManeger dbManeger=new DbManeger();


    public int findCurrencyById(int id) throws SQLException {
        dbManeger.excuteQuery("select a.id from mysql.currency a where a.id=?");
        dbManeger.setInt(1,id);
        int currencyId= Integer.parseInt(dbManeger.executeResults(1).toString());
        return currencyId;
    }

    public Object findCurrencyById2(int id) throws SQLException {
        dbManeger.excuteQuery("select * from mysql.currency a where a.id=?");
        dbManeger.setInt(1,id);
        Object currencyIdName= dbManeger.executeResults(2);
        return currencyIdName;
    }
}


