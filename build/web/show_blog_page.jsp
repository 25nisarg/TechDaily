<%-- 
    Document   : show_blog_page
    Created on : 17 Aug, 2022, 4:03:43 PM
    Author     : Admin
--%>
<%@page import="com.tech.daily.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.daily.dao.UserDao"%>
<%@page import="com.tech.daily.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.daily.helper.ConnectionProvider"%>
<%@page import="com.tech.daily.dao.PostDao"%>
<%@page import="com.tech.daily.entities.Post"%>
<%@page import="com.tech.daily.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }

    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%> || Tech Daily</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <link rel="stylesheet" href="css/styles.css" type="text/css" >
        <style>
            body{
                background: url(img/bg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 99%, 90% 83%, 46% 100%, 20% 90%, 0 95%, 0% 35%, 0 0);
            }
            .post-title{
                font-weight: 200;
                font-size: 30px;
            }
            .post-content{
                font-weight: 200;
                font-size: 24px;

            }
            .row-user{
                border: 1px solid black;
                padding-top: 15px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;

            }
            .post-user-info{
                font-weight: 400;
                font-size: 20px;
            }

        </style>

    </head>
<body>

    <!--navbar start-->
    <nav class="navbar navbar-expand-lg bg-dark navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-desktop"></span> Tech Daily</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="profile.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal">Do Post</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Categories
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Programming Languages</a></li>
                            <li><a class="dropdown-item" href="#">Projects</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Data Structure</a></li>
                        </ul>
                    </li>

                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#profile-model"><span class="fa fa-user"></span> <%=user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span> Logout</a>
                    </li>

                </ul>
                <!--                    <form class="d-flex" role="search">
                                        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                                        <button class="btn btn-outline-secondary text-light" type="submit">Search</button>
                                    </form>-->
            </div>
        </div>
    </nav>  
    <!--navbar end-->

    <!--main body-->

    <div class="container">
        <div class="row my-4">
            <div class="col-md-8 offset-md-2 ">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h4 class="post-title"><%=p.getpTitle()%></h4>
                    </div>
                    <div class="card-body">
                        <img src="blog_pics/<%=p.getpPic()%>" class="card-img-top my-2" alt="...">
                        <div class="row my-3 row-user">
                            <div class="col-md-8">
                                <p class="post-user-info">
                                    <% UserDao ud = new UserDao(ConnectionProvider.getConnection());%>
                                    <a href="#"><%= ud.getUserByUserId(p.getUserId()).getName()%></a>Has Posted: 
                                </p>
                            </div>
                            <div class="col-md-4">
                                <p class="post-date">
                                    <%= DateFormat.getDateTimeInstance().format(p.getpDate())%>
                                </p>
                            </div>
                        </div>
                        <p class="post-content"><%=p.getpContent()%></p>
                        <br/>
                        <br/>
                        <div class="post-code">
                            <pre><%=p.getpCode()%></pre>
                        </div>
                    </div>
                    <div class="card-footer bg-dark">
                        <%
                            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());

                        %>
                        <a href="" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= ld.countLikeOnPost(p.getPid())%></span></a>
                       
                    </div>
                   

                </div>
            </div>
        </div>
    </div>

    <!--end of main body-->




    <!--profile model-->
    <!-- Modal -->
    <div class="modal fade" id="profile-model" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header primarg-Background text-white">
                    <h5 class="modal-title" id="UserModalLabel">Tech Daily</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <img src="pics/<%=user.getProfile()%>" alt="User profile" width="120px" class="image-fluid" style="border-radius:5px"/>
                        <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>
                        <!--detail-->
                        <div id="profile-details">
                            <table class="table">

                                <tbody>
                                    <tr>
                                        <th scope="row">ID</th>
                                        <td><%= user.getId()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td><%= user.getEmail()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Gender</th>
                                        <td colspan="2"><%= user.getGender()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">About</th>
                                        <td colspan="2"><%= user.getAbout()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Registered On</th>
                                        <td colspan="2"><%= user.getDateTime().toString()%></td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!--profile edit-->
                        <div id="profile-edit" style="display: none">
                            <h3 class="mt-3">Please Edit Carefully</h3>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID:</td>
                                        <td><%= user.getId()%></td>
                                    </tr>
                                    <tr>
                                        <td>Email:</td>
                                        <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Name:</td>
                                        <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Password:</td>
                                        <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Gender:</td>
                                        <td><%= user.getGender().toUpperCase()%></td>
                                    </tr>
                                    <tr>
                                        <td>About:</td>
                                        <td>
                                            <textarea class="form-control" name="user_about"><%= user.getAbout()%></textarea>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>Profile Pic:</td>
                                        <td>
                                            <input type="file" name="image" class="form-control"/>
                                        </td>
                                    </tr>

                                </table>
                                <div class="container">
                                    <button type="submit" class="btn btn-outline-primary">Save</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>


    <!--end of profile model-->
    <!--start of add post model-->



    <!-- Button trigger modal -->
    <!--        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Launch demo modal
            </button>-->

    <!-- Modal -->
    <div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="PostModalLabel">Provide The Post Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AddPostServlet" method="post" id="add-post-form">
                        <div class="form-group">

                            <select class="form-control" name="cid">
                                <option selected disabled>---Select Category---</option>
                                <%
                                    PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = postd.getCategories();
                                    for (Category c : list) {
                                        //                                    System.out.println(c.getName());

                                %>

                                <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                <%
                                    }
                                %>

                            </select>
                        </div>

                        <div class="form-group mt-2">
                            <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control"/>
                        </div>
                        <div class="form-group mt-2">
                            <textarea name="pContent" class="form-control" rows="5" placeholder="Enter Your Content"></textarea>
                        </div>
                        <div class="form-group mt-2">
                            <textarea name="pCode" class="form-control" rows="4" placeholder="Enter Your Program(if any)"></textarea>
                        </div>
                        <div class="form-group mt-2">
                            <input type="file" name="pPic" placeholder="Select Pic" class="form-control"/>
                        </div>
                        <div class="mt-2 container text-center">
                            <button type="submit" class="btn btn-outline-primary">Post</button>
                        </div>

                    </form>
                </div>
                <!--                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary">Save changes</button>
                                    </div>-->
            </div>
        </div>
    </div>



    <!--end of post model-->

    <!--java script-->

    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script>
                            $(document).ready(function () {
                                let editStatus = false;
                                $('#edit-profile-button').click(function () {
                                    if (editStatus === false) {
                                        $("#profile-details").hide();
                                        $("#profile-edit").show();
                                        editStatus = true;
                                        $(this).text("Back");
                                    } else {
                                        $("#profile-details").show();
                                        $("#profile-edit").hide();
                                        editStatus = false;
                                        $(this).text("Edit");
                                    }

                                })
                            });
    </script>
    <!--now add post js-->
    <script>
        $(document).ready(function (e) {
//                alert("Loaded")
            $("#add-post-form").on("submit", function (event) {
                event.preventDefault();
                let form = new FormData(this);
                $.ajax({
                    url: "AddPostServlet",
                    type: 'POST',
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
//                            alert("hello");
                        if (data.trim() === 'Done') {
                            swal("Good job!", "Saved Successfully!", "success");

                        } else {

                            swal("Ooppppsss!", "Something Went Wrong!", "error");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {

                    },
                    processData: false,
                    contentType: false
                });
            });
        });
    </script>
    <script src="js/myjs.js"></script>
</body>
</html>
