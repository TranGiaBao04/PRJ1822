/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.StartupProject;
import utils.DbUtils;

/**
 *
 * @author Admin
 */
public class StartupProjectDAO {

    private static final String READ_ALL_PROJECT = "SELECT * FROM tblStartupProjects";
    private static final String CREATE_PROJECT = "INSERT INTO tblStartupProjects (project_id, project_name, Description, Status, estimated_launch) VALUES(?,?,?,?,?)";
    private static final String CREATE_PROJECT_ID = " SELECT TOP 1 project_id FROM tblStartupProjects ORDER BY project_id DESC ";
    private static final String UPDATE_PROJECT = "UPDATE tblStartupProjects SET project_name = ?, Description = ?, Status = ?, estimated_launch = ? WHERE project_id = ? ";
    private static final String SEARCH_PROJECT = "SELECT * FROM tblStartupProjects where project_name like ? or Description like ? or Status like ? or estimated_launch like ? ";
    private static final String SEARCH_PROJECT_ID = "SELECT * FROM tblStartupProjects WHERE project_id = ?";

    public List<StartupProject> readAll() {
        List<StartupProject> projects = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(READ_ALL_PROJECT);
            rs = ps.executeQuery();

            while (rs.next()) {
                int projectId = rs.getInt("project_id");
                String projectName = rs.getString("project_name");
                String description = rs.getString("Description");
                String status = rs.getString("Status");
                Date estimatedLaunch = rs.getDate("estimated_launch");

                projects.add(new StartupProject(projectId, projectName, description, status, estimatedLaunch));
            }
        } catch (Exception e) {
            System.err.println("Error in readAll(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return projects;
    }

    public boolean create(StartupProject project) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(CREATE_PROJECT);

            ps.setInt(1, project.getProjectId());
            ps.setString(2, project.getProjectName());
            ps.setString(3, project.getDescription());
            ps.setString(4, project.getStatus());
            ps.setDate(5, project.getEstimatedLaunch());

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

        } catch (Exception e) {
            System.err.println("Error in create(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }

    public int createId(){
        int projectid = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try{
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(CREATE_PROJECT_ID);
            rs = ps.executeQuery();
            
            if(rs.next()){
                projectid = rs.getInt("project_id");
            }
        } catch (Exception e) {
            System.err.println("Error in createID(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return projectid + 1;
    }

    public boolean update(StartupProject project) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(UPDATE_PROJECT);

            ps.setString(1, project.getProjectName());
            ps.setString(2, project.getDescription());
            ps.setString(3, project.getStatus());
            ps.setDate(4, project.getEstimatedLaunch());
            ps.setInt(5, project.getProjectId());
            
            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);
        } catch (Exception e) {
            System.err.println("Error in update(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }

    public List<StartupProject> search(String searchTerm) {
        List<StartupProject> projects = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String search = "%" + searchTerm + "%"; //cho phép tìm chuỗi chứa searchTerm ở bất kỳ vị trí nào.
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(SEARCH_PROJECT);

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);

            rs = ps.executeQuery();

            while (rs.next()) {
                int projectId = rs.getInt("project_id");
                String projectName = rs.getString("project_name");
                String description = rs.getString("Description");
                String status = rs.getString("Status");
                Date estimatedLaunch = rs.getDate("estimated_launch");

                projects.add(new StartupProject(projectId, projectName, description, status, estimatedLaunch));
            }
        } catch (Exception e) {
            System.err.println("Error in search(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return projects;
    }
    
    public StartupProject searchId(int projectid) {
        StartupProject sp = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(SEARCH_PROJECT_ID);
            ps.setInt(1, projectid);
            rs = ps.executeQuery();

            if (rs.next()) {
                sp = new StartupProject(rs.getInt("project_id"),
                        rs.getString("project_name"),
                        rs.getString("Description"),
                        rs.getString("Status"),
                        rs.getDate("estimated_launch"));
            }

        } catch (Exception e) {
            System.err.println("Error in searchID(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return sp;
    }

    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
