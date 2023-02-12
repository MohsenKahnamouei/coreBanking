package com.coreBanking.gui.loan;

import com.coreBanking.loan.LoanManager;
import com.coreBanking.loan.LoanTable;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class GuiGetPaymentForm {
    public static class showLoanPaymentForm extends JFrame implements ActionListener {
        Container container = getContentPane();
        LoanManager loanManager = new LoanManager();
        String depositNumber;
        int customerId, serial;
        int end;
        String[][] data1;
        JTable LoanListTable;
        JScrollPane LoanListScrollPane;
        JLabel choose1labale = new JLabel("دریافت از قسط شماره :");
        JTextField choose1TextFeild = new JTextField();
        JLabel choose2labale = new JLabel("تا قسط شماره:");
        JTextField choose2TextFeild = new JTextField();
        JButton acceptButtom = new JButton("Do IT");


        String[] column = {"Customer Id", "Serial", "Payment Number", "Ghest Amount", "Main amount", "Profit Amount", "Payment State", "SarResid"};


        public showLoanPaymentForm(int customerId, int serial, String depositNum) {
            ArrayList<LoanTable> loanTables = loanManager.showLoanListForGetPayment(customerId, serial);
            this.end = loanTables.size();
            this.data1 = new String[end + 1][9];
            this.LoanListTable = new JTable(data1, column);
            this.LoanListScrollPane = new JScrollPane(LoanListTable);
            this.customerId = customerId;
            this.serial = serial;
            this.depositNumber = depositNum;


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
            choose1labale.setBounds(600, 500, 150, 150);
            choose1TextFeild.setBounds(470, 560, 100, 30);
            choose2labale.setBounds(350, 500, 150, 150);
            choose2TextFeild.setBounds(230, 560, 100, 30);
            acceptButtom.setBounds(400, 700, 100, 50);


        }

        public void addComponentsToContainer() {
            container.add(LoanListScrollPane);
            container.add(choose1labale);
            container.add(choose1TextFeild);
            container.add(choose2labale);
            container.add(choose2TextFeild);
            container.add(acceptButtom);


        }

        public void addActionEvent() {
            ArrayList<LoanTable> loanTables = loanManager.showLoanListForGetPayment(customerId, serial);


            int row = 0;
            for (LoanTable loanTable :
                    loanTables) {
                data1[row][0] = String.valueOf(loanTable.getCustid());
                data1[row][1] = String.valueOf(loanTable.getLoanSerial());
                data1[row][2] = String.valueOf(loanTable.getPaynum());
                data1[row][3] = String.valueOf(loanTable.getGhestamount());
                data1[row][4] = String.valueOf(loanTable.getAslamount());
                data1[row][5] = String.valueOf(loanTable.getSudamount());
                data1[row][6] = String.valueOf(loanTable.getPaystate());
                data1[row][7] = String.valueOf(loanTable.getSarresidghest());


                row += 1;
            }

            JTable LoanListTable = new JTable(data1, column);
            JScrollPane LoanListScrollPane = new JScrollPane(LoanListTable);
            acceptButtom.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            String ghestAz, ghestTa;
            ghestAz = choose1TextFeild.getText();
            ghestTa = choose2TextFeild.getText();

            if (e.getSource() == acceptButtom) {
                try {
                    float sumGetPayment = loanManager.getUnPaymentLoanAmount(customerId, serial, Integer.parseInt(ghestAz), Integer.parseInt(ghestTa));
                    loanManager.getPeyment(customerId, serial, Integer.parseInt(ghestAz), Integer.parseInt(ghestTa), depositNumber, sumGetPayment);
                    JOptionPane.showMessageDialog(this, "Opration IS Done");
                } catch (NumberFormatException numberFormatException) {
                    JOptionPane.showMessageDialog(this, "Input Number Is Not Correct");
                }

            }


        }
    }
}
