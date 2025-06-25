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
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                max-width: 600px;
                margin: 0 auto;
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                animation: slideIn 0.6s ease-out;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                position: relative;
                overflow: hidden;
            }

            .header::before {
                content: '';
                position: absolute;
                top: -50%;
                right: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                animation: rotate 20s linear infinite;
            }

            @keyframes rotate {
                from { transform: rotate(0deg); }
                to { transform: rotate(360deg); }
            }

            .back-btn {
                display: inline-flex;
                align-items: center;
                background: rgba(255, 255, 255, 0.2);
                color: white;
                text-decoration: none;
                padding: 10px 20px;
                border-radius: 25px;
                font-weight: 500;
                margin-bottom: 20px;
                transition: all 0.3s ease;
                backdrop-filter: blur(10px);
                position: relative;
                z-index: 1;
            }

            .back-btn:hover {
                background: rgba(255, 255, 255, 0.3);
                transform: translateX(-5px);
            }

            .back-btn::before {
                content: '←';
                margin-right: 8px;
                font-size: 18px;
            }

            .header h2 {
                font-size: 32px;
                font-weight: 700;
                position: relative;
                z-index: 1;
            }

            .form-container {
                padding: 40px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #2d3748;
                font-weight: 600;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-group input,
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 15px 20px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-size: 16px;
                transition: all 0.3s ease;
                background-color: #f8fafc;
                font-family: inherit;
            }

            .form-group input:focus,
            .form-group textarea:focus,
            .form-group select:focus {
                outline: none;
                border-color: #667eea;
                background-color: white;
                box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
                transform: translateY(-2px);
            }

            .form-group textarea {
                resize: vertical;
                min-height: 100px;
                font-family: inherit;
            }

            .form-group select {
                cursor: pointer;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 12px center;
                background-repeat: no-repeat;
                background-size: 16px;
                appearance: none;
            }

            .error {
                color: #e53e3e;
                font-size: 13px;
                font-weight: 500;
                margin-top: 8px;
                display: block;
                padding: 8px 12px;
                background-color: #fed7d7;
                border-radius: 6px;
                border-left: 4px solid #f56565;
                animation: shake 0.5s ease-in-out;
            }

            @keyframes shake {
                0%, 20%, 40%, 60%, 80% {
                    transform: translateX(0);
                }
                10%, 30%, 50%, 70%, 90% {
                    transform: translateX(-3px);
                }
            }

            .submit-btn {
                width: 100%;
                padding: 18px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 18px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                position: relative;
                overflow: hidden;
            }

            .submit-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
                transition: left 0.6s;
            }

            .submit-btn:hover::before {
                left: 100%;
            }

            .submit-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
            }

            .submit-btn:active {
                transform: translateY(-1px);
            }

            .status-options {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
                gap: 10px;
                margin-top: 10px;
            }

            .status-indicator {
                display: inline-block;
                width: 12px;
                height: 12px;
                border-radius: 50%;
                margin-right: 8px;
            }

            .status-ideation { background-color: #ed8936; }
            .status-development { background-color: #3182ce; }
            .status-launch { background-color: #38a169; }
            .status-scaling { background-color: #805ad5; }

            .form-hint {
                font-size: 12px;
                color: #718096;
                margin-top: 5px;
                font-style: italic;
            }

            @media (max-width: 768px) {
                body {
                    padding: 10px;
                }

                .container {
                    border-radius: 15px;
                }

                .header {
                    padding: 25px 20px;
                }

                .header h2 {
                    font-size: 24px;
                }

                .form-container {
                    padding: 30px 20px;
                }

                .form-group input,
                .form-group textarea,
                .form-group select {
                    padding: 12px 15px;
                    font-size: 14px;
                }

                .submit-btn {
                    padding: 15px;
                    font-size: 16px;
                }
            }

            @media (max-width: 480px) {
                .header h2 {
                    font-size: 20px;
                }

                .form-container {
                    padding: 25px 15px;
                }

                .status-options {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <a href="javascript:history.back()" class="back-btn">Back</a>
                <h2>Startup Project</h2>
            </div>

            <div class="form-container">
                <form action="MainController" method="get">
                    <input type="hidden" name="action" value="${not empty startupProject ? 'update' : 'create'}">

                    <div class="form-group">
                        <label for="projectName">
                            <span class="status-indicator status-ideation"></span>
                            Project Name
                        </label>
                        <input type="text" id="projectName" name="projectName" 
                               value="${not empty startupProject ? startupProject.projectName : spError.projectName}" 
                               placeholder="Enter your project name..." required>
                        <c:if test="${not empty errorName}">
                            <span class="error">${errorName}</span>
                        </c:if>
                        <div class="form-hint">Choose a memorable and descriptive name for your project</div>
                    </div>

                    <div class="form-group">
                        <label for="description">
                            <span class="status-indicator status-development"></span>
                            Description
                        </label>
                        <textarea id="description" name="description" rows="4" 
                                  placeholder="Describe your project vision, goals, and key features...">${not empty startupProject ? startupProject.description : spError.description}</textarea>
                        <c:if test="${not empty errorDescription}">
                            <span class="error">${errorDescription}</span>
                        </c:if>
                        <div class="form-hint">Provide a clear overview of what your project aims to achieve</div>
                    </div>

                    <div class="form-group">
                        <label for="status">
                            <span class="status-indicator status-launch"></span>
                            Current Status
                        </label>
                        <c:set var="statusValue" value="${not empty startupProject ? startupProject.status : spError.status}" />
                        <select id="status" name="status">
                            <option value="Ideation" ${statusValue == 'Ideation' ? 'selected' : ''}>
                                💡 Ideation - Planning and conceptualizing
                            </option>
                            <option value="Development" ${statusValue == 'Development' ? 'selected' : ''}>
                                🔧 Development - Building and testing
                            </option>
                            <option value="Launch" ${statusValue == 'Launch' ? 'selected' : ''}>
                                🚀 Launch - Going to market
                            </option>
                            <option value="Scaling" ${statusValue == 'Scaling' ? 'selected' : ''}>
                                📈 Scaling - Growing and expanding
                            </option>
                        </select>
                        <div class="form-hint">Select the current phase of your project development</div>
                    </div>

                    <div class="form-group">
                        <label for="launchDate">
                            <span class="status-indicator status-scaling"></span>
                            Estimated Launch Date
                        </label>
                        <input type="date" id="launchDate" name="launchDate" 
                               value="${not empty startupProject ? startupProject.estimatedLaunch : spError.estimatedLaunch}" required>
                        <c:if test="${not empty errorDate}">
                            <span class="error">${errorDate}</span>
                        </c:if>
                        <div class="form-hint">Set a target date for your project launch or milestone</div>
                    </div>
                        
                    <c:if test="${not empty startupProject}">
                        <input type="hidden" name="projectId" value="${startupProject.projectId}">
                        <input type="hidden" name="oldLaunchDate" value="${startupProject.estimatedLaunch}">
                    </c:if>
                    
                    <input type="submit" value="${not empty startupProject ? '✨ Update Project' : '🚀 Create Project'}" class="submit-btn">
                </form>
            </div>
        </div>
    </body>
</html>