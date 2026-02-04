<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib prefix="spring"
uri="http://www.springframework.org/tags" %>
<spring:eval
  expression="@environment.getProperty('recaptcha.secretKey')"
  var="secretKey"
/>
<c:set var="contextPath" value="/WEB-INF/views" scope="application" />
<!DOCTYPE html>
<html>
  <jsp:include page="../common/head.jsp" />
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
                    <form id="loginForm">
                      <div class="form-group">
                        <input
                          type="text"
                          class="form-control form-control-user"
                          aria-describedby="emailHelp"
                          id="userEmail"
                          name="userEmail"
                          placeholder="Enter Email Address..."
                        />
                      </div>
                      <div class="form-group">
                        <input
                          type="password"
                          id="userPw"
                          name="userPw"
                          class="form-control form-control-user"
                          placeholder="Password"
                        />
                      </div>
                      <div class="form-group">
                        <div class="custom-control custom-checkbox small">
                          <input
                            type="checkbox"
                            id="reEmail"
                            class="custom-control-input"
                          />
                          <label class="custom-control-label" for="reEmail"
                            >Remember Me</label
                          >
                        </div>
                      </div>
                    </form>
                    <a
                      href="#"
                      id="login"
                      class="btn btn-primary btn-user btn-block"
                    >
                      로그인
                    </a>
                    <hr />
                    <div class="text-center">
                      <a class="small" href="#" id="goMembership"
                        >Create an Account!</a
                      >
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
  <script>
    const emailKey = "USER_EMAIL";

    $(function () {
      if (localStorage.getItem(emailKey) != "") {
        $("#userEmail").val(localStorage.getItem(emailKey));
        $("#reEmail").prop("checked", true);
      }

      $("#login").click(function () {
        ajaxCall("/login", "POST", "loginForm", loginCallbackFnc);
      });

      $("#userPw").on("keydown", function (e) {
        if (e.keyCode === 13) {
          $("#login").click();
        }
      });

      $("#goMembership").click(function () {
        location.href = "/membership";
      });
    });

    function loginCallbackFnc(res) {
      if (res.result == true) {
        gfnAlert("로그인 되었습니다.");

        var userEmail = $("#reEmail").is(":checked")
          ? $("#userEmail").val()
          : "";
        localStorage.setItem(emailKey, userEmail);

        location.href = "/";
      } else {
        gfnAlert("이메일 혹은 비밀번호가 다릅니다.");
      }
    }
  </script>
</html>
