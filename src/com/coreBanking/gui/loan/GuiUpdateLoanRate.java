package com.coreBanking.gui.loan;

import com.coreBanking.loan.LoanManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GuiUpdateLoanRate {
    public static class updateLoanRate extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel RateLable = new JLabel("New Rate ");
        JTextField RateTextField = new JTextField();
        JButton acceptButton = new JButton("Do It");

        public updateLoanRate() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            RateLable.setBounds(50, 50, 130, 30);
            RateTextField.setBounds(150, 50, 130, 30);

            acceptButton.setBounds(135, 350, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(RateLable);
            container.add(RateTextField);
            container.add(acceptButton);
        }

        public void addActionEvent() {
            acceptButton.addActionListener(this);

        }


        @Override
        public void actionPerformed(ActionEvent e) {
            LoanManager loanManager = new LoanManager();
            String rate = RateTextField.getText();
            try {
                loanManager.updateLoanRate(Integer.parseInt(rate));
                JOptionPane.showMessageDialog(this, "Opration Is Done");
            } catch (NumberFormatException numberFormatException) {
                JOptionPane.showMessageDialog(this, "Input Number Is Not Correct");
            }
        }
    }

}
