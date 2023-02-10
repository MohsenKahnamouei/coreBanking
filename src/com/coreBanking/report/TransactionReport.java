package com.coreBanking.report;

import java.util.ArrayList;
import java.util.Date;
import java.util.stream.Stream;

public class TransactionReport extends ArrayList {
    int transactionId;
    String account;
    float amount;
    String trnname;
    String drcrtyp;
    Date trndate;
    String trndesc;
    String refsystem;

    public TransactionReport(int transactionId, String account, float amount, String trnname, String drcrtyp, Date trndate, String trndesc, String refsystem) {
        this.transactionId = transactionId;
        this.account = account;
        this.amount = amount;
        this.trnname = trnname;
        this.drcrtyp = drcrtyp;
        this.trndate = trndate;
        this.trndesc = trndesc;
        this.refsystem = refsystem;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public String getTrnname() {
        return trnname;
    }

    public void setTrnname(String trnname) {
        this.trnname = trnname;
    }

    public String getDrcrtyp() {
        return drcrtyp;
    }

    public void setDrcrtyp(String drcrtyp) {
        this.drcrtyp = drcrtyp;
    }

    public Date getTrndate() {
        return trndate;
    }

    public void setTrndate(Date trndate) {
        this.trndate = trndate;
    }

    public String getTrndesc() {
        return trndesc;
    }

    public void setTrndesc(String trndesc) {
        this.trndesc = trndesc;
    }

    public String getRefsystem() {
        return refsystem;
    }

    public void setRefsystem(String refsystem) {
        this.refsystem = refsystem;
    }

    @Override
    public String toString() {
        return "TransactionReport{" +
                "transactionId=" + transactionId +
                ", account='" + account + '\'' +
                ", amount=" + amount +
                ", trnname='" + trnname + '\'' +
                ", drcrtyp='" + drcrtyp + '\'' +
                ", trndate=" + trndate +
                ", trndesc='" + trndesc + '\'' +
                ", refsystem='" + refsystem + '\'' +
                '}';
    }


    @Override
    public Stream stream() {
        return super.stream();
    }
}
