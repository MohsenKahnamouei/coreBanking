package com.coreBanking.deposit;

import com.coreBanking.customer.Customer;

public class Deposit {
    int customerId;
    int currencyId;
    float balance;
    String depositNumber;
    String depositTitle;
    int depositType;

    public Deposit(int customerId, int currencyId, float balance,
                   String depositNumber, String depositTitle, int depositType) {
        this.customerId = customerId;
        this.currencyId = currencyId;
        this.balance = balance;
        this.depositNumber = depositNumber;
        this.depositTitle = depositTitle;
        this.depositType = depositType;
    }


    public int getdepositType() {
        return depositType;
    }

    public void setDepositType(int depositType) {
        this.depositType = depositType;
    }
    public int getCustomer() {
        return customerId;
    }

    public void setCustomer(Customer customer) {
        this.currencyId = customerId;
    }

    public int getCurrency() {
        return currencyId;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(Long balance) {
        this.balance = balance;
    }

    public String getDepositNumber() {
        return depositNumber;
    }

    public void setDepositNumber(String depositNumber) {
        this.depositNumber = depositNumber;
    }

    public String getDepositTitle() {
        return depositTitle;
    }

    public void setDepositTitle(String depositTitle) {
        this.depositTitle = depositTitle;
    }

    @Override
    public String toString() {
        return "Deposit{" +
                "customer=" + customerId +
                ",currency=" + currencyId +
                ", balance=" + balance +
                ", depositNumber='" + depositNumber + '\'' +
                ", depositTitle='" + depositTitle + '\'' +
                ", depositType='" + depositType + '\'' +
                '}';
    }
}
