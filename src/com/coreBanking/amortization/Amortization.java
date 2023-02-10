package com.coreBanking.amortization;

public class Amortization {
    float totalProfitAmount; // * کل سود *
    float loanAmount; //  * مبلغ پرداختی *
    float rate;//  * نرخ تسهیلات *
    int peymentCount;// * تعداد اقساط *
    float peymentAmount;// * مبلغ هر قسط *
    float hideProfitPeyment; // * سود مستتر در قسط *
    int k ;// * تعداد اقساط پرداخت نشده قبل از پرداخت *
    int l ;// * تعداد اقساط پرداخت نشده بعد از پرداخت *

    public float getTotalProfitAmount() {
        return totalProfitAmount;
    }

    public void setTotalProfitAmount(float totalProfitAmount) {
        this.totalProfitAmount = totalProfitAmount;
    }

    public float getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(float loanAmount) {
        this.loanAmount = loanAmount;
    }

    public float getRate() {
        return rate;
    }

    public void setRate(float rate) {
        this.rate = rate;
    }

    public int getPeymentCount() {
        return peymentCount;
    }

    public void setPeymentCount(int peymentCount) {
        this.peymentCount = peymentCount;
    }

    public float getPeymentAmount() {
        return peymentAmount;
    }

    public void setPeymentAmount(float peymentAmount) {
        this.peymentAmount = peymentAmount;
    }

    public float getHideProfitPeyment() {
        return hideProfitPeyment;
    }

    public void setHideProfitPeyment(float hideProfitPeyment) {
        this.hideProfitPeyment = hideProfitPeyment;
    }

    public int getK() {
        return k;
    }

    public void setK(int k) {
        this.k = k;
    }

    public int getL() {
        return l;
    }

    public void setL(int l) {
        this.l = l;
    }

    @Override
    public String toString() {
        return "Amortization{" +
                "totalProfitAmount=" + totalProfitAmount +
                ", loanAmount=" + loanAmount +
                ", rate=" + rate +
                ", peymentCount=" + peymentCount +
                ", peymentAmount=" + peymentAmount +
                ", hideProfitPeyment=" + hideProfitPeyment +
                ", k=" + k +
                ", l=" + l +
                '}';
    }
}

