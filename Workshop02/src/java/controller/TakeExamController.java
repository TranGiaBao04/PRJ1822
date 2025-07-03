/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ExamDAO;
import dao.QuestionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Exam;
import model.Questions;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "TakeExamController", urlPatterns = {"/TakeExamController"})
public class TakeExamController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String TAKE_EXAM_PAGE = "take-exam.jsp";
    private static final String EXAM_RESULT_PAGE = "exam-result.jsp";
    private static final String DASHBOARD_PAGE = "dashboard.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;

        try {
            // Check login
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            if (user == null) {
                url = LOGIN_PAGE;
                request.setAttribute("message", "Please login!");
            } else {
                String action = request.getParameter("action");

                if ("startExam".equals(action)) {
                    url = handleStartExam(request, response);
                } else if ("submitExam".equals(action)) {
                    url = handleSubmitExam(request, response);
                } else {
                    url = DASHBOARD_PAGE;
                }
            }
        } catch (Exception e) {
            request.setAttribute("message", "System error. Please try again!");
            System.out.println("TakeExam error: " + e.getMessage());
            e.printStackTrace();
            url = DASHBOARD_PAGE;
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private String handleStartExam(HttpServletRequest request, HttpServletResponse response) {
        try {
            String examIdStr = request.getParameter("examId");

            if (examIdStr == null || examIdStr.trim().isEmpty()) {
                request.setAttribute("message", "Invalid exam selection!");
                return DASHBOARD_PAGE;
            }

            int examId = Integer.parseInt(examIdStr);

            // Load chi tiết exam
            ExamDAO examDAO = new ExamDAO();
            Exam exam = examDAO.detail(examId);

            if (exam == null) {
                request.setAttribute("message", "Exam not found!");
                return DASHBOARD_PAGE;
            }

            // Load questions cho exam
            QuestionDAO questionDAO = new QuestionDAO();
            List<Questions> questions = questionDAO.getQuestion(examId);

            if (questions == null || questions.isEmpty()) {
                request.setAttribute("message", "No questions found for this exam!");
                return DASHBOARD_PAGE;
            }

            // lưu thời gian làm exam trong session
            HttpSession session = request.getSession();
            session.setAttribute("examStartTime", System.currentTimeMillis());
            session.setAttribute("examDuration", exam.getDuration());

            request.setAttribute("exam", exam);
            request.setAttribute("questions", questions);

            return TAKE_EXAM_PAGE;

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid exam ID!");
            return DASHBOARD_PAGE;
        } catch (Exception e) {
            request.setAttribute("message", "Error starting exam!");
            System.out.println("Start exam error: " + e.getMessage());
            return DASHBOARD_PAGE;
        }
    }

    private String handleSubmitExam(HttpServletRequest request, HttpServletResponse response) {
        try {
            String examIdStr = request.getParameter("examId");

            if (examIdStr == null || examIdStr.trim().isEmpty()) {
                request.setAttribute("message", "Invalid exam submission!");
                return DASHBOARD_PAGE;
            }

            int examId = Integer.parseInt(examIdStr);

            // check xem thời gian làm bài hết chưa
            HttpSession session = request.getSession();
            Long startTime = (Long) session.getAttribute("examStartTime");
            Integer duration = (Integer) session.getAttribute("examDuration");

            if (startTime != null && duration != null) {
                long elapsedTime = (System.currentTimeMillis() - startTime) / (1000 * 60); // phút
                if (elapsedTime > duration) {
                    request.setAttribute("message", "Exam time has expired!");
                    // Vẫn tính điểm nhưng cảnh báo hết giờ
                }
            }

            // Load exam và questions
            ExamDAO examDAO = new ExamDAO();
            Exam exam = examDAO.detail(examId);

            QuestionDAO questionDAO = new QuestionDAO();
            List<Questions> questions = questionDAO.getQuestion(examId);

            if (exam == null || questions == null || questions.isEmpty()) {
                request.setAttribute("message", "Error loading exam data!");
                return DASHBOARD_PAGE;
            }

            // Tính điểm
            int correctAnswers = 0;
            int totalQuestions = questions.size();

            for (Questions question : questions) {
                String userAnswer = request.getParameter("question_" + question.getQuestionId());
                if (userAnswer != null && userAnswer.equals(question.getCorrect_option())) {
                    correctAnswers++;
                }
            }

            int obtainedMarks = (correctAnswers * exam.getTotalmarks()) / totalQuestions;

            // Lưu kết quả trong phiên và yêu cầu
            User user = (User) session.getAttribute("user");

            // Clean data trong session
            session.removeAttribute("examStartTime");
            session.removeAttribute("examDuration");

            // Đặt lại kết quả
            request.setAttribute("exam", exam);
            request.setAttribute("correctAnswers", correctAnswers);
            request.setAttribute("totalQuestions", totalQuestions);
            request.setAttribute("obtainedMarks", obtainedMarks);
            request.setAttribute("studentName", user.getName());

            return EXAM_RESULT_PAGE;

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid exam data!");
            return DASHBOARD_PAGE;
        } catch (Exception e) {
            request.setAttribute("message", "Error submitting exam!");
            System.out.println("Submit exam error: " + e.getMessage());
            return DASHBOARD_PAGE;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
