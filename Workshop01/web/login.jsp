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
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:redirect url="dashboard.jsp"/>
            </c:when>
            <c:otherwise>
                <form action="MainController" method="post">
                <input type="hidden" name="action" value="login"/>
                UserName : <input type="text" name="strUsername" placeholder="Username" required /> <br/> 
                Password : <input type="password" name="strPassword" placeholder="Password" required/> </br>
                <input type="submit" value="Login"/>
            </form>
                <c:if test="${not empty requestScope.message}">
                    <span style="color: red">${requestScope.message}</span>
                </c:if>
            </c:otherwise>
        </c:choose>
    </body>
</html>
