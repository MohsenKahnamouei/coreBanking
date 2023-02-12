package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.customer.OrgCustomer;
import com.coreBanking.exception.CustomerNotFoundException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

public class GuiEditOrgCustomer {
    public static class EditOrgCustomerById extends JFrame implements ActionListener {

        Container container = getContentPane();

        JButton serchButtom = new JButton("search");
        JLabel serchLabel = new JLabel("Customer Number: ");
        JTextField serchNumberTextField = new JTextField();


        public EditOrgCustomerById() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            serchLabel.setBounds(40, 150, 120, 30);
            serchNumberTextField.setBounds(170, 150, 150, 30);
            serchButtom.setBounds(150, 300, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(serchButtom);
            container.add(serchLabel);
            container.add(serchNumberTextField);


        }

        public void addActionEvent() {
            serchButtom.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            CustomerManeger customerManeger = new CustomerManeger();
            GuiEditOrgCustomerInfForm.EditOrgCustomerForm editOrgCustomerForm =
                    new GuiEditOrgCustomerInfForm.EditOrgCustomerForm();
            ArrayList<OrgCustomer> list = new ArrayList<>();


            if (e.getSource() == serchButtom) {
                String customerid = serchNumberTextField.getText();
                try {

                    if (customerManeger.findOrgCustomerById2(Integer.parseInt(customerid))) {
                        list.add(customerManeger.findOrgCustomerById(Integer.parseInt(customerid)));
                        editOrgCustomerForm.idTextField.setText(String.valueOf(list.get(0).getId()));
                        editOrgCustomerForm.fullnameTextField.setText(list.get(0).getFullName());
                        editOrgCustomerForm.shomaresabtTextField.setText(list.get(0).getShomareSabt());
                        editOrgCustomerForm.addressTextField.setText(list.get(0).getAddress());
                        editOrgCustomerForm.setTitle("Find Customer");
                        editOrgCustomerForm.setVisible(true);
                        editOrgCustomerForm.setBounds(10, 10, 370, 600);
                        editOrgCustomerForm.setResizable(false);
                    }


                } catch (CustomerNotFoundException | NumberFormatException  customerNotFoundException) {
                    JOptionPane.showMessageDialog(this, "Customer Number Is not Correct");
                }


            }

        }


    }
}
