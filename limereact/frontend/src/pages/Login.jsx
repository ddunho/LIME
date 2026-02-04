import { useEffect, useState } from "react";
import axios from "axios";

function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [rememberMe, setRememberMe] = useState(false);

  // Remember Me 로컬스토리지 로드
  useEffect(() => {
    const savedEmail = localStorage.getItem("REMEMBER_EMAIL");
    if (savedEmail) {
      setEmail(savedEmail);
      setRememberMe(true);
    }
  }, []);

  // 로그인 처리
  const handleLogin = async () => {
  if (!email || !password) {
    alert("이메일과 비밀번호를 입력해주세요.");
    return;
  }

  if (rememberMe) {
    localStorage.setItem("REMEMBER_EMAIL", email);
  } else {
    localStorage.removeItem("REMEMBER_EMAIL");
  }

  try {
    const res = await axios.post("/user/login", {
      email,
      password,
    });

    if (res.data.success) {
      alert("로그인 성공!");
      window.location.href = "/";
    } else {
      alert(res.data.msg || "이메일 또는 비밀번호가 올바르지 않습니다.");
    }
  } catch (e) {
    alert("서버 오류가 발생했습니다.");
  }
};

  // Enter 키 로그인
  const handleKeyDown = (e) => {
    if (e.key === "Enter") {
      handleLogin();
    }
  };

  return (
    <div className="container bg-gradient-primary">
      <div className="row justify-content-center">
        <div className="col-xl-10 col-lg-12 col-md-9">
          <div className="card o-hidden border-0 shadow-lg my-5">
            <div className="card-body p-0">
              <div className="row">
                <div className="col-lg-6 d-none d-lg-block bg-login-image" />
                <div className="col-lg-6">
                  <div className="p-5">
                    <div className="text-center">
                      <h1 className="h4 text-gray-900 mb-4">
                        Welcome Back!
                      </h1>
                    </div>

                    <div className="form-group">
                      <input
                        type="email"
                        className="form-control form-control-user"
                        placeholder="Enter Email Address..."
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        onKeyDown={handleKeyDown}
                      />
                    </div>

                    <div className="form-group">
                      <input
                        type="password"
                        className="form-control form-control-user"
                        placeholder="Password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        onKeyDown={handleKeyDown}
                      />
                    </div>

                    <div className="form-group">
                      <div className="custom-control custom-checkbox small">
                        <input
                          type="checkbox"
                          className="custom-control-input"
                          id="rememberMe"
                          checked={rememberMe}
                          onChange={(e) =>
                            setRememberMe(e.target.checked)
                          }
                        />
                        <label
                          className="custom-control-label"
                          htmlFor="rememberMe"
                        >
                          Remember Me
                        </label>
                      </div>
                    </div>

                    <button
                      className="btn btn-primary btn-user btn-block"
                      onClick={handleLogin}
                    >
                      로그인
                    </button>

                    <hr />

                    <div className="text-center">
                      <a className="small" href="/signup">
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
  );
}

export default Login;
