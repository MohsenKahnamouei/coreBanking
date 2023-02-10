package com.coreBanking.loan;

import com.coreBanking.amortization.AmortizationManager;
import com.coreBanking.cash.CashManager;
import com.coreBanking.deposit.DepositManager;
import com.coreBanking.orgFandamental.OrgFandamental;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

public class LoanManager {
    LoanDb loandb = new LoanDb();
    DepositManager depositManager = new DepositManager();
    AmortizationManager amortizationManager = new AmortizationManager();
    OrgFandamental orgFandamental = new OrgFandamental();
    CashManager cashManager=new CashManager();


    public void createLoanForCustomer(int customerId, float amountLoan,
                                      int payCount, String depnum) throws SQLException {


        int serial = loandb.getLoanSerial(customerId);
        int now = Calendar.getInstance().get(6);
        int currencyId = 1;
        float profitRate = Float.parseFloat(loandb.getLoanRate().toString());
        float amountProfit = amortizationManager.calculateTotalProfitAmount(amountLoan, profitRate, payCount);
        float ghestAmount = amortizationManager.calucaltePeymentAmount(amountLoan, payCount, profitRate);

        try {
            loandb.createLoan(customerId, serial, amountLoan, amountProfit, payCount, profitRate, 1);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }


        depositManager.creditDepositBalance(depnum, (long) amountLoan);


        for (int i = 0; i < payCount; i++) {

            float profitAmount = amortizationManager.calculateHideProfitPeyment(amountLoan, profitRate, payCount).get(i);
            float aslamount = ghestAmount - profitAmount;

            loandb.createLoanTable(currencyId, serial, i + 1
                    , ghestAmount, aslamount, profitAmount,
                    orgFandamental.CurrentDateTimeExample2(now + ((i + 1) * 30)));

        }


    }

    public void updateLoanRate(int rate){
        try {
            loandb.updateLoanRate(rate);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
    }


    public void getPeyment(int customerId,int serial,int payNumberAz,int payNumberTa,String depnum,float amount){
        try {
            loandb.getPeyment(customerId,serial,payNumberAz,payNumberTa,amount);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }

        try {
            depositManager.debitDepositBalance(depnum,amount);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }

        try {
            cashManager.increaseCashBalance(1,amount);
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }


    }

    public ArrayList<LoanTable> showLoanList(int customer,int serial) {

            return loandb.paymentTable(customer,serial);

    }

    public ArrayList<LoanTable> showLoanListForGetPayment(int customer,int serial) {

        return loandb.getPaymentTable(customer,serial);

    }

    public float getUnPaymentLoanAmount(int customerId,int serial,int begin,int end){
        return loandb.getUnPaymentLoanAmount(customerId,serial,begin,end);
    }

    public float getProfitReport(){
        return loandb.getProfitReport();
    }



}
