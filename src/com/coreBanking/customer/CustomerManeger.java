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
        customerDB=new CustomerDB();

    }

    public void addCustomer(Customer customer){

        customers.add(customer);
    }

    public RealCustomer createRealCustomer (int id, int customertype,String address, String fname
            , String lname, String codemeli)
    {
        RealCustomer customer=new RealCustomer(id,customertype,address,fname,lname,codemeli);
        addCustomer(customer);
        try {
            customerDB.saveRealCustomerInDB(customer);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return new RealCustomer(id,customertype,address,fname,lname,codemeli);
    }

    public OrgCustomer createOrgCustomer (int id,int customertype,String address,String fullName,String shomareSabt){
        OrgCustomer customer=new OrgCustomer(id,customertype,address,shomareSabt,fullName);
        addCustomer(customer);
        try {
            customerDB.saveOrgCustomerInDB(customer);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return new OrgCustomer(id,customertype,address,shomareSabt,fullName);
    }



    public RealCustomer findRealCustomerById(int id) throws SQLException, CustomerNotFoundException {
        RealCustomer customerInfo =customerDB.findRealCustomerById(id);
        return customerInfo;
        }

    public boolean findRealCustomerById2(int id) throws SQLException, CustomerNotFoundException {
        RealCustomer customerInfo =customerDB.findRealCustomerById(id);
        return true;
    }

    public OrgCustomer findOrgCustomerById(int id) throws SQLException, CustomerNotFoundException {
        OrgCustomer customerInfo =customerDB.findOrgCustomerById(id);
        return customerInfo;
    }

    public boolean findOrgCustomerById2(int id) throws SQLException, CustomerNotFoundException {
        OrgCustomer customerInfo =customerDB.findOrgCustomerById(id);
        return true;
    }





    public ArrayList<RealCustomer> showRealCustomerList() throws SQLException {

             return customerDB.showRealCustomerList();
    }



    public ArrayList<OrgCustomer> showOrgCustomerList() throws SQLException {
        return customerDB.showOrgCustomerList();

    }








    public ArrayList<Customer> getcustomer(){

        return new ArrayList<> (customers);
    }

     public void editRealCustomer(int id,String address,String fname,String lname,String codemeli) throws SQLIntegrityConstraintViolationException, SQLException {
        customerDB.editRealCustomer(id,address,fname,lname,codemeli);
     }

    public void editOrgCustomer(int id,String address,String fullname,String shomaresabt) throws SQLIntegrityConstraintViolationException, SQLException {
        customerDB.editOrgCustomer(id,address,fullname,shomaresabt);
    }

    public boolean deleteCustomer (int customerId) throws SQLException {
        return customerDB.deleteCustomer(customerId);
    }





    /*public void saveCustomer() throws IOException {
        File file = new File("CustomerList.txt");
        try {
            BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(file));
            StringBuilder stringBuilder = new StringBuilder();
            for (Customer customer : customers) {
                stringBuilder.append(customer.getId()).append(",")
                        .append(customer.getFname()).append(",")
                        .append(customer.getLname()).append(",")
                        .append(customer.getCodemeli()).append(",")
                        .append(customer.getBalance()).append("\n");
            }

        bufferedWriter.write(stringBuilder.toString());
        bufferedWriter.flush();
        bufferedWriter.close();
    }catch (IOException e){
        e.printStackTrace();

        }

    }*/

    /*public void loadCustomer (){
        customers.clear();
        File file =new File("CustomerList.txt");
        try {
            BufferedReader bufferedReader=new BufferedReader(new FileReader(file) );
            String line = null;
            while (true){
                try {
                    if (!((line=bufferedReader.readLine())!=null)) break;
                } catch (IOException e) {
                    e.printStackTrace();
                }
                if(!line.isEmpty()){
                    String[] customerDetials=line.split(",");
                    Customer customer=createCustomer(customerDetials[1],customerDetials[2],customerDetials[3],Integer.parseInt(customerDetials[0]));
                    customer.setBalance(Long.parseLong(customerDetials[4]));
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

    }*/

}
