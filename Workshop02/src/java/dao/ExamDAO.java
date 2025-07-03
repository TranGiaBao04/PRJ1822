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
import model.Exam;
import utils.DbUtils;

/**
 *
 * @author Admin
 */
public class ExamDAO {

    public static final String READ_ALL_EXAM = "SELECT * FROM tblExams WHERE category_id = ?";
    public static final String CREATE_EXAM = "INSERT INTO tblExams (exam_id, exam_title, Subject, category_id, total_marks, Duration) VALUES(?,?,?,?,?,?)";
    public static final String UPDATE_EXAM = "UPDATE tblExams SET exam_title = ?, Subject = ?, category_id = ?, total_marks = ?, Duration = ? WHERE exam_id = ? ";
    public static final String DETAIL_EXAM = "SELECT * FROM tblExams WHERE exam_id = ?";
    public static final String DELETE_EXAM = "DELETE FROM tblExams WHERE exam_id= ?";

    public List<Exam> readAll(int categoryId) {
        List<Exam> exam = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(READ_ALL_EXAM);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int examId = rs.getInt("exam_id");
                String examTitle = rs.getString("exam_title");
                String subject = rs.getString("Subject");
                int totalmarks = rs.getInt("total_marks");
                int duration = rs.getInt("Duration");

                exam.add(new Exam(examId, examTitle, subject, categoryId, totalmarks, duration));
            }
        } catch (Exception e) {
            System.err.println("Error in readAll(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return exam;
    }

    public boolean create(Exam exam) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(CREATE_EXAM);

            ps.setInt(1, exam.getExamId());
            ps.setString(2, exam.getExamTitle());
            ps.setString(3, exam.getSubject());
            ps.setInt(4, exam.getCategoryId());
            ps.setInt(5, exam.getTotalmarks());
            ps.setInt(6, exam.getDuration());

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

    public boolean update(Exam exam) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(UPDATE_EXAM);

            ps.setString(1, exam.getExamTitle());
            ps.setString(2, exam.getSubject());
            ps.setInt(3, exam.getCategoryId());
            ps.setInt(4, exam.getTotalmarks());
            ps.setInt(5, exam.getDuration());
            ps.setInt(6, exam.getExamId());

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

    public Exam detail(int examId) {
        Exam exam = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(DETAIL_EXAM);
            ps.setInt(1, examId);
            rs = ps.executeQuery();

            while (rs.next()) {
                String exam_title = rs.getString("exam_title");
                String subject = rs.getString("Subject");
                int category_id = rs.getInt("category_id");
                int total_marks = rs.getInt("total_marks");
                int duration = rs.getInt("Duration");

                exam = new Exam(examId, exam_title, subject, category_id, total_marks, duration);
            }
        } catch (Exception e) {
            System.err.println("Error in detail(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return exam;
    }

    public boolean remove(int examId) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(DELETE_EXAM);
            ps.setInt(1, examId);

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

        } catch (Exception e) {
            System.err.println("Error in remove(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
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
