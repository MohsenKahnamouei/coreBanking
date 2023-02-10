package com.coreBanking.report;

import com.coreBanking.db.DbManeger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReportDb {

    DbManeger dbManeger = new DbManeger();

    public ArrayList<TransactionReport> top5TransactionReport() throws SQLException {
        dbManeger.excuteQuery("select a.id ,a.depid,a.amount,b.trnname,if(a.drcrtyp=0,'Credit','Debit')drcrtyp,a.trndate,a.trndesc,a.refsystem\n" +
                "from mysql.deposittransaction a join mysql.transaction b on a.trnid=b.trnid order by a.trndate desc limit 5");

        ResultSet result = dbManeger.executeQuery2();
        ArrayList<TransactionReport> transactionReports = new ArrayList<>();
        while (result.next()) {
            TransactionReport trnrep = new TransactionReport(
                    result.getInt("id"),
                    result.getString("depid"),
                    result.getFloat("amount"),
                    result.getString("trnname"),
                    result.getString("drcrtyp"),
                    result.getDate("trndate"),
                    result.getString("trndesc"),
                    result.getString("refsystem"));
            transactionReports.add(trnrep);
        }

        return transactionReports;
    }

    public int transactionCount(){
        int transCount = 0;
        try {
            dbManeger.excuteQuery("select count(*)\n" +
                    "from mysql.deposittransaction a");
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        try {
            transCount= Integer.parseInt(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return transCount;
    }

    public ArrayList<TransactionReport> transactionList() throws SQLException {
        dbManeger.excuteQuery("select a.id ,a.depid,a.amount,b.trnname,if(a.drcrtyp=0,'Credit','Debit')drcrtyp,a.trndate,a.trndesc,a.refsystem\n" +
                "from mysql.deposittransaction a join mysql.transaction b on a.trnid=b.trnid order by a.trndate");

        ResultSet result = dbManeger.executeQuery2();
        ArrayList<TransactionReport> transactionReports = new ArrayList<>();
        while (result.next()) {
            TransactionReport trnrep = new TransactionReport(
                    result.getInt("id"),
                    result.getString("depid"),
                    result.getFloat("amount"),
                    result.getString("trnname"),
                    result.getString("drcrtyp"),
                    result.getDate("trndate"),
                    result.getString("trndesc"),
                    result.getString("refsystem"));
            transactionReports.add(trnrep);
        }

        return transactionReports;
    }


}
