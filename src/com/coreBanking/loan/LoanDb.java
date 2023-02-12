package com.coreBanking.loan;

import com.coreBanking.db.DbManeger;
import com.coreBanking.orgFandamental.OrgFandamental;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class LoanDb {
    DbManeger dbManeger = new DbManeger();
    OrgFandamental orgFandamental = new OrgFandamental();

    public void createLoan(int customerId, int serial, float amountLoan,
                           float amountProfit, int payCount, float profitRate, int currencyId) {

        dbManeger.executeUpdate("insert into mysql.loan (customerid, Serial, begindate, amountloan,\n" +
                "                   amountprofit, paycount, profitrate, currencyId)\n" +
                "                   VALUES (?,?,?,?,?,?,?,?)");
        dbManeger.setInt(1, customerId);
        dbManeger.setInt(2, serial);
        dbManeger.setString(3, orgFandamental.CurrentDateTimeExample());
        dbManeger.setfloat(4, amountLoan);
        dbManeger.setfloat(5, amountProfit);
        dbManeger.setInt(6, payCount);
        dbManeger.setfloat(7, profitRate);
        dbManeger.setInt(8, currencyId);
        dbManeger.DMLUpdade();
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid," +
                " drcrtyp, trndate,trndesc,refsystem)" +
                " values (?,?,?,?,?,?,?)");
        dbManeger.setString(1, String.valueOf(customerId));
        dbManeger.setfloat(2, amountLoan);
        dbManeger.setInt(3, 7);
        dbManeger.setInt(4, 0);
        dbManeger.setString(5, orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6, "تشکیل پرونده تسهیلات");
        dbManeger.setString(7, "L");
        dbManeger.DMLUpdade();

    }

    public void createLoanTable(int customerid, int serial, int paynumber, float ghestamount, float aslamount,
                                float sudamount, String sarresid) {
        dbManeger.executeUpdate("insert into mysql.loanpaytables (customerid, Serial, paynumber,\n" +
                "                                 ghestamount, aslamount, sudamount, paystate, Sarresidghest)\n" +
                "                                 values (?,?,?,?,?,?,?,?)");
        dbManeger.setInt(1, customerid);
        dbManeger.setInt(2, serial);
        dbManeger.setInt(3, paynumber);
        dbManeger.setfloat(4, ghestamount);
        dbManeger.setfloat(5, aslamount);
        dbManeger.setfloat(6, sudamount);
        dbManeger.setInt(7, 1);
        dbManeger.setString(8, sarresid);
        dbManeger.DMLUpdade();

    }

    public Object getLoanRate() {
        Object rate = null;
        dbManeger.excuteQuery("select a.rate from mysql.loanrate a where a.rateid=1");
        try {
            rate = dbManeger.executeResults(1);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return rate;
    }

    public void updateLoanRate(int rate) throws SQLException {
        dbManeger.executeUpdate("update mysql.loanrate a set a.rate=? where a.rateid=1");
        dbManeger.setInt(1, rate);
        dbManeger.DMLUpdade();
    }

    public int getLoanSerial(int customerId) {
        dbManeger.excuteQuery("select max(a.Serial) from mysql.loan a where a.customerid=?");
        dbManeger.setInt(1, customerId);
        int serial = 0;
        Object o = null;
        try {
            o = dbManeger.executeResults(1);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        if (o != null && Integer.parseInt(o.toString()) > 0) {
            try {
                serial = Integer.parseInt(dbManeger.executeResults(1).toString());
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
        } else {
            serial = 1;

        }
        return serial;
    }

    public void getPeyment(int customerId, int serial, int payNumberAz, int payNumberTa, float amount) {
        dbManeger.executeUpdate("update mysql.loanpaytables a set a.paystate=0 where a.customerid=? and a.Serial=? and a.paynumber between ? and ? ");
        dbManeger.setInt(1, customerId);
        dbManeger.setInt(2, serial);
        dbManeger.setInt(3, payNumberAz);
        dbManeger.setInt(4, payNumberTa);
        dbManeger.DMLUpdade();
        dbManeger.executeUpdate("insert into mysql.deposittransaction (depid, amount, trnid, drcrtyp, trndate, trndesc, refsystem) VALUES (?,?,?,?,?,?,?)");
        dbManeger.setInt(1, customerId);
        dbManeger.setfloat(2, amount);
        dbManeger.setInt(3, 8);
        dbManeger.setInt(4, 1);
        dbManeger.setString(5, orgFandamental.CurrentDateTimeExample());
        dbManeger.setString(6, "دریافت قسط تسهیلات");
        dbManeger.setString(7, "L");
        dbManeger.DMLUpdade();


    }

    public int maxPaymentLoan(int customerid, int serial) throws SQLException {
        dbManeger.excuteQuery("select a.paycount from mysql.loan a where customerid=? and a.Serial=? ");
        dbManeger.setInt(1, customerid);
        dbManeger.setInt(2, serial);
        return Integer.parseInt(dbManeger.executeResults(1).toString());
    }


    public ArrayList<LoanTable> paymentTable(int customerId, int serial) {

        dbManeger.excuteQuery("select a.customerid,a.Serial,a.paynumber,a.ghestamount,a.aslamount,a.sudamount,a.paystate,a.Sarresidghest from\n" +
                "  mysql.loanpaytables a where a.customerid=? and a.Serial=? ");
        dbManeger.setInt(1, customerId);
        dbManeger.setInt(2, serial);

        ResultSet resultSet = null;
        try {
            resultSet = dbManeger.executeQuery2();
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        ArrayList<LoanTable> loanTables = new ArrayList<>();
        while (true) {
            try {
                if (!resultSet.next()) break;
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            LoanTable loanTable = null;
            try {
                loanTable = new LoanTable(resultSet.getInt("customerId"),
                        resultSet.getInt("serial"),
                        resultSet.getInt("paynumber"),
                        resultSet.getFloat("ghestamount"),
                        resultSet.getFloat("aslamount"),
                        resultSet.getFloat("sudamount"),
                        resultSet.getInt("paystate"),
                        resultSet.getDate("Sarresidghest"));
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            loanTables.add(loanTable);
        }
        return loanTables;
    }


    public ArrayList<LoanTable> getPaymentTable(int customerId, int serial) {

        dbManeger.excuteQuery("select a.customerid,a.Serial,a.paynumber,a.ghestamount,a.aslamount,a.sudamount,a.paystate,a.Sarresidghest from\n" +
                "  mysql.loanpaytables a where a.paystate=1 and a.customerid=? and a.Serial=? ");
        dbManeger.setInt(1, customerId);
        dbManeger.setInt(2, serial);

        ResultSet resultSet = null;
        try {
            resultSet = dbManeger.executeQuery2();
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        ArrayList<LoanTable> loanTables = new ArrayList<>();
        while (true) {
            try {
                if (!resultSet.next()) break;
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            LoanTable loanTable = null;
            try {
                loanTable = new LoanTable(resultSet.getInt("customerId"),
                        resultSet.getInt("serial"),
                        resultSet.getInt("paynumber"),
                        resultSet.getFloat("ghestamount"),
                        resultSet.getFloat("aslamount"),
                        resultSet.getFloat("sudamount"),
                        resultSet.getInt("paystate"),
                        resultSet.getDate("Sarresidghest"));
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            loanTables.add(loanTable);
        }
        return loanTables;
    }


    public float getUnPaymentLoanAmount(int customerId, int serial, int begin, int end) {
        dbManeger.excuteQuery("select sum(a.ghestamount) from mysql.loanpaytables a where a.paystate=1 and a.customerid=? and a.Serial=? and a.paynumber between ? and ?");
        dbManeger.setInt(1, customerId);
        dbManeger.setInt(2, serial);
        dbManeger.setInt(3, begin);
        dbManeger.setInt(4, end);
        try {
            return Float.parseFloat(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return 0;
    }

    public float getProfitReport() {
        dbManeger.excuteQuery("select sum(a.sudamount) from mysql.loanpaytables a where a.paystate=0");
        try {
            return Float.parseFloat(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return 0;
    }

    public boolean findLoan(int customerId) {
        dbManeger.excuteQuery("select * from mysql.loan a where a.customerid=?");
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

    public boolean findLoan2(int customerId, int serial) {
        dbManeger.excuteQuery("select * from mysql.loan a where a.customerid=? and serial=?");
        dbManeger.setInt(1, customerId);
        dbManeger.setInt(2, serial);
        try {
            if (Integer.parseInt(dbManeger.executeResults(1).toString()) != 0) {
                return true;
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return false;

    }


}


