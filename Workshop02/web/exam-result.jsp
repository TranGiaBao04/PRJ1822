<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/styles.css"/>
    <title>Exam Result - Online Exam System</title>
    <script>
        // Disable back button
        window.history.pushState(null, "", window.location.href);        
        window.onpopstate = function () {
            window.history.pushState(null, "", window.location.href);
        };
        
        // Prevent page refresh
        window.onbeforeunload = null;
    </script>
</head>
<body>
    <div>
        <header>
            <h1>Online Exam System - Exam Result</h1>
            <div>
                Student: ${sessionScope.user.name}
            </div>
        </header>
        
        <c:if test="${not empty requestScope.message}">
            <div style="color: orange; margin: 10px 0;">
                ${requestScope.message}
            </div>
        </c:if>
        
        <main>
            <h2>Exam Results</h2>
            
            <div style="border: 2px solid #4CAF50; padding: 20px; margin: 20px 0; background-color: #f9f9f9;">
                <h3>Exam Details</h3>
                <p><strong>Exam Title:</strong> ${requestScope.exam.examTitle}</p>
                <p><strong>Subject:</strong> ${requestScope.exam.subject}</p>
                <p><strong>Total Questions:</strong> ${requestScope.totalQuestions}</p>
                <p><strong>Total Marks:</strong> ${requestScope.exam.totalmarks}</p>
                
                <hr>
                
                <h3>Your Performance</h3>
                <p><strong>Correct Answers:</strong> ${requestScope.correctAnswers} / ${requestScope.totalQuestions}</p>
                <p><strong>Marks Obtained:</strong> ${requestScope.obtainedMarks} / ${requestScope.exam.totalmarks}</p>
                              
            </div>
            
            <div style="text-align: center; margin: 20px 0;">
                <a href="DashboardController" 
                   style="background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
                    Back to Dashboard
                </a>    
            </div>
            
        </main>
    </div>
</body>
</html>