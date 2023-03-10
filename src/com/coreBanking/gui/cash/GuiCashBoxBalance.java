package com.coreBanking.gui.cash;

import com.coreBanking.cash.CashManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiCashBoxBalance {
    public static class cashBoxBalance extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel cashIdLable = new JLabel("CashBox Id ");
        JTextField cashIdTextField = new JTextField();
        JButton acceptButton = new JButton("Do It");

        public cashBoxBalance() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            cashIdLable.setBounds(50, 50, 130, 30);
            cashIdTextField.setBounds(150, 50, 130, 30);

            acceptButton.setBounds(135, 350, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(cashIdLable);
            container.add(cashIdTextField);
            container.add(acceptButton);
        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            CashManager cashManager = new CashManager();
            String cashId = cashIdTextField.getText();
            try {
                if (cashManager.findCashId(Integer.parseInt(cashId))) {
                    float balance = cashManager.getcashIdBalance(Integer.parseInt(cashId));
                    JOptionPane.showMessageDialog(this, balance);
                } else {
                    JOptionPane.showMessageDialog(this, "Cash Id Is Not Correct");
                }
            } catch (NumberFormatException numberFormatException) {
                JOptionPane.showMessageDialog(this, "Cash Id Is Not Correct");
            }

        }
    }
}
