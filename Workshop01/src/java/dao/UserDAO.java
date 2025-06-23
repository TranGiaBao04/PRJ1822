/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.User;
import utils.DbUtils;

/**
 *
 * @author Admin
 */
public class UserDAO {
    
    public UserDAO(){
        
    }
    
    public static User checkLogin(String username, String password) {
        User us = null;
        try {
            String sql = "SELECT * FROM tblUsers WHERE Username = ? AND Password = ? ";
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return us = new User(rs.getString("Username"),
                        rs.getString("Name"),
                        rs.getString("Password"),
                        rs.getString("Role"));

            }
        } catch (Exception e) {
            System.out.println("Login error: " + e.getMessage());
        }
        return null;
    }
    
    public List<User> getAllUsers(){
        List<User> userList = new ArrayList<>();
        String sql = "SELECT Username, Name, Password, Role FROM tblUsers ORDER BY UserName";
        try{
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                User us = new User();
                us.setUsername(rs.getString("Username"));
                us.setName(rs.getString("Name"));
                us.setPassword(rs.getString("Password"));
                us.setRole(rs.getString("Role"));
                userList.add(us);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    public boolean updatePassword(String userID, String newPassword) {
        String sql = "UPDATE tblUsers SET Password = ? WHERE Username = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, userID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
