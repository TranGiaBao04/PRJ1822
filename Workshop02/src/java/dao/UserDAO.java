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
    
    public static User checkLogin(String username, String password){
        User us = null;
        String sql = "SELECT * FROM tblUsers WHERE username = ? AND password = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("Name"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("Role"));
                return user;
            }
            
        } catch (Exception e) {
            System.out.println("Login error:" +e.getMessage());
        }        
        return null;
    }
    
    public List<User> getAllUsers(){
        List<User> userlist = new ArrayList<>();
        String sql = "SELECT username, Name, password, Role FROM tblUsers ORDER BY username";
        try{
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                User us = new User();
                us.setUsername(rs.getString("username"));
                us.setName(rs.getString("Name"));
                us.setPassword(rs.getString("password"));
                us.setRole(rs.getString("Role"));
                userlist.add(us);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        return userlist;
    }
    
    public boolean updatePassword(String userId, String newPass){
        String sql = "UPDATE tblUsers SET password = ? WHERE username = ?";
        try{
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPass);
            ps.setString(2, userId);
            int result = ps.executeUpdate();
            return result > 0;
        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
