package com.coreBanking.gui.loan;


import com.coreBanking.loan.LoanManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;


public class GuiShowLoanDetails {
    public static class showLoanDetails extends JFrame implements ActionListener {
        LoanManager loanManager=new LoanManager();
        Container container = getContentPane();

        JLabel customerIdLable = new JLabel("Customer Id");
        JLabel serialLable = new JLabel("Loan serial");

        JTextField customerIdTextField = new JTextField();
        JTextField serialTextField = new JTextField();

        JButton acceptButton = new JButton("Accept");

        public showLoanDetails() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            customerIdLable.setBounds(20, 20, 130, 30);
            customerIdTextField.setBounds(150, 20, 130, 30);

            serialLable.setBounds(20, 80, 130, 30);
            serialTextField.setBounds(150, 80, 130, 30);

            acceptButton.setBounds(135, 350, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(customerIdLable);
            container.add(customerIdTextField);
            container.add(serialLable);
            container.add(serialTextField);
            container.add(acceptButton);

        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            String customerId, serial;
            customerId = customerIdTextField.getText();
            serial = serialTextField.getText();
            GuiShowLoanPaymentList.showLoanPaymentList showLoanPaymentList= null;
            try {
                showLoanPaymentList = new GuiShowLoanPaymentList.showLoanPaymentList(Integer.parseInt(customerId),Integer.parseInt(serial));
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }


            if (e.getSource() == acceptButton) {

                showLoanPaymentList.setTitle("Loan Payment List");
                showLoanPaymentList.setVisible(true);
                showLoanPaymentList.setBounds(30, 30, 1000, 1000);
                showLoanPaymentList.setResizable(false);

            }
        }
    }
}
