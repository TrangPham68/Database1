/* Project 3 Phase 3
 * Prudence Lam, Trang Pham, Helen Le
 */

import java.sql.*;
import java.util.Scanner;

public class p3 {
    private static String USERID = "username";
    private static String PASSWORD = "password";

    public static void main(String[] args) {
        // check for valid number of arguments
        if (args.length < 2) {
            System.out.println("You need to include your UserID and Password parameters on the command line");
            System.out.println("Usage: java p3 <username> <password> [1|2|3|4]");
        } else if (args.length == 2) {
            System.out.println("""
                    Include the number of the following menu item as the third parameter on the command line.

                    1 – Report Participant Information
                    2 – Report Pottery Information
                    3 – Report Building Galleries Information
                    4 – Update Member ID
                    """);
        } else if (args.length == 3) { // run program if enough arguments
            USERID = args[0];
            PASSWORD = args[1];
        }

        Scanner s = new Scanner(System.in); // read from stdin

        // check for Oracle driver
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            System.out.println("No Oracle JDBC Driver found");
            e.printStackTrace();
            return;
        }
        Connection connection = null;

        try { // create connection string with userid and password
            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@oracle.wpi.edu:1521:orcl", USERID, PASSWORD);
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return;
        }
        System.out.println("Oracle JDBC Driver Connected!");

        // evaluate data
        switch (args[2]) {
            case "1" -> { // print participant data
                System.out.println("Enter Participant’s email address: ");
                String pEmail = s.nextLine(); // read in email from user input

                // perform query
                try { // attempt to send SQL command to database
                    String str = "SELECT * FROM PARTICIPANT WHERE EMAIL = ?";
                    PreparedStatement stmt = connection.prepareStatement(str);
                    stmt.setString(1, pEmail); // set value for question mark
                    ResultSet rset = stmt.executeQuery();

                    // print results
                    while (rset.next()) {
                        System.out.println("Participant Information");
                        System.out.println("Email: " + pEmail);
                        System.out.println("Name: " + rset.getString("firstName") + rset.getString("lastName"));
                        System.out.println("Phone: " + rset.getString("phone"));
                        System.out.println("City/State: " + rset.getString("city") + "," + rset.getString("state"));
                        // check for valid memberID
                        Integer mID = rset.getObject("memberID") != null ? rset.getInt("memberID") : null;
                        if (mID != null) {
                            System.out.println("MemberID: " + mID);
                        }
                    }
                    rset.close();
                    stmt.close();
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("Get Data Failed! Check output console");
                    e.printStackTrace();
                }
            }
            case "2" -> {
                System.out.println("Enter Pottery ID: ");
                int potteryID = s.nextInt();

                // perform the query
                try {
                    String str = "SELECT * " +
                            "FROM POTTERY P " +
                            "NATURAL JOIN ARTWORK A" +
                            "JOIN PARTICIPANT PT ON (WHERE A.CREATOREMAIL = P.EMAIL)" +
                            "WHERE ARTWORKID = ?";
                    PreparedStatement stmt = connection.prepareStatement(str);
                    stmt.setInt(1,potteryID); // set value for question mark
                    ResultSet rset = stmt.executeQuery();

                    // print results
                    while (rset.next()) {
                        System.out.println("Pottery Information");
                        System.out.println("Artwork ID: " + potteryID);
                        System.out.println("Artist Name: " + rset.getString("firstName") + rset.getString("lastName"));
                        System.out.println("Title: " + rset.getString("title"));
                        System.out.println("Clay Body " + rset.getString("clayBody"));
                        System.out.println("Price " + rset.getString("price"));
                    }
                    rset.close();
                    stmt.close();
                    connection.close();
                } catch (SQLException e){
                    System.out.println("Get Data Failed! Check output console");
                    e.printStackTrace();
                }
            }
            // report building galleries info
            case "3" -> {
                System.out.println("Enter Building Name: ");
                String buildingName = s.nextLine(); // read in building name from user input

                // perform the query
                try {
                    String str = "SELECT * " +
                            "FROM POTTERY P " +
                            "NATURAL JOIN ARTWORK A" +
                            "JOIN PARTICIPANT PT ON (WHERE A.CREATOREMAIL = P.EMAIL)" +
                            "WHERE ARTWORKID = ?";
                    PreparedStatement stmt = connection.prepareStatement(str);
                    stmt.setString(1, buildingName); // set value for question mark
                    ResultSet rset = stmt.executeQuery();

                    // print results
                    while (rset.next()) {
                        System.out.println("Building Gallery Information");
                        System.out.println("Building Name: " + buildingName);
                        System.out.println("Building Address: " + rset.getString("firstName") + rset.getString("lastName"));
                    }
                    rset.close();
                    stmt.close();
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("Get Data Failed! Check output console");
                    e.printStackTrace();
                }
            }
            //add db function
            case "4" -> {
                System.out.println("Enter the Participant’s Email Address: ");
                String pEmail = s.nextLine(); // read in building name from user input
                System.out.println("Enter the updated Member ID: ");
                int newID = s.nextInt(); // read in building name from user input

                try {
                    String str = "UPDATE PARTICIPANT SET MEMBERID = ? WHERE EMAIL = ?";
                    PreparedStatement stmt = connection.prepareStatement(str);
                    stmt.setInt(1, newID);
                    stmt.setString(2, pEmail);
                    ResultSet rset = stmt.executeQuery();

                    System.out.println("Updated Participant's Member ID");

                    rset.close();
                    stmt.close();
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("Update Failed! Check output console");
                    e.printStackTrace();
                }
            }
            //add db function
            default -> throw new IllegalStateException("Unexpected value: " + args[2]);
        }
    }
}