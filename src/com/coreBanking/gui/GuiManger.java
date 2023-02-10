package com.coreBanking.gui;

import com.coreBanking.db.DbManeger;
import com.coreBanking.exception.UserNotFoundException;

import java.sql.SQLException;

public class GuiManger {
    GuiDb guiDb=new GuiDb();

    public Object mngUser(String usercode) throws UserNotFoundException, SQLException {

        Object userCode=guiDb.checkUser(usercode);
        return  userCode;

    }

    public Object mngPass(String usercode,String passWord) throws UserNotFoundException, SQLException {

        Object password=guiDb.checkPassword(usercode,passWord);
        return  password;

    }

//    public static void main(String[] args) throws UserNotFoundException, SQLException {
//        GuiManger guiManger=new GuiManger();
//        guiManger.mngUser(String.valueOf(1));
//    }


}