package com.coreBanking.amortization;

import java.util.ArrayList;

public class AmortizationManager {


    public float calculateTotalProfitAmount (float loanAmount, float rate, int peymentCount){
        float totalProfitAmount=(loanAmount*rate*(peymentCount+1)*1)/2400 ;
        return totalProfitAmount;

    }

    public float calucaltePeymentAmount(float loanAmount,int peymentCount,float rate){
        float totalProfitAmount=calculateTotalProfitAmount(loanAmount,rate,peymentCount);
        float peymentAmount=(loanAmount+totalProfitAmount)/peymentCount;
        return peymentAmount;

    }

    public ArrayList<Float> calculateHideProfitPeyment (float loanAmount, float rate, int peymentCount){
        ArrayList<Float> hideProfitlist=new ArrayList<Float>();
        float totalProfitAmount=calculateTotalProfitAmount(loanAmount,rate,peymentCount);
        for (int i = 0; i <=peymentCount ; i++) {
            float k=peymentCount-i;
            float l=k-1;
            float hideProfitPeyment=totalProfitAmount*((k*(k+1)-l*(l+1))/(peymentCount*(peymentCount+1)));
            hideProfitlist.add(i,hideProfitPeyment);
        }
        return hideProfitlist;


    }



//    public static void main(String[] args) {
//        AmortizationManager amortizationManager=new AmortizationManager();
//        float loanAmount= Long.valueOf(200000);
//        float rate= Long.valueOf(6);
//        int peymentCount=12;
//
//        System.out.println(amortizationManager.calculateHideProfitPeyment(loanAmount,rate,peymentCount));
//
//
//
//    }
}
