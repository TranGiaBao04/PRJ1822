<%-- 
    Document   : login
    Created on : Jun 27, 2025, 2:11:12 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/styles.css"/>
        <title>Login</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:redirect url="dashboard.jsp"/>
            </c:when>
            <c:otherwise>
                <div class="login-container">
                    <div class="login-header">
                        <h1>Welcome Back</h1>
                        <p>Please sign in to your account</p>
                    </div>
                    
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="login"/>
                        
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="strUsername" placeholder="Enter your username" required/>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="strPassword" placeholder="Enter your password" required/>
                        </div>
                        
                        <input type="submit" value="Sign In" class="login-btn"/>
                    </form>
                    
                    <c:if test="${not empty requestScope.message}">
                        <div class="error-message">${requestScope.message}</div> 
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>
