/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ExamCategoriesDAO;
import dao.ExamDAO;
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
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DashboardController", urlPatterns = {"/DashboardController"})
public class DashboardController extends HttpServlet {

    private static final String DASHBOARD_PAGE = "dashboard.jsp";
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String EXAMS_BY_CATEGORY_PAGE = "exams-by-category.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = DASHBOARD_PAGE;
        try {
            // check login(do ng dùng có thể nhập trên thanh url nên cần check ở đây)
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            if (user == null) {
                url = LOGIN_PAGE;
                request.setAttribute("message", "Please login!");
            } else {
                String action = request.getParameter("action");

                if ("viewCategories".equals(action)) {
                    url = handleViewCategories(request, response);
                } else if ("viewExamsByCategory".equals(action)) {
                    url = handleViewExamsByCategory(request, response);
                } else {
                    // default dashboard action
                    url = handleDashboard(request, response);
                }
            }
        } catch (Exception e) {
            request.setAttribute("message", "System error. Please try again!");
            System.out.println("Dashboard error: " + e.getMessage());
            e.printStackTrace();
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

    private String handleViewCategories(HttpServletRequest request, HttpServletResponse response) {
        try {
            ExamCategoriesDAO categoryDAO = new ExamCategoriesDAO();
            List<ExamCategories> categories = categoryDAO.readAll();

            request.setAttribute("categories", categories);

        } catch (Exception e) {
            request.setAttribute("message", "Error loading exam categories!");
            System.out.println("Categories load error: " + e.getMessage());
        }
        return DASHBOARD_PAGE;
    }

    private String handleViewExamsByCategory(HttpServletRequest request, HttpServletResponse response) {
       try{
           String categoryIdStr = request.getParameter("categoryId");
           String categoryName = request.getParameter("categoryName");
           
           if(categoryIdStr != null && !categoryIdStr.trim().isEmpty()){
               int categoryId = Integer.parseInt(categoryIdStr);
               
               ExamDAO examDAO = new ExamDAO();
               List<Exam> exams = examDAO.readAll(categoryId);
               
               request.setAttribute("exams", exams);
               request.setAttribute("categoryName", categoryName);
               request.setAttribute("categoryId", categoryId);
               
               return EXAMS_BY_CATEGORY_PAGE;
           }else {
               request.setAttribute("message", "Invalid category selection!");
           }
           
       }catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid category ID!");
        } catch (Exception e) {
            request.setAttribute("message", "Error loading exams!");
            System.out.println("Exams load error: " + e.getMessage());
        }
       // nếu lỗi trả về dashboard
       return handleDashboard(request, response);
    }

    private String handleDashboard(HttpServletRequest request, HttpServletResponse response) {
        try {
            ExamCategoriesDAO categoryDAO = new ExamCategoriesDAO();
            List<ExamCategories> categories = categoryDAO.readAll();

            request.setAttribute("categories", categories);
        } catch (Exception e) {
            request.setAttribute("message", "Error loading dashboard data!");
            System.out.println("Dashboard load error: " + e.getMessage());
        }
        return DASHBOARD_PAGE;
    }
}
