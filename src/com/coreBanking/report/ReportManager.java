package com.coreBanking.report;

import com.aspose.cells.Workbook;
import com.aspose.cells.Worksheet;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReportManager {
    ReportDb reportDb = new ReportDb();
    ArrayList<TransactionReport> trnRep = null;

    public ArrayList<TransactionReport> top5TransactionReport() {
        try {
            trnRep = reportDb.top5TransactionReport();
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        return trnRep;
    }

    public int transactionCount() {
        return reportDb.transactionCount();
    }


    public void saveTransaction(String nameForFile) throws IOException {
        String fileName = nameForFile + ".txt";
        ArrayList<TransactionReport> trnreps = new ArrayList<>();
        try {
            trnreps = reportDb.transactionList();
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
        File file = new File(fileName);
        try {
            BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(file));
            StringBuilder stringBuilder = new StringBuilder();
            for (TransactionReport report : trnreps) {
                stringBuilder.append(report.getTransactionId()).append(",")
                        .append(report.getAccount()).append(",")
                        .append(report.getAmount()).append(",")
                        .append(report.getTrnname()).append(",")
                        .append(report.getDrcrtyp()).append("\n")
                        .append(report.getTrndate()).append("\n")
                        .append(report.getTrndesc()).append("\n")
                        .append(report.getRefsystem()).append("\n");
            }

            bufferedWriter.write(stringBuilder.toString());
            bufferedWriter.flush();
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();

        }

    }


    public void saveTransactionInExcel(String nameForFile) throws SQLException {
        String fileName = nameForFile + ".xlsx";
        ArrayList<TransactionReport> trnrep = reportDb.transactionList();
        Workbook transactionListWorkBook = new Workbook();
        Worksheet transactionListWorkSheet = transactionListWorkBook.getWorksheets().get(0);
        int count = reportDb.transactionCount();

        String[][] data1 = new String[count][8];
        int row = 0;

        for (TransactionReport transactionReport :
                trnrep) {
            data1[row][0] = String.valueOf(transactionReport.getTransactionId());
            data1[row][1] = transactionReport.getAccount();
            data1[row][2] = String.valueOf(transactionReport.getAmount());
            data1[row][3] = transactionReport.getTrnname();
            data1[row][4] = transactionReport.getDrcrtyp();
            data1[row][5] = String.valueOf(transactionReport.getTrndate());
            data1[row][6] = transactionReport.getTrndesc();
            data1[row][7] = transactionReport.getRefsystem();
            try {
                transactionListWorkSheet.getCells().importArray(data1, 0, 0);
            } catch (Exception e) {
                e.printStackTrace();
            }


            row += 1;
        }

        // Save the output Excel file containing the exported list
        try {
            transactionListWorkBook.save(fileName);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}
