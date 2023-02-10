package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.gui.GuiManger;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class GuiCustomerModual {

    CustomerManeger customerManeger=new CustomerManeger();

    public static class CustomerFrame extends JFrame implements ActionListener {

        Container container = getContentPane();
        JButton createRealCustomerButton = new JButton("create Real Customer");
        JButton createOrgCustomerButton = new JButton("create Org Customer");




        public CustomerFrame() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            createRealCustomerButton.setBounds(20, 30, 200, 30);
            createOrgCustomerButton.setBounds(20, 70, 200, 30);


        }

        public void addComponentsToContainer() {
            container.add(createRealCustomerButton);
            container.add(createOrgCustomerButton);

        }

        public void addActionEvent() {
            createRealCustomerButton.addActionListener(this);
            createOrgCustomerButton.addActionListener(this);
        }




        @Override
        public void actionPerformed(ActionEvent e) {
            CustomerManeger customerManeger=new CustomerManeger();
            GuiManger guiManger = new GuiManger();
            //Coding Part of LOGIN button
            if (e.getSource() == createRealCustomerButton) {


            }

        }

    }
}


