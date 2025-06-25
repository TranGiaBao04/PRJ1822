<%-- 
    Document   : welcome
    Created on : Jun 20, 2025, 7:38:24 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="Login.jsp?errorNoti=You+must+log+in+first"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8fafc;
                color: #2d3748;
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                border-radius: 15px;
                margin-bottom: 30px;
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }

            .header h2 {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 5px;
            }

            .user-info {
                text-align: right;
            }

            .user-info h3 {
                font-size: 18px;
                font-weight: 500;
                margin-bottom: 10px;
                opacity: 0.95;
            }

            .logout-btn {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
                backdrop-filter: blur(10px);
            }

            .logout-btn:hover {
                background: rgba(255, 255, 255, 0.3);
                transform: translateY(-2px);
            }

            .actions-bar {
                background: white;
                padding: 25px;
                border-radius: 12px;
                margin-bottom: 25px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 15px;
            }

            .search-bar {
                display: flex;
                gap: 10px;
                flex: 1;
                min-width: 300px;
            }

            .search-bar input[type="text"] {
                flex: 1;
                padding: 12px 15px;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .search-bar input[type="text"]:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .search-bar input[type="submit"],
            .create-btn {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                white-space: nowrap;
            }

            .search-bar input[type="submit"]:hover,
            .create-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            }

            .error-message {
                background-color: #fed7d7;
                color: #c53030;
                padding: 15px 20px;
                border-radius: 8px;
                border-left: 4px solid #f56565;
                margin-bottom: 20px;
                font-weight: 500;
            }

            table {
                width: 100%;
                background: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                margin-bottom: 20px;
            }

            th {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 18px 15px;
                text-align: left;
                font-weight: 600;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            td {
                padding: 15px;
                border-bottom: 1px solid #e2e8f0;
                vertical-align: middle;
            }

            tr:last-child td {
                border-bottom: none;
            }

            tr:nth-child(even) {
                background-color: #f8fafc;
            }

            tr:hover {
                background-color: #edf2f7;
                transition: background-color 0.2s ease;
            }

            .update-form {
                display: inline-block;
            }

            .update-form button {
                background: linear-gradient(45deg, #48bb78, #38a169);
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 500;
                font-size: 12px;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .update-form button:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 15px rgba(72, 187, 120, 0.3);
            }

            .search-results-header {
                background: white;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            .search-results-header h3 {
                color: #4a5568;
                font-size: 20px;
                font-weight: 600;
            }

            .no-results {
                text-align: center;
                background: white;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                color: #718096;
            }

            .no-results h3 {
                font-size: 18px;
                font-weight: 500;
            }

            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-ideation {
                background-color: #fef5e7;
                color: #c05621;
            }

            .status-development {
                background-color: #e6fffa;
                color: #1a365d;
            }

            .status-launch {
                background-color: #f0fff4;
                color: #22543d;
            }

            .status-scaling {
                background-color: #e8f4fd;
                color: #1e40af;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .header {
                    flex-direction: column;
                    text-align: center;
                }

                .user-info {
                    text-align: center;
                    margin-top: 15px;
                }

                .actions-bar {
                    flex-direction: column;
                    align-items: stretch;
                }

                .search-bar {
                    min-width: auto;
                    flex-direction: column;
                }

                table {
                    font-size: 12px;
                }

                th, td {
                    padding: 10px 8px;
                }
            }

            @media (max-width: 480px) {
                .header h2 {
                    font-size: 24px;
                }

                table {
                    font-size: 11px;
                }

                th, td {
                    padding: 8px 5px;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty sessionScope.successMessage}">
            <script>
                alert("${sessionScope.successMessage}");
            </script>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <div class="container">
            <div class="header">
                <div>
                    <h2>Startup Project Dashboard</h2>
                </div>
                <div class="user-info">
                    <h3>Hello, ${sessionScope.user.name} (${sessionScope.user.role})</h3> 
                    <a href="MainController?action=logout" class="logout-btn">Logout</a>
                </div>
            </div>

            <div class="actions-bar">
                <form action="MainController" method="get" class="search-bar">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="searchTerm" placeholder="Search project by name...">
                    <input type="submit" value="Search">
                </form>
                <c:if test="${sessionScope.user.role eq 'Founder'}">
                    <a href="create.jsp" class="create-btn">Create Project</a>
                </c:if>
            </div>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty projects and empty projectSearch}">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Launch Date</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach var="p" items="${projects}">
                        <tr>
                            <td>${p.projectId}</td>
                            <td>${p.projectName}</td>
                            <td>${p.description}</td>
                            <td>
                                <span class="status-badge status-${p.status.toLowerCase()}">
                                    ${p.status}
                                </span>
                            </td>
                            <td>${p.estimatedLaunch}</td>
                          <c:if test="${sessionScope.user.role eq 'Founder'}"> 
                                <td>
                                <form action="MainController" method="get" class="update-form">
                                    <input type="hidden" name="action" value="updateGetPage">
                                    <input type="hidden" name="projectId" value="${p.projectId}">
                                    <button type="submit">Update</button>
                                </form>
                            </td>
                          </c:if> 
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <c:choose>
                <c:when test="${not empty projectSearch}">
                    <div class="search-results-header">
                        <h3>Search Results for "${searchTerm}"</h3>
                    </div>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Launch Date</th>
                            <c:if test="${sessionScope.user.role eq 'Founder'}">
                                <th>Action</th>
                            </c:if>
                        </tr>
                        <c:forEach var="p" items="${projectSearch}">
                            <tr>
                                <td>${p.projectId}</td>
                                <td>${p.projectName}</td>
                                <td>${p.description}</td>
                                <td>
                                    <span class="status-badge status-${p.status.toLowerCase()}">
                                        ${p.status}
                                    </span>
                                </td>
                                <td>${p.estimatedLaunch}</td>
                                <c:if test="${sessionScope.user.role eq 'Founder'}">
                                    <td>
                                    <form action="MainController" method="get" class="update-form">
                                        <input type="hidden" name="action" value="updateGetPage">
                                        <input type="hidden" name="projectId" value="${p.projectId}">
                                        <button type="submit">Update</button>
                                    </form>
                                </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <c:if test="${sessionScope.user.role eq 'Founder'}">
                        <div class="no-results">
                            <h3>No information found related to your request</h3>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>