package com.coreBanking.gui;

import com.coreBanking.gui.cash.GuiCashBoxBalance;
import com.coreBanking.gui.cash.GuiDecreaseCashbox;
import com.coreBanking.gui.cash.GuiIncreaseCashbox;
import com.coreBanking.gui.customer.GuiFindCustomerById;
import com.coreBanking.gui.customer.GuiShowCustomerList;
import com.coreBanking.gui.loan.GuiUpdateLoanRate;
import com.coreBanking.gui.report.GuiTop5TransactionReport;
import com.coreBanking.gui.report.GuiTransactioReportFormat;
import com.coreBanking.loan.LoanManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiMainMenu2 {
    public static class MainMenu2 extends JFrame implements ActionListener {

        Container container = getContentPane();
        JButton customerListViewButton = new JButton("Customer List View");
        JButton FindCustomerByIdButton = new JButton("Find Customer By Id");
        JButton increaseCashBalanceButton = new JButton("Increase Teller CashBox");
        JButton decreaseCashBalanceButton = new JButton("decrease Teller CashBox");
        JButton FindCashBoxBalanceButtom = new JButton("CashBox Balance");
        JButton updateLoanRateButtom = new JButton("Update Loan Rate");
        JButton profitReportButtom = new JButton("Profit Report");
        JButton top5TransactionReportButtom = new JButton("Top 5 Transaction Report");
        JButton exportTransactionButtom = new JButton("Export Transaction");


        public MainMenu2() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            customerListViewButton.setBounds(20, 30, 200, 30);
            FindCustomerByIdButton.setBounds(20, 70, 200, 30);
            increaseCashBalanceButton.setBounds(20, 110, 200, 30);
            decreaseCashBalanceButton.setBounds(20, 150, 200, 30);
            FindCashBoxBalanceButtom.setBounds(20, 190, 200, 30);
            updateLoanRateButtom.setBounds(20, 230, 200, 30);
            profitReportButtom.setBounds(20, 270, 200, 30);
            top5TransactionReportButtom.setBounds(20, 310, 200, 30);
            exportTransactionButtom.setBounds(20, 350, 200, 30);


        }

        public void addComponentsToContainer() {
            container.add(customerListViewButton);
            container.add(FindCustomerByIdButton);
            container.add(decreaseCashBalanceButton);
            container.add(increaseCashBalanceButton);
            container.add(FindCashBoxBalanceButtom);
            container.add(updateLoanRateButtom);
            container.add(profitReportButtom);
            container.add(top5TransactionReportButtom);
            container.add(exportTransactionButtom);


        }

        public void addActionEvent() {
            customerListViewButton.addActionListener(this);
            FindCustomerByIdButton.addActionListener(this);
            increaseCashBalanceButton.addActionListener(this);
            decreaseCashBalanceButton.addActionListener(this);
            FindCashBoxBalanceButtom.addActionListener(this);
            updateLoanRateButtom.addActionListener(this);
            profitReportButtom.addActionListener(this);
            top5TransactionReportButtom.addActionListener(this);
            exportTransactionButtom.addActionListener(this);


        }


        @Override
        public void actionPerformed(ActionEvent e) {
            if (e.getSource() == customerListViewButton) {
                GuiShowCustomerList.showCustomerList showCustomerList = new GuiShowCustomerList.showCustomerList();
                showCustomerList.setTitle("Real Customer Creation");
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

            if (e.getSource() == increaseCashBalanceButton) {
                GuiIncreaseCashbox.IncreaseCashbox increaseCashbox = new GuiIncreaseCashbox.IncreaseCashbox();
                increaseCashbox.setTitle("Increase CashBox");
                increaseCashbox.setVisible(true);
                increaseCashbox.setBounds(10, 10, 370, 600);
                increaseCashbox.setResizable(false);
            }

            if (e.getSource() == decreaseCashBalanceButton) {
                GuiDecreaseCashbox.DecreaseCashbox decreaseCashbox = new GuiDecreaseCashbox.DecreaseCashbox();
                decreaseCashbox.setTitle("Decrease CashBox");
                decreaseCashbox.setVisible(true);
                decreaseCashbox.setBounds(10, 10, 370, 600);
                decreaseCashbox.setResizable(false);
            }

            if (e.getSource() == FindCashBoxBalanceButtom) {
                GuiCashBoxBalance.cashBoxBalance cashBoxBalance = new GuiCashBoxBalance.cashBoxBalance();
                cashBoxBalance.setTitle("CashBox Balance");
                cashBoxBalance.setVisible(true);
                cashBoxBalance.setBounds(10, 10, 370, 600);
                cashBoxBalance.setResizable(false);
            }

            if (e.getSource() == updateLoanRateButtom) {
                GuiUpdateLoanRate.updateLoanRate updateLoanRate = new GuiUpdateLoanRate.updateLoanRate();

                updateLoanRate.setTitle("Update Loan Rate");
                updateLoanRate.setVisible(true);
                updateLoanRate.setBounds(10, 10, 370, 600);
                updateLoanRate.setResizable(false);
            }

            if (e.getSource() == profitReportButtom) {
                LoanManager loanManager = new LoanManager();
                JOptionPane.showMessageDialog(this, loanManager.getProfitReport());

            }

            if (e.getSource() == top5TransactionReportButtom) {
                GuiTop5TransactionReport.top5TransactionReport transactionReport = new GuiTop5TransactionReport.top5TransactionReport();

                transactionReport.setTitle("Top 5 Transaction Report");
                transactionReport.setVisible(true);
                transactionReport.setBounds(30, 30, 1000, 1000);
                transactionReport.setResizable(false);

            }
            if (e.getSource() == exportTransactionButtom) {
                GuiTransactioReportFormat.TransactioReportFormat transactioReportFormat = new GuiTransactioReportFormat.TransactioReportFormat();

                transactioReportFormat.setTitle("Transaction Format");
                transactioReportFormat.setVisible(true);
                transactioReportFormat.setBounds(10, 10, 370, 600);
                transactioReportFormat.setResizable(false);
            }


        }

    }

}
