package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.customer.RealCustomer;
import com.coreBanking.exception.CustomerNotFoundException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class GuiEditRealCustomer {
    public static class EditRealCustomerById extends JFrame implements ActionListener {

        Container container = getContentPane();

        JButton serchButtom = new JButton("search");
        JLabel serchLabel = new JLabel("Customer Number: ");
        JTextField serchNumberTextField = new JTextField();


        public EditRealCustomerById() {
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
            GuiEditRealCustomerInfForm.EditRealCustomerForm editRealCustomerForm =
                    new GuiEditRealCustomerInfForm.EditRealCustomerForm();
            ArrayList<RealCustomer> list = new ArrayList<>();


            if (e.getSource() == serchButtom) {
                String customerid = serchNumberTextField.getText();
                try {

                    if (customerManeger.findRealCustomerById2(Integer.parseInt(customerid))) {
                        list.add(customerManeger.findRealCustomerById(Integer.parseInt(customerid)));
                        editRealCustomerForm.idTextField.setText(String.valueOf(list.get(0).getId()));
                        editRealCustomerForm.fnameTextField.setText(list.get(0).getFname());
                        editRealCustomerForm.lnameTextField.setText(list.get(0).getLname());
                        editRealCustomerForm.codemeliTextField.setText(list.get(0).getCodemeli());
                        editRealCustomerForm.addressTextField.setText(list.get(0).getAddress());
                        editRealCustomerForm.setTitle("Find Customer");
                        editRealCustomerForm.setVisible(true);
                        editRealCustomerForm.setBounds(10, 10, 370, 600);
                        editRealCustomerForm.setResizable(false);
                    }


                } catch (CustomerNotFoundException | NumberFormatException customerNotFoundException) {
                    JOptionPane.showMessageDialog(this, "Customer Number Is not Correct");
                }


            }

        }


    }


}



