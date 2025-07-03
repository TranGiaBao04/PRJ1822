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
import model.ExamCategories;
import utils.DbUtils;

/**
 *
 * @author Admin
 */
public class ExamCategoriesDAO {
    
    private static final String READ_ALL_EXAMCATEGORIES = "SELECT * FROM tblExamCategories";
    
    public List<ExamCategories> readAll(){
        List<ExamCategories> examcategory = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try{
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(READ_ALL_EXAMCATEGORIES);
            rs = ps.executeQuery();
            
            while(rs.next()){
                int categoryId = rs.getInt("category_id");
                String categoryName = rs.getString("category_name");
                String description = rs.getString("description");
                
                examcategory.add(new ExamCategories(categoryId, categoryName, description));
            }
        }catch (Exception e) {
            System.err.println("Error in readAll(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return examcategory;
    }

    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null){
                rs.close();
            }
            if (ps != null){
                ps.close();
            }
            if (conn != null){
                conn.close();
            } 
        } catch (Exception e) {
            System.err.println("Error closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
