package com.coreBanking.customer;

import com.coreBanking.exception.CustomerNotFoundException;
import com.coreBanking.exception.SQLIntegrityConstraintViolationException;

import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerManeger {

    private ArrayList<Customer> customers;
    public CustomerDB customerDB;


    public CustomerManeger() {

        customers = new ArrayList<>();
        customerDB = new CustomerDB();

    }

    public void addCustomer(Customer customer) {

        customers.add(customer);
    }

    public RealCustomer createRealCustomer(int id, int customertype, String address, String fname
            , String lname, String codemeli) {
        RealCustomer customer = new RealCustomer(id, customertype, address, fname, lname, codemeli);
        addCustomer(customer);
        customerDB.saveRealCustomerInDB(customer);
        return new RealCustomer(id, customertype, address, fname, lname, codemeli);
    }

    public OrgCustomer createOrgCustomer(int id, int customertype, String address, String fullName, String shomareSabt) {
        OrgCustomer customer = new OrgCustomer(id, customertype, address, shomareSabt, fullName);
        addCustomer(customer);
        customerDB.saveOrgCustomerInDB(customer);
        return new OrgCustomer(id, customertype, address, shomareSabt, fullName);
    }


    public RealCustomer findRealCustomerById(int id) throws CustomerNotFoundException {
        return customerDB.findRealCustomerById(id);

    }

    public boolean findCustomerById(int id) {
        return customerDB.findCustomerById(id);
    }

    public boolean findRealCustomerById2(int id) throws CustomerNotFoundException {
        RealCustomer customerInfo = customerDB.findRealCustomerById(id);
        return true;
    }

    public int findCustomerByCodemeli2(String codemeli) throws CustomerNotFoundException {
        return customerDB.findCustomerByCodemeli2(codemeli);
    }

    public OrgCustomer findOrgCustomerById(int id) throws CustomerNotFoundException {
        OrgCustomer customerInfo = customerDB.findOrgCustomerById(id);
        return customerInfo;
    }

    public boolean findCustomerByCodemeli(String codemeli) {
        return customerDB.findCustomerByCodemeli(codemeli);
    }

    public boolean findOrgCustomerById2(int id) {
        OrgCustomer customerInfo = customerDB.findOrgCustomerById(id);
        return true;
    }


    public ArrayList<RealCustomer> showRealCustomerList() throws SQLException {

        return customerDB.showRealCustomerList();
    }


    public ArrayList<OrgCustomer> showOrgCustomerList() throws SQLException {
        return customerDB.showOrgCustomerList();

    }


    public ArrayList<Customer> getcustomer() {

        return new ArrayList<>(customers);
    }

    public void editRealCustomer(int id, String address, String fname, String lname, String codemeli) {
        customerDB.editRealCustomer(id, address, fname, lname, codemeli);
    }

    public void editOrgCustomer(int id, String address, String fullname, String shomaresabt) throws SQLIntegrityConstraintViolationException, SQLException {
        customerDB.editOrgCustomer(id, address, fullname, shomaresabt);
    }

    public boolean deleteCustomer(int customerId) {
        return customerDB.deleteCustomer(customerId);
    }


}
