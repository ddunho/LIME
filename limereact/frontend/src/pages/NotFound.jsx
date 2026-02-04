import { Link } from "react-router-dom";
import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";

function NotFound() {
  return (
    <div id="wrapper">
      <Sidebar />

      <div id="content-wrapper" className="d-flex flex-column">
        <div id="content">
          <Topbar />

          <div className="container-fluid">
            <div className="text-center">
              <div
                className="error mx-auto"
                style={{ fontSize: "6rem", fontWeight: "bold" }}
              >
                ERROR
              </div>

              <p className="lead text-gray-800 mb-4">
                Page Not Found
              </p>

              <p className="text-gray-500 mb-4">
                존재하지 않거나 삭제된 페이지입니다.
              </p>

              <Link to="/" className="btn btn-primary">
                ← 메인으로 돌아가기
              </Link>
            </div>
          </div>
        </div>

        <Footer />
      </div>
    </div>
  );
}

export default NotFound;
