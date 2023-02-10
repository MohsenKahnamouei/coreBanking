package com.coreBanking.customer;

public abstract class Customer {
    int customertype;
    private int id;
    String address;

    Customer(){

    }

    Customer(int id, int customertype,String address){
        this.id=id;
        this.customertype=customertype;
        this.address=address;
    }

    public int getId() {
        return id;
    }

    public int getCustomerType() {
        return customertype;
    }

    public void setCustomerType(int customertype) {
        this.customertype = customertype;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

//    @Override
//    public String toString() {
//        return "Customer{" +
//                "customerType='" + customertype + '\'' +
//                ", id=" + id +
//                ", address=" + address +
//                '}';
//    }


    @Override
    public String toString() {
        return "Customer{" +
                "customertype=" + customertype +
                ", id=" + id +
                ", address='" + address + '\'' +
                '}';
    }
}


