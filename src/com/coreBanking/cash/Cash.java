package com.coreBanking.cash;

public class Cash {
    int currencyId, cashID;
    float balace;

    public int getCurrencyId() {
        return currencyId;
    }

    public void setCurrencyId(int currencyId) {
        this.currencyId = currencyId;
    }

    public int getCashID() {
        return cashID;
    }

    public void setCashID(int cashID) {
        this.cashID = cashID;
    }

    public float getBalace() {
        return balace;
    }

    public void setBalace(Long balace) {
        this.balace = balace;
    }

    @Override
    public String toString() {
        return "Cash{" +
                "currencyId=" + currencyId +
                ", cashID=" + cashID +
                ", balace=" + balace +
                '}';
    }
}
