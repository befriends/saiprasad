

package DBConnection;

import java.sql.Connection;
import java.sql.DriverManager;


public class DBPool {
    public final static Connection getConnection() {
        Connection conn = null;//    nnnnnnnnn

        try {
            Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smartdairy?user=root&password=sairam");
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
