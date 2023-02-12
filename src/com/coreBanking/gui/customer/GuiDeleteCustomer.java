package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.deposit.DepositManager;
import com.coreBanking.loan.LoanManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiDeleteCustomer {

    public static class deletCustomer extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel customerIdLable = new JLabel("Customer Id ");
        JTextField customerTextField = new JTextField();
        JButton acceptButton = new JButton("Do It");

        public deletCustomer() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            customerIdLable.setBounds(50, 50, 130, 30);
            customerTextField.setBounds(150, 50, 130, 30);

            acceptButton.setBounds(135, 350, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(customerIdLable);
            container.add(customerTextField);
            container.add(acceptButton);
        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            CustomerManeger customerManeger = new CustomerManeger();
            DepositManager depositManager = new DepositManager();
            LoanManager loanManager = new LoanManager();

            String customerId = customerTextField.getText();
            try {
                if (customerManeger.findCustomerById(Integer.parseInt(customerId))) {
                    if (!depositManager.findDep(Integer.parseInt(customerId))) {
                        if (!loanManager.findLoan(Integer.parseInt(customerId))) {
                            customerManeger.deleteCustomer(Integer.parseInt(customerId));
                            JOptionPane.showMessageDialog(this, "Opration Is Done");
                        } else {
                            JOptionPane.showMessageDialog(this, "Customer Has Loan");
                        }
                    } else {
                        JOptionPane.showMessageDialog(this, "Customer has Deposit");
                    }
                } else {
                    JOptionPane.showMessageDialog(this, "Customer Has Not Found");

                }
            } catch (NumberFormatException numberFormatException) {
                JOptionPane.showMessageDialog(this, "Customer Id Is Not Correct");
            }
        }
    }
}
