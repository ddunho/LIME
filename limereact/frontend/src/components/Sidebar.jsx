import { useState } from "react";
import { Link } from "react-router-dom";
import useAuthStore from "../store/authStore";
import LogoutModal from "./LogoutModal";

function Sidebar() {
  const [openPages, setOpenPages] = useState(false);
  const [showLogoutModal, setShowLogoutModal] = useState(false);

  const isLogin = useAuthStore((state) => state.isLogin);

  const handleLogout = () => {
    setShowLogoutModal(false);
  };

  return (
    <>
      <ul 
        className="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" 
        id="accordionSidebar"
      >
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

        <li className="nav-item">
          <a 
            className="nav-link collapsed"
            href="#"
            data-toggle="collapse"
            data-target="#collapsePages"
            onClick={(e) => {
              e.preventDefault();
              setOpenPages(!openPages);
            }}
          >
            <i className="fas fa-fw fa-folder"></i>
            <span>Pages</span>
          </a>
        
          <div 
            id="collapsePages" 
            className={`collapse ${openPages ? 'show' : ''}`}
          >
            <div className="bg-white py-2 collapse-inner rounded">
              <h6 className="collapse-header">Login Screens:</h6>

              {isLogin ? (
                <a 
                  className="collapse-item"
                  href="#"
                  data-toggle="modal"
                  data-target="#logoutModal"
                  onClick={(e) => {
                    e.preventDefault();
                    setShowLogoutModal(true);
                  }}
                >
                  Logout
                </a>
              ) : (
                <Link className="collapse-item" to="/login">
                  Login
                </Link>
              )}

              <Link className="collapse-item" to="/membership">
                membership
              </Link>
            </div>
          </div>
        </li>

        <li className="nav-item active">
          <Link to="/" className="nav-link">
            <i className="fas fa-fw fa-table"></i>
            <span>Tables</span>
          </Link>
        </li>

        <hr className="sidebar-divider d-none d-md-block" />

        <div className="text-center d-none d-md-inline">
          <button className="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
      </ul>

      {showLogoutModal && (
        <LogoutModal 
          onClose={() => setShowLogoutModal(false)}
          onLogout={handleLogout}
        />
      )}
    </>
  );
}

export default Sidebar;