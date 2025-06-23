/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StartupProjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import model.StartupProject;
import utils.AuthUtils;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProjectController", urlPatterns = {"/ProjectController"})
public class ProjectController extends HttpServlet {

    private static String CREATE_PAGE = "create.jsp";
    private static String DASHBOARD_PAGE = "dashboard.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = DASHBOARD_PAGE;
        String action = request.getParameter("action");
        StartupProjectDAO spDAO = new StartupProjectDAO();

        try {
            // Kiểm tra quyền truy cập - chỉ Founder mới được thực hiện các thao tác với project
            if (!AuthUtils.isFounder(request)) {
                request.setAttribute("error", AuthUtils.getAccessDeniedMessage(" manage projects"));
                // Vẫn hiển thị danh sách project cho TeamMember xem (chỉ xem, không thao tác)
                List<StartupProject> list = spDAO.readAll();
                request.setAttribute("projects", list);
                url = DASHBOARD_PAGE;
            } else {
                // Chỉ Founder mới được thực hiện các thao tác này
                if ("create".equals(action)) {
                    url = validateProject(request, response, action);
                } else if ("search".equals(action)) {
                    String searchTerm = request.getParameter("searchTerm");
                    if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                        List<StartupProject> list = spDAO.search(searchTerm.trim());
                        request.setAttribute("projectSearch", list);
                        request.setAttribute("searchTerm", searchTerm);
                        System.out.println("Search results: " + list.size() + " projects found");
                    } else {
                        // Nếu search term rỗng, hiển thị tất cả
                        List<StartupProject> list = spDAO.readAll();
                        request.setAttribute("projectSearch", list);
                        request.setAttribute("message", "Please enter search term");
                    }
                    url = DASHBOARD_PAGE;
                } else if ("updateGetPage".equals(action)) {
                    int projectId = Integer.parseInt(request.getParameter("projectId"));
                    StartupProject sp = spDAO.searchId(projectId);
                    if (sp != null) {
                        request.setAttribute("startupProject", sp);
                        url = CREATE_PAGE;
                    } else {
                        request.setAttribute("error", "Project not found");
                        url = DASHBOARD_PAGE;
                    }
                } else if ("update".equals(action)) {
                    url = validateProject(request, response, action);
                } else {
                    // Default: show all projects
                    List<StartupProject> list = spDAO.readAll();
                    request.setAttribute("projects", list);
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid project ID");
            url = DASHBOARD_PAGE;
        } catch (Exception e) {
            request.setAttribute("error", "Failed to process request: " + e.getMessage());
            e.printStackTrace(); // For debugging
            url = DASHBOARD_PAGE;
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    protected String validateProject(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {

        String url = DASHBOARD_PAGE;
        StartupProjectDAO spdao = new StartupProjectDAO();

        // Lấy dữ liệu form
        String projectName = request.getParameter("projectName");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        Date launchDate = Date.valueOf(request.getParameter("launchDate"));

        int projectId = "update".equals(action)
                ? Integer.parseInt(request.getParameter("projectId"))
                : spdao.createId();

        // Validate từng phần
        boolean isValid = true;

        if (!validateName(request, projectName)) {
            isValid = false;
        }
        if (!validateDescription(request, description)) {
            isValid = false;
        }
        if (!validateStatus(request, status)) {
            isValid = false;
        }
        if ("update".equals(action)) {
            if (!validateUpdateLaunchDate(request, launchDate)) {
                isValid = false;
            }
        } else {
            if (!validateCreateLaunchDate(request, launchDate)) {
                isValid = false;
            }
        }

        // Xử lý khi hợp lệ
        if (isValid) {
            StartupProject sp = new StartupProject(projectId, projectName, description, status, launchDate);
            boolean result = "update".equals(action) ? spdao.update(sp) : spdao.create(sp);

            if (result) {
                request.getSession().setAttribute("successMessage",
                        "update".equals(action) ? "Project updated successfully." : "Project created successfully.");
                List<StartupProject> projs = spdao.readAll();
                request.setAttribute("projects", projs);
            } else {
                request.setAttribute("error", "Database operation failed.");
                url = CREATE_PAGE;
            }
        } else {
            url = CREATE_PAGE;
            StartupProject spError = new StartupProject(projectId, projectName, description, status, launchDate);
            request.setAttribute("spError", spError);
            request.setAttribute("error", "Create/Update failed.");
        }

        return url;
    }

    private boolean validateName(HttpServletRequest request, String name) {
        if (name == null || name.trim().length() < 3 || name.trim().length() > 100) {
            request.setAttribute("errorName", "Project name must be between 3 and 100 characters.");
            return false;
        }
        return true;
    }

    private boolean validateDescription(HttpServletRequest request, String desc) {
        if (desc == null || desc.trim().length() < 10) {
            request.setAttribute("errorDescription", "Description must be at least 10 characters.");
            return false;
        }
        return true;
    }

    private boolean validateStatus(HttpServletRequest request, String status) {
        List<String> validStatuses = Arrays.asList("Ideation", "Development", "Launch", "Scaling");
        if (status == null || !validStatuses.contains(status)) {
            request.setAttribute("errorStatus", "Invalid status selected.");
            return false;
        }
        return true;
    }

    private boolean validateCreateLaunchDate(HttpServletRequest request, Date launchDate) {
        if (launchDate == null) {
            request.setAttribute("errorDate", "Launch date is required.");
            return false;
        }
        Date today = Date.valueOf(LocalDate.now());
        if (launchDate.before(today)) {
            request.setAttribute("errorDate", "Launch date must be in the future.");
            return false;
        }
        return true;
    }

    private boolean validateUpdateLaunchDate(HttpServletRequest request, Date newLaunchDate) {
        try {
            Date oldLaunchDate = Date.valueOf(request.getParameter("oldLaunchDate"));
            if (newLaunchDate.before(oldLaunchDate)) {
                request.setAttribute("errorDate", "New launch date must be after old launch date.");
                return false;
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorDate", "Invalid old launch date.");
            return false;
        }
        return true;
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
