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

        else if (args.length == 2 )
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
            db.ConnectDB(args[0], args[1]);
        }

        //evaluate data
        Scanner s = new Scanner(System.in); // read from stdin
        switch (args[2]) {
            case "1": // print participant data
                System.out.println("Enter Participant’s email address: ");
                String pEmail = s.nextLine(); // read in email from user input
                db.getParticipant(pEmail);
                break;
            case "2": //print Pottery or Artowrk info
                System.out.println("Enter Pottery ID: ");
                int potteryID = s.nextInt();
                db.getPottery(potteryID);
                break;

            case "3": //Print List of Galleries in Building
                System.out.println("Enter Building Name: ");
                String buildingName = s.nextLine(); // read in building name from user input
                db.getBuilding(buildingName);
                break;

            case "4": //Update Member ID
                System.out.println("Enter the Participant’s Email Address: ");
                String email = s.nextLine(); // read in building name from user input
                System.out.println("Enter the updated Member ID: ");
                int newID = s.nextInt(); // read in building name from user input
                db.updateParticipant(email, newID);
                break;

            default:
                throw new IllegalStateException("Unexpected value: " + args[2]);
        }
        return;
    }

}


