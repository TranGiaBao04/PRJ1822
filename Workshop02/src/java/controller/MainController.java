/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "MainController", urlPatterns = {"","/MainController"})
public class MainController extends HttpServlet {
    
    private static final String LOGIN_PAGE = "login.jsp";
    
    private boolean isUserAction(String action){
        return "login".equals(action)
                || "logout".equals(action);
    }
    
    private boolean isDashboardAction(String action){
        return "viewCategories".equals(action)
                || "viewExamsByCategory".equals(action)
                || "dashboard".equals(action);
    }
    
    private boolean isExamManagementAction(String action){
        return "showCreateExam".equals(action)
                || "createExam".equals(action)
                || "showAddQuestions".equals(action)
                || "addQuestions".equals(action);
    }
    
    private boolean isTakeExamAction(String action){
        return "startExam".equals(action)
                || "submitExam".equals(action);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try  {
            String action = request.getParameter("action");
            if(isUserAction(action)){
                url = "/UserController";
            }else if(isDashboardAction(action)){
                url = "/DashboardController";
            }else if(isExamManagementAction(action)){
                url = "/ExamManagementController";
            }else if(isTakeExamAction(action)) {
                url = "/TakeExamController";
            }
        }catch(Exception e){ 
        }finally{
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

}
