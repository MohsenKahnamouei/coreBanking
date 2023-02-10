package com.coreBanking;

import com.coreBanking.gui.GuiLoginForm;

import javax.swing.*;

public class GuiMain {

    public static void main(String[] a) {

        GuiLoginForm.LoginFrame frame = new GuiLoginForm.LoginFrame();
        frame.setTitle("Login Form");
        frame.setVisible(true);
        frame.setBounds(10, 10, 370, 600);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setResizable(false);

    }

}

