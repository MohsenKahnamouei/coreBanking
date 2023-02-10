package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiEditCustomerById {
    public static class EditCustomerById extends JFrame implements ActionListener {

        Container container = getContentPane();

        JButton editRealCustomerButtom = new JButton("Edit Real Customer");
        JButton editOrgCustomerButtom = new JButton("Edit Org Customer");





        public EditCustomerById() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            editRealCustomerButtom.setBounds(20, 30, 200, 30);
            editOrgCustomerButtom.setBounds(20, 70, 200, 30);


        }

        public void addComponentsToContainer() {
            container.add(editRealCustomerButtom);
            container.add(editOrgCustomerButtom);


        }

        public void addActionEvent() {
            editRealCustomerButtom.addActionListener(this);
            editOrgCustomerButtom.addActionListener(this);

        }




        @Override
        public void actionPerformed(ActionEvent e) {
            CustomerManeger customerManeger=new CustomerManeger();

            if (e.getSource() == editRealCustomerButtom) {
                GuiEditRealCustomer.EditRealCustomerById editRealCustomerById=new GuiEditRealCustomer.EditRealCustomerById();
                editRealCustomerById.setTitle("Find Customer");
                editRealCustomerById.setVisible(true);
                editRealCustomerById.setBounds(10, 10, 370, 600);
                editRealCustomerById.setResizable(false);


            }
            if (e.getSource() == editOrgCustomerButtom) {
                GuiEditOrgCustomer.EditOrgCustomerById editOrgCustomerById=new GuiEditOrgCustomer.EditOrgCustomerById();
                editOrgCustomerById.setTitle("Find Customer");
                editOrgCustomerById.setVisible(true);
                editOrgCustomerById.setBounds(10, 10, 370, 600);
                editOrgCustomerById.setResizable(false);


            }


        }

    }
}
