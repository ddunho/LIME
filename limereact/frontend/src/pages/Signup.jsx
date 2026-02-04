import { useEffect, useState } from "react";
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

  /* ================= 공통 입력 처리 ================= */
  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  /* ================= Username ================= */
  const handleUsernameBlur = async () => {
    if (!form.username) {
      alert("닉네임을 입력해주세요.");
      return;
    }

    if (form.username.length > 10) {
      alert("닉네임은 10글자 이하입니다.");
      return;
    }

    try {
      const res = await axios.post("/user/check-userName", {
        userName: form.username,
      });
      if (!res.data) {
        alert("사용 가능한 닉네임입니다.");
        setIsUsernameValid(true);
      } else {
        alert("이미 존재하는 닉네임입니다.");
        setIsUsernameValid(false);
      }
    } catch {
      alert("닉네임 중복 확인 오류");
      setIsUsernameValid(false);
    }
  };

  /* ================= Email ================= */
  const checkEmail = async () => {
    if (!emailRegex.test(form.email)) {
      alert("이메일 형식이 올바르지 않습니다.");
      return;
    }

    const res = await axios.post("/user/check-email", {
      email: form.email,
    });

    if (res.data) {
      alert("이미 사용 중인 이메일입니다.");
      setIsEmailValid(false);
    } else {
      alert("사용 가능한 이메일입니다.");
      setIsEmailValid(true);
    }
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
  const handleSignup = async () => {
  const phone = form.phone.replace(/-/g, "");

  if (!isUsernameValid || !isEmailValid) {
    alert("중복 확인을 완료해주세요.");
    return;
  }

  if (!pwRegex.test(form.password)) {
    alert("비밀번호 형식이 올바르지 않습니다.");
    return;
  }

  if (form.password !== form.passwordConfirm) {
    alert("비밀번호가 일치하지 않습니다.");
    return;
  }

  if (!/^010\d{8}$/.test(phone)) {
    alert("휴대폰 번호 형식 오류");
    return;
  }

  if (!confirm("회원가입을 하시겠습니까?")) return;

  try {
    const res = await axios.post("/user/signup", {
      ...form,
      phone,
    });

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
    <div className="container bg-gradient-primary">
      <div className="card shadow-lg my-5">
        <div className="card-body p-5">
          <h4 className="text-center mb-4">회원가입</h4>

          <input
            name="username"
            placeholder="닉네임"
            className="form-control mb-2"
            value={form.username}
            onChange={handleChange}
            onBlur={handleUsernameBlur}
          />

          <div className="d-flex gap-2 mb-2">
            <input
              name="email"
              placeholder="이메일"
              className="form-control"
              value={form.email}
              onChange={handleChange}
            />
            <button className="btn btn-primary" onClick={checkEmail}>
              중복확인
            </button>
          </div>

          <input
            type="password"
            name="password"
            placeholder="비밀번호"
            className="form-control mb-2"
            onChange={handleChange}
          />
          <input
            type="password"
            name="passwordConfirm"
            placeholder="비밀번호 확인"
            className="form-control mb-2"
            onChange={handleChange}
          />

          <input
            name="phone"
            placeholder="휴대폰번호"
            className="form-control mb-2"
            value={form.phone}
            onChange={handlePhoneChange}
          />

          <div className="d-flex gap-2 mb-2">
            <input
              name="address"
              readOnly
              className="form-control"
              value={form.address}
              placeholder="주소"
            />
            <button className="btn btn-primary" onClick={execDaumPostCode}>
              주소찾기
            </button>
          </div>

          <input
            name="addressDetail"
            placeholder="상세주소"
            className="form-control mb-2"
            onChange={handleChange}
          />

          <button
            className="btn btn-primary btn-block mt-3"
            onClick={handleSignup}
          >
            Register Account
          </button>
        </div>
      </div>
    </div>
  );
}

export default Signup;
