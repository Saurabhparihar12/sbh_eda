import java.io.IOException;
import java.sql.SQLException;

class MultiCatchExample {
    public static void main(String[] args) {
        try {
            performOperation();
        } catch (IOException | SQLException e) {
            System.out.println("Caught exception: " + e.getMessage());
        }
    }

    static void performOperation() throws IOException, SQLException {
        try {
            int choice = 1;
            if (choice == 1) {
                throw new IOException("IO error occurred");
            } else {
                throw new SQLException("Database error occurred");
            }
        } catch (Exception e) {
            throw e;
        }
    }
}
