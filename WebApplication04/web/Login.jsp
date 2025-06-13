<%-- 
    Document   : Login
    Created on : May 23, 2025, 9:50:31 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Object objMS = request.getAttribute("message");
            String msg = (objMS==null)?"":(objMS+"");
        %>
        <form action="Maincontroller" method="post">
            <input type="hidden" name="action" value="Login"/>
            UserID: <input type="text" name="strUserID" /> <br/>
            Password: <input type="password" name="strPassword"/> <br/>
            <input type="submit" value="Login"/>
        </form>
        <span style="color: red"><%=msg%></span>
    </body>
</html>
