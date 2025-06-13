    <%-- 
    Document   : Welcome
    Created on : May 23, 2025, 10:17:04 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<%@page import="java.util.List" %>
<%@page import="model.ProductDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if(AuthUtils.isLoggedIn(request)){
                UserDTO user = AuthUtils.getCurrentUser(request);
                String keyword = (String) request.getAttribute("keyword");
        %>
        <h1>Welcome <%= user.getFullName() %>!</h1>
        <a href="MainController?action=logout">Logout</a>
        <hr/>
        <form action="MainController" method="post" >
            <input type="hidden" name="action" value="searchProduct"/>
            Search product by name:
            <input type="text" name="keyword" value="<%=keyword!=null?keyword:""%>"/>
            <input type="submit" value="Search"/> 
        </form>
        <br/>
        <% if(AuthUtils.isAdmin(request)){ %>
        <a href="productForm.jsp">Add Product</a>
        <% } %>
        <% 
            List<ProductDTO> list = (List<ProductDTO>)request.getAttribute("list");
            if(list!=null && list.isEmpty()){
            %>
            No products have name match with the keyword.
            <%
            }else if(list!=null && !list.isEmpty()){
            %>
            <table>
                <thead>
                <th>Id</th>
                <th>Name</th>
                <th>Image</th>
                <th>Description</th>
                <th>Price</th>
                <th>Size</th>
                <th>Status</th>
                </thead>
                <tbody>
                    <% for(ProductDTO p : list){ %>
                    <tr>
                        <td><%=p.getId()%></td>
                        <td><%=p.getName()%></td>
                        <td><%=p.getImage()%></td>
                        <td><%=p.getDescription()%></td>
                        <td><%=p.getPrice()%></td>
                        <td><%=p.getSize()%></td>
                        <td data-label="Status">
                            <span>
                                <%=p.isStatus() ? "Active" : "Inactive"%>
                            </span> 
                        </td>
                        <% if(AuthUtils.isAdmin(request)){ %>
                        <td data-label="Action">
                            <form action="MainController" method="post">
                                <input type="hidden" name="action" value="editProduct" />
                                <input type="hidden" name="productId" value="<%=p.getId()%>"/>
                                <input type="hidden" name="keyword" value="<%=keyword!=null?keyword:""%>" />
                                <input type="submit" value="Edit"/>
                            </form>
                            <form action="MainController" method="get">
                                <input type="hidden" name="action" value="changeProductStatus"/>
                                <input type="hidden" name="productId" value="<%=p.getId()%>"/>
                                <input type="hidden" name="keyword" value="<%=keyword!=null?keyword:""%>" />
                                <input type="submit" value="Delete"
                                       onclick="return confirm('Are you sure you want to delete this product?')"/>
                            </form>
                        </td>
                        <% } %>
                    </tr>
                    <% } %>
                </tbody>
            </table>
                <%
            }
        %>
        <%}else{ %>
            <%=AuthUtils.getAccessDeniedMessage("Welcome.jsp")%> <br/>
            (Or <a href="<%=AuthUtils.getLoginURL()%>">Login</a>)
        <%}%>
    </body>
</html>
