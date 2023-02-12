package com.coreBanking.customer;

import com.coreBanking.db.DbManeger;
import com.coreBanking.exception.CustomerNotFoundException;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerDB {
    DbManeger dbManeger = new DbManeger();


    public void saveRealCustomerInDB(RealCustomer realCustomer) {

        dbManeger.executeUpdate("insert into mysql.customer (customer_type,customer_id,address) values (?,?,?)");

        dbManeger.setInt(1, realCustomer.getCustomerType());
        dbManeger.setInt(2, Integer.parseInt(String.valueOf(realCustomer.getId())));
        dbManeger.setString(3, realCustomer.getAddress());
        dbManeger.DMLUpdade();

        dbManeger.executeUpdate("insert into mysql.real_customer (fname,lname,codemeli,id) values (?,?,?,?)");

        dbManeger.setString(1, realCustomer.getFname());
        dbManeger.setString(2, realCustomer.getLname());
        dbManeger.setString(3, realCustomer.getCodemeli());
        dbManeger.setInt(4, Integer.parseInt(String.valueOf(realCustomer.getId())));
        dbManeger.DMLUpdade();


    }

    public void saveOrgCustomerInDB(OrgCustomer orgCustomer) {

        dbManeger.executeUpdate("insert into mysql.customer (customer_type,customer_id,address) values (?,?,?)");

        dbManeger.setInt(1, orgCustomer.getCustomerType());
        dbManeger.setInt(2, Integer.parseInt(String.valueOf(orgCustomer.getId())));
        dbManeger.setString(3, orgCustomer.getAddress());
        dbManeger.DMLUpdade();

        dbManeger.executeUpdate("insert into mysql.org_customer (id, shomaresabt, fullname) values (?,?,?)");

        dbManeger.setString(1, String.valueOf(Integer.parseInt(String.valueOf(orgCustomer.getId()))));
        dbManeger.setString(2, orgCustomer.getShomareSabt());
        dbManeger.setString(3, orgCustomer.getFullName());
        dbManeger.DMLUpdade();


    }


    public RealCustomer findRealCustomerById(int id) throws CustomerNotFoundException {
        Object customer_id = null, customer_type = null, address = null, fname = null, lname = null, codemeli = null;

        dbManeger.excuteQuery("select " +
                "b.customer_id,b.customer_type,b.address,a.fname,a.lname,a.codemeli " +
                "from mysql.real_customer a join mysql.customer b on a.id=b.customer_id " +
                "where a.id=?");

        dbManeger.setInt(1, id);
        int getid = 0;
        try {
            getid = Integer.parseInt(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        if (getid == id) {
            try {
                customer_id = dbManeger.executeResults(1);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                customer_type = dbManeger.executeResults(2);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                address = dbManeger.executeResults(3);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                fname = dbManeger.executeResults(4);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                lname = dbManeger.executeResults(5);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                codemeli = dbManeger.executeResults(6);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }

            return new RealCustomer(Integer.parseInt(customer_id.toString())
                    , Integer.parseInt(customer_type.toString()), address.toString(), fname.toString()
                    , lname.toString(), codemeli.toString());
        }
        throw new CustomerNotFoundException();
    }


    public boolean findCustomerByCodemeli(String codemeli) {

        dbManeger.excuteQuery("select * from mysql.real_customer c where c.codemeli=?");

        dbManeger.setString(1, codemeli);
        try {
            if (Integer.parseInt(dbManeger.executeResults(4).toString()) != 0) {
                return true;
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return false;
    }

    public int findCustomerByCodemeli2(String codemeli) {
        int id = 0;

        dbManeger.excuteQuery("select * from mysql.real_customer c where c.codemeli=?");

        dbManeger.setString(1, codemeli);
        try {
            if (Integer.parseInt(dbManeger.executeResults(4).toString()) != 0) {
                id = Integer.parseInt(dbManeger.executeResults(4).toString());
                return id;
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return id;

    }


    public boolean findCustomerById(int id) {

        dbManeger.excuteQuery("select * from mysql.customer c where c.customer_id=?");

        dbManeger.setInt(1, id);
        try {
            if (Integer.parseInt(dbManeger.executeResults(2).toString()) != 0) {
                return true;
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return false;

    }

    public OrgCustomer findOrgCustomerById(int id) throws CustomerNotFoundException {
        Object customer_id = null, customer_type = null, address = null, shomaresabt = null, fullname = null;

        dbManeger.excuteQuery("select b.customer_id,b.customer_type,b.address,a.shomaresabt,a.fullname\n" +
                "               from mysql.org_customer a join mysql.customer b on a.id=b.customer_id where b.customer_id=?");

        dbManeger.setInt(1, id);
        int getid = 0;
        try {
            getid = Integer.parseInt(dbManeger.executeResults(1).toString());
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        if (getid == id) {
            try {
                customer_id = dbManeger.executeResults(1);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                customer_type = dbManeger.executeResults(2);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                address = dbManeger.executeResults(3);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                shomaresabt = dbManeger.executeResults(4);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
            try {
                fullname = dbManeger.executeResults(5);
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }

            OrgCustomer orgCustomer = new OrgCustomer(Integer.parseInt(customer_id.toString())
                    , Integer.parseInt(customer_type.toString()), address.toString(), shomaresabt.toString()
                    , fullname.toString());
            return orgCustomer;
        }
        throw new CustomerNotFoundException();
    }


    public ArrayList<RealCustomer> showRealCustomerList() throws SQLException {

        dbManeger.excuteQuery("SELECT\n" +
                "       b.customer_id,b.customer_type,b.address,tb.fname,tb.lname,tb.codemeli\n" +
                "                FROM mysql.real_customer TB \n" +
                "                    join\n" +
                "                    mysql.customer b on tb.id=b.customer_id ");

        ResultSet result = dbManeger.executeQuery2();
        ArrayList<RealCustomer> customers = new ArrayList<>();
        while (result.next()) {
            RealCustomer realCustomer = new RealCustomer(
                    result.getInt("customer_id"),
                    result.getInt("customer_type"),
                    result.getString("address"),
                    result.getString("fname"),
                    result.getString("lname"),
                    result.getString("codemeli"));
            customers.add(realCustomer);
        }

        return customers;
    }


    public ArrayList<OrgCustomer> showOrgCustomerList() throws SQLException {
        dbManeger.excuteQuery("SELECT\n" +
                "    b.customer_id,b.customer_type,b.address,tb.fullname,tb.shomaresabt\n" +
                "FROM  mysql.org_customer TB\n" +
                "         join\n" +
                "     mysql.customer b on tb.id=b.customer_id");

        ResultSet result = dbManeger.executeQuery2();
        ArrayList<OrgCustomer> customerList = new ArrayList<>();
        while (result.next()) {
            OrgCustomer orgCustomer =
                    new OrgCustomer(
                            result.getInt("customer_id"),
                            result.getInt("customer_type"),
                            result.getString("address"),
                            result.getString("shomaresabt"),
                            result.getString("fullname"));
            customerList.add(orgCustomer);


        }

        return customerList;
    }


    public void editRealCustomer(int id, String address, String fname, String lname, String codemeli) {

        dbManeger.executeUpdate("update mysql.customer c set c.address=? where c.customer_id=?");

        dbManeger.setString(1, address);
        dbManeger.setInt(2, id);
        dbManeger.DMLUpdade();

        dbManeger.executeUpdate("update mysql.real_customer c set c.fname=?, c.lname=? , c.codemeli=? where c.id=?");

        dbManeger.setString(1, fname);
        dbManeger.setString(2, lname);
        dbManeger.setString(3, codemeli);
        dbManeger.setInt(4, id);
        dbManeger.DMLUpdade();

    }

    public void editOrgCustomer(int id, String address, String fullname, String shomaresabt) throws SQLException {
        dbManeger.executeUpdate("update mysql.customer c set c.address=? where c.customer_id=?");
        dbManeger.setString(1, address);
        dbManeger.setInt(2, id);
        dbManeger.DMLUpdade();
        dbManeger.executeUpdate("update mysql.org_customer a set a.fullname=?,a.shomaresabt=? where id=?");
        dbManeger.setString(1, fullname);
        dbManeger.setString(2, shomaresabt);
        dbManeger.setInt(3, id);
        dbManeger.DMLUpdade();

    }

    public boolean deleteCustomer(int customerId) {

        dbManeger.executeUpdate("delete from mysql.real_customer a where a.id=? and  a.id not in\n" +
                "           (select b.customerid from mysql.loan b ) and\n" +
                "        a.id not in (select c.customer_id from mysql.deposit c )");

        dbManeger.setInt(1, customerId);
        dbManeger.DMLUpdade();

        dbManeger.executeUpdate("delete from mysql.org_customer a where a.id=? and  a.id not in\n" +
                "        (select b.customerid from mysql.loan b ) and\n" +
                "        a.id not in (select c.customer_id from mysql.deposit c )");

        dbManeger.setInt(1, customerId);
        dbManeger.DMLUpdade();

        dbManeger.executeUpdate("delete from mysql.customer a where a.customer_id=? and  a.customer_id not in\n" +
                "        (select b.customerid from mysql.loan b ) and\n" +
                "        a.customer_id not in (select c.customer_id from mysql.deposit c )");
        dbManeger.setInt(1, customerId);
        dbManeger.DMLUpdade();

        return true;

    }


}