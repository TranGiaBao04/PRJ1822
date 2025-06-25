<%-- 
    Document   : login
    Created on : Jun 20, 2025, 7:38:36 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .login-container {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                animation: slideIn 0.5s ease-out;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .login-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .login-header h2 {
                color: #333;
                font-size: 28px;
                font-weight: 600;
                margin-bottom: 5px;
            }

            .login-header p {
                color: #666;
                font-size: 14px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
                font-size: 14px;
            }

            .form-group input {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e1e5e9;
                border-radius: 8px;
                font-size: 16px;
                transition: all 0.3s ease;
                background-color: #fafafa;
            }

            .form-group input:focus {
                outline: none;
                border-color: #667eea;
                background-color: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .form-group input::placeholder {
                color: #aaa;
            }

            .login-btn {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .login-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            }

            .login-btn:active {
                transform: translateY(0);
            }

            .error-message {
                background-color: #fee;
                color: #c53030;
                padding: 12px 15px;
                border-radius: 8px;
                border-left: 4px solid #f56565;
                margin-top: 15px;
                font-size: 14px;
                animation: shake 0.5s ease-in-out;
            }

            @keyframes shake {
                0%, 20%, 40%, 60%, 80% {
                    transform: translateX(0);
                }
                10%, 30%, 50%, 70%, 90% {
                    transform: translateX(-5px);
                }
            }

            .welcome-message {
                text-align: center;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            }

            .welcome-message h2 {
                font-size: 24px;
                margin-bottom: 10px;
            }

            .welcome-message p {
                font-size: 16px;
                opacity: 0.9;
            }

            @media (max-width: 480px) {
                .login-container {
                    margin: 20px;
                    padding: 30px 25px;
                }
                
                .login-header h2 {
                    font-size: 24px;
                }
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:redirect url="dashboard.jsp"/>
            </c:when>
            <c:otherwise>
                <div class="login-container">
                    <div class="login-header">
                        <h2>Welcome Back</h2>
                        <p>Please sign in to your account</p>
                    </div>
                    
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="login"/>
                        
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="strUsername" placeholder="Enter your username" required />
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