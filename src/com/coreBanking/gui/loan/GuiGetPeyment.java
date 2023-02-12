package com.coreBanking.gui.loan;


import com.coreBanking.deposit.DepositManager;
import com.coreBanking.loan.LoanManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiGetPeyment {
    public static class getLoanPayment extends JFrame implements ActionListener {

        Container container = getContentPane();
        LoanManager loanManager = new LoanManager();
        DepositManager depositManager = new DepositManager();

        JLabel customerIdLable = new JLabel("Customer Id");
        JLabel serialLable = new JLabel("Loan serial: ");
        JLabel depNumLable = new JLabel("depnum");
        JTextField customerIdTextField = new JTextField();
        JTextField serialTextField = new JTextField();
        JTextField depNumTextField = new JTextField();

        JButton acceptButton = new JButton("Do It");

        public getLoanPayment() {
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

            depNumLable.setBounds(20, 130, 130, 30);
            depNumTextField.setBounds(150, 130, 130, 30);


            acceptButton.setBounds(135, 350, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(customerIdLable);
            container.add(customerIdTextField);
            container.add(serialLable);
            container.add(serialTextField);
            container.add(depNumLable);
            container.add(depNumTextField);
            container.add(acceptButton);
        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            String customerID, serial, depnum;
            customerID = customerIdTextField.getText();
            serial = serialTextField.getText();
            depnum = depNumTextField.getText();

            if (e.getSource() == acceptButton) {
                try {
                    if (loanManager.findLoan2(Integer.parseInt(customerID), Integer.parseInt(serial))) {
                        if (depositManager.findDep1(depnum)) {
                            GuiGetPaymentForm.showLoanPaymentForm showLoanPaymentForm = new GuiGetPaymentForm.showLoanPaymentForm
                                    (Integer.parseInt(customerID), Integer.parseInt(serial), depnum);
                            showLoanPaymentForm.setTitle("Loan Payment Form");
                            showLoanPaymentForm.setVisible(true);
                            showLoanPaymentForm.setBounds(30, 30, 1000, 1000);
                            showLoanPaymentForm.setResizable(false);
                        } else {
                            JOptionPane.showMessageDialog(this, "Deposit Does Not Exists");
                        }
                    } else {
                        JOptionPane.showMessageDialog(this, "Loan Does Not Exist");
                    }

                } catch (NumberFormatException numberFormatException) {
                    JOptionPane.showMessageDialog(this, "Input Number Is Not Currect");
                }

            }

        }
    }
}
