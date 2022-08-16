
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
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
        <main class="primarg-Background p-5 banner-background">
            <div class="container">
                <div class="col-md-5 offset-md-3">
                    <div class="card">
                        <div class="card-header text-center text-white primarg-Background">
                            <h1>Register Here</h1>
                        </div>
                        <div class="card-body">
                            <form id="reg-form" action="RegisterServlet">
                                <div class="mb-3">
                                    <label for="Username" class="form-label">User Name</label>
                                    <input type="text" name="user_name" class="form-control" id="username" aria-describedby="emailHelp" >

                                </div>


                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <input type="email" name="user_email" class="form-control" id="InputEmail" aria-describedby="emailHelp">
                                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                </div>


                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <input type="password" name="user_password" class="form-control" id="exampleInputPassword1">
                                </div>


                                <div class="mb-3">
                                    <label for="gender" class="form-label">Select Gender</label><br>
                                    <input type="radio" class="" id="gender" value="Male" name="gender"> Male
                                    <input type="radio" class="" id="gender" value="Female" name="gender"> Female
                                </div>


                                <div class="mb-3">

                                    <textarea id="about" class="form-control" name="about" rows="4" placeholder="Enter Details about Yourself"></textarea> 

                                </div>


                                <div class="mb-3 form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="Check">
                                    <label class="form-check-label" for="Check">Terms & Condition</label>
                                </div>

                                <br>
                                <div id="loader" class="container text-center" style="display: none">
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                </div>
                                <button type="submit" id="submitBtn" disabled="disabled" class="btn btn-primary">Submit</button>
                            </form>
                        </div>

                    </div>

                </div>
            </div>
        </main>


        <!--Script-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script>
//            $(document).ready(function(){
//                alert("Done");
//            })
            $(document).ready(function () {
                var the_terms = $("#Check");

                the_terms.click(function () {
                    if ($(this).is(":checked")) {
                        $("#submitBtn").removeAttr("disabled");
                    } else {
                        $("#submitBtn").attr("disabled", "disabled");
                    }
                });
                $('#reg-form').on('submit', function (event) {
                    $("#loader").show();
                    $("#submitBtn").hide();
                    event.preventDefault();
                    let form = new FormData(this);
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#loader").hide();
                            $("#submitBtn").show();
                            if (data.trim() === 'Done') {
                                swal("Registered Successfully.. We will redirect you to login page")
                                        .then((value) => {
                                            window.location = "login.jsp";
                                        });
                            } else {
                                swal(data);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                            $("#loader").hide();
                            $("#submitBtn").show();
                            swal("Something went wrong");

                        },
                        processData: false,
                        contentType: false
                    });
                });

            });
        </script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
