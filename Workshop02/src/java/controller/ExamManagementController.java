/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ExamCategoriesDAO;
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
import java.util.List;
import model.Exam;
import model.ExamCategories;
import model.Questions;
import model.User;
import utils.AuthUtils;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ExamManagementController", urlPatterns = {"/ExamManagementController"})
public class ExamManagementController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String CREATE_EXAM_PAGE = "create-exam.jsp";
    private static final String ADD_QUESTIONS_PAGE = "add-questions.jsp";
    private static final String DASHBOARD_PAGE = "dashboard.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            // check login(do ng dùng có thể nhập trên thanh url nên cần check ở đây)
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            if (user == null) {
                url = LOGIN_PAGE;
                request.setAttribute("message", "Please login!");
            } else if (AuthUtils.isInstructor(request)) { // check phân quyền 
                String action = request.getParameter("action");
                if ("showCreateExam".equals(action)) {
                    url = handleShowCreateExam(request, response);
                } else if ("createExam".equals(action)) {
                    url = handleCreateExam(request, response);
                } else if ("showAddQuestions".equals(action)) {
                    url = handleShowAddQuestions(request, response);
                } else if ("addQuestions".equals(action)) {
                    url = handleAddQuestions(request, response);
                } else {
                    url = DASHBOARD_PAGE;
                }
            } else {
                url = DASHBOARD_PAGE;
                request.setAttribute("message", "Access denied! Only instructors can manage exams.");
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

    private String handleShowCreateExam(HttpServletRequest request, HttpServletResponse response) {
        try {
            ExamCategoriesDAO categoryDAO = new ExamCategoriesDAO();
            List<ExamCategories> categories = categoryDAO.readAll();
            request.setAttribute("categories", categories);

            return CREATE_EXAM_PAGE;

        } catch (Exception e) {
            request.setAttribute("message", "Error loading exam categories!");
            System.out.println("Show create exam error: " + e.getMessage());
            return DASHBOARD_PAGE;
        }
    }

    private String handleCreateExam(HttpServletRequest request, HttpServletResponse response) {
        try {
            String examTitle = request.getParameter("examTitle");
            String subject = request.getParameter("subject");
            String categoryIdStr = request.getParameter("categoryId");
            String totalMarksStr = request.getParameter("totalMarks");
            String durationStr = request.getParameter("duration");

            // Validation
            if (examTitle == null || examTitle.trim().isEmpty()
                    || subject == null || subject.trim().isEmpty()
                    || categoryIdStr == null || categoryIdStr.trim().isEmpty()
                    || totalMarksStr == null || totalMarksStr.trim().isEmpty()
                    || durationStr == null || durationStr.trim().isEmpty()) {

                request.setAttribute("message", "Please fill in all required fields!");
                return handleShowCreateExam(request, response);
            }

            int categoryId = Integer.parseInt(categoryIdStr);
            int totalMarks = Integer.parseInt(totalMarksStr);
            int duration = Integer.parseInt(durationStr);

            // Tạo exam 
            Exam exam = new Exam();
            exam.setExamTitle(examTitle.trim());
            exam.setSubject(subject.trim());
            exam.setCategoryId(categoryId);
            exam.setTotalmarks(totalMarks);
            exam.setDuration(duration);

            ExamDAO examDAO = new ExamDAO();
            boolean created = examDAO.create(exam);

            // lưu exam
            if (created) {
                request.setAttribute("message", "Exam created successfully!");
                return DASHBOARD_PAGE;
            } else {
                request.setAttribute("message", "Failed to create exam!");
                return handleShowCreateExam(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Please enter valid numbers for marks and duration!");
            return handleShowCreateExam(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error creating exam!");
            System.out.println("Create exam error: " + e.getMessage());
            return handleShowCreateExam(request, response);
        }
    }

    private String handleShowAddQuestions(HttpServletRequest request, HttpServletResponse response) {
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

            // Load questions
            QuestionDAO questionDAO = new QuestionDAO();
            List<Questions> questions = questionDAO.getQuestion(examId);

            request.setAttribute("exam", exam);
            request.setAttribute("questions", questions);

            return ADD_QUESTIONS_PAGE;
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid exam ID!");
            return DASHBOARD_PAGE;
        } catch (Exception e) {
            request.setAttribute("message", "Error loading exam details!");
            System.out.println("Show add questions error: " + e.getMessage());
            return DASHBOARD_PAGE;
        }
    }

    private String handleAddQuestions(HttpServletRequest request, HttpServletResponse response) {
        try {
            String examIdStr = request.getParameter("examId");
            String questionText = request.getParameter("questionText");
            String optionA = request.getParameter("optionA");
            String optionB = request.getParameter("optionB");
            String optionC = request.getParameter("optionC");
            String optionD = request.getParameter("optionD");
            String correctOption = request.getParameter("correctOption");

            // Validation
            if (examIdStr == null || examIdStr.trim().isEmpty()
                    || questionText == null || questionText.trim().isEmpty()
                    || optionA == null || optionA.trim().isEmpty()
                    || optionB == null || optionB.trim().isEmpty()
                    || optionC == null || optionC.trim().isEmpty()
                    || optionD == null || optionD.trim().isEmpty()
                    || correctOption == null || correctOption.trim().isEmpty()) {

                request.setAttribute("message", "Please fill in all fields!");
                return handleShowAddQuestions(request, response);
            }

            int examId = Integer.parseInt(examIdStr);

            // Validate option đúng
            if (!correctOption.matches("[ABCD]")) {
                request.setAttribute("message", "Correct option must be A, B, C, or D!");
                return handleShowAddQuestions(request, response);
            }

            // Tạo question object
            Questions question = new Questions();
            question.setExamId(examId);
            question.setQuestiontext(questionText.trim());
            question.setOption_a(optionA.trim());
            question.setOption_b(optionB.trim());
            question.setOption_c(optionC.trim());
            question.setOption_d(optionD.trim());
            question.setCorrect_option(correctOption.trim());

            // Lưu question
            QuestionDAO questionDAO = new QuestionDAO();
            boolean added = questionDAO.addQuestion(question);

            if (added) {
                request.setAttribute("message", "Question added successfully!");
            } else {
                request.setAttribute("message", "Failed to add question!");
            }

            return handleShowAddQuestions(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid exam ID!");
            return DASHBOARD_PAGE;
        } catch (Exception e) {
            request.setAttribute("message", "Error adding question!");
            System.out.println("Add question error: " + e.getMessage());
            return handleShowAddQuestions(request, response);
        }
    }

}
