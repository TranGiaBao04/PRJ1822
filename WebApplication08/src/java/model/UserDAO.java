/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import utils.DbUtils;

/**
 *
 * @author Admin
 */
public class UserDAO {
    
    public UserDAO(){
        
    }
    
    public boolean login(String userID, String password){
        UserDTO user = getUserById(userID);
        if(user != null){
            if(user.getPassword().equals(password)){
                if(user.isStatus()){
                    return true;
                }
            }
        }
        return false;
    }

    public UserDTO getUserById(String id) {
        UserDTO user = null;
        try{
            String sql = "SELECT * FROM tblUsers WHERE userID=?";                   
            
            Connection conn = DbUtils.getConnection();
            
            PreparedStatement pr = conn.prepareStatement(sql);
            pr.setString(1, id);
            
            ResultSet rs = pr.executeQuery();
            
            while(rs.next()){
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String roleID = rs.getString("roleID");
                boolean status = rs.getBoolean("status");
                
                user = new UserDTO(userID, password, fullName, roleID, status);
            }
        }catch(Exception e){
            System.out.println(e);
        }
        return user;
    }
}
