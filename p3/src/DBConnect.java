import java.sql.*;

public class DBConnect {
    private static String USERID = "userName";
    private static String PASSWORD = "password";
    private Connection connection;

    /**
     * Connect to Database Server with ID and Password
     * @param UserID
     * @param Password
     */
    public void ConnectDB( String UserID, String Password){
        USERID = UserID;
        PASSWORD = Password;
        System.out.println("-------Oracle JDBC COnnection Testing ---------");
        try {
            // Register the Oracle driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

        } catch (ClassNotFoundException e){
            System.out.println("Where is your Oracle JDBC Driver?");
            e.printStackTrace();
        }

        System.out.println("Oracle JDBC Driver Registered!");
        connection = null;

        try {
            // create the connection string
            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@oracle.wpi.edu:1521:orcl", USERID, PASSWORD);
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
        }
        System.out.println("Oracle JDBC Driver Connected!");
    }

    /**
     * When the user enters the participant’s email address,
     * the program should execute a query of the Participant table,
     * print on the screen Email, Name (first+Last), Phone, City/State and Member ID
     * @param pEmail Participant Email
     */
    public void getParticipant(String pEmail)
    {
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

    /**
     * When the user enters the pottery (artwork) ID,
     * the program should execute a query of the Pottery and related tables
     * and print on the screen the following Pottery information Artwork ID, Artist Name, Title, Clay Body and Price
     * @param potteryID the artworkID
     */
    public void getPottery( int potteryID)
    {
        try {
            String str = "SELECT * " +
                    "FROM POTTERY P " +
                    "NATURAL JOIN ARTWORK A " +
                    "JOIN PARTICIPANT PT ON  A.CREATOREMAIL = PT.EMAIL " +
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
                System.out.println("Clay Body: " + rset.getString("clayBody"));
                System.out.println("Price: " + rset.getString("price"));
            }
            rset.close();
            stmt.close();
            connection.close();
        } catch (SQLException e){
            System.out.println("Get Data Failed! Check output console");
            e.printStackTrace();
        }
    }

    /**
     * When the user enters the account name,
     * the program should execute a query of the Building and Gallery tables,
     * print on the screen Building name, address and a list of galleries in the building
     * list of galleries is in alphabet order
     * @param buildingName
     */
    public void getBuilding(String buildingName)
    {
        try {
            String str = "SELECT * " +
                    "FROM BUILDING B " +
                    "NATURAL JOIN GALLERY G " +
                    "WHERE BUILDINGNAME = ? " +
                    "ORDER BY GALLERYNAME";
            PreparedStatement stmt = connection.prepareStatement(str);
            stmt.setString(1, buildingName); // set value for question mark
            ResultSet rset = stmt.executeQuery();

            // print results
            int count = 0;
            while (rset.next()) {
                if (count == 0) {
                    System.out.println("Building Gallery Information");
                    System.out.println("Building Name: " + buildingName);
                    System.out.println("Building Address: " + rset.getString("street"));
                    System.out.println("                  " + rset.getString("city") + ", " + rset.getString("state") + ", " + rset.getString("zipcode"));
                }
                System.out.println("Gallery " + (count + 1) + ": "+ rset.getString("galleryname"));
                count ++;
            }
            rset.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            System.out.println("Get Data Failed! Check output console");
            e.printStackTrace();
        }
    }

    /**
     * update the member ID for the email address in the Participant table
     * and the program terminates
     * @param pEmail participant ID
     * @param newID new ID to be updated to
     */
    public void updateParticipant(String pEmail, int newID)
    {
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
        }
        catch (SQLException e) {
        System.out.println("Update Failed! Check output console");
        e.printStackTrace();
        }
    }

}
