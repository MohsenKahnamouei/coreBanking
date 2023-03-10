package com.coreBanking.deposit;

import com.coreBanking.db.DbManeger;
import com.coreBanking.orgFandamental.OrgFandamental;

import java.sql.SQLException;

public class DepositDb {
    DbManeger dbManeger = new DbManeger();
    OrgFandamental orgFandamental = new OrgFandamental();

    public void saveDepositInDb(Deposit deposit) {
        dbManeger.executeUpdate("insert into mysql.deposit \n" +
                "    (customer_id, currency_id, balance, `depossitnumber(20)`, deposittitle, deposittype) \n" +
                "    values (?,?,?,?,?,?)");
        dbManeger.setInt(1, deposit.getCustomer());
        dbManeger.setInt(2, deposit.getCurrency());
        dbManeger.setInt(3, 0);
        dbManeger.setString(4, deposit.getDepositNumber());
        dbManeger.setString(5, deposit.getDepositTitle());
        dbManeger.setInt(6, deposit.getCurrency());

        dbManeger.DMLUpdade();
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid," +
                " drcrtyp, trndate,trndesc,refsystem)" +
                " values (?,?,?,?,?,?,?)");
        dbManeger.setString(1, deposit.getDepositNumber());
        dbManeger.setfloat(2, 0);
        dbManeger.setInt(3, 1);
        dbManeger.setInt(4, 1);
        dbManeger.setString(5, orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6, "افتتاح سپرده");
        dbManeger.setString(7, "D");
        dbManeger.DMLUpdade();


    }

    public int findDepType(int id) {
        int deptypId = 0;
        dbManeger.excuteQuery("select a.`id(2)` from mysql.deposittype a where a.`id(2)`=?");
        dbManeger.setInt(1, id);
        try {
            deptypId = Integer.parseInt(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return deptypId;
    }

    public Object findDepType2(int id) {
        Object depTyp = null;
        dbManeger.excuteQuery("select * from mysql.deposittype a where a.`id(2)`=?");
        dbManeger.setInt(1, id);
        try {
            depTyp = dbManeger.executeResults(2);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return depTyp;

    }

    public int finddepCurrency(String depnum) {
        int currency = 0;
        dbManeger.excuteQuery("select a.currency_id from mysql.deposit a where a.`depossitnumber(20)`=?");
        dbManeger.setString(1, depnum);
        try {
            currency = Integer.parseInt(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return currency;
    }


    public float getDepositBalance(String depnum) {
        float bal = 0;
        dbManeger.excuteQuery("select a.balance from mysql.deposit a where a.`depossitnumber(20)`=?");
        dbManeger.setString(1, depnum);
        try {
            bal = Float.parseFloat(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return bal;
    }


    public void creditbalance(String depnum, float amount, float newBalance) {
        dbManeger.executeUpdate("update mysql.deposit a set a.balance=? where a.`depossitnumber(20)`=?");
        dbManeger.setfloat(1, newBalance);
        dbManeger.setString(2, depnum);
        dbManeger.DMLUpdade();
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid," +
                " drcrtyp, trndate,trndesc,refsystem)" +
                " values (?,?,?,?,?,?,?)");
        dbManeger.setString(1, depnum);
        dbManeger.setfloat(2, amount);
        dbManeger.setInt(3, 4);
        dbManeger.setInt(4, 1);
        dbManeger.setString(5, orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6, "واریز به سپرده");
        dbManeger.setString(7, "D");
        dbManeger.DMLUpdade();

    }


    public void debitbalance(String depnum, float amount, float newBalance) {
        dbManeger.executeUpdate("update mysql.deposit a set a.balance=? where a.`depossitnumber(20)`=?");
        dbManeger.setfloat(1, newBalance);
        dbManeger.setString(2, depnum);
        dbManeger.DMLUpdade();
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid," +
                " drcrtyp, trndate,trndesc,refsystem)" +
                " values (?,?,?,?,?,?,?)");
        dbManeger.setString(1, depnum);
        dbManeger.setfloat(2, amount);
        dbManeger.setInt(3, 5);
        dbManeger.setInt(4, 0);
        dbManeger.setString(5, orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6, "برداشت از سپرده");
        dbManeger.setString(7, "D");
        dbManeger.DMLUpdade();

    }

    public void transferAmountBetweenDeposits(String depCredit, String depDebit, float amount, float newBalanceCredit, float newBalanceDebit) {
        //update credit balace
        dbManeger.executeUpdate("update mysql.deposit a set a.balance=? where a.`depossitnumber(20)`=?");
        dbManeger.setfloat(1, newBalanceCredit);
        dbManeger.setString(2, depCredit);
        dbManeger.DMLUpdade();
        //update debit balance
        dbManeger.executeUpdate("update mysql.deposit a set a.balance=? where a.`depossitnumber(20)`=?");
        dbManeger.setfloat(1, newBalanceDebit);
        dbManeger.setString(2, depDebit);
        dbManeger.DMLUpdade();
        // insert transaction credit
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid," +
                " drcrtyp, trndate,trndesc,refsystem)" +
                " values (?,?,?,?,?,?,?)");
        dbManeger.setString(1, depCredit);
        dbManeger.setfloat(2, amount);
        dbManeger.setInt(3, 6);
        dbManeger.setInt(4, 1);
        dbManeger.setString(5, orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6, "انتقال وجه بین سپرده");
        dbManeger.setString(7, "D");
        dbManeger.DMLUpdade();
        // insert transaction debit
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid," +
                " drcrtyp, trndate,trndesc,refsystem)" +
                " values (?,?,?,?,?,?,?)");
        dbManeger.setString(1, depDebit);
        dbManeger.setfloat(2, amount);
        dbManeger.setInt(3, 6);
        dbManeger.setInt(4, 0);
        dbManeger.setString(5, orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6, "انتقال وجه بین سپرده");
        dbManeger.setString(7, "D");
        dbManeger.DMLUpdade();

    }

    public boolean findDep(int customerId) {
        dbManeger.excuteQuery("select * from mysql.deposit d where d.customer_id=?");
        dbManeger.setInt(1, customerId);
        try {
            if (Integer.parseInt(dbManeger.executeResults(1).toString()) != 0) {
                return true;
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return false;
    }

    public boolean findDep1(String depNum) {
        dbManeger.excuteQuery("select * from mysql.deposit d where d.`depossitnumber(20)`=?");
        dbManeger.setString(1, depNum);
        try {
            if (Integer.parseInt(dbManeger.executeResults(4).toString()) != 0) {
                return true;
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }

        return false;

    }


}
