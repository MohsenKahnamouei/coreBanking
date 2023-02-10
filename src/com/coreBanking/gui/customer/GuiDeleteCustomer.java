package com.coreBanking.gui.customer;

import com.coreBanking.cash.CashManager;
import com.coreBanking.customer.CustomerManeger;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

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
            CustomerManeger customerManeger=new CustomerManeger();
            String customerId=customerTextField.getText();
            try {
                boolean accept=customerManeger.deleteCustomer(Integer.parseInt(customerId));
                if (accept){
                    JOptionPane.showMessageDialog(this,"Customer Has Been Deleted");
                }
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
        }
    }
}
