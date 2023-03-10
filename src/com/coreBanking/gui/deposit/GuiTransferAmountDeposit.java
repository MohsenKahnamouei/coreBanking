package com.coreBanking.gui.deposit;

import com.coreBanking.deposit.DepositManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiTransferAmountDeposit {
    public static class trasferAmount extends JFrame implements ActionListener {
        DepositManager depositManager = new DepositManager();

        Container container = getContentPane();
        JLabel debitDepnumLable = new JLabel("Debit Deposit Number ");
        JLabel creditDepnumLable = new JLabel("Credit Deposit Number ");
        JLabel amountLable = new JLabel("Amount ");

        JTextField debitDepnumTextField = new JTextField();
        JTextField creditDepnumTextField = new JTextField();
        JTextField amountTextField = new JTextField();

        JButton acceptButton = new JButton("Do It");

        public trasferAmount() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            debitDepnumLable.setBounds(30, 100, 150, 30);
            debitDepnumTextField.setBounds(180, 100, 150, 30);

            creditDepnumLable.setBounds(30, 150, 150, 30);
            creditDepnumTextField.setBounds(180, 150, 150, 30);

            amountLable.setBounds(30, 200, 150, 30);
            amountTextField.setBounds(180, 200, 150, 30);


            acceptButton.setBounds(100, 300, 150, 30);


        }

        public void addComponentsToContainer() {
            container.add(debitDepnumLable);
            container.add(debitDepnumTextField);
            container.add(creditDepnumLable);
            container.add(creditDepnumTextField);
            container.add(amountLable);
            container.add(amountTextField);
            container.add(acceptButton);

        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            String debitDepnum, creditDepnum, amount;
            debitDepnum = debitDepnumTextField.getText();
            creditDepnum = creditDepnumTextField.getText();
            amount = amountTextField.getText();
            try {
                if (depositManager.findDep1(debitDepnum)) {
                    if (depositManager.findDep1(creditDepnum)) {
                        if (depositManager.getDepositBalance(debitDepnum) - Float.parseFloat(amount) >= 0) {
                            depositManager.transferAmount(creditDepnum, debitDepnum, Long.parseLong(amount));
                            JOptionPane.showMessageDialog(this, "Opration is successfull");
                        } else {
                            JOptionPane.showMessageDialog(this, "Debit Deposit Has Not Enogh Balance");
                        }
                    } else {
                        JOptionPane.showMessageDialog(this, "Credit Deposit Is Not Correct");
                    }
                } else {
                    JOptionPane.showMessageDialog(this, "Debit Deposit Is Not Correct");
                }
            } catch (NumberFormatException numberFormatException) {
                JOptionPane.showMessageDialog(this, "Input Number Is Not Correct");
            }

        }
    }
}
