package com.coreBanking.deposit;

import com.coreBanking.cash.CashManager;
import com.coreBanking.exception.SQLIntegrityConstraintViolationException;

import java.sql.SQLException;
import java.util.ArrayList;

public class DepositManager {

    ArrayList<Deposit> deposits;
    DepositDb depositDb=new DepositDb();
    CashManager cashManager=new CashManager();
    Currency currency=new Currency();

    public DepositManager() {
        deposits = new ArrayList<>();
    }

    public Deposit openDeposit  (int customerId, int currencyId,
                               float balance, String depositNumber,
                               String depositTitle, int depositType) throws SQLIntegrityConstraintViolationException, SQLException {
        Deposit deposit = new Deposit(customerId, currencyId, balance, depositNumber, depositTitle, depositType);
        depositDb.saveDepositInDb(deposit);
        deposits.add(deposit);
        return new Deposit(customerId, currencyId, balance, depositNumber, depositTitle, depositType);

    }

    public String createDepositNumber(String depnum,int depTypId,int currencyId) throws SQLException {
        String depositNumber = depositDb.findDepType(depTypId)+"0"+currency.findCurrencyById(currencyId)+depnum;
        System.out.println("deposit Number: "+depositNumber);
        return depositNumber;
    }

    public int chooseDepositType(int id) throws SQLException {
        int deptyp=depositDb.findDepType(id);
        Object deptypNam=depositDb.findDepType2(id);
        System.out.println(deptypNam);
        return deptyp;
    }

    public int chooseDepositCurrency(int id) throws SQLException {
        int depCurrency=currency.findCurrencyById(id);
        Object depCurrencyName=currency.findCurrencyById2(id);
        System.out.println(depCurrencyName);
        return depCurrency;
    }

    public boolean creditDepositBalance(String depnum,float amount) {
        float oldBalance= Float.parseFloat(null);
        try {
            oldBalance = depositDb.getDepositBalance(depnum);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        float newBalance=oldBalance+amount;
        int cashId= 0;
        try {
            cashId = depositDb.finddepCurrency(depnum);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        try {
            depositDb.creditbalance(depnum,amount,newBalance);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        try {
            cashManager.increaseCashBalance(cashId,amount);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return true;

    }

    public boolean debitDepositBalance(String depnum,float amount) throws SQLException {
        float oldBalance=depositDb.getDepositBalance(depnum);
        if (oldBalance-amount>=0) {
            float newBalance = oldBalance - amount;
            int cashId = depositDb.finddepCurrency(depnum);
            depositDb.debitbalance(depnum, amount, newBalance);
            cashManager.decreaseCashBalance(cashId, amount);
            return true;
        }else {
            return false;
        }

    }

    public boolean transferAmount (String creditDepNum,String debitDepnum,float amount) throws SQLException {
        if (depositDb.getDepositBalance(debitDepnum)-amount>=0){
            float newBalanceCredit=depositDb.getDepositBalance(creditDepNum)+amount;
            float newBalancedebit=depositDb.getDepositBalance(creditDepNum)-amount;
            depositDb.transferAmountBetweenDeposits(creditDepNum,debitDepnum,amount,newBalanceCredit,newBalancedebit);
            return true;
        }
        return false;

    }

    public int findDepositCurrency (String depnum) throws SQLException {
        return depositDb.finddepCurrency(depnum);

    }



}
