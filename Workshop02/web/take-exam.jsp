<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/styles.css"/>
    <title>Taking Exam - Online Exam System</title>
    <script>
        let startTimeMillis = ${examStartTime};
        let durationMinutes = ${requestScope.exam.duration};

        function updateTimer() {
            let now = new Date().getTime();
            let elapsedMillis = now - startTimeMillis;// thời gian trôi qua
            let remainingMillis = (durationMinutes * 60 * 1000) - elapsedMillis;//thời gian còn lại

            if (remainingMillis <= 0) {
                    document.getElementById("timer").innerHTML = "Time expired!";
                    document.getElementById("examForm").submit();
            } else {
                    let minutes = Math.floor(remainingMillis / (1000 * 60));// tính số phút còn lại
                    let seconds = Math.floor((remainingMillis % (1000 * 60)) / 1000);// tính số giây còn lại
                    document.getElementById("timer").innerHTML = minutes + "m " + seconds + "s";
                }
            }

            setInterval(updateTimer, 1000);
        function confirmSubmit() {
            return confirm('Are you sure you want to submit your exam? This action cannot be undone.');
        }   
    </script>
</head>
<body>
    <div>
        <header>
            <h1>Online Exam System</h1>
            <div>
                Student: ${sessionScope.user.name}
            </div>
        </header>
        
        <main>
            <h2>Taking Exam: ${requestScope.exam.examTitle}</h2>
            <p><strong>Time Remaining:</strong> <span id="timer"></span></p>
            <div style="background-color: #f0f0f0; padding: 15px; margin: 10px 0; border-radius: 5px;">
                <p><strong>Subject:</strong> ${requestScope.exam.subject}</p>
                <p><strong>Total Marks:</strong> ${requestScope.exam.totalmarks}</p>
                <p><strong>Duration:</strong> ${requestScope.exam.duration} minutes</p>
                <p><strong>Total Questions:</strong> ${requestScope.questions.size()}</p>
                <p style="color: red;"><strong>Instructions:</strong> Select one answer for each question. Click Submit when finished.</p>
            </div>
            
            <hr>
            
            <form id="examForm" action="TakeExamController" method="post" onsubmit="return confirmSubmit()">
                <input type="hidden" name="action" value="submitExam">
                <input type="hidden" name="examId" value="${requestScope.exam.examId}">
                
                <c:forEach var="question" items="${requestScope.questions}" varStatus="status">
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