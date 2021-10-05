import java.sql.*;

public class DBConnect {
    //private static final String USERID = "ttpham";
    //private static final String PASSWORD = "Thutrang68";
    private Connection connection;

    public boolean ConnectDB( String UserID, String Password){
        System.out.println("-------Oracle JDBC COnnection Testing ---------");
        try {
            // Register the Oracle driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

        } catch (ClassNotFoundException e){
            System.out.println("Where is your Oracle JDBC Driver?");
            e.printStackTrace();
            return false;
        }

        System.out.println("Oracle JDBC Driver Registered!");
        connection = null;

        try {
            // create the connection string
            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@oracle.wpi.edu:1521:orcl", UserID, Password);
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return false;
        }
        System.out.println("Oracle JDBC Driver Connected!");
        return true;
    }

    public void getGallery() {
        try {
            Statement stmt = connection.createStatement();
            String str = "SELECT * FROM GALLERY";
            ResultSet rset = stmt.executeQuery(str);

            String galleryName = "";
            String buildingName = "";
            int maxCapacity = 0;
            // Process the results

            while (rset.next()) {
                maxCapacity = rset.getInt("maxCapacity");
                galleryName = rset.getString("galleryname");
                buildingName = rset.getString("buildingname");

                System.out.println("Gallery Name: " + galleryName + "  Building Name: " + buildingName + "   Max Capacity: " + maxCapacity);
            } // end while

            rset.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            System.out.println("Get Data Failed! Check output console");
            e.printStackTrace();
            return;
        }
    }

}
