package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiCreateRealCustomer {
    public static class CreateRealCustomer extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel fnameLable = new JLabel("First Name: ");
        JLabel lnameLable = new JLabel("Last Name: ");
        JLabel codemeliLable = new JLabel("Code Meli: ");
        JLabel idLable = new JLabel("Customer Number: ");
        JLabel addressLable = new JLabel("Address: ");
        JTextField fnameTextField = new JTextField();
        JTextField lnameTextField = new JTextField();
        JTextField codemeliTextField = new JTextField();
        JTextField idTextField = new JTextField();
        JTextField addressTextField = new JTextField();
        JButton acceptButton = new JButton("Accept");

        public CreateRealCustomer() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            fnameLable.setBounds(20, 20, 130, 30);
            fnameTextField.setBounds(150, 20, 130, 30);

            lnameLable.setBounds(20, 80, 130, 30);
            lnameTextField.setBounds(150, 80, 130, 30);

            codemeliLable.setBounds(20, 140, 130, 30);
            codemeliTextField.setBounds(150, 140, 130, 30);

            idLable.setBounds(20, 200, 130, 30);
            idTextField.setBounds(150, 200, 130, 30);

            addressLable.setBounds(20, 260, 130, 30);
            addressTextField.setBounds(150, 260, 130, 30);

            acceptButton.setBounds(135, 350, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(fnameLable);
            container.add(fnameTextField);
            container.add(lnameLable);
            container.add(lnameTextField);
            container.add(codemeliLable);
            container.add(codemeliTextField);
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
                String fname, lname, codemeli, id, address;
                fname = fnameTextField.getText();
                lname = lnameTextField.getText();
                codemeli = codemeliTextField.getText();
                id = idTextField.getText();
                address = addressTextField.getText();
                Object customer = customerManeger.createRealCustomer(Integer.parseInt(id)
                        , 0, address, fname, lname, codemeli);
                JOptionPane.showMessageDialog(this, "Customer Create Successful");
                JOptionPane.showMessageDialog(this, customer);

            }
        }
    }


}
