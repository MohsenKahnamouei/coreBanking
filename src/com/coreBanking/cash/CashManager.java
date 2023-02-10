package com.coreBanking.cash;

import java.sql.SQLException;

public class CashManager {
    CashDb cashDb=new CashDb();


    public float getcashIdBalance(int cashId) throws SQLException {
        return  Float.parseFloat(cashDb.getBalance(cashId).toString());
    }

    public void increaseCashBalance(int cashId, float amount) throws SQLException {
        float oldBalance=Float.parseFloat(cashDb.getBalance(cashId).toString());
        float newBalance= oldBalance+amount;
        cashDb.increaseBalance(cashId,amount,newBalance);
    }

    public boolean decreaseCashBalance(int cashId, float amount) throws SQLException {
        float oldBalance=Float.parseFloat(cashDb.getBalance(cashId).toString());
        if (oldBalance-amount>=0) {
            float newBalance=(Float.parseFloat(cashDb.getBalance(cashId).toString())-amount);
            cashDb.decreaseBalance(cashId,amount,newBalance);
            return true;
        }else {
            return false;

        }

    }
}
