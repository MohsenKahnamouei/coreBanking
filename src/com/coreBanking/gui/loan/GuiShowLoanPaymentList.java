package com.coreBanking.gui.loan;

import com.coreBanking.loan.LoanManager;
import com.coreBanking.loan.LoanTable;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

public class GuiShowLoanPaymentList {
    public static class showLoanPaymentList  extends JFrame implements ActionListener {
        Container container = getContentPane();
        LoanManager loanManager=new LoanManager();
        int customerId,serial;
        int end;
        String[][] data1;
        JTable LoanListTable;
        JScrollPane LoanListScrollPane;


       String[] column = {"Customer Id", "Serial", "Payment Number", "Ghest Amount", "Main amount", "Profit Amount","Payment State","SarResid"};


        public showLoanPaymentList(int customerId,int serial) throws SQLException {
            ArrayList<LoanTable> loanTables =loanTables = loanManager.showLoanList(customerId,serial);
            this.end = loanTables.size();
            this.data1 = new String[end+1][8];
            this.LoanListTable = new JTable(data1,column);
            this.LoanListScrollPane = new JScrollPane(LoanListTable);
            this.customerId=customerId;
            this.serial=serial;


            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();


        }

        public void setLayoutManager() {
            container.setLayout(null);

        }

        public void setLocationAndSize() {
            LoanListTable.setBounds(30, 40, 500, 200);
            LoanListScrollPane.setBounds(30, 40, 800, 500);




        }

        public void addComponentsToContainer() {
            container.add(LoanListScrollPane);





        }

        public void addActionEvent() {
            ArrayList<LoanTable> loanTables =loanManager.showLoanList(customerId,serial);


            int row = 0;
            for (LoanTable loanTable:
                    loanTables) {
                data1[row][0] = String.valueOf(loanTable.getCustid());
                data1[row][1] = String.valueOf(loanTable.getLoanSerial());
                data1[row][2] = String.valueOf(loanTable.getPaynum());
                data1[row][3] = String.valueOf(loanTable.getGhestamount());
                data1[row][4] = String.valueOf(loanTable.getAslamount());
                data1[row][5] = String.valueOf(loanTable.getSudamount());
                data1[row][6] = String.valueOf(loanTable.getPaystate());
                data1[row][7] = String.valueOf(loanTable.getSarresidghest());


                row+=1;
            }

            JTable LoanListTable = new JTable(data1,column);
            JScrollPane LoanListScrollPane = new JScrollPane(LoanListTable);
        }




        @Override
        public void actionPerformed(ActionEvent e) {


        }
    }
}
