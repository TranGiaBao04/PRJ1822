<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="css/styles.css"/>
        <title>Exams in ${requestScope.categoryName} - Online Exam System</title>
    </head>
    <body>
        <div>
            <header>
                <h1>Online Exam System</h1>
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
                <h2>Exams in Category: ${requestScope.categoryName}</h2>

                <c:if test="${sessionScope.user.role eq 'Student'}">
                    <div class="role-info">
                        <strong>Student View:</strong> Click "Take Exam" to start any available exam.
                    </div>
                </c:if>

                <c:if test="${sessionScope.user.role eq 'Instructor'}">
                    <div class="role-info">
                        <strong>Instructor View:</strong> Click "Add Questions" to manage exam questions.
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty requestScope.exams}">
                        <table border="1" style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr>
                                    <th>Exam Title</th>
                                    <th>Subject</th>
                                    <th>Total Marks</th>
                                    <th>Duration (minutes)</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="exam" items="${requestScope.exams}">
                                    <tr>
                                        <td>${exam.examTitle}</td>
                                        <td>${exam.subject}</td>
                                        <td>${exam.totalmarks}</td>
                                        <td>${exam.duration}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${sessionScope.user.role eq 'Student'}">
                                                    <a href="TakeExamController?action=startExam&examId=${exam.examId}" class="take-exam-btn">
                                                        Take Exam
                                                    </a>
                                                </c:when>
                                                <c:when test="${sessionScope.user.role == 'Instructor'}">
                                                    <a href="ExamManagementController?action=showAddQuestions&examId=${exam.examId}" class="manage-btn">
                                                        Add Questions
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: gray;">No actions available</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>No exams found in this category.</p>
                        <c:if test="${sessionScope.user.role eq 'Instructor'}">
                            <p><a href="ExamManagementController?action=showCreateExam">Create a new exam</a></p>
                        </c:if>
                        <c:if test="${sessionScope.user.role eq 'Student'}">
                            <p>Please check other categories or contact your instructor.</p>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
    </body>
</html>