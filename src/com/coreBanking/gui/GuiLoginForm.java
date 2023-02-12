package com.coreBanking.gui;

import com.coreBanking.exception.UserNotFoundException;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class GuiLoginForm {

    public static class LoginFrame extends JFrame implements ActionListener {

        Container container = getContentPane();
        JLabel userLabel = new JLabel("USERNAME");
        JLabel passwordLabel = new JLabel("PASSWORD");
        JTextField userTextField = new JTextField();
        JPasswordField passwordField = new JPasswordField();
        JButton loginButton = new JButton("LOGIN");
        JButton resetButton = new JButton("RESET");
        JCheckBox showPassword = new JCheckBox("Show Password");


        public LoginFrame() {
            setLayoutManager();
            setLocationAndSize();
            addComponentsToContainer();
            addActionEvent();

        }

        public void setLayoutManager() {
            container.setLayout(null);
        }

        public void setLocationAndSize() {
            userLabel.setBounds(50, 150, 100, 30);
            passwordLabel.setBounds(50, 220, 100, 30);
            userTextField.setBounds(150, 150, 150, 30);
            passwordField.setBounds(150, 220, 150, 30);
            showPassword.setBounds(150, 250, 150, 30);
            loginButton.setBounds(50, 300, 100, 30);
            resetButton.setBounds(200, 300, 100, 30);


        }

        public void addComponentsToContainer() {
            container.add(userLabel);
            container.add(passwordLabel);
            container.add(userTextField);
            container.add(passwordField);
            container.add(showPassword);
            container.add(loginButton);
            container.add(resetButton);
        }

        public void addActionEvent() {
            loginButton.addActionListener(this);
            resetButton.addActionListener(this);
            showPassword.addActionListener(this);
        }


        @Override
        public void actionPerformed(ActionEvent e) {
            GuiManger guiManger = new GuiManger();
            //Coding Part of LOGIN button
            if (e.getSource() == loginButton) {
                String userText;
                String pwdText;
                userText = userTextField.getText();
                pwdText = passwordField.getText();

                try {
                    if (guiManger.mngUser(userText) == userText && guiManger.mngPass(userText, pwdText) == pwdText && Integer.parseInt(userText) == 1) {
                        JOptionPane.showMessageDialog(this, "Login Successful");
                        GuiMainMenu1.MainMenu1 frame2 = new GuiMainMenu1.MainMenu1();
                        frame2.setTitle("Main menu");
                        frame2.setVisible(true);
                        frame2.setBounds(10, 10, 370, 600);
                        frame2.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                        frame2.setResizable(false);
                    } else if (guiManger.mngUser(userText) == userText && guiManger.mngPass(userText, pwdText) == pwdText && Integer.parseInt(userText) == 2) {
                        JOptionPane.showMessageDialog(this, "Login Successful");
                        GuiMainMenu2.MainMenu2 frame3 = new GuiMainMenu2.MainMenu2();
                        frame3.setTitle("Main menu");
                        frame3.setVisible(true);
                        frame3.setBounds(10, 10, 370, 600);
                        frame3.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                        frame3.setResizable(false);
                    } else {
                        JOptionPane.showMessageDialog(this, "Invalid Username or Password");
                    }
                } catch (UserNotFoundException | SQLException userNotFoundException) {
                    userNotFoundException.printStackTrace();
                }

            }


            //Coding Part of RESET button
            if (e.getSource() == resetButton) {
                userTextField.setText("");
                passwordField.setText("");
            }
            //Coding Part of showPassword JCheckBox
            if (e.getSource() == showPassword) {
                if (showPassword.isSelected()) {
                    passwordField.setEchoChar((char) 0);
                } else {
                    passwordField.setEchoChar('*');
                }


            }
        }

    }
}
