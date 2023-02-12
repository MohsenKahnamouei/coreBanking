package com.coreBanking.deposit;

import com.coreBanking.cash.CashManager;
import com.coreBanking.exception.DepositNotFoundException;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

public class DepositManager {

    ArrayList<Deposit> deposits;
    DepositDb depositDb = new DepositDb();
    CashManager cashManager = new CashManager();
    Currency currency = new Currency();

    public DepositManager() {
        deposits = new ArrayList<>();
    }

    public Deposit openDeposit(int customerId, int currencyId,
                               float balance, String depositNumber,
                               String depositTitle, int depositType) throws SQLIntegrityConstraintViolationException {
        Deposit deposit = new Deposit(customerId, currencyId, balance, depositNumber, depositTitle, depositType);
        depositDb.saveDepositInDb(deposit);
        deposits.add(deposit);
        return new Deposit(customerId, currencyId, balance, depositNumber, depositTitle, depositType);

    }

    public String createDepositNumber(String depnum, int depTypId, int currencyId) throws SQLIntegrityConstraintViolationException {
        return depositDb.findDepType(depTypId) + "0" + currency.findCurrencyById(currencyId) + depnum;
    }

    public int chooseDepositType(int id) {
        int deptyp = depositDb.findDepType(id);
        Object deptypNam = depositDb.findDepType2(id);
        System.out.println(deptypNam);
        return deptyp;
    }

    public int chooseDepositCurrency(int id) {
        int depCurrency = currency.findCurrencyById(id);
        Object depCurrencyName = currency.findCurrencyById2(id);
        System.out.println(depCurrencyName);
        return depCurrency;
    }

    public boolean creditDepositBalance(String depnum, float amount) {
        float oldBalance = depositDb.getDepositBalance(depnum);
        float newBalance = oldBalance + amount;
        int cashId = depositDb.finddepCurrency(depnum);
        depositDb.creditbalance(depnum, amount, newBalance);
        cashManager.increaseCashBalance(cashId, amount);
        return true;

    }

    public boolean creditDepositBalanceForLoan(String depnum, float amount) {
        float oldBalance = depositDb.getDepositBalance(depnum);
        float newBalance = oldBalance + amount;
        int cashId = depositDb.finddepCurrency(depnum);
        depositDb.creditbalance(depnum, amount, newBalance);
        cashManager.decreaseCashBalance(cashId, amount);
        return true;

    }

    public boolean debitDepositBalance(String depnum, float amount) {
        float oldBalance = depositDb.getDepositBalance(depnum);
        if (oldBalance - amount >= 0) {
            float newBalance = oldBalance - amount;
            int cashId = depositDb.finddepCurrency(depnum);
            depositDb.debitbalance(depnum, amount, newBalance);
            cashManager.decreaseCashBalance(cashId, amount);
            return true;
        } else {
            return false;
        }

    }

    public boolean transferAmount(String creditDepNum, String debitDepnum, float amount) {
        if (depositDb.getDepositBalance(debitDepnum) - amount >= 0) {
            float newBalanceCredit = depositDb.getDepositBalance(creditDepNum) + amount;
            float newBalancedebit = depositDb.getDepositBalance(creditDepNum) - amount;
            depositDb.transferAmountBetweenDeposits(creditDepNum, debitDepnum, amount, newBalanceCredit, newBalancedebit);
            return true;
        }
        return false;

    }

    public int findDepositCurrency(String depnum) {
        return depositDb.finddepCurrency(depnum);

    }

    public boolean findDep(int customerId) {
        return depositDb.findDep(customerId);

    }


    public boolean findDep1(String depnum) {
        return depositDb.findDep1(depnum);

    }

    public float getDepositBalance(String depnum) {
        return depositDb.getDepositBalance(depnum);
    }
}
