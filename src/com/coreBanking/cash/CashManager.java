package com.coreBanking.cash;

public class CashManager {
    CashDb cashDb = new CashDb();


    public float getcashIdBalance(int cashId) {
        return Float.parseFloat(cashDb.getBalance(cashId).toString());
    }

    public void increaseCashBalance(int cashId, float amount) {
        float oldBalance = Float.parseFloat(cashDb.getBalance(cashId).toString());
        float newBalance = oldBalance + amount;
        cashDb.increaseBalance(cashId, amount, newBalance);
    }

    public void decreaseCashBalance(int cashId, float amount) {
        float oldBalance = Float.parseFloat(cashDb.getBalance(cashId).toString());
        if (oldBalance - amount >= 0) {
            float newBalance = (Float.parseFloat(cashDb.getBalance(cashId).toString()) - amount);
            cashDb.decreaseBalance(cashId, amount, newBalance);
        }

    }

    public boolean findCashId(int cashId){
        return cashDb.findCashId(cashId);
    }
}
