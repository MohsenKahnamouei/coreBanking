package com.coreBanking.gui.cash;

import com.coreBanking.cash.CashManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class GuiDecreaseCashbox {
    public static class DecreaseCashbox extends JFrame implements ActionListener {
        CashManager cashManager=new CashManager();

        Container container = getContentPane();
        JLabel cashIdLable = new JLabel("Cash Id ");
        JLabel amountLable = new JLabel("Amount ");
        JTextField cashIdTextField = new JTextField();
        JTextField amountTextField = new JTextField();
        JButton DoItButton = new JButton("Do It");




        public DecreaseCashbox() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            cashIdLable.setBounds(50, 100, 150, 30);
            cashIdTextField.setBounds(120, 100, 150, 30);
            amountLable.setBounds(50, 150, 150, 30);
            amountTextField.setBounds(120, 150, 150, 30);
            DoItButton.setBounds(120, 250, 150, 30);



        }

        public void addComponentsToContainer() {
            container.add(cashIdLable);
            container.add(cashIdTextField);
            container.add(amountLable);
            container.add(amountTextField);
            container.add(DoItButton);


        }

        public void addActionEvent() {

            DoItButton.addActionListener(this);


        }




        @Override
        public void actionPerformed(ActionEvent e) {
            String cashId,amount;
            float newBalance = Float.parseFloat(null);
            if (e.getSource() == DoItButton) {
                cashId=cashIdTextField.getText();
                amount=amountTextField.getText();
                try {
                    cashManager.decreaseCashBalance(Integer.parseInt(cashId),Float.parseFloat(amount) );
                } catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                }
                try {
                    newBalance=cashManager.getcashIdBalance(Integer.parseInt(cashId));
                } catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                }
                JOptionPane.showMessageDialog(this,newBalance);


            }


        }

    }
}
