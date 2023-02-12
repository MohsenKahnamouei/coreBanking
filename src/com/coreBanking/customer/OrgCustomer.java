package com.coreBanking.customer;

public class OrgCustomer extends Customer {
    String shomareSabt;
    String fullName;
    String address;

    public OrgCustomer(int id, int customertype, String address, String shomareSabt, String fullName) {
        super(id, customertype, address);
        this.shomareSabt = shomareSabt;
        this.fullName = fullName;
        this.address = address;
    }


    public String getShomareSabt() {
        return shomareSabt;
    }

    public void setShomareSabt(String shomareSabt) {
        this.shomareSabt = shomareSabt;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    @Override
    public String toString() {
        return "OrgCustomer{" +
                "shomareSabt='" + shomareSabt + '\'' +
                ", fullName='" + fullName + '\'' +
                "} " + super.toString();
    }
}