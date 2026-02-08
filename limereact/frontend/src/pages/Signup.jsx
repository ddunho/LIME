import { useEffect, useState, useRef } from "react";
import axios from "axios";

const pwRegex =
  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,15}$/;
const emailRegex =
  /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

function Signup() {
  const [form, setForm] = useState({
    username: "",
    email: "",
    password: "",
    passwordConfirm: "",
    phone: "",
    address: "",
    addressDetail: "",
    addressExtra: "",
    zipcode: "",
  });

  const [isUsernameValid, setIsUsernameValid] = useState(false);
  const [isEmailValid, setIsEmailValid] = useState(false);
  const [isPasswordValid, setIsPasswordValid] = useState(false);
  const [isPasswordMatch, setIsPasswordMatch] = useState(false);
  const [usernameMsg, setUsernameMsg] = useState("");
  const [emailMsg, setEmailMsg] = useState("");
  const [passwordChecked, setPasswordChecked] = useState(false);
  const [passwordConfirmChecked, setPasswordConfirmChecked] = useState(false);

  const passwordRef = useRef(null);
  const passwordConfirmRef = useRef(null);

  /* ================= Username ================= */
  const handleUsernameChange = (e) => {
    const filtered = e.target.value.replace(/[^a-zA-Z0-9]/g, "");
    setForm((prev) => ({ ...prev, username: filtered }));
    setIsUsernameValid(false);
    setUsernameMsg("");
  };

  const handleUsernameBlur = async () => {
    const username = form.username;

    if (!username) {
      setUsernameMsg("닉네임을 입력해주세요.");
      setIsUsernameValid(false);
      return;
    }

    if (username.length > 10) {
      setUsernameMsg("닉네임은 10글자 이하로 입력해주세요.");
      setIsUsernameValid(false);
      return;
    }

    try {
      const res = await axios.post("/user/check-userName", {
        userName: username,
      });
      if (!res.data.exists) {
        setUsernameMsg("사용 가능한 닉네임입니다.");
        setIsUsernameValid(true);
      } else {
        setUsernameMsg("이미 존재하는 닉네임입니다.");
        setIsUsernameValid(false);
      }
    } catch {
      setUsernameMsg("중복 확인 중 오류가 발생했습니다.");
      setIsUsernameValid(false);
    }
  };

  /* ================= Email ================= */
  const handleEmailChange = (e) => {
    const filtered = e.target.value.replace(/[^a-zA-Z0-9@._-]/g, "");
    setForm((prev) => ({ ...prev, email: filtered }));
    setIsEmailValid(false);
    setEmailMsg("");
  };

  const checkEmail = async () => {
    const email = form.email;

    if (!emailRegex.test(email)) {
      alert("이메일 형식이 올바르지 않습니다.");
      return;
    }

    try {
      const res = await axios.post("/user/check-email", {
        email: email,
      });

      if (res.data.exists) {
        alert("이미 사용 중인 이메일입니다.");
        setIsEmailValid(false);
      } else {
        alert("사용 가능한 이메일입니다.");
        setIsEmailValid(true);
      }
    } catch {
      alert("이메일 중복 확인 중 오류가 발생했습니다.");
      setIsEmailValid(false);
    }
  };

  /* ================= Password ================= */
  const handlePasswordChange = (e) => {
    const filtered = e.target.value.replace(/[^A-Za-z0-9@$!%*#?&]/g, "");
    setForm((prev) => ({ ...prev, password: filtered }));
    setIsPasswordValid(false);
    setIsPasswordMatch(false);
    setPasswordChecked(false);
    setPasswordConfirmChecked(false);
  };

  const handlePasswordConfirmFocus = () => {
    // 이미 검증했으면 다시 검증하지 않음
    if (passwordChecked) {
      return;
    }

    const password = form.password;

    if (!password) {
      return;
    }

    if (!pwRegex.test(password)) {
      alert("비밀번호는 8-15자이며, 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
      setIsPasswordValid(false);
      setPasswordChecked(true);
      return;
    }

    alert("사용 가능한 비밀번호입니다.");
    setIsPasswordValid(true);
    setPasswordChecked(true);
  };

  /* ================= Password Confirm ================= */
  const handlePasswordConfirmChange = (e) => {
    const filtered = e.target.value.replace(/[^A-Za-z0-9@$!%*#?&]/g, "");
    setForm((prev) => ({ ...prev, passwordConfirm: filtered }));
    setIsPasswordMatch(false);
    setPasswordConfirmChecked(false);
  };

  const handlePasswordConfirmBlur = () => {
    // 이미 검증했으면 다시 검증하지 않음
    if (passwordConfirmChecked) {
      return;
    }

    const { password, passwordConfirm } = form;

    if (!passwordConfirm) {
      return;
    }

    if (password !== passwordConfirm) {
      alert("비밀번호가 일치하지 않습니다.");
      setIsPasswordMatch(false);
      setPasswordConfirmChecked(true);
      return;
    }

    alert("비밀번호가 일치합니다.");
    setIsPasswordMatch(true);
    setPasswordConfirmChecked(true);
  };

  /* ================= Phone ================= */
  const handlePhoneChange = (e) => {
    let v = e.target.value.replace(/[^0-9]/g, "");
    if (v.length > 3 && v.length <= 7)
      v = v.slice(0, 3) + "-" + v.slice(3);
    else if (v.length > 7)
      v = v.slice(0, 3) + "-" + v.slice(3, 7) + "-" + v.slice(7, 11);

    setForm((p) => ({ ...p, phone: v }));
  };

  /* ================= Address Detail ================= */
  const handleAddressDetailChange = (e) => {
    setForm((prev) => ({ ...prev, addressDetail: e.target.value }));
  };

  /* ================= Daum 주소 ================= */
  const execDaumPostCode = () => {
    new window.daum.Postcode({
      oncomplete: function (data) {
        setForm((prev) => ({
          ...prev,
          zipcode: data.zonecode,
          address: data.roadAddress || data.jibunAddress,
          addressExtra: data.buildingName || "",
        }));
      },
    }).open();
  };

  /* ================= Signup ================= */
  const handleSignup = async (e) => {
    e.preventDefault();

    const phoneWithoutHyphen = form.phone.replace(/-/g, "");

    const data = {
      username: form.username,
      email: form.email,
      password: form.password,
      passwordConfirm: form.passwordConfirm,
      phone: phoneWithoutHyphen,
      address: form.address,
      addressDetail: form.addressDetail,
      addressExtra: form.addressExtra,
      zipcode: form.zipcode,
    };

    // 필수 항목 체크
    if (!data.username || !data.email || !data.password || !data.passwordConfirm || !data.phone) {
      alert("모든 필수 항목을 입력하세요.");
      return;
    }

    // 닉네임 길이 체크
    if (data.username.length > 10) {
      alert("닉네임은 10글자 이하로 입력해주세요.");
      return;
    }

    // 닉네임 중복확인 체크
    if (!isUsernameValid) {
      alert("닉네임 중복확인을 완료해주세요.");
      return;
    }

    // 이메일 형식 체크
    if (!emailRegex.test(data.email)) {
      alert("이메일 형식이 올바르지 않습니다.");
      return;
    }

    // 이메일 길이 체크
    if (data.email.length > 254) {
      alert("이메일은 254글자 이하로 입력해주세요.");
      return;
    }

    // 이메일 중복확인 체크
    if (!isEmailValid) {
      alert("이메일 중복확인을 완료해주세요.");
      return;
    }

    // 비밀번호 유효성 체크
    if (!pwRegex.test(data.password)) {
      alert("비밀번호는 8-15자이며, 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
      return;
    }

    // 비밀번호 검증 완료 체크
    if (!isPasswordValid) {
      alert("비밀번호 검증을 완료해주세요.");
      return;
    }

    // 비밀번호 일치 체크
    if (data.password !== data.passwordConfirm) {
      alert("비밀번호가 일치하지 않습니다.");
      return;
    }

    // 비밀번호 일치 확인 체크
    if (!isPasswordMatch) {
      alert("비밀번호 일치 확인을 완료해주세요.");
      return;
    }

    // 휴대폰 번호 유효성 체크
    const phoneRegex = /^010\d{8}$/;
    if (!phoneRegex.test(data.phone)) {
      alert("휴대폰 번호 형식이 올바르지 않습니다. (010으로 시작하는 11자리)");
      return;
    }

    if (!window.confirm("회원가입을 하시겠습니까?")) return;

    try {
      const res = await axios.post("/user/signup", data);

      if (res.data.result) {
        alert(res.data.msg);
        window.location.href = "/login";
      } else {
        alert(res.data.msg);
      }
    } catch (error) {
      alert("회원가입 중 오류가 발생했습니다.");
    }
  };

  /* ================= Daum Script ================= */
  useEffect(() => {
    const script = document.createElement("script");
    script.src =
      "https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js";
    script.async = true;
    document.body.appendChild(script);
  }, []);

  return (
    <div className="bg-gradient-primary">
      <div className="container">
        <div className="card o-hidden border-0 shadow-lg my-5">
          <div className="card-body p-0">
            <div className="row">
              <div className="col-lg-5 d-none d-lg-block bg-register-image"></div>

              <div className="col-lg-7">
                <div className="p-5">
                  <div className="text-center">
                    <h1 className="h4 text-gray-900 mb-4">회원가입</h1>
                  </div>

                  <form className="user">
                    {/* username */}
                    <div className="form-group">
                      <input
                        type="text"
                        className="form-control form-control-user"
                        name="username"
                        maxLength="10"
                        placeholder="이름 (최대 10글자)"
                        value={form.username}
                        onChange={handleUsernameChange}
                        onBlur={handleUsernameBlur}
                      />
                      <small
                        id="usernameMsg"
                        style={{
                          color: usernameMsg.includes("가능") ? "green" : "red",
                        }}
                      >
                        {usernameMsg}
                      </small>
                    </div>

                    {/* email */}
                    <div className="form-group row">
                      <div className="col-sm-9 mb-3 mb-sm-0">
                        <input
                          type="email"
                          className="form-control form-control-user"
                          name="email"
                          maxLength="254"
                          placeholder="이메일주소 (최대 254글자)"
                          value={form.email}
                          onChange={handleEmailChange}
                        />
                        <small
                          id="emailMsg"
                          style={{
                            color: emailMsg.includes("가능") ? "green" : "red",
                          }}
                        >
                          {emailMsg}
                        </small>
                      </div>
                      <div className="col-sm-3">
                        <button
                          type="button"
                          className="btn btn-primary btn-user btn-block"
                          onClick={checkEmail}
                        >
                          중복확인
                        </button>
                      </div>
                    </div>

                    {/* password */}
                    <div className="form-group row">
                      <div className="col-sm-6 mb-3 mb-sm-0">
                        <input
                          ref={passwordRef}
                          type="password"
                          className="form-control form-control-user"
                          name="password"
                          maxLength="15"
                          placeholder="비밀번호 (8-15자)"
                          value={form.password}
                          onChange={handlePasswordChange}
                        />
                      </div>
                      <div className="col-sm-6">
                        <input
                          ref={passwordConfirmRef}
                          type="password"
                          className="form-control form-control-user"
                          name="passwordConfirm"
                          maxLength="15"
                          placeholder="비밀번호 확인"
                          value={form.passwordConfirm}
                          onChange={handlePasswordConfirmChange}
                          onFocus={handlePasswordConfirmFocus}
                          onBlur={handlePasswordConfirmBlur}
                        />
                      </div>
                    </div>

                    {/* phone */}
                    <div className="form-group">
                      <input
                        type="text"
                        className="form-control form-control-user"
                        name="phone"
                        maxLength="13"
                        placeholder="휴대폰번호 (010-0000-0000)"
                        value={form.phone}
                        onChange={handlePhoneChange}
                      />
                    </div>

                    {/* address */}
                    <div className="form-group row">
                      <div className="col-sm-9 mb-3 mb-sm-0">
                        <input
                          type="text"
                          className="form-control form-control-user"
                          name="address"
                          readOnly
                          placeholder="주소"
                          value={form.address}
                        />
                      </div>
                      <div className="col-sm-3">
                        <button
                          type="button"
                          className="btn btn-primary btn-user btn-block"
                          onClick={execDaumPostCode}
                        >
                          주소찾기
                        </button>
                      </div>
                    </div>

                    <div className="form-group">
                      <input
                        type="text"
                        className="form-control form-control-user"
                        name="addressDetail"
                        maxLength="254"
                        placeholder="상세주소"
                        value={form.addressDetail}
                        onChange={handleAddressDetailChange}
                      />
                    </div>

                    <div className="form-group row">
                      <div className="col-sm-6 mb-3 mb-sm-0">
                        <input
                          type="text"
                          className="form-control form-control-user"
                          name="zipcode"
                          readOnly
                          placeholder="우편번호"
                          value={form.zipcode}
                        />
                      </div>
                      <div className="col-sm-6">
                        <input
                          type="text"
                          className="form-control form-control-user"
                          name="addressExtra"
                          readOnly
                          placeholder="참고사항"
                          value={form.addressExtra}
                        />
                      </div>
                    </div>

                    <a 
                      href="#"
                      id="btnSignup"
                      className="btn btn-primary btn-user btn-block"
                      onClick={handleSignup}
                    >
                      Register Account
                    </a>
                  </form>

                  <hr />

                  <div className="text-center">
                    <a className="small" href="/login">
                      Already have an account? Login!
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Signup;