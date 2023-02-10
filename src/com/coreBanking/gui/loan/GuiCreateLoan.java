package com.coreBanking.gui.loan;

import com.coreBanking.cash.CashManager;
import com.coreBanking.loan.LoanManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class GuiCreateLoan {
    public static class createLoan extends JFrame implements ActionListener {

        Container container = getContentPane();

        JLabel customerIdLable = new JLabel("Customer Id");
        JLabel amountLoanLable = new JLabel("Loan Amount");
        JLabel payCountLable = new JLabel("Peyment Count");
        JLabel depNumLable = new JLabel("Deposit Number");
        JTextField customerIdTextField = new JTextField();
        JTextField amountLoanTextField = new JTextField();
        JTextField payCountTextField = new JTextField();
        JTextField depNumTextField = new JTextField();
        JButton acceptButton = new JButton("Do It");

        public createLoan() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            customerIdLable.setBounds(20, 20, 130, 30);
            customerIdTextField.setBounds(150, 20, 130, 30);

            amountLoanLable.setBounds(20, 80, 130, 30);
            amountLoanTextField.setBounds(150, 80, 130, 30);

            payCountLable.setBounds(20, 130, 130, 30);
            payCountTextField.setBounds(150, 130, 130, 30);

            depNumLable.setBounds(20, 190, 130, 30);
            depNumTextField.setBounds(150, 190, 130, 30);

            acceptButton.setBounds(135, 350, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(customerIdLable);
            container.add(customerIdTextField);
            container.add(amountLoanLable);
            container.add(amountLoanTextField);
            container.add(payCountLable);
            container.add(payCountTextField);
            container.add(depNumLable);
            container.add(depNumTextField);
            container.add(acceptButton);
        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            LoanManager loanManager=new LoanManager();
            CashManager cashManager=new CashManager();

            String customerId,amountLoan,payCount,depNum;
            customerId=customerIdTextField.getText();
            amountLoan=amountLoanTextField.getText();
            payCount=payCountTextField.getText();
            depNum=depNumTextField.getText();



            try {
                if (Float.parseFloat(amountLoan)<=cashManager.getcashIdBalance(1)) {
                    loanManager.createLoanForCustomer(Integer.parseInt(customerId), Float.parseFloat(amountLoan), Integer.parseInt(payCount), depNum);
                    JOptionPane.showMessageDialog(this,"Loan Pay To Deposit");
                } else {JOptionPane.showMessageDialog(this,"CashBox Has Not Request Amount");}
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }


        }
    }
}
