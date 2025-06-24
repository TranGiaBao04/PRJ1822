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


            <div class="header">
                <h2>Startup Project Dashboard</h2>
                <div class="user-info">
                    <h3>Hello, ${sessionScope.user.name} (${sessionScope.user.role})</h3> 
                    <a href="MainController?action=logout" class="logout-btn">Logout</a>
                </div>
            </div>

                <div class="actions-bar">
                    <form action="MainController" method="get" class="search-bar">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="searchTerm" placeholder="Search project by name...">
                        <input type="submit" value="Search">
                    </form>
                    <c:if test="${sessionScope.user.role eq 'Founder'}">
                        <a href="create.jsp" class="create-btn"> Create Project</a>
                    </c:if>
                </div>
                    <c:if test="${not empty error}">
                        <div class="error-message" style="color: red; padding: 10px; margin: 10px 0;">
                            ${error}
                        </div>
                    </c:if>


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
                          <c:if test="${sessionScope.user.role eq 'Founder'}"> 
                                <td>
                                <form action="MainController" method="get" class="update-form">
                                    <input type="hidden" name="action" value="updateGetPage">
                                    <input type="hidden" name="projectId" value="${p.projectId}">
                                    <button type="submit">Update</button>
                                </form>
                            </td>
                          </c:if> 
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <c:choose>
                <c:when test="${not empty projectSearch}">
                    <h3>Information Relate " ${searchTerm} "</h3>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Launch Date</th>
                            <c:if test="${sessionScope.user.role eq 'Founder'}">
                                <th>Action</th>
                            </c:if>
                        </tr>
                        <c:forEach var="p" items="${projectSearch}">
                            <tr>
                                <td>${p.projectId}</td>
                                <td>${p.projectName}</td>
                                <td>${p.description}</td>
                                <td>${p.status}</td>
                                <td>${p.estimatedLaunch}</td>
                                <c:if test="${sessionScope.user.role eq 'Founder'}">
                                    <td>
                                    <form action="MainController" method="get" class="update-form">
                                        <input type="hidden" name="action" value="updateGetPage">
                                        <input type="hidden" name="projectId" value="${p.projectId}">
                                        <button type="submit">Update</button>
                                    </form>
                                </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <c:if test="${sessionScope.user.role eq 'Founder'}">
                        <h3>Dont looking up any information relate your request</h3>
                    </c:if>
                </c:otherwise>
            </c:choose>


        </div>
    </body>
</html>
