import java.sql.*;
import java.util.Scanner;

public class p3 {

    private static DBConnect db;

    public static void main(String[] args) {

        if (args.length <2)
        {
            System.out.println("You need to include your UserID and Password parameters on the command line");
            return;
        }

        else if (args.length != 3 )
        {
            System.out.println("Include the number of the following menu item as the third parameter on the command line.\n" +
                    "\n" +
                    "1 – Report Participant Information\n" +
                    "2 – Report Pottery Information\n" +
                    "3 – Report Building Galleries Information\n" +
                    "4 – Update Member ID\n");
            return;
        }

        //create database connection if not there already
        if (db == null) {
            db = new DBConnect();
            if (!db.ConnectDB(args[0], args[1])) {
                return;
            }
        }

        //evaluate data
        switch (args[2]) {
            case "1":
                System.out.println("Enter Participant’s email address: <and wait for user’s input>");
                //add db function
                break;
            case "2":
                System.out.println("Enter Pottery ID: <and wait for user’s input>");
                //add db function
                break;

            case "3":
                System.out.println("Enter Building Name: <and wait for user’s input>");
                //add db function
                break;

            case "4":
                System.out.println("Enter the Participant’s Email Address: <and wait for user’s input>\n" +
                                "Enter the updated Member ID: <and wait for user’s input>\n");
                //add db function
                break;

            default:
                throw new IllegalStateException("Unexpected value: " + args[2]);
        }
        return;
    }

}


