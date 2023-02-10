package com.coreBanking.loan;

import java.util.Date;

public class Loan {
    int customerId;
    int serial;
    Date beginDate;
    float amountLoan;
    float amountProfit;
    int payCount;
    int profitRate;
    int currencyId;

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getSerial() {
        return serial;
    }

    public void setSerial(int serial) {
        this.serial = serial;
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public float getAmountLoan() {
        return amountLoan;
    }

    public void setAmountLoan(Long amountLoan) {
        this.amountLoan = amountLoan;
    }

    public float getAmountProfit() {
        return amountProfit;
    }

    public void setAmountProfit(Long amountProfit) {
        this.amountProfit = amountProfit;
    }

    public int getPayCount() {
        return payCount;
    }

    public void setPayCount(int payCount) {
        this.payCount = payCount;
    }

    public int getProfitRate() {
        return profitRate;
    }

    public void setProfitRate(int profitRate) {
        this.profitRate = profitRate;
    }

    public int getCurrencyId() {
        return currencyId;
    }

    public void setCurrencyId(int currencyId) {
        this.currencyId = currencyId;
    }

    @Override
    public String toString() {
        return "Loan{" +
                "customerId=" + customerId +
                ", serial=" + serial +
                ", beginDate=" + beginDate +
                ", amountLoan=" + amountLoan +
                ", amountProfit=" + amountProfit +
                ", payCount=" + payCount +
                ", profitRate=" + profitRate +
                ", currencyId=" + currencyId +
                '}';
    }
}
