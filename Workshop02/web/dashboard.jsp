<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="css/styles.css"/>
        <title>Dashboard - Online Exam System</title>
    </head>
    <body>
        <div>
            <header>
                <h1>Online Exam System - Dashboard</h1>
                <div>
                    Welcome, ${sessionScope.user.name} (${sessionScope.user.role})
                    <a href="MainController?action=logout">Logout</a>
                </div>
            </header>

            <c:if test="${not empty requestScope.message}">
                <div style="color: red; margin: 10px 0;">
                    ${requestScope.message}
                </div>
            </c:if>

            <nav>
                <h2>Quick Actions</h2>

                <c:if test="${sessionScope.user.role eq 'Instructor'}">
                    <div class="instructor-actions">
                        <h3>Instructor Actions</h3>
                        <a href="ExamManagementController?action=showCreateExam" class="nav-button">Create New Exam</a>
                        <a href="DashboardController?action=viewCategories" class="nav-button">View All Categories</a>
                    </div>
                </c:if>

                <c:if test="${sessionScope.user.role eq 'Student'}">
                    <div class="student-actions">
                        <h3>Student Actions</h3>
                        <a href="DashboardController?action=viewCategories" class="nav-button">Browse Exams</a>
                    </div>
                </c:if>
            </nav>

            <main>
                <h2>Exam Categories</h2>

                <c:choose>
                    <c:when test="${not empty requestScope.categories}">
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>Category Name</th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="category" items="${requestScope.categories}">
                                    <tr>
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