package com.coreBanking.gui.customer;

import com.coreBanking.customer.CustomerManeger;
import com.coreBanking.exception.CustomerNotFoundException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class GuiFindRealCustomer {
    public static class FindRealCustomer extends JFrame implements ActionListener {

        Container container = getContentPane();

        JButton serchButtom = new JButton("search");
        JLabel serchLabel = new JLabel("Customer Number: ");
        JTextField serchNumberTextField = new JTextField();





        public FindRealCustomer() {
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
            CustomerManeger customerManeger=new CustomerManeger();


            if (e.getSource() == serchButtom) {
                String customerid=serchNumberTextField.getText();
                Object customerInf = null;
                try {

                    if (customerManeger.findRealCustomerById2(Integer.parseInt(customerid)))
                        customerInf=customerManeger.findRealCustomerById(Integer.parseInt(customerid));
                        JOptionPane.showMessageDialog(this,customerInf );

                }catch(CustomerNotFoundException | SQLException customerNotFoundException){
                    JOptionPane.showMessageDialog(this,"Customer Number Is not Correct");
                }


            }

        }

    }
}
