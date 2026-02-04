<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<c:set var="contextPath" value="/WEB-INF/views" scope="application" />
<!DOCTYPE html>
<html>
  <jsp:include page="../common/head.jsp" />

  <body class="bg-gradient-primary">
    <div class="container">
      <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
          <!-- Nested Row within Card Body -->
          <div class="row">
            <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
            <div class="col-lg-7">
              <div class="p-5">
                <div class="text-center">
                  <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                </div>
                <form class="user" id="userForm">
                  <div class="form-group">
                    <input
                      type="text"
                      class="form-control form-control-user"
                      id="userNm"
                      name="userNm"
                      placeholder="이름"
                    />
                  </div>
                  <div class="form-group row">
                    <div class="col-sm-9 mb-3 mb-sm-0">
                      <input
                        type="text"
                        id="userEmail"
                        name="userEmail"
                        email-check="N"
                        class="form-control form-control-user"
                        placeholder="이메일주소"
                      />
                    </div>
                    <div class="col-sm-3">
                      <a
                        href="#"
                        class="btn btn-primary btn-user btn-block"
                        id="checkEmail"
                      >
                        중복확인
                      </a>
                    </div>
                  </div>
                  <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                      <input
                        type="password"
                        class="form-control form-control-user"
                        id="userPw"
                        name="userPw"
                        placeholder="비밀번호"
                      />
                    </div>
                    <div class="col-sm-6">
                      <input
                        type="password"
                        class="form-control form-control-user"
                        id="userPwCheck"
                        name="userPwCheck"
                        placeholder="비밀번호 확인"
                      />
                    </div>
                  </div>
                  <div class="form-group">
                    <input
                      type="text"
                      class="form-control form-control-user"
                      id="userPhone"
                      name="userPhone"
                      placeholder="휴대폰번호"
                    />
                  </div>
                  <div class="form-group row">
                    <div class="col-sm-9 mb-3 mb-sm-0">
                      <input
                        type="text"
                        id="userAddress"
                        name="userAddress"
                        class="form-control form-control-user"
                        placeholder="주소"
                        readonly="readonly"
                      />
                    </div>
                    <div class="col-sm-3">
                      <a
                        href="#"
                        id="searchAddress"
                        class="btn btn-primary btn-user btn-block"
                      >
                        주소찾기
                      </a>
                    </div>
                  </div>
                  <div class="form-group">
                    <input
                      type="text"
                      id="userAddressDetail"
                      name="userAddressDetail"
                      class="form-control form-control-user"
                      placeholder="상세주소"
                    />
                  </div>
                  <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                      <input
                        type="text"
                        id="userAddressCode"
                        name="userAddressCode"
                        class="form-control form-control-user"
                        placeholder="우편번호"
                        readonly="readonly"
                      />
                    </div>
                    <div class="col-sm-6">
                      <input
                        type="text"
                        id="userAddressExtra"
                        name="userAddressExtra"
                        class="form-control form-control-user"
                        placeholder="참고사항"
                        readonly="readonly"
                      />
                    </div>
                  </div>

                  <a
                    href="#"
                    id="createUser"
                    class="btn btn-primary btn-user btn-block"
                  >
                    Register Account
                  </a>
                </form>
                <hr />
                <div class="text-center">
                  <a class="small" href="login"
                    >Already have an account? Login!</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
  <script>
    $(function () {
      validate.addValidate("userNm", {
        regType: "ID",
        required: "Y",
        title: "닉네임",
        msgType: "TEXT",
        maxLength: 10,
      });
      validate.addValidate("userEmail", {
        regType: "EMAIL",
        required: "Y",
        title: "이메일",
        msgType: "ALERT",
      });
      validate.addValidate("userPw", {
        regType: "PASSWORD",
        required: "Y",
        title: "비밀번호",
        msgType: "ALERT",
        maxLength: 15,
      });
      validate.addValidate("userPwCheck", {
        regType: "PASSWORD",
        required: "Y",
        title: "비밀번호확인",
        msgType: "ALERT",
        maxLength: 15,
      });
      validate.addValidate("userPhone", {
        regType: "PHONE",
        required: "Y",
        title: "휴대폰번호",
        msgType: "ALERT",
        maxLength: 13,
      });
      validate.addValidate("userAddress", { required: "Y", title: "주소" });
      validate.addValidate("userAddressCode", {
        required: "Y",
        title: "우편번호",
      });

      $("#userPwCheck").change(function () {
        checkPassword();
      });

      $("#checkEmail").click(function () {
        const emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        const emailVal = $("#userEmail").val();
		
	     let content = "@1234 test";
	     
	     const prefix = "@1234 ";
	     const test = content.replaceAll(prefix, "").trim();
		 const test2 = content.replaceAll(prefix, "");
	     
		 console.log("test : '" + test + "'");
		 console.log("test : '" + test2 + "'");
		     
		
		
		
        if (!emailReg.test(emailVal)) {
          gfnAlert("이메일 형식이 아닙니다.");
          return false;
        }

        ajaxCall(
          "/checkEmail",
          "POST",
          { userEmail: emailVal },
          checkEmailCallbackFnc
        );
      });

      /* 주소찾기 */
      $("#searchAddress").click(function () {
        daumPostcode(
          "userAddressCode",
          "userAddress",
          "userAddressDetail",
          "userAddressExtra"
        );
      });

      $("#createUser").click(function () {
        if (!gfnAlert("회원가입을 하시겠습니까?", "confirm")) {
          return false;
        }

        if ($("#userEmail").attr("email-check") != "Y") {
          gfnAlert("이메일 체크가 필요합니다다.");
          return false;
        }

        if (!checkPassword()) {
          return false;
        }

        if (!validate.checkValidate()) {
          return false;
        }

        $("#userPhone").val($("#userPhone").val().replaceAll("-", ""));

        ajaxCall("/createUser", "POST", "userForm", createUserCallbackFnc);
      });
    });

    function checkPassword() {
      if ($("#userPw").val() != $("#userPwCheck").val()) {
        gfnAlert("비밀번호가 다릅니다.");
        return false;
      }
      return true;
    }

    function checkEmailCallbackFnc(res) {
      if (res.result == true) {
        gfnAlert("사용 가능한 이메일입니다.");
        $("#userEmail").attr("email-check", "Y");
        $("#userEmail").change(function () {
          $("#userEmail").attr("email-check", "N");
        });
      } else {
        gfnAlert("사용 불가능한 이메일입니다.");
        $("#userEmail").attr("email-check", "N");
      }
    }

    function createUserCallbackFnc(res) {
      if (res.result == true) {
        gfnAlert("회원가입이 완료되었습니다.");
        location.href = "/login";
      } else {
        gfnAlert("회원가입이 실패되었습니다.");
      }
    }
  </script>
</html>
