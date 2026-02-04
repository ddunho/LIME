import { useState } from "react";
import { Link } from "react-router-dom";

function Sidebar({ isLogin, onLogoutClick }) {
  const [openPages, setOpenPages] = useState(false);

  return (
    <ul className="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion">

      <Link
        to="/"
        className="sidebar-brand d-flex align-items-center justify-content-center"
      >
        <div className="sidebar-brand-icon rotate-n-15">
          <i className="fas fa-laugh-wink"></i>
        </div>
        <div className="sidebar-brand-text mx-3">게시판</div>
      </Link>

      <hr className="sidebar-divider my-0" />

      {/* Pages */}
      <li className="nav-item">
        <button
          className="nav-link collapsed btn btn-link text-left"
          onClick={() => setOpenPages(!openPages)}
        >
          <i className="fas fa-fw fa-folder"></i>
          <span>Pages</span>
        </button>

        {openPages && (
          <div className="bg-white py-2 collapse-inner rounded">
            <h6 className="collapse-header">Login Screens:</h6>

            {isLogin ? (
              <button
                className="collapse-item btn btn-link"
                onClick={onLogoutClick}
              >
                Logout
              </button>
            ) : (
              <Link className="collapse-item" to="/login">
                Login
              </Link>
            )}

            <Link className="collapse-item" to="/membership">
              membership
            </Link>
          </div>
        )}
      </li>

      {/* Tables */}
      <li className="nav-item active">
        <Link className="nav-link" to="/">
          <i className="fas fa-fw fa-table"></i>
          <span>Tables</span>
        </Link>
      </li>

      <hr className="sidebar-divider d-none d-md-block" />

      <div className="text-center d-none d-md-inline">
        <button className="rounded-circle border-0"></button>
      </div>
    </ul>
  );
}

export default Sidebar;
