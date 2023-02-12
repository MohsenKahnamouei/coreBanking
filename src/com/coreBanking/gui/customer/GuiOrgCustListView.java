package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.customer.OrgCustomer;
import com.coreBanking.customer.RealCustomer;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

public class GuiOrgCustListView {
    public static class showOrgCustomerList extends JFrame implements ActionListener {
        CustomerManeger customerManeger = new CustomerManeger();
        Container container = getContentPane();
        ArrayList<RealCustomer> customers = customerManeger.showRealCustomerList();

        int end = customers.size();
        String[][] data1 = new String[end + 1][6];
        String[] column = {"Full Name", "Shomare Sabt", "Customer Id", "Customer Type", "Address"};
        JTable orgCustomerListTable = new JTable(data1, column);
        JScrollPane OrgCustomerListScrollPane = new JScrollPane(orgCustomerListTable);


        public showOrgCustomerList() throws SQLException {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            orgCustomerListTable.setBounds(30, 40, 500, 200);
            OrgCustomerListScrollPane.setBounds(30, 40, 800, 500);


        }

        public void addComponentsToContainer() {
            container.add(OrgCustomerListScrollPane);


        }

        public void addActionEvent() {
            ArrayList<OrgCustomer> customerList = null;
            try {
                customerList = customerManeger.showOrgCustomerList();
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            int row = 0;

            for (OrgCustomer customer :
                    customerList) {
                data1[row][0] = customer.getFullName();
                data1[row][1] = customer.getShomareSabt();
                data1[row][2] = String.valueOf(customer.getId());
                data1[row][3] = String.valueOf(customer.getCustomerType());
                data1[row][4] = customer.getAddress();
                row += 1;
            }

            JTable orgCustomerListTable = new JTable(data1, column);
            JScrollPane realCustomerListScrollPane = new JScrollPane(orgCustomerListTable);
        }


        @Override
        public void actionPerformed(ActionEvent e) {


        }
    }
}
