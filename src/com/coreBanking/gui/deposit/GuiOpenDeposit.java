package com.coreBanking.gui.deposit;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.deposit.DepositManager;
import com.coreBanking.exception.CustomerNotFoundException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

public class GuiOpenDeposit {
    public static class OpenDeposit extends JFrame implements ActionListener {
        CustomerManeger customerManeger = new CustomerManeger();
        DepositManager depositManager = new DepositManager();
        Container container = getContentPane();

        JLabel customerNumberLabel = new JLabel("Customer Number");
        JLabel currencyLabel = new JLabel("Currency");
        JLabel depositNumberLabel = new JLabel("Deposit number");
        JLabel depositTitleLabel = new JLabel("Deposit Title");
        JLabel depositTypeLabel = new JLabel("Deposit Type");
        JTextField customerNumberTextField = new JTextField();
        JTextField depositNumberTextField = new JTextField();
        JTextField depositTitleTextField = new JTextField();
        JCheckBox currencyCheckBox1 = new JCheckBox("ریال");
        JCheckBox currencyCheckBox2 = new JCheckBox("دلار");
        JCheckBox depositTypeCheckBox1 = new JCheckBox("جاری");
        JCheckBox depositTypeCheckBox2 = new JCheckBox("قرض الحسنه");
        JCheckBox depositTypeCheckBox3 = new JCheckBox("کوتاه مدت");
        JCheckBox depositTypeCheckBox4 = new JCheckBox("بلند مدت");
        JCheckBox depositTypeCheckBox5 = new JCheckBox("کئتاه مدت ویژه");


        JButton DoItButton = new JButton("Do It");


        public OpenDeposit() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }


        public void setLocationAndSize() {
            customerNumberLabel.setBounds(30, 35, 150, 30);
            customerNumberTextField.setBounds(150, 35, 150, 30);
            currencyLabel.setBounds(30, 70, 100, 30);
            currencyCheckBox1.setBounds(60, 100, 100, 30);
            currencyCheckBox2.setBounds(170, 100, 100, 30);
            depositNumberLabel.setBounds(30, 135, 100, 30);
            depositNumberTextField.setBounds(150, 135, 150, 30);
            depositTitleLabel.setBounds(30, 170, 150, 30);
            depositTitleTextField.setBounds(150, 170, 150, 30);
            depositTypeLabel.setBounds(30, 205, 150, 30);
            depositTypeCheckBox1.setBounds(60, 235, 70, 30);
            depositTypeCheckBox2.setBounds(170, 235, 150, 30);
            depositTypeCheckBox3.setBounds(60, 265, 70, 30);
            depositTypeCheckBox4.setBounds(170, 265, 70, 30);
            depositTypeCheckBox5.setBounds(60, 295, 150, 30);
            DoItButton.setBounds(135, 400, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(customerNumberLabel);
            container.add(customerNumberTextField);
            container.add(currencyLabel);
            container.add(currencyCheckBox1);
            container.add(currencyCheckBox2);
            container.add(depositNumberLabel);
            container.add(depositNumberTextField);
            container.add(depositTitleLabel);
            container.add(depositTitleTextField);
            container.add(depositTypeLabel);
            container.add(depositTypeCheckBox1);
            container.add(depositTypeCheckBox2);
            container.add(depositTypeCheckBox3);
            container.add(depositTypeCheckBox4);
            container.add(depositTypeCheckBox5);
            container.add(DoItButton);


        }

        public void addActionEvent() {
            DoItButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {

            String customerNumber, depositNumber, depositTitle;
            Object deposit = null;
            customerNumber = customerNumberTextField.getText();
            depositNumber = depositNumberTextField.getText();
            depositTitle = depositTitleTextField.getText();
            try {
                if (customerManeger.findRealCustomerById2(Integer.parseInt(customerNumber))) {
                    if (currencyCheckBox1.isSelected()) {
                        if (depositTypeCheckBox1.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 1, 1);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 1, Long.valueOf(0), depnum, depositTitle, 1);
                        }
                        if (depositTypeCheckBox2.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 2, 1);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 1, Long.valueOf(0), depnum, depositTitle, 2);
                        }
                        if (depositTypeCheckBox3.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 3, 1);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 1, Long.valueOf(0), depnum, depositTitle, 3);
                        }
                        if (depositTypeCheckBox4.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 4, 1);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 1, Long.valueOf(0), depnum, depositTitle, 4);
                        }
                        if (depositTypeCheckBox5.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 5, 1);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 1, Long.valueOf(0), depnum, depositTitle, 5);
                        }
                        JOptionPane.showMessageDialog(this, "Deposit Open");
                        JOptionPane.showMessageDialog(this, deposit);
                    }
                    if (currencyCheckBox2.isSelected()) {
                        if (depositTypeCheckBox1.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 1, 2);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 2, Long.valueOf(0), depnum, depositTitle, 1);
                        }
                        if (depositTypeCheckBox2.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 2, 2);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 2, Long.valueOf(0), depnum, depositTitle, 2);
                        }
                        if (depositTypeCheckBox3.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 3, 2);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 2, Long.valueOf(0), depnum, depositTitle, 3);
                        }
                        if (depositTypeCheckBox4.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 4, 2);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 2, Long.valueOf(0), depnum, depositTitle, 4);
                        }
                        if (depositTypeCheckBox5.isSelected()) {
                            String depnum = depositManager.createDepositNumber(depositNumber, 5, 2);
                            deposit = depositManager.openDeposit(
                                    Integer.parseInt(customerNumber), 2, Long.valueOf(0), depnum, depositTitle, 5);
                        }
                        if ((depositTypeCheckBox1.isSelected() && depositTypeCheckBox2.isSelected()) ||
                                (depositTypeCheckBox1.isSelected() && depositTypeCheckBox3.isSelected()) ||
                                (depositTypeCheckBox1.isSelected() && depositTypeCheckBox4.isSelected()) ||
                                (depositTypeCheckBox1.isSelected() && depositTypeCheckBox5.isSelected())
                        ) {
                            JOptionPane.showMessageDialog(this, "Please Choose One Depoit Type");
                        }
                        JOptionPane.showMessageDialog(this, " Open Successfull");
                        JOptionPane.showMessageDialog(this, deposit);

                    }
                    if (currencyCheckBox1.isSelected() && currencyCheckBox2.isSelected()) {
                        JOptionPane.showMessageDialog(this, "Please Choose One Currency");
                    }

                }

            } catch (CustomerNotFoundException | NumberFormatException | SQLIntegrityConstraintViolationException customerNotFoundException) {
                JOptionPane.showMessageDialog(this, "Customer Number Is Wrong");
            }


        }
    }
}
