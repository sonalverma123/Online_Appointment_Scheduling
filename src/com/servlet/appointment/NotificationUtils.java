package com.servlet.appointment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class NotificationUtils {

    public static int getUnreadNotificationCount(Connection conn, int healthcareProfessionalId) {
        int count = 0;
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM appointments WHERE healthcare_professional_id = ? AND notification_status = 'unread'");
            stmt.setInt(1, healthcareProfessionalId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

}
