package com.coreBanking.cash;

import com.coreBanking.db.DbManeger;
import com.coreBanking.orgFandamental.OrgFandamental;

import java.sql.SQLException;

public class CashDb {
    DbManeger dbManeger=new DbManeger();
    OrgFandamental orgFandamental=new OrgFandamental();

    public Object getBalance (int cashId) throws SQLException {
        dbManeger.excuteQuery("select a.balance from mysql.cash a where a.cashid=?");
        dbManeger.setInt(1,cashId);
        return  dbManeger.executeResults(1);

    }

    public void increaseBalance(int cashId,float amount,float newAmount) throws SQLException {
        dbManeger.executeUpdate("update mysql.cash a set a.balance=? where a.cashid=?");
        dbManeger.setfloat(1,newAmount);
        dbManeger.setInt(2,cashId);
        dbManeger.DMLUpdade();
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid," +
                " drcrtyp, trndate,trndesc,refsystem)" +
                " values (?,?,?,?,?,?,?)");
        dbManeger.setInt(1,cashId);
        dbManeger.setfloat(2,amount);
        dbManeger.setInt(3,2);
        dbManeger.setInt(4,0);
        dbManeger.setString(5,orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6,"افزایش صندوق");
        dbManeger.setString(7,"C");
        dbManeger.DMLUpdade();

    }

    public void decreaseBalance(int cashId, float amount, float newAmount) throws SQLException {
        dbManeger.executeUpdate("update mysql.cash a set a.balance=? where a.cashid=?");
        dbManeger.setfloat(1,newAmount);
        dbManeger.setInt(2,cashId);
        dbManeger.DMLUpdade();
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid," +
                " drcrtyp, trndate,trndesc,refsystem)" +
                " values (?,?,?,?,?,?,?)");
        dbManeger.setInt(1,cashId);
        dbManeger.setfloat(2,amount);
        dbManeger.setInt(3,3);
        dbManeger.setInt(4,1);
        dbManeger.setString(5,orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6,"کاهش صندوق");
        dbManeger.setString(7,"C");
        dbManeger.DMLUpdade();

    }


    public static void main(String[] args) throws SQLException {
        CashDb cashDb=new CashDb();
        System.out.println(cashDb.getBalance(1));
    }
}
