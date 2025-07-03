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
import model.Questions;
import utils.DbUtils;

/**
 *
 * @author Admin
 */
public class QuestionDAO {

    private static final String ADD_QUESTION = "INSERT INTO tblQuestions (question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES(?,?,?,?,?,?,?,?)";
    private static final String GET_QUESTION = "SELECT * FROM tblQuestions WHERE exam_id = ?";

    public boolean addQuestion(Questions question) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(ADD_QUESTION);

            ps.setInt(1, question.getQuestionId());
            ps.setInt(2, question.getExamId());
            ps.setString(3, question.getQuestiontext());
            ps.setString(4, question.getOption_a());
            ps.setString(5, question.getOption_b());
            ps.setString(6, question.getOption_c());
            ps.setString(7, question.getOption_d());
            ps.setString(8, question.getCorrect_option());

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);
        } catch (Exception e) {
            System.err.println("Error in add quesstion(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }

    public List<Questions> getQuestion(int examId) {
        List<Questions> ques = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_QUESTION);
            ps.setInt(1, examId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int questionId = rs.getInt("question_id");
                String questiontext = rs.getString("question_text");
                String option_a = rs.getString("option_a");
                String option_b = rs.getString("option_b");
                String option_c = rs.getString("option_c");
                String option_d = rs.getString("option_d");
                String correct_option = rs.getString("correct_option");

                ques.add(new Questions(questionId, examId, questiontext, option_a, option_b, option_c, option_d, correct_option));
            }
        } catch (Exception e) {
            System.err.println("Error in get quessions(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return ques;
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
