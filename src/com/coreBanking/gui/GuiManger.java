package com.coreBanking.gui;

import com.coreBanking.exception.UserNotFoundException;

import java.sql.SQLException;

public class GuiManger {
    GuiDb guiDb = new GuiDb();

    public Object mngUser(String usercode) throws UserNotFoundException, SQLException {

        return guiDb.checkUser(usercode);

    }

    public Object mngPass(String usercode, String passWord) throws UserNotFoundException, SQLException {

        return guiDb.checkPassword(usercode, passWord);

    }


}