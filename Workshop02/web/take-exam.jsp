<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Taking Exam - Online Exam System</title>
    <script>
        // Timer functionality
        let timeLeft = ${exam.duration} * 60; // Convert minutes to seconds
        
        function updateTimer() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            document.getElementById('timer').innerHTML = 
                `Time Remaining: ${minutes}:${seconds.toString().padStart(2, '0')}`;
            
            if (timeLeft <= 0) {
                alert('Time is up! Submitting exam...');
                document.getElementById('examForm').submit();
                return;
            }
            
            timeLeft--;
        }
        
        function startTimer() {
            updateTimer();
            setInterval(updateTimer, 1000);
        }
        
        function confirmSubmit() {
            return confirm('Are you sure you want to submit your exam? This action cannot be undone.');
        }
        
        window.onload = startTimer;
        
        // Prevent page refresh/back
        window.onbeforeunload = function() {
            return "Are you sure you want to leave? Your exam progress will be lost.";
        };
    </script>
</head>
<body>
    <div>
        <header>
            <h1>Online Exam System</h1>
            <div>
                Student: ${user.name}
                <span id="timer" style="font-weight: bold; color: red;"></span>
            </div>
        </header>
        
        <main>
            <h2>${exam.examTitle}</h2>
            <p><strong>Subject:</strong> ${exam.subject}</p>
            <p><strong>Total Marks:</strong> ${exam.totalmarks}</p>
            <p><strong>Duration:</strong> ${exam.duration} minutes</p>
            <p><strong>Total Questions:</strong> ${questions.size()}</p>
            
            <hr>
            
            <form id="examForm" action="TakeExamController" method="post" onsubmit="return confirmSubmit()">
                <input type="hidden" name="action" value="submitExam">
                <input type="hidden" name="examId" value="${exam.examId}">
                
                <c:forEach var="question" items="${questions}" varStatus="status">
                    <div style="border: 1px solid #ccc; margin: 15px 0; padding: 15px;">
                        <h3>Question ${status.index + 1}</h3>
                        <p>${question.questiontext}</p>
                        
                        <div>
                            <input type="radio" id="q${question.questionId}_a" 
                                   name="question_${question.questionId}" value="A">
                            <label for="q${question.questionId}_a">A) ${question.option_a}</label>
                        </div>
                        
                        <div>
                            <input type="radio" id="q${question.questionId}_b" 
                                   name="question_${question.questionId}" value="B">
                            <label for="q${question.questionId}_b">B) ${question.option_b}</label>
                        </div>
                        
                        <div>
                            <input type="radio" id="q${question.questionId}_c" 
                                   name="question_${question.questionId}" value="C">
                            <label for="q${question.questionId}_c">C) ${question.option_c}</label>
                        </div>
                        
                        <div>
                            <input type="radio" id="q${question.questionId}_d" 
                                   name="question_${question.questionId}" value="D">
                            <label for="q${question.questionId}_d">D) ${question.option_d}</label>
                        </div>
                    </div>
                </c:forEach>
                
                <div style="text-align: center; margin: 20px 0;">
                    <input type="submit" value="Submit Exam" 
                           style="background-color: #4CAF50; color: white; padding: 10px 20px; font-size: 16px;">
                </div>
            </form>
        </main>
    </div>
</body>
</html>