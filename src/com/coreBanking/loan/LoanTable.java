package com.coreBanking.loan;

import java.util.Date;

public class LoanTable {
    int custid;
    int loanSerial;
    int paynum;
    float ghestamount;
    float aslamount;
    float sudamount;
    int paystate;
    Date Sarresidghest;

    public LoanTable(int custid, int loanSerial, int paynum,
           float ghestamount, float aslamount, float sudamount, int paystate, Date sarresidghest)
    {
        this.custid = custid;
        this.loanSerial = loanSerial;
        this.paynum = paynum;
        this.ghestamount = ghestamount;
        this.aslamount = aslamount;
        this.sudamount = sudamount;
        this.paystate = paystate;
        Sarresidghest = sarresidghest;
    }

    public int getCustid() {
        return custid;
    }

    public void setCustid(int custid) {
        this.custid = custid;
    }

    public int getLoanSerial() {
        return loanSerial;
    }

    public void setLoanSerial(int loanSerial) {
        this.loanSerial = loanSerial;
    }

    public int getPaynum() {
        return paynum;
    }

    public void setPaynum(int paynum) {
        this.paynum = paynum;
    }

    public float getGhestamount() {
        return ghestamount;
    }

    public void setGhestamount(float ghestamount) {
        this.ghestamount = ghestamount;
    }

    public float getAslamount() {
        return aslamount;
    }

    public void setAslamount(float aslamount) {
        this.aslamount = aslamount;
    }

    public float getSudamount() {
        return sudamount;
    }

    public void setSudamount(float sudamount) {
        this.sudamount = sudamount;
    }

    public int getPaystate() {
        return paystate;
    }

    public void setPaystate(int paystate) {
        this.paystate = paystate;
    }

    public Date getSarresidghest() {
        return Sarresidghest;
    }

    public void setSarresidghest(Date sarresidghest) {
        Sarresidghest = sarresidghest;
    }

    @Override
    public String toString() {
        return "LoanTable{" +
                "custid=" + custid +
                ", loanSerial=" + loanSerial +
                ", paynum=" + paynum +
                ", ghestamount=" + ghestamount +
                ", aslamount=" + aslamount +
                ", sudamount=" + sudamount +
                ", paystate=" + paystate +
                ", Sarresidghest=" + Sarresidghest +
                '}';
    }
}
