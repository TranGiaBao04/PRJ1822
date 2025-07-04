<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/styles.css"/>
    <title>Create Exam - Online Exam System</title>
</head>
<body>
    <div>
        <header>
            <h1>Online Exam System - Create Exam</h1>
            <div>
                Welcome, ${sessionScope.user.name} (${sessionScope.user.role})
                <a href="MainController?action=logout">Logout</a>
            </div>
        </header>
        
        <nav>
            <a href="DashboardController">Back to Dashboard</a>
        </nav>
        
        <c:if test="${not empty requestScope.message}">
            <div style="color: red; margin: 10px 0;">
                ${requestScope.message}
            </div>
        </c:if>
        
        <main>
            <h2>Create New Exam</h2>
            
            <form action="MainController" method="post">
                <input type="hidden" name="action" value="createExam">
                
                <div>
                    <label for="examTitle">Exam Title:</label><br>
                    <input type="text" id="examTitle" name="examTitle" required>
                </div>
                
                <div>
                    <label for="subject">Subject:</label><br>
                    <input type="text" id="subject" name="subject" required>
                </div>
                
                <div>
                    <label for="categoryId">Category:</label><br>
                    <select id="categoryId" name="categoryId" required>
                        <option value="">Select a category</option>
                        <c:forEach var="category" items="${requestScope.categories}">
                            <option value="${category.categoryId}">${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div>
                    <label for="totalMarks">Total Marks:</label><br>
                    <input type="number" id="totalMarks" name="totalMarks" min="1" required>
                </div>
                
                <div>
                    <label for="duration">Duration (minutes):</label><br>
                    <input type="number" id="duration" name="duration" min="1" required>
                </div>
                
                <div>
                    <input type="submit" value="Create Exam">
                    <input type="button" value="Cancel" onclick="window.location.href='DashboardController'">
                </div>
            </form>
        </main>
    </div>
</body>
</html>