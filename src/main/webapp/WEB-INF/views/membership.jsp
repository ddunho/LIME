<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

    <title>Register</title>

    <jsp:include page="/WEB-INF/views/common/assets.jsp"/>
</head>

<body class="bg-gradient-primary">

<div class="container">
    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <div class="row">

                <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>

                <div class="col-lg-7">
                    <div class="p-5">

                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                        </div>

                        <form class="user" method="post" action="/user/signup">

                            <!-- username -->
                            <div class="form-group">
                                <input type="text"
                                       class="form-control form-control-user"
                                       name="username"
                                       maxlength="10"
                                       placeholder="이름 (최대 10글자)"/>
                                <small id="usernameMsg"></small>
                            </div>

                            <!-- email -->
                            <div class="form-group row">
                                <div class="col-sm-9 mb-3 mb-sm-0">
                                    <input type="email"
                                           class="form-control form-control-user"
                                           name="email"
                                           maxlength="254"
                                           placeholder="이메일주소 (최대 254글자)"/>
                                    <small id="emailMsg"></small>
                                </div>
                                <div class="col-sm-3">
                                    <button type="button"
                                            class="btn btn-primary btn-user btn-block"
                                            onclick="checkEmail()">
                                        중복확인
                                    </button>
                                </div>
                            </div>

                            <!-- password -->
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="password"
                                           class="form-control form-control-user"
                                           name="password"
                                           maxlength="15"
                                           placeholder="비밀번호 (8-15자)"/>
                                </div>
                                <div class="col-sm-6">
                                    <input type="password"
                                           class="form-control form-control-user"
                                           name="passwordConfirm"
                                           maxlength="15"
                                           placeholder="비밀번호 확인"/>
                                </div>
                            </div>

                            <!-- phone -->
                            <div class="form-group">
                                <input type="text"
                                       class="form-control form-control-user"
                                       name="phone"
                                       maxlength="13"
                                       placeholder="휴대폰번호 (010-0000-0000)"/>
                            </div>

                            <!-- address -->
                            <div class="form-group row">
                                <div class="col-sm-9 mb-3 mb-sm-0">
                                    <input type="text"
                                           class="form-control form-control-user"
                                           name="address"
                                           readonly
                                           placeholder="주소"/>
                                </div>
                                <div class="col-sm-3">
                                    <button type="button"
                                            class="btn btn-primary btn-user btn-block"
                                            onclick="execDaumPostCode()">
                                        주소찾기
                                    </button>
                                </div>
                            </div>

                            <div class="form-group">
                                <input type="text"
                                       class="form-control form-control-user"
                                       name="addressDetail"
                                       placeholder="상세주소"/>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="text"
                                           class="form-control form-control-user"
                                           name="zipcode"
                                           readonly
                                           placeholder="우편번호"/>
                                </div>
                                <div class="col-sm-6">
                                    <input type="text"
                                           class="form-control form-control-user"
                                           name="addressExtra"
                                           readonly
                                           placeholder="참고사항"/>
                                </div>
                            </div>

                            <a href="#"
                               id="btnSignup"
                               class="btn btn-primary btn-user btn-block">
                                Register Account
                            </a>
                        </form>

                        <hr/>

                        <div class="text-center">
                            <a class="small" href="/login">
                                Already have an account? Login!
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<script>
$(document).ready(function() {

    const $form = $('form.user');
    const $usernameMsg = $('#usernameMsg');
    const $emailMsg = $('#emailMsg');
    const $emailInput = $form.find('input[name="email"]');

    let isUsernameValid = false;
    let isEmailValid = false;

    /*--------------------------------------------username--------------------------------------------*/

    $('input[name="username"]').on('input', function () {
        //영문, 숫자만 허용하고 10글자 제한
        $(this).val($(this).val().replace(/[^a-zA-Z0-9]/g, ""));

        //입력 내용 변경 시 중복확인 초기화
        isUsernameValid = false;
        $('#usernameMsg').text('');
    });

	$('input[name="username"]').on('blur', function () {
	    const username = $(this).val();

	    //빈 값 체크
	    if (!username) {
	        $('#usernameMsg')
	            .text('닉네임을 입력해주세요.')
	            .css('color', 'red');
	        isUsernameValid = false;
	        return;
	    }

	    //길이 체크
	    if (username.length > 10) {
	        $('#usernameMsg')
	            .text('닉네임은 10글자 이하로 입력해주세요.')
	            .css('color', 'red');
	        isUsernameValid = false;
	        return;
	    }
	    
	    //중복 확인
	    $.ajax({
	        type: 'POST',
	        url: '/user/check-userName',
	        contentType: 'application/json',
	        data: JSON.stringify({ userName: username }),
	        success: function (isDuplicate) {
	            if (!isDuplicate) {
	                $('#usernameMsg')
	                    .text('사용 가능한 닉네임입니다.')
	                    .css('color', 'green');
	                isUsernameValid = true;
	            } else {
	                $('#usernameMsg')
	                    .text('이미 존재하는 닉네임입니다.')
	                    .css('color', 'red');
	                isUsernameValid = false;
	            }
	        },
	        error: function () {
	            $('#usernameMsg')
	                .text('중복 확인 중 오류가 발생했습니다.')
	                .css('color', 'red');
	            isUsernameValid = false;
	        }
	    });
    });

    /*--------------------------------------------email--------------------------------------------*/

    $('input[name="email"]').on('input', function () {
        // 이메일 허용 문자만 입력 가능하고 254글자 제한
        $(this).val($(this).val().replace(/[^a-zA-Z0-9@._-]/g, ""));

        // 입력 내용 변경 시 중복확인 초기화
        isEmailValid = false;
        $('#emailMsg').text('');
    });

    window.checkEmail = function() {
        const email = $emailInput.val();
        const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!emailRegex.test(email)) {
            alert("이메일 형식이 올바르지 않습니다.");
            $emailInput.focus();
            return;
        }

        fetch("/user/check-email", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email })
        })
        .then(res => res.json())
        .then(exists => {
            if (exists) {
                alert("이미 사용 중인 이메일 입니다.");
                isEmailValid = false;
                $emailInput.focus();
            } else {
                alert("사용 가능한 이메일 입니다.");
                isEmailValid = true;
            }
        });
    }

    /*--------------------------------------------password--------------------------------------------*/

    // 비밀번호: 8-15자, 문자+숫자+특수문자 필수
    const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,15}$/;

    $('input[name="password"]').on('input', function () {
        // 허용된 문자만 입력 가능
        $(this).val($(this).val().replace(/[^A-Za-z0-9@$!%*#?&]/g, ""));
    });

    $('input[name="password"]').on('change', function () {
        if (!pwRegex.test($(this).val())) {
            alert("비밀번호는 8-15자이며, 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
        } else {
            alert("사용 가능한 비밀번호입니다.");
        }
    });

    $('input[name="passwordConfirm"]').on('input', function () {
        // 허용된 문자만 입력 가능
        $(this).val($(this).val().replace(/[^A-Za-z0-9@$!%*#?&]/g, ""));
    });

    $('input[name="passwordConfirm"]').on('change', function () {
        alert(
            $(this).val() === $('input[name="password"]').val()
                ? "비밀번호가 일치합니다."
                : "비밀번호가 일치하지 않습니다."
        );
    });

    /*--------------------------------------------phone--------------------------------------------*/

    $('input[name="phone"]').on('input', function () {
        // 숫자만 입력 가능
        let value = $(this).val().replace(/[^0-9]/g, "");

        // 자동 하이픈 추가 (010-0000-0000 형식)
        if (value.length > 3 && value.length <= 7) {
            value = value.slice(0, 3) + "-" + value.slice(3);
        } else if (value.length > 7) {
            value = value.slice(0, 3) + "-" + value.slice(3, 7) + "-" + value.slice(7, 11);
        }

        $(this).val(value);
    });

    $('input[name="phone"]').on('change', function () {
        const phoneWithoutHyphen = $(this).val().replace(/-/g, "");
        const phoneRegex = /^010\d{8}$/;

        alert(
            phoneRegex.test(phoneWithoutHyphen)
                ? "올바른 휴대폰 번호입니다."
                : "휴대폰 번호 형식이 올바르지 않습니다. (010으로 시작하는 11자리)"
        );
    });

    /*--------------------------------------------signup--------------------------------------------*/
    
    $('#btnSignup').on('click', function (e) {
        e.preventDefault();
        signup();
    });

    function signup() {
        const phoneWithoutHyphen = $('input[name="phone"]').val().replace(/-/g, "");

        const data = {
            username: $('input[name="username"]').val(),
            email: $('input[name="email"]').val(),
            password: $('input[name="password"]').val(),
            passwordConfirm: $('input[name="passwordConfirm"]').val(),
            phone: phoneWithoutHyphen,
            address: $('input[name="address"]').val(),
            addressDetail: $('input[name="addressDetail"]').val(),
            addressExtra: $('input[name="addressExtra"]').val(),
            zipcode: $('input[name="zipcode"]').val()
        };

        // 필수 항목 체크
        if (!data.username || !data.email || !data.password || !data.passwordConfirm || !data.phone) {
            alert("모든 필수 항목을 입력하세요.");
            return;
        }

        // 닉네임 길이 체크
        if (data.username.length > 10) {
            alert("닉네임은 10글자 이하로 입력해주세요.");
            $('input[name="username"]').focus();
            return;
        }

        // 닉네임 중복확인 체크
        if (!isUsernameValid) {
            alert("닉네임 중복확인을 완료해주세요.");
            $('input[name="username"]').focus();
            return;
        }

        // 이메일 형식 체크
        if (!/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(data.email)) {
            alert("이메일 형식이 올바르지 않습니다.");
            $('input[name="email"]').focus();
            return;
        }

        // 이메일 길이 체크
        if (data.email.length > 254) {
            alert("이메일은 254글자 이하로 입력해주세요.");
            $('input[name="email"]').focus();
            return;
        }

        // 이메일 중복확인 체크
        if (!isEmailValid) {
            alert("이메일 중복확인을 완료해주세요.");
            $('input[name="email"]').focus();
            return;
        }

        // 비밀번호 유효성 체크
        if (!pwRegex.test(data.password)) {
            alert("비밀번호는 8-15자이며, 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
            $('input[name="password"]').focus();
            return;
        }

        // 비밀번호 일치 체크
        if (data.password !== data.passwordConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            $('input[name="passwordConfirm"]').focus();
            return;
        }

        // 휴대폰 번호 유효성 체크
        const phoneRegex = /^010\d{8}$/;
        if (!phoneRegex.test(data.phone)) {
            alert("휴대폰 번호 형식이 올바르지 않습니다. (010으로 시작하는 11자리)");
            $('input[name="phone"]').focus();
            return;
        }

        if (!confirm("회원가입을 하시겠습니까?")) return;

        $.ajax({
            type: 'POST',
            url: '/user/signup',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
                alert("회원가입이 완료되었습니다.");
                location.href = "/login";
            },
            error: function () {
                alert("회원가입 중 오류가 발생했습니다.");
            }
        });
    }

}); //document.ready 끝
</script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function execDaumPostCode() {
	    new daum.Postcode({
	        oncomplete: function (data) {
	            $('input[name="zipcode"]').val(data.zonecode);
	            $('input[name="address"]').val(
	                data.roadAddress || data.jibunAddress
	            );

	            if (data.buildingName) {
	                $('input[name="addressExtra"]').val(data.buildingName);
	            }

	            $('input[name="addressDetail"]').focus();
	        }
	    }).open();
	}

</script>

</body>
</html>