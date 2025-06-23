<%-- 
    Document   : create
    Created on : Jun 22, 2025, 9:52:49 PM
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
        <title>Create Project</title>
    </head>
    <body>
        <div class="container">
            <a href="javascript:history.back()" class="back-btn"> Back</a>

            <h2>Startup Project</h2>

            <form action="MainController" method="get">
                <input type="hidden" name="action" value="${not empty startupProject ? 'update' : 'create'}">

                <label>Project Name:</label>
                <input type="text" name="projectName" value="${not empty startupProject ? startupProject.projectName : spError.projectName}" required>
                <c:if test="${not empty errorName}">
                    <span class="error">${errorName}</span>
                </c:if>

                <label>Description:</label>
                <textarea name="description" rows="3">${not empty startupProject ? startupProject.description : spError.description}</textarea>
                <c:if test="${not empty errorDescription}">
                    <span class="error">${errorDescription}</span>
                </c:if>

                <label>Status:</label>
                <c:set var="statusValue" value="${not empty startupProject ? startupProject.status : spError.status}" />
                <select name="status">
                    <option value="Ideation" ${statusValue == 'Ideation' ? 'selected' : ''}>Ideation</option>
                    <option value="Development" ${statusValue == 'Development' ? 'selected' : ''}>Development</option>
                    <option value="Launch" ${statusValue == 'Launch' ? 'selected' : ''}>Launch</option>
                    <option value="Scaling" ${statusValue == 'Scaling' ? 'selected' : ''}>Scaling</option>
                </select>

                <label>Launch Date:</label>
                <input type="date" name="launchDate" value="${not empty startupProject ? startupProject.estimatedLaunch : spError.estimatedLaunch}" required>
                <c:if test="${not empty errorDate}">
                    <span class="error">${errorDate}</span>
                </c:if>
                    
                <c:if test="${not empty startupProject}">
                    <input type="hidden" name="projectId" value="${startupProject.projectId}">
                    <input type="hidden" name="oldLaunchDate" value="${startupProject.estimatedLaunch}">
                </c:if>
                <input type="submit" value="${not empty startupProject ? 'Update Project' : 'Create Project'}">
            </form>
        </div>
    </body>
</html>
