package com.coreBanking.gui.report;

import com.coreBanking.gui.cash.GuiCashBoxBalance;
import com.coreBanking.gui.cash.GuiDecreaseCashbox;
import com.coreBanking.gui.cash.GuiIncreaseCashbox;
import com.coreBanking.gui.customer.GuiFindCustomerById;
import com.coreBanking.gui.customer.GuiShowCustomerList;
import com.coreBanking.gui.loan.GuiUpdateLoanRate;
import com.coreBanking.loan.LoanManager;
import com.coreBanking.report.ReportManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.sql.SQLException;

public class GuiTransactioReportFormat {
    public static class TransactioReportFormat extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel fileNameLabel=new JLabel("File Name");
        JTextField fileNameTextField=new JTextField();
        JButton textFormatButton = new JButton("Text Format");
        JButton excelFormatButton = new JButton("Excle Format");





        public TransactioReportFormat() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            fileNameLabel.setBounds(20, 50, 150, 30);
            fileNameTextField.setBounds(150, 50, 150, 30);
            textFormatButton.setBounds(50, 150, 100, 30);
            excelFormatButton.setBounds(170, 150, 100, 30);





        }

        public void addComponentsToContainer() {
            container.add(fileNameLabel);
            container.add(fileNameTextField);
            container.add(textFormatButton);
            container.add(excelFormatButton);


        }

        public void addActionEvent() {
            textFormatButton.addActionListener(this);
            excelFormatButton.addActionListener(this);



        }




        @Override
        public void actionPerformed(ActionEvent e) {
            ReportManager reportManager=new ReportManager();
            String fileName=fileNameTextField.getText();
            if (e.getSource() == textFormatButton) {
                try {
                    reportManager.saveTransaction(fileName);
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
                JOptionPane.showMessageDialog(this,"Opratioen Is Done");

            }

            if (e.getSource() == excelFormatButton) {
                try {
                    reportManager.saveTransactionInExcel(fileName);
                } catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                }
                JOptionPane.showMessageDialog(this,"Opratioen Is Done");

            }



        }

    }
}
