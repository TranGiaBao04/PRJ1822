/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.User;

/**
 *
 * @author Admin
 */
public class UserDAO {
    
    public UserDAO(){
        
    }
    
    public boolean login(String userID,String password){
        
    }
    
    public User getUserById(String id){
        User us = null;
        try{
            String sql = "SELECT * FROM tblUsers WHERE userID=?";
        }catch(Exception e){
            System.out.println(e);
        }
        return us;
    }
}
