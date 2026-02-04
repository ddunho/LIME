import { useState } from "react";
import { Link } from "react-router-dom";

function Topbar({ user, onLogoutClick }) {
  const [openDropdown, setOpenDropdown] = useState(false);

  return (
    <nav className="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

      <form className="form-inline">
        <button
          className="btn btn-link d-md-none rounded-circle mr-3"
          type="button"
        >
          <i className="fa fa-bars"></i>
        </button>
      </form>

      <ul className="navbar-nav ml-auto">
        <div className="topbar-divider d-none d-sm-block"></div>

        <li className="nav-item dropdown no-arrow">
          {user ? (
            <button
              className="nav-link dropdown-toggle btn btn-link"
              onClick={() => setOpenDropdown(!openDropdown)}
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
            <Link className="nav-link" to="/login">
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
            <div className="dropdown-menu dropdown-menu-right shadow animated--grow-in show">
              <Link className="dropdown-item" to="/profile">
                <i className="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                Profile
              </Link>

              <div className="dropdown-divider"></div>

              {user ? (
                <button
                  className="dropdown-item btn btn-link"
                  onClick={onLogoutClick}
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
  );
}

export default Topbar;
