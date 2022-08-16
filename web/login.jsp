<%@page import="com.tech.daily.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <link rel="stylesheet" href="css/styles.css" type="text/css" >
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 99%, 77% 95%, 50% 100%, 20% 97%, 0 100%, 0% 35%, 0 0);
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <main class="d-flex align-items-center primarg-Background banner-background" style="height: 75vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div class="card-header primarg-Background text-white text-center">
                                <h1>Login  Here </h1>
                            </div>
                            <div class="card-body">
                                <form action="LoginServlet" method="Post">
                                    <div class="mb-3">
                                        <label for="Email" class="form-label">Email address</label>
                                        <input type="email" required name="email" class="form-control" id="Email1" aria-describedby="emailHelp">
                                        <!--<div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>-->
                                    </div>
                                    <div class="mb-3">
                                        <label for="Password" class="form-label">Password</label>
                                        <input type="password" name="password" required class="form-control" id="Password1">
                                    </div>
<!--                                    <div class="alert alert-danger" role="alert">
                                        A simple danger alert—check it out!
                                    </div>-->
                                    <%
                                        Message m = (Message)session.getAttribute("msg");
                                        if (m != null) {
                                    %>
                                    <div class="alert <%= m.getCssClass() %>" role="alert">
                                        <%= m.getContent()%>
                                    </div>
                                    <%
                                        session.removeAttribute("msg");
                                        }
                                    %>

                                    <div class="container text-center">

                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </main>


        <!--Script-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
        <script>
//            $(document).ready(function(){
//                alert("Done");
//            })
        </script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
