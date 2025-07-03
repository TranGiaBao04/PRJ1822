<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exams in ${categoryName} - Online Exam System</title>
</head>
<body>
    <div>
        <header>
            <h1>Online Exam System</h1>
            <div>
                Welcome, ${user.name} (${user.role})
                <a href="UserController?action=logout">[Logout]</a>
            </div>
        </header>
        
        <nav>
            <a href="DashboardController">Back to Dashboard</a>
        </nav>
        
        <c:if test="${not empty message}">
            <div style="color: red; margin: 10px 0;">
                ${message}
            </div>
        </c:if>
        
        <main>
            <h2>Exams in Category: ${categoryName}</h2>
            
            <c:choose>
                <c:when test="${not empty exams}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Exam ID</th>
                                <th>Exam Title</th>
                                <th>Subject</th>
                                <th>Total Marks</th>
                                <th>Duration (minutes)</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="exam" items="${exams}">
                                <tr>
                                    <td>${exam.examId}</td>
                                    <td>${exam.examTitle}</td>
                                    <td>${exam.subject}</td>
                                    <td>${exam.totalmarks}</td>
                                    <td>${exam.duration}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role == 'student'}">
                                                <a href="TakeExamController?action=startExam&examId=${exam.examId}">
                                                    Take Exam
                                                </a>
                                            </c:when>
                                            <c:when test="${user.role == 'instructor'}">
                                                <a href="ExamManagementController?action=showAddQuestions&examId=${exam.examId}">
                                                    Add Questions
                                                </a>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>No exams found in this category.</p>
                    <c:if test="${user.role == 'instructor'}">
                        <p><a href="ExamManagementController?action=showCreateExam">Create a new exam</a></p>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>