

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry Something went Wrong</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <link rel="stylesheet" href="css/styles.css" type="text/css" >
        <style>
            .banner-background{
               clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 99%, 90% 83%, 46% 100%, 20% 90%, 0 95%, 0% 35%, 0 0);
            }
        </style>
    </head>
    <body>
        <div class="container text-center">
            <image src="img/error.png" class="img-fluid"/>
            <h3 class="display-3">Sorry... Something went wrong</h3>
            <%= exception%>
            <a href="index.jsp" class="btn btn-outline-secondary btn-lg text-Dark mt-3">Home</a>
        </div>
    </body>
</html>
