package com.coreBanking.gui.customer;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiFindCustomerById {
    public static class FindCustomerById extends JFrame implements ActionListener {

        Container container = getContentPane();

        JButton findRealCustomerButtom = new JButton("Find Real Customer");
        JButton findOrgCustomerButtom = new JButton("Find Org Customer");


        public FindCustomerById() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            findRealCustomerButtom.setBounds(20, 30, 200, 30);
            findOrgCustomerButtom.setBounds(20, 70, 200, 30);


        }

        public void addComponentsToContainer() {
            container.add(findRealCustomerButtom);
            container.add(findOrgCustomerButtom);


        }

        public void addActionEvent() {
            findRealCustomerButtom.addActionListener(this);
            findOrgCustomerButtom.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {

            if (e.getSource() == findRealCustomerButtom) {
                GuiFindRealCustomer.FindRealCustomer findRealCustomer = new GuiFindRealCustomer.FindRealCustomer();
                findRealCustomer.setTitle("Real Customer Details");
                findRealCustomer.setVisible(true);
                findRealCustomer.setBounds(10, 10, 370, 600);
                findRealCustomer.setResizable(false);

            }
            if (e.getSource() == findOrgCustomerButtom) {
                GuiFindOrgCustomer.FindOrgCustomer findOrgCustomer = new GuiFindOrgCustomer.FindOrgCustomer();
                findOrgCustomer.setTitle("Org Customer Details");
                findOrgCustomer.setVisible(true);
                findOrgCustomer.setBounds(10, 10, 370, 600);
                findOrgCustomer.setResizable(false);


            }


        }

    }
}
