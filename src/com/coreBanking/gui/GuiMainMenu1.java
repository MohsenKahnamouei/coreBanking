package com.coreBanking.gui;

import com.coreBanking.gui.cash.GuiCashBoxBalance;
import com.coreBanking.gui.customer.*;
import com.coreBanking.gui.deposit.GuiCreditDeposit;
import com.coreBanking.gui.deposit.GuiDebitDeposit;
import com.coreBanking.gui.deposit.GuiOpenDeposit;
import com.coreBanking.gui.deposit.GuiTransferAmountDeposit;
import com.coreBanking.gui.loan.GuiCreateLoan;
import com.coreBanking.gui.loan.GuiGetPeyment;
import com.coreBanking.gui.loan.GuiShowLoanDetails;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class GuiMainMenu1 {

    public static class MainMenu1 extends JFrame implements ActionListener {

        Container container = getContentPane();
        JButton createRealCustomerButton = new JButton("create Real Customer");
        JButton createOrgCustomerButton = new JButton("create Org Customer");
        JButton customerListViewButton = new JButton("Customer List View");
        JButton FindCustomerByIdButton = new JButton("Find Customer By Id");
        JButton editCustomerByIdButton = new JButton("Edit Customer By Id");
        JButton deleteCustomerByIdButton = new JButton("Delete Customer By Id");
        JButton OpenDepositButton = new JButton("Open Deposit");
        JButton creditDepositButton = new JButton("Credit deposit");
        JButton debitDepositButton = new JButton("Debit Deposit");
        JButton transferAmountButton = new JButton("Transfer Between Two Deposit");
        JButton FindCashBoxBalanceButtom = new JButton("CashBox Balance");
        JButton createLoanButtom = new JButton("Create Loan");
        JButton showPaymentListOfLoan = new JButton("List Of Loan Payment");
        JButton getPaymentButtom = new JButton("Get Loan Peyment");


        public MainMenu1() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            createRealCustomerButton.setBounds(20, 30, 200, 30);
            createOrgCustomerButton.setBounds(20, 60, 200, 30);
            customerListViewButton.setBounds(20, 90, 200, 30);
            FindCustomerByIdButton.setBounds(20, 120, 200, 30);
            editCustomerByIdButton.setBounds(20, 150, 200, 30);
            deleteCustomerByIdButton.setBounds(20, 180, 200, 30);
            OpenDepositButton.setBounds(20, 210, 200, 30);
            creditDepositButton.setBounds(20, 240, 200, 30);
            debitDepositButton.setBounds(20, 270, 200, 30);
            transferAmountButton.setBounds(20, 300, 200, 30);
            FindCashBoxBalanceButtom.setBounds(20, 330, 200, 30);
            createLoanButtom.setBounds(20, 360, 200, 30);
            showPaymentListOfLoan.setBounds(20, 390, 200, 30);
            getPaymentButtom.setBounds(20, 420, 200, 30);


        }

        public void addComponentsToContainer() {
            container.add(createRealCustomerButton);
            container.add(createOrgCustomerButton);
            container.add(customerListViewButton);
            container.add(FindCustomerByIdButton);
            container.add(editCustomerByIdButton);
            container.add(deleteCustomerByIdButton);
            container.add(OpenDepositButton);
            container.add(creditDepositButton);
            container.add(debitDepositButton);
            container.add(transferAmountButton);
            container.add(FindCashBoxBalanceButtom);
            container.add(createLoanButtom);
            container.add(showPaymentListOfLoan);
            container.add(getPaymentButtom);


        }

        public void addActionEvent() {
            createRealCustomerButton.addActionListener(this);
            createOrgCustomerButton.addActionListener(this);
            customerListViewButton.addActionListener(this);
            FindCustomerByIdButton.addActionListener(this);
            editCustomerByIdButton.addActionListener(this);
            deleteCustomerByIdButton.addActionListener(this);
            OpenDepositButton.addActionListener(this);
            creditDepositButton.addActionListener(this);
            debitDepositButton.addActionListener(this);
            transferAmountButton.addActionListener(this);
            FindCashBoxBalanceButtom.addActionListener(this);
            createLoanButtom.addActionListener(this);
            showPaymentListOfLoan.addActionListener(this);
            getPaymentButtom.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {

            if (e.getSource() == createRealCustomerButton) {
                GuiCreateRealCustomer.CreateRealCustomer realCustomer = new GuiCreateRealCustomer.CreateRealCustomer();
                realCustomer.setTitle("Real Customer Creation");
                realCustomer.setVisible(true);
                realCustomer.setBounds(10, 10, 370, 600);
                realCustomer.setResizable(false);

            }
            if (e.getSource() == createOrgCustomerButton) {
                GuiCreateOrgCustomer.CreateOrgCustomer createOrgCustomer = new GuiCreateOrgCustomer.CreateOrgCustomer();
                createOrgCustomer.setTitle("Org Customer Creation");
                createOrgCustomer.setVisible(true);
                createOrgCustomer.setBounds(10, 10, 370, 600);
                createOrgCustomer.setResizable(false);

            }
            if (e.getSource() == customerListViewButton) {
                GuiShowCustomerList.showCustomerList showCustomerList = new GuiShowCustomerList.showCustomerList();
                showCustomerList.setTitle("Customer List");
                showCustomerList.setVisible(true);
                showCustomerList.setBounds(10, 10, 370, 600);
                showCustomerList.setResizable(false);

            }
            if (e.getSource() == FindCustomerByIdButton) {
                GuiFindCustomerById.FindCustomerById findCustomerById = new GuiFindCustomerById.FindCustomerById();
                findCustomerById.setTitle("Find Customer");
                findCustomerById.setVisible(true);
                findCustomerById.setBounds(10, 10, 370, 600);
                findCustomerById.setResizable(false);
            }

            if (e.getSource() == editCustomerByIdButton) {
                GuiEditCustomerById.EditCustomerById editCustomerById = new GuiEditCustomerById.EditCustomerById();
                editCustomerById.setTitle("Edit Customer");
                editCustomerById.setVisible(true);
                editCustomerById.setBounds(10, 10, 370, 600);
                editCustomerById.setResizable(false);
            }

            if (e.getSource() == deleteCustomerByIdButton) {
                GuiDeleteCustomer.deletCustomer deletCustomer = new GuiDeleteCustomer.deletCustomer();

                deletCustomer.setTitle("Delete Customer");
                deletCustomer.setVisible(true);
                deletCustomer.setBounds(10, 10, 370, 600);
                deletCustomer.setResizable(false);

            }
            if (e.getSource() == OpenDepositButton) {
                GuiOpenDeposit.OpenDeposit openDeposit = new GuiOpenDeposit.OpenDeposit();
                openDeposit.setTitle("Open Deposit");
                openDeposit.setVisible(true);
                openDeposit.setBounds(10, 10, 370, 600);
                openDeposit.setResizable(false);
            }
            if (e.getSource() == creditDepositButton) {
                GuiCreditDeposit.CreditDeposit creditDeposit = new GuiCreditDeposit.CreditDeposit();
                creditDeposit.setTitle("Credit Deposit");
                creditDeposit.setVisible(true);
                creditDeposit.setBounds(10, 10, 370, 600);
                creditDeposit.setResizable(false);
            }

            if (e.getSource() == debitDepositButton) {
                GuiDebitDeposit.debitDeposit debitDeposit = new GuiDebitDeposit.debitDeposit();
                debitDeposit.setTitle("Open Deposit");
                debitDeposit.setVisible(true);
                debitDeposit.setBounds(10, 10, 370, 600);
                debitDeposit.setResizable(false);
            }

            if (e.getSource() == transferAmountButton) {
                GuiTransferAmountDeposit.trasferAmount trasferAmount = new GuiTransferAmountDeposit.trasferAmount();
                trasferAmount.setTitle("Open Deposit");
                trasferAmount.setVisible(true);
                trasferAmount.setBounds(10, 10, 370, 600);
                trasferAmount.setResizable(false);
            }

            if (e.getSource() == FindCashBoxBalanceButtom) {
                GuiCashBoxBalance.cashBoxBalance cashBoxBalance = new GuiCashBoxBalance.cashBoxBalance();
                cashBoxBalance.setTitle("CashBox Balance");
                cashBoxBalance.setVisible(true);
                cashBoxBalance.setBounds(10, 10, 370, 600);
                cashBoxBalance.setResizable(false);
            }

            if (e.getSource() == createLoanButtom) {
                GuiCreateLoan.createLoan createLoan = new GuiCreateLoan.createLoan();
                createLoan.setTitle("Create Loan For Customer");
                createLoan.setVisible(true);
                createLoan.setBounds(10, 10, 370, 600);
                createLoan.setResizable(false);
            }

            if (e.getSource() == showPaymentListOfLoan) {
                GuiShowLoanDetails.showLoanDetails showLoanDetails = new GuiShowLoanDetails.showLoanDetails();
                showLoanDetails.setTitle("Loan List Details");
                showLoanDetails.setVisible(true);
                showLoanDetails.setBounds(10, 10, 370, 600);
                showLoanDetails.setResizable(false);


            }

            if (e.getSource() == getPaymentButtom) {
                GuiGetPeyment.getLoanPayment getLoanPayment = new GuiGetPeyment.getLoanPayment();
                getLoanPayment.setTitle("Loan List Details");
                getLoanPayment.setVisible(true);
                getLoanPayment.setBounds(10, 10, 370, 600);
                getLoanPayment.setResizable(false);


            }


        }

    }
}
