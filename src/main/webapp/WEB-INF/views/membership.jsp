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
                                       placeholder="이름"/>
                                <small id="usernameMsg"></small>
                            </div>

                            <!-- email -->
                            <div class="form-group row">
                                <div class="col-sm-9 mb-3 mb-sm-0">
                                    <input type="email"
                                           class="form-control form-control-user"
                                           name="email"
                                           placeholder="이메일주소"/>
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
                                           placeholder="비밀번호"/>
                                </div>
                                <div class="col-sm-6">
                                    <input type="password"
                                           class="form-control form-control-user"
                                           name="passwordConfirm"
                                           placeholder="비밀번호 확인"/>
                                </div>
                            </div>

                            <!-- phone -->
                            <div class="form-group">
                                <input type="text"
                                       class="form-control form-control-user"
                                       name="phone"
                                       placeholder="휴대폰번호"/>
                            </div>

                            <!-- address -->
                            <div class="form-group row">
                                <div class="col-sm-9 mb-3 mb-sm-0">
                                    <input type="text"
                                           class="form-control form-control-user"
                                           name="address"
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
                                           placeholder="우편번호"/>
                                </div>
                                <div class="col-sm-6">
                                    <input type="text"
                                           class="form-control form-control-user"
                                           name="addressExtra"
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

const form = document.querySelector("form.user");
const usernameMsg = document.getElementById("usernameMsg");
const emailInput = form.email;

let isUsernameValid = false;


/*--------------------------------------------username--------------------------------------------*/

form.username.addEventListener("input", function () {
    this.value = this.value.replace(/[^a-zA-Z0-9]/g, "");
    isUsernameValid = false;
    usernameMsg.textContent = "";
});

form.username.addEventListener("blur", function () {
    const username = this.value.trim();

    if (!username || username.length > 10) {
        usernameMsg.textContent = "닉네임은 10글자 이하로 입력해주세요.";
        usernameMsg.style.color = "red";
        isUsernameValid = false;
        return;
    }

	const xhr = new XMLHttpRequest();
	xhr.open("POST", "/check-userName", true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function () {
	    if (xhr.readyState === 4 && xhr.status === 200) {
	        const isDuplicate = JSON.parse(xhr.responseText);

	        if (!isDuplicate) {
	            usernameMsg.textContent = "사용 가능한 닉네임입니다.";
	            usernameMsg.style.color = "green";
	            isUsernameValid = true;
	        } else {
	            usernameMsg.textContent = "이미 존재하는 닉네임입니다.";
	            usernameMsg.style.color = "red";
	            isUsernameValid = false;
	        }
	    }
	};

	xhr.send(JSON.stringify({ userName: username }));

});

/*--------------------------------------------email--------------------------------------------*/

emailInput.addEventListener("input", function () {
    this.value = this.value.replace(/[^a-zA-Z0-9@.]/g, "");
});

function checkEmail() {
    const email = emailInput.value.trim();
    const emailRegex = /^[a-zA-Z0-9@.]{8,15}$/;

    if (!emailRegex.test(email)) {
        alert("이메일 형식이 올바르지 않습니다.");
        emailInput.focus();
        return;
    }

    fetch("/user/check-email", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email })
    })
    .then(res => res.json())
    .then(isDuplicate => {
        if (isDuplicate) {
            alert("이미 사용 중인 이메일 입니다.");
            emailInput.focus();
        } else {
            alert("사용 가능한 이메일 입니다.");
        }
    });
}

/*--------------------------------------------password--------------------------------------------*/

const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&]).{8,15}$/;

form.password.addEventListener("blur", function () {
    alert(
        pwRegex.test(this.value)
            ? "사용 가능한 비밀번호입니다."
            : "사용 불가능한 비밀번호입니다."
    );
});

form.passwordConfirm.addEventListener("blur", function () {
    alert(
        this.value === form.password.value
            ? "비밀번호가 일치합니다."
            : "비밀번호가 일치하지 않습니다."
    );
});

/*--------------------------------------------phone--------------------------------------------*/
const phoneRegex = /^010\d{8}$/;

form.phone.addEventListener("blur", function () {
    alert(
        phoneRegex.test(this.value)
            ? "올바른 휴대폰 번호입니다."
            : "휴대폰 번호 형식이 올바르지 않습니다."
    );
});

/*--------------------------------------------signup--------------------------------------------*/
document.getElementById("btnSignup").addEventListener("click", function (e) {
    e.preventDefault();
    signup();
});

function signup() {
    const data = {
        username: form.username.value.trim(),
        email: emailInput.value.trim(),
        password: form.password.value,
        passwordConfirm: form.passwordConfirm.value,
        phone: form.phone.value.trim(),
        address: form.address.value.trim(),
        addressDetail: form.addressDetail.value.trim(),
        addressExtra: form.addressExtra.value.trim(),
        zipcode: form.zipcode.value.trim()
    };

    if (!data.username || !data.email || !data.password || !data.passwordConfirm || !data.phone) {
        alert("모든 필수 항목을 입력하세요.");
        return;
    }

    if (!isUsernameValid) {
        alert("닉네임 중복체크를 확인해주세요.");
        form.username.focus();
        return;
    }

    if (!/^[a-zA-Z0-9@.]{8,15}$/.test(data.email)) {
        alert("이메일 형식이 올바르지 않습니다.");
        emailInput.focus();
        return;
    }

    if (!pwRegex.test(data.password)) {
        alert("비밀번호 조건을 확인해주세요.");
        form.password.focus();
        return;
    }

    if (data.password !== data.passwordConfirm) {
        alert("비밀번호가 일치하지 않습니다.");
        form.passwordConfirm.focus();
        return;
    }

    if (!phoneRegex.test(data.phone)) {
        alert("휴대폰 번호 형식이 올바르지 않습니다.");
        form.phone.focus();
        return;
    }

    if (!confirm("회원가입을 하시겠습니까?")) return;

    const xhr = new XMLHttpRequest();
    xhr.open("POST", "/user/signup", true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            alert("회원가입이 완료되었습니다.");
            location.href = "/login";
        }
    };
    xhr.send(JSON.stringify(data));
}
</script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
            form.zipcode.value = data.zonecode;
            form.address.value = data.roadAddress || data.jibunAddress;
            if (data.buildingName) {
                form.addressExtra.value = data.buildingName;
            }
            form.addressDetail.focus();
        }
    }).open();
}
</script>

</body>
</html>
