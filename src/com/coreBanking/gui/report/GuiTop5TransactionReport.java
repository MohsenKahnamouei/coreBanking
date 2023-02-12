package com.coreBanking.gui.report;


import com.coreBanking.report.ReportManager;
import com.coreBanking.report.TransactionReport;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class GuiTop5TransactionReport {
    public static class top5TransactionReport extends JFrame implements ActionListener {
        ReportManager reportManager = new ReportManager();
        Container container = getContentPane();


        String[][] data1 = new String[6][8];
        String[] column = {"Transaction Id", "Account", "Amount", "Transaction Name", "Debit/Credit", "Transaction Date", "Transaction Description", "Refrence System",};
        JTable transactionListTable = new JTable(data1, column);
        JScrollPane transactionListScrollPane = new JScrollPane(transactionListTable);


        public top5TransactionReport() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            transactionListTable.setBounds(30, 40, 500, 200);
            transactionListScrollPane.setBounds(30, 40, 800, 500);


        }

        public void addComponentsToContainer() {
            container.add(transactionListScrollPane);


        }

        public void addActionEvent() {
            ArrayList<TransactionReport> transactions = reportManager.top5TransactionReport();
            int row = 0;

            for (TransactionReport transactionReport :
                    transactions) {
                data1[row][0] = String.valueOf(transactionReport.getTransactionId());
                data1[row][1] = transactionReport.getAccount();
                data1[row][2] = String.valueOf(transactionReport.getAmount());
                data1[row][3] = transactionReport.getTrnname();
                data1[row][4] = transactionReport.getDrcrtyp();
                data1[row][5] = String.valueOf(transactionReport.getTrndate());
                data1[row][6] = transactionReport.getTrndesc();
                data1[row][7] = transactionReport.getRefsystem();


                row += 1;
            }

            JTable transactionListTable = new JTable(data1, column);
            JScrollPane transactionListScrollPane = new JScrollPane(transactionListTable);
        }


        @Override
        public void actionPerformed(ActionEvent e) {


        }
    }
}
