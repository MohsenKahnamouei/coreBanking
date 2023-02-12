package com.coreBanking.customer;

public class RealCustomer extends Customer {
    private String fname;
    private String lname;
    private String codemeli;


    public RealCustomer(int id, int customertype, String address, String fname, String lname, String codeMeli) {
        super(id, customertype, address);
        this.fname = fname;
        this.lname = lname;
        this.codemeli = codeMeli;
    }


    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getCodemeli() {
        return codemeli;
    }

    public void setCodemeli(String codemeli) {
        this.codemeli = codemeli;
    }

    @Override
    public String toString() {
        return "RealCustomer{" +
                "fname='" + fname + '\'' +
                ", lname='" + lname + '\'' +
                ", codemeli='" + codemeli + '\'' +
                "} " + super.toString();
    }

}
