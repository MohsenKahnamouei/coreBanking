package com.coreBanking.gui.deposit;

import com.coreBanking.deposit.DepositManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiCreditDeposit {
    public static class CreditDeposit extends JFrame implements ActionListener {
        DepositManager depositManager = new DepositManager();

        Container container = getContentPane();
        JLabel depnumLable = new JLabel("Deposit Number ");
        JLabel amountLable = new JLabel("Amount ");

        JTextField depnumTextField = new JTextField();
        JTextField amountTextField = new JTextField();

        JButton acceptButton = new JButton("Do It");

        public CreditDeposit() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            depnumLable.setBounds(50, 100, 150, 30);
            depnumTextField.setBounds(150, 100, 150, 30);

            amountLable.setBounds(50, 150, 150, 30);
            amountTextField.setBounds(150, 150, 150, 30);


            acceptButton.setBounds(100, 250, 150, 30);


        }

        public void addComponentsToContainer() {
            container.add(depnumLable);
            container.add(depnumTextField);
            container.add(amountLable);
            container.add(amountTextField);
            container.add(acceptButton);

        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            String depnum, amount;
            depnum = depnumTextField.getText();
            amount = amountTextField.getText();

            try {
                if (depositManager.findDep1(depnum)) {
                    depositManager.creditDepositBalance(depnum, Long.parseLong(amount));
                    JOptionPane.showMessageDialog(this, "Opration is successfull");
                } else {
                    JOptionPane.showMessageDialog(this, "DEposit Not Exists");
                }
            } catch (NumberFormatException numberFormatException) {
                JOptionPane.showMessageDialog(this, "Input Number Is Not Correct");
            }

        }
    }
}
