package com.coreBanking.gui.customer;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class GuiShowCustomerList {
    public static class showCustomerList extends JFrame implements ActionListener {

        Container container = getContentPane();
        JButton realCustomerListViewButton = new JButton("Real Customer List View");
        JButton orgCustomerListViewButton = new JButton("Org Customer List View");


        public showCustomerList() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            realCustomerListViewButton.setBounds(20, 30, 200, 30);
            orgCustomerListViewButton.setBounds(20, 80, 200, 30);


        }

        public void addComponentsToContainer() {
            container.add(realCustomerListViewButton);
            container.add(orgCustomerListViewButton);


        }

        public void addActionEvent() {
            realCustomerListViewButton.addActionListener(this);
            orgCustomerListViewButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            if (e.getSource() == realCustomerListViewButton) {
                GuiRealCustListview.showRealCustomerList showRealCustomerList = null;
                try {
                    showRealCustomerList = new GuiRealCustListview.showRealCustomerList();
                } catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                }

                showRealCustomerList.setTitle("Real Customer List");
                showRealCustomerList.setVisible(true);
                showRealCustomerList.setBounds(30, 30, 1000, 1000);


            }

            if (e.getSource() == orgCustomerListViewButton) {
                GuiOrgCustListView.showOrgCustomerList showOrgCustomerList = null;
                try {
                    showOrgCustomerList = new GuiOrgCustListView.showOrgCustomerList();
                } catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                }
                showOrgCustomerList.setTitle("Org Customer List");
                showOrgCustomerList.setVisible(true);
                showOrgCustomerList.setBounds(30, 30, 1000, 1000);


            }

        }

    }
}
