package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.customer.RealCustomer;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

public class GuiRealCustListview {
    public static class showRealCustomerList extends JFrame implements ActionListener {
        CustomerManeger customerManeger = new CustomerManeger();
        Container container = getContentPane();
        ArrayList<RealCustomer> customers = customerManeger.showRealCustomerList();


        int end = customers.size();
        String[][] data1 = new String[end + 1][6];
        String[] column = {"First Name", "Last Name", "Code Meli", "Customer Type", "Cystomer Id", "Address"};
        JTable realCustomerListTable = new JTable(data1, column);
        JScrollPane realCustomerListScrollPane = new JScrollPane(realCustomerListTable);


        public showRealCustomerList() throws SQLException {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            realCustomerListTable.setBounds(30, 40, 500, 200);
            realCustomerListScrollPane.setBounds(30, 40, 800, 500);


        }

        public void addComponentsToContainer() {
            container.add(realCustomerListScrollPane);


        }

        public void addActionEvent() {
            ArrayList<RealCustomer> customerList = null;
            try {
                customerList = customerManeger.showRealCustomerList();
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            int row = 0;

            for (RealCustomer customer :
                    customerList) {
                data1[row][0] = customer.getFname();
                data1[row][1] = customer.getLname();
                data1[row][2] = customer.getCodemeli();
                data1[row][3] = String.valueOf(customer.getCustomerType());
                data1[row][4] = String.valueOf(customer.getId());
                data1[row][5] = customer.getAddress();

                row += 1;
            }

            JTable realCustomerListTable = new JTable(data1, column);
            JScrollPane realCustomerListScrollPane = new JScrollPane(realCustomerListTable);
        }


        @Override
        public void actionPerformed(ActionEvent e) {


        }
    }
}

