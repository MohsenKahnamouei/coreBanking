package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiCreateOrgCustomer {
    public static class CreateOrgCustomer extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel fullNameLable = new JLabel("Full Name: ");
        JLabel shomareSabtLable = new JLabel("shomareSabt: ");
        JLabel idLable = new JLabel("Customer Number: ");
        JLabel addressLable = new JLabel("Address: ");
        JTextField fullNameTextField = new JTextField();
        JTextField shomareSabtTextField = new JTextField();
        JTextField idTextField = new JTextField();
        JTextField addressTextField = new JTextField();
        JButton acceptButton = new JButton("Accept");

        public CreateOrgCustomer() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            fullNameLable.setBounds(20, 20, 130, 30);
            fullNameTextField.setBounds(150, 20, 130, 30);

            shomareSabtLable.setBounds(20, 80, 130, 30);
            shomareSabtTextField.setBounds(150, 80, 130, 30);

            idLable.setBounds(20, 130, 130, 30);
            idTextField.setBounds(150, 130, 130, 30);

            addressLable.setBounds(20, 190, 130, 30);
            addressTextField.setBounds(150, 190, 130, 30);

            acceptButton.setBounds(135, 350, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(fullNameLable);
            container.add(fullNameTextField);
            container.add(shomareSabtLable);
            container.add(shomareSabtTextField);
            container.add(idLable);
            container.add(idTextField);
            container.add(addressLable);
            container.add(addressTextField);
            container.add(acceptButton);
        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            CustomerManeger customerManeger = new CustomerManeger();
            if (e.getSource() == acceptButton) {
                String fullname, shomaresabt, id, address;
                fullname = fullNameTextField.getText();
                shomaresabt = shomareSabtTextField.getText();
                id = idTextField.getText();
                address = addressTextField.getText();
                try {
                    if (!customerManeger.findCustomerById(Integer.parseInt(id))) {
                        Object customer = customerManeger.createOrgCustomer(Integer.parseInt(id), 1, address, fullname, shomaresabt);
                        JOptionPane.showMessageDialog(this, "Customer Create Successful");
                        JOptionPane.showMessageDialog(this, customer);
                    } else {
                        JOptionPane.showMessageDialog(this, "Customer ID IS Exist");
                    }
                } catch (NumberFormatException numberFormatException) {
                    JOptionPane.showMessageDialog(this, "Number Format Is Not Correct");
                }

            }
        }
    }
}
