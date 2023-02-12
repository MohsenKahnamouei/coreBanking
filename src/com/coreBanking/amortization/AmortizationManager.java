package com.coreBanking.amortization;

import java.util.ArrayList;

public class AmortizationManager {


    public float calculateTotalProfitAmount (float loanAmount, float rate, int peymentCount){
        return(loanAmount*rate*(peymentCount+1)*1)/2400 ;


    }

    public float calucaltePeymentAmount(float loanAmount,int peymentCount,float rate){
        float totalProfitAmount=calculateTotalProfitAmount(loanAmount,rate,peymentCount);
        return(loanAmount+totalProfitAmount)/peymentCount;


    }

    public ArrayList<Float> calculateHideProfitPeyment (float loanAmount, float rate, int peymentCount){
        ArrayList<Float> hideProfitlist=new ArrayList<>();
        float totalProfitAmount=calculateTotalProfitAmount(loanAmount,rate,peymentCount);
        for (int i = 0; i <=peymentCount ; i++) {
            float k=peymentCount-i;
            float l=k-1;
            float hideProfitPeyment=totalProfitAmount*((k*(k+1)-l*(l+1))/(peymentCount*(peymentCount+1)));
            hideProfitlist.add(i,hideProfitPeyment);
        }
        return hideProfitlist;


    }


}
