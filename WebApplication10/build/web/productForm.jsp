<%-- 
    Document   : productForm
    Created on : Jun 6, 2025, 10:35:51 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<%@page import="model.ProductDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Form</title>
    </head>
    <body>
        <% if (AuthUtils.isAdmin(request)){
            String checkError = (String)request.getAttribute("checkError");
            String message = (String)request.getAttribute("message");
            ProductDTO product  = (ProductDTO)request.getAttribute("product");
            Boolean isEdit = (Boolean)request.getAttribute("isEdit")!=null;
            String keyword = (String)request.getAttribute("keyword");
        %>
        <div class="header">
            <a href="Welcome.jsp"> Back to Products</a>
            <h1><%=isEdit ? "EDIT PRODUCT" : "ADD PRODUCT"%></h1>
        </div>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="addProduct"/>
            <input type="hidden" name="action" value="<%=isEdit ? "updateProduct" : "addProduct"%>"/>
            <div> 
                <label for="id"/> ID* </label> 
                <input type="text" id="id" name="id" required="required"
                       value="<%= product!=null?product.getId():""%>/>"
                       <%=isEdit ? "readonly" : ""%>
                       />
            </div>

            <div> 
                <label for="name"/> Name* </label> 
                <input type="text" id="name" name="name" required="required"
                       value="<%= product!=null?product.getName():""%>/>
            </div>

            <div> 
                <label for="image"/> Image </label> 
                <input type="text" id="image" name="image"
                       value="<%= product!=null?product.getImage():""%>/>
            </div>

            <div> 
                <label for="description"/> Description </label> 
                <textarea  id="description" name="description">
                    <%=product!=null?product.getDescription():""%>
                </textarea>
            </div>
            
            <div> 
                <label for="price"/> Price* </label> 
                <input type="text" id="price" name="price" required="required"
                       value="<%=product!=null?product.getPrice():""%>"/>
            </div>

            <div> 
                <label for="size"/> Size </label> 
                <input type="text" id="size" name="size"
                       value="<%=product!=null?product.getSize():""%>"/>
            </div>
            
            <div>            
                <input type="checkbox" id="status" name="status"
                    <%=product!=null&&product.isStatus()?" checked='checked' ":""%>/>
                <label for="status"/> Active Product </label> 
            </div>
            
            <div> 
                <input type="hidden" name="keyword" value="<%=keyword!=null?keyword:""%>"/>
                <input type="submit" value="<%=isEdit ? "Update Product" : "Add Product"%>"/>
                <input type="reset" value="Reset"/>    
            </div>
        </form>
        <% if(checkError != null && !checkError.isEmpty()) { %>
                <div class="error-message"><%=checkError%></div>
                <% } else if(message != null&& !message.isEmpty()) { %>
                <div class="success-message"><%=message%></div>
                <% } %>
            </div>

            <%
        }else {
            %>
            <div class="header">
                <h1>ACCESS DENIED</h1>
            </div>
            <div class="access-denied">
                <%=AuthUtils.getAccessDeniedMessage("Product Form")%> 
            </div>
            <%
        }
            %>
    </body>
</html>
