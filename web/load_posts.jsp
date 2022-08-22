<%@page import="com.tech.daily.entities.User"%>
<%@page import="com.tech.daily.dao.LikeDao"%>
<%@page import="java.util.*"%>
<%@page import="com.tech.daily.entities.Post"%>
<%@page import="com.tech.daily.helper.ConnectionProvider"%>
<%@page import="com.tech.daily.dao.PostDao"%>
<div class="row">

    <%
        User uu=(User)session.getAttribute("currentUser");
//        Thread.sleep(1000);
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPost();
        } else {
            posts = d.getPostById(cid);
        }
        if (posts.size() == 0) {
            out.println("<H3 class='display-3 text-center'>No Post in this category</H3>");
        }
        for (Post p : posts) {
    %>

    <div class="col-md-6 mt-2">
        <div class="card" >
            <img src="blog_pics/<%=p.getpPic()%>" class="card-img-top" alt="...">
            <div class="card-body">
                <b><%= p.getpTitle()%></b>
                <p><%= p.getpContent()%></p>

            </div>
            <div class="card-footer bg-dark text-center">
                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                %>
                <a href="" onclick="doLike(<%= p.getPid()%>,<%= uu.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= ld.countLikeOnPost(p.getPid())%></span></a>

                <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>" class="btn btn-outline-light btn-sm">Read More</a>
                <!--<a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span> 5</span></a>-->
            </div>
        </div>
    </div>

    <%
        }
    %>
</div>