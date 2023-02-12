package com.coreBanking.gui;

import com.coreBanking.db.DbManeger;
import com.coreBanking.exception.UserNotFoundException;

import java.sql.SQLException;

public class GuiDb {


    public Object checkUser(String userCode) throws SQLException {
        DbManeger dbManeger = new DbManeger();
        dbManeger.excuteQuery("select * from mysql.users a where a.usercode=?");
        dbManeger.setString(1, userCode);
        String usercode = dbManeger.executeResults(1).toString();
        if (Integer.parseInt(usercode) != 0) {
            return userCode;
        }
        return new UserNotFoundException();

    }

    public Object checkPassword(String userCode, String passWord) throws SQLException {
        DbManeger dbManeger = new DbManeger();
        dbManeger.excuteQuery("select * from mysql.users a where a.usercode=? and a.password=?");
        dbManeger.setString(1, userCode);
        dbManeger.setString(2, passWord);
        String usercode = dbManeger.executeResults(1).toString();
        String password = dbManeger.executeResults(3).toString();
        if (Integer.parseInt(password) != 0) {
            return passWord;
        }
        return new UserNotFoundException();

    }


}
