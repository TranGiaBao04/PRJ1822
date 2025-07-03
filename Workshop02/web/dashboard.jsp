<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Online Exam System</title>
</head>
<body>
    <div>
        <header>
            <h1>Online Exam System - Dashboard</h1>
            <div>
                Welcome, ${user.name} (${user.role})
                <a href="UserController?action=logout">[Logout]</a>
            </div>
        </header>
        
        <c:if test="${not empty message}">
            <div style="color: red; margin: 10px 0;">
                ${message}
            </div>
        </c:if>
        
        <nav>
            <h2>Navigation</h2>
            <ul>
                <li><a href="DashboardController?action=viewCategories">View Exam Categories</a></li>
                
                <c:if test="${user.role == 'instructor'}">
                    <li><a href="ExamManagementController?action=showCreateExam">Create New Exam</a></li>
                </c:if>
            </ul>
        </nav>
        
        <main>
            <h2>Exam Categories</h2>
            
            <c:choose>
                <c:when test="${not empty categories}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Category ID</th>
                                <th>Category Name</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${categories}">
                                <tr>
                                    <td>${category.categoryId}</td>
                                    <td>${category.categoryName}</td>
                                    <td>${category.description}</td>
                                    <td>
                                        <a href="DashboardController?action=viewExamsByCategory&categoryId=${category.categoryId}&categoryName=${category.categoryName}">
                                            View Exams
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>No exam categories found.</p>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>