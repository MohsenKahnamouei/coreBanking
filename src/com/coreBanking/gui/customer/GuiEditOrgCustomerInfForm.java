package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.exception.SQLIntegrityConstraintViolationException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class GuiEditOrgCustomerInfForm {
    public static class EditOrgCustomerForm extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel fullnameLabel = new JLabel("Full Name");
        JLabel shomaresabtLabel = new JLabel("Shomare Sabt");
        JLabel addressLabel = new JLabel("Address");
        JLabel idLabel = new JLabel("Customer Number");
        JTextField fullnameTextField = new JTextField();
        JTextField shomaresabtTextField = new JTextField();
        JTextField addressTextField = new JTextField();
        JTextField idTextField = new JTextField();
        JButton DoItButton = new JButton("Do It");


        public EditOrgCustomerForm() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            fullnameLabel.setBounds(50, 150, 100, 30);
            shomaresabtLabel.setBounds(50, 190, 100, 30);
            addressLabel.setBounds(50, 230, 100, 30);
            idLabel.setBounds(50, 270, 100, 30);
            fullnameTextField.setBounds(150, 150, 100, 30);
            shomaresabtTextField.setBounds(150, 190, 100, 30);
            addressTextField.setBounds(150, 230, 100, 30);
            idTextField.setBounds(150, 270, 100, 30);
            DoItButton.setBounds(135, 380, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(fullnameLabel);
            container.add(shomaresabtLabel);
            container.add(addressLabel);
            container.add(fullnameTextField);
            container.add(shomaresabtTextField);
            container.add(addressTextField);
            container.add(DoItButton);
            container.add(idLabel);
            container.add(idTextField);


        }

        public void addActionEvent() {
            DoItButton.addActionListener(this);


        }


        @Override
        public void actionPerformed(ActionEvent e) {
            String fullname, shomaresabt, address;
            String id;
            GuiEditOrgCustomer.EditOrgCustomerById editOrgCustomerById = new GuiEditOrgCustomer.EditOrgCustomerById();
            CustomerManeger customerManeger = new CustomerManeger();
            if (e.getSource() == DoItButton) {
                id = idTextField.getText();
                fullname = fullnameTextField.getText();
                shomaresabt = shomaresabtTextField.getText();
                address = addressTextField.getText();
                try {
                    customerManeger.editOrgCustomer(Integer.parseInt(id), address, fullname, shomaresabt);
                } catch (SQLIntegrityConstraintViolationException | SQLException sqlIntegrityConstraintViolationException) {
                    JOptionPane.showMessageDialog(this, "This data Exist In Data Base,Opration Faild");
                }
                JOptionPane.showMessageDialog(this, "Opration Is Done");


            }


        }


    }
}
