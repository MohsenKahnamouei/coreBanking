package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.exception.SQLIntegrityConstraintViolationException;
import com.coreBanking.gui.customer.GuiEditRealCustomer;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class GuiEditRealCustomerInfForm {
    public static class EditRealCustomerForm extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel fnameLabel = new JLabel("Firs Name");
        JLabel lnameLabel = new JLabel("Last Name");
        JLabel codemeliLabel = new JLabel("Code meli");
        JLabel addressLabel = new JLabel("Address");
        JLabel idLabel = new JLabel("Customer Number");
        JTextField fnameTextField = new JTextField();
        JTextField lnameTextField = new JTextField();
        JTextField codemeliTextField = new JTextField();
        JTextField addressTextField = new JTextField();
        JTextField idTextField = new JTextField();
        JButton DoItButton = new JButton("Do It");



        public EditRealCustomerForm() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            fnameLabel.setBounds(50, 150, 100, 30);
            lnameLabel.setBounds(50, 190, 100, 30);
            codemeliLabel.setBounds(50, 230, 100, 30);
            addressLabel.setBounds(50, 270, 100, 30);
            idLabel.setBounds(50, 310, 100, 30);
            fnameTextField.setBounds(150, 150, 100, 30);
            lnameTextField.setBounds(150, 190, 100, 30);
            codemeliTextField.setBounds(150, 230, 100, 30);
            addressTextField.setBounds(150, 270, 100, 30);
            idTextField.setBounds(150, 310, 100, 30);
            DoItButton.setBounds(135, 380, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(fnameLabel);
            container.add(lnameLabel);
            container.add(codemeliLabel);
            container.add(addressLabel);
            container.add(fnameTextField);
            container.add(lnameTextField);
            container.add(codemeliTextField);
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
            String fname,lname,codemeli,address;
            String id;
            GuiEditRealCustomer.EditRealCustomerById editRealCustomerById=new GuiEditRealCustomer.EditRealCustomerById();
            CustomerManeger customerManeger=new CustomerManeger();
            if (e.getSource() == DoItButton) {
                id=idTextField.getText();
                fname=fnameTextField.getText();
                lname=lnameTextField.getText();
                codemeli=codemeliTextField.getText();
                address=addressTextField.getText();
                try {
                    customerManeger.editRealCustomer(Integer.parseInt(id),address,fname,lname,codemeli);
                } catch (SQLIntegrityConstraintViolationException | SQLException sqlIntegrityConstraintViolationException) {
                    JOptionPane.showMessageDialog(this, "This data Exist In Data Base,Opration Faild");
                }
                JOptionPane.showMessageDialog(this, "Opration Is Done");



            }


        }


    }
}
