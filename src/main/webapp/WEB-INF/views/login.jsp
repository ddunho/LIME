<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>SB Admin 2 - Login</title>

    <jsp:include page="/WEB-INF/views/common/assets.jsp"/>
</head>

<body class="bg-gradient-primary">
<div class="container">
    <!-- Outer Row -->
    <div class="row justify-content-center">
        <div class="col-xl-10 col-lg-12 col-md-9">
            <div class="card o-hidden border-0 shadow-lg my-5">
                <div class="card-body p-0">
                    <!-- Nested Row within Card Body -->
                    <div class="row">
                        <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                        <div class="col-lg-6">
                            <div class="p-5">
                                <div class="text-center">
                                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                </div>

                                <form class="user" method="post" action="/login" id="loginForm">
                                    <div class="form-group">
                                        <input
                                            type="email"
                                            name="email"
                                            class="form-control form-control-user"
                                            placeholder="Enter Email Address..." />
                                    </div>

                                    <div class="form-group">
                                        <input
                                            type="password"
                                            name="password"
                                            class="form-control form-control-user"
                                            placeholder="Password" />
                                    </div>

                                    <div class="form-group">
                                        <div class="custom-control custom-checkbox small">
                                            <input
                                                type="checkbox"
                                                class="custom-control-input"
                                                id="rememberMe" />
                                            <label class="custom-control-label" for="rememberMe">
                                                Remember Me
                                            </label>
                                        </div>
                                    </div>

									<a href="index.html"
									   id="loginBtn"
									   class="btn btn-primary btn-user btn-block">
									  로그인
									</a>

                                </form>

                                <hr />

                                <div class="text-center">
                                    <a class="small" href="/membership">
                                        Create an Account!
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
	$(document).ready(function () {

	    const savedEmail = localStorage.getItem("REMEMBER_EMAIL");
	    if (savedEmail) {
	        $("input[name='email']").val(savedEmail);
	        $("#rememberMe").prop("checked", true);
	    }

	    $("#loginBtn").on("click", function (e) {
	        e.preventDefault();

	        const email = $("input[name='email']").val().trim();
	        const password = $("input[name='password']").val().trim();
	        const rememberMe = $("#rememberMe").is(":checked");

	        if (!email || !password) {
	            alert("이메일과 비밀번호를 입력해주세요.");
	            return;
	        }

	        if (rememberMe) {
	            localStorage.setItem("REMEMBER_EMAIL", email);
	        } else {
	            localStorage.removeItem("REMEMBER_EMAIL");
	        }

	        $.ajax({
	            url: "/user/login",
	            type: "POST",
	            contentType: "application/json",
	            data: JSON.stringify({ email, password }),
	            success: function () {
					alert("로그인 성공!");
	                location.href = "/";
	            },
	            error: function () {
	                alert("이메일 또는 비밀번호가 올바르지 않습니다.");
	            }
	        });
	    });
	});

</script>

</body>
</html>
