/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;
import utils.DbUtils;

/**
 *
 * @author Admin
 */
public class UserDAO {
    
    public UserDAO(){
        
    }
    
    public boolean login(String username,String password){
       User us = getUserByNameId(username);
       if(us!=null){
           if(us.getPassword().equals(password)){
               return true;
           }
       }
       return false;
    }
    
    public User getUserByNameId(String nameId){
        User us = null;
        try{
            // tao sql
            String sql = "SELECT * FROM tblUsers WHERE username=?";
            //ket noi
            Connection conn = DbUtils.getConnection();
            // tao cong cu de thuc thi cau lenh sql
            PreparedStatement pr = conn.prepareStatement(sql);
            pr.setString(1, nameId);
            // thuc thi lenh
            ResultSet rs = pr.executeQuery();
            // duyet bang
            while(rs.next()){
                String username = rs.getString("username");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String role = rs.getString("role");
                
                us = new User(username, name, password, role);
            }
        }catch(Exception e){
            System.out.println(e);
        }
        return us;
    }
}
