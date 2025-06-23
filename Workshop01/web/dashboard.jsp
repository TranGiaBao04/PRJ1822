<%-- 
    Document   : welcome
    Created on : Jun 20, 2025, 7:38:24 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="Login.jsp?errorNoti=You+must+log+in+first"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.successMessage}">
            <script>
                alert("${sessionScope.successMessage}");
            </script>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <div class="container">

            <!-- Top bar -->
            <div class="header">
                <h2>Startup Project Dashboard</h2>
                <div class="user-info">
                    <h3>Hello, ${sessionScope.user.name}</h3> 
                    <a href="MainController?action=logout" class="logout-btn">Logout</a>
                </div>
            </div>

            <!-- Action bar -->
            <div class="actions-bar">
                <form action="MainController" method="get" class="search-bar">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="searchTerm" placeholder="Search project by name...">
                    <input type="submit" value="Search">
                </form>
                <a href="create.jsp" class="create-btn"> Create Project</a>
            </div>

            <!-- Project table -->
                <c:if test="${not empty projects and empty projectSearch}">
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Launch Date</th>
                            <th>Action</th>
                        </tr>
                        <c:forEach var="p" items="${projects}">
                            <tr>
                                <td>${p.projectId}</td>
                                <td>${p.projectName}</td>
                                <td>${p.description}</td>
                                <td>${p.status}</td>
                                <td>${p.estimatedLaunch}</td>
                                <td>
                                    <form action="MainController" method="get" class="update-form">
                                        <input type="hidden" name="action" value="updateGetPage">
                                        <input type="hidden" name="projectId" value="${p.projectId}">
                                        <button type="submit">Update</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
            
            <c:choose>
                <c:when test="${not empty projectSearch}">
                    <h3>information relate " ${searchTerm} "</h3>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Launch Date</th>
                            <th>Action</th>
                        </tr>
                        <c:forEach var="p" items="${projectSearch}">
                            <tr>
                                <td>${p.projectId}</td>
                                <td>${p.projectName}</td>
                                <td>${p.description}</td>
                                <td>${p.status}</td>
                                <td>${p.estimatedLaunch}</td>
                                <td>
                                    <form action="MainController" method="get" class="update-form">
                                        <input type="hidden" name="action" value="updateGetPage">
                                        <input type="hidden" name="projectId" value="${p.projectId}">
                                        <button type="submit">Update</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <h3>Dont looking up any information relate your request</h3>
                </c:otherwise>
            </c:choose>
                

        </div>
    </body>
</html>
