<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Questions - Online Exam System</title>
</head>
<body>
    <div>
        <header>
            <h1>Online Exam System - Add Questions</h1>
            <div>
                Welcome, ${user.name} (${user.role})
                <a href="UserController?action=logout">[Logout]</a>
            </div>
        </header>
        
        <nav>
            <a href="DashboardController">Back to Dashboard</a>
        </nav>
        
        <c:if test="${not empty message}">
            <div style="color: green; margin: 10px 0;">
                ${message}
            </div>
        </c:if>
        
        <main>
            <h2>Add Questions to: ${exam.examTitle}</h2>
            <p><strong>Subject:</strong> ${exam.subject}</p>
            <p><strong>Total Marks:</strong> ${exam.totalmarks}</p>
            <p><strong>Duration:</strong> ${exam.duration} minutes</p>
            
            <hr>
            
            <h3>Add New Question</h3>
            
            <form action="ExamManagementController" method="post">
                <input type="hidden" name="action" value="addQuestions">
                <input type="hidden" name="examId" value="${exam.examId}">
                
                <div>
                    <label for="questionText">Question:</label><br>
                    <textarea id="questionText" name="questionText" rows="3" cols="50" required></textarea>
                </div>
                
                <div>
                    <label for="optionA">Option A:</label><br>
                    <input type="text" id="optionA" name="optionA" required>
                </div>
                
                <div>
                    <label for="optionB">Option B:</label><br>
                    <input type="text" id="optionB" name="optionB" required>
                </div>
                
                <div>
                    <label for="optionC">Option C:</label><br>
                    <input type="text" id="optionC" name="optionC" required>
                </div>
                
                <div>
                    <label for="optionD">Option D:</label><br>
                    <input type="text" id="optionD" name="optionD" required>
                </div>
                
                <div>
                    <label for="correctOption">Correct Answer:</label><br>
                    <select id="correctOption" name="correctOption" required>
                        <option value="">Select correct answer</option>
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                        <option value="D">D</option>
                    </select>
                </div>
                
                <div>
                    <input type="submit" value="Add Question">
                </div>
            </form>
            
            <hr>
            
            <h3>Existing Questions</h3>
            
            <c:choose>
                <c:when test="${not empty questions}">
                    <p><strong>Total Questions:</strong> ${questions.size()}</p>
                    
                    <c:forEach var="question" items="${questions}" varStatus="status">
                        <div style="border: 1px solid #ccc; margin: 10px 0; padding: 10px;">
                            <h4>Question ${status.index + 1}</h4>
                            <p><strong>Q:</strong> ${question.questiontext}</p>
                            <p><strong>A:</strong> ${question.option_a}</p>
                            <p><strong>B:</strong> ${question.option_b}</p>
                            <p><strong>C:</strong> ${question.option_c}</p>
                            <p><strong>D:</strong> ${question.option_d}</p>
                            <p><strong>Correct Answer:</strong> ${question.correct_option}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>No questions added yet. Add the first question above.</p>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>