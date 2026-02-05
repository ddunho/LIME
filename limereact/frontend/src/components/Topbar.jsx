import { useState } from "react";
import { Link } from "react-router-dom";
import useAuthStore from "../store/authStore";
import LogoutModal from "./LogoutModal";

function Topbar() {
  const [openDropdown, setOpenDropdown] = useState(false);
  const [isLogoutOpen, setIsLogoutOpen] = useState(false);

  const isLogin = useAuthStore((state) => state.isLogin);
  const user = useAuthStore((state) => state.user);
  const logout = useAuthStore((state) => state.logout);

  const handleLogout = () => {
    logout();
    setIsLogoutOpen(false);
    alert("로그아웃 성공!");
    window.location.href = "/";
  };

  return (
    <>
      <nav className="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
        <form className="form-inline">
          <button 
            id="sidebarToggleTop" 
            className="btn btn-link d-md-none rounded-circle mr-3" 
            type="button"
          >
            <i className="fa fa-bars"></i>
          </button>
        </form>

        <ul className="navbar-nav ml-auto">
          <div className="topbar-divider d-none d-sm-block"></div>

          <li className="nav-item dropdown no-arrow">
            {isLogin && user ? (
              <button
                className="nav-link dropdown-toggle btn btn-link"
                id="userDropdown"
                role="button"
                onClick={() => setOpenDropdown(!openDropdown)}
                aria-haspopup="true"
                aria-expanded={openDropdown}
              >
                <span className="mr-2 d-none d-lg-inline text-gray-600 small">
                  {user.username}
                </span>
                <img
                  className="img-profile rounded-circle"
                  src="/img/undraw_profile.svg"
                  alt="profile"
                />
              </button>
            ) : (
              <Link 
                to="/login"
                className="nav-link"
              >
                <span className="mr-2 d-none d-lg-inline text-gray-600 small">
                  guest
                </span>
                <img
                  className="img-profile rounded-circle"
                  src="/img/undraw_profile.svg"
                  alt="profile"
                />
              </Link>
            )}

            {openDropdown && (
              <div 
                className="dropdown-menu dropdown-menu-right shadow animated--grow-in show"
                aria-labelledby="userDropdown"
              >
                <Link className="dropdown-item" to="#">
                  <i className="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Profile
                </Link>
                
                <div className="dropdown-divider"></div>

                {isLogin ? (
                  <button
                    className="dropdown-item btn btn-link"
                    onClick={() => {
                      setOpenDropdown(false);
                      setIsLogoutOpen(true);
                    }}
                  >
                    <i className="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    Logout
                  </button>
                ) : (
                  <Link className="dropdown-item" to="/login">
                    <i className="fas fa-sign-in-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    Login
                  </Link>
                )}
              </div>
            )}
          </li>
        </ul>
      </nav>

      <LogoutModal
        isOpen={isLogoutOpen}
        onClose={() => setIsLogoutOpen(false)}
        onLogout={handleLogout}
      />
    </>
  );
}

export default Topbar;