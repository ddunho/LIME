import { useEffect, useState } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import axios from "axios";
import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";

function MainPage() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();

  const [posts, setPosts] = useState([]);
  const [loginUser, setLoginUser] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);

  useEffect(() => {
    const page = Number(searchParams.get("page")) || 1;
    setCurrentPage(page);
    fetchPosts(page);
  }, [searchParams]);

  const fetchPosts = async (page) => {
  try {
    const res = await axios.get("/", {
      params: { page },
    });

    if (res.data.success) {
      setPosts(res.data.posts || []);
      setTotalPages(res.data.totalPages || 1);
    }
  } catch (error) {
    console.error("게시글 로드 실패:", error);
  }
};

  const goDetail = (postUid, deleteYn) => {
    if (deleteYn === "Y") return;
    navigate(`/detail/${postUid}`);
  };

  const handleWriteClick = () => {
    if (!loginUser) {
      if (confirm("로그인 하시겠습니까?")) {
        navigate("/login");
      }
      return;
    }
    navigate("/write");
  };

  return (
    <div id="wrapper">
      <Sidebar />

      <div id="content-wrapper" className="d-flex flex-column">
        <div id="content">
          <Topbar />

          <div className="container-fluid">
            <h1 className="h3 mb-2 text-gray-800">게시판</h1>

            <div className="card shadow mb-4">
              <div className="card-body table-responsive">
                <table className="table table-bordered">
                  <thead>
                    <tr>
                      <th>닉네임</th>
                      <th>제목</th>
                      <th>날짜</th>
                      <th>댓글</th>
                    </tr>
                  </thead>
                  <tbody>
                    {posts.map((post) =>
                      post.DELETEYN === "N" ? (
                        <tr
                          key={post.POSTUID}
                          style={{ cursor: "pointer" }}
                          onClick={() =>
                            goDetail(post.POSTUID, post.DELETEYN)
                          }
                        >
                          <td>{post.USERNAME}</td>
                          <td>{post.TITLE}</td>
                          <td>{post.WRITEDATE}</td>
                          <td>
                            {post.COMMENT_COUNT > 0 ? (
                              <span className="badge badge-primary">
                                {post.COMMENT_COUNT}개
                              </span>
                            ) : (
                              <span className="text-muted">0개</span>
                            )}
                          </td>
                        </tr>
                      ) : (
                        <tr
                          key={post.POSTUID}
                          style={{ cursor: "not-allowed" }}
                        >
                          <td>{post.USERNAME}</td>
                          <td>
                            <span className="text-muted font-italic">
                              삭제된 게시글입니다.
                            </span>
                          </td>
                          <td>{post.WRITEDATE}</td>
                          <td>
                            <span className="text-muted">-</span>
                          </td>
                        </tr>
                      )
                    )}
                  </tbody>
                </table>

                {/* 페이지네이션 */}
                <nav>
                  <ul className="pagination justify-content-center">
                    <li
                      className={`page-item ${
                        currentPage === 1 ? "disabled" : ""
                      }`}
                    >
                      <button
                        className="page-link"
                        onClick={() =>
                          navigate(`/?page=${currentPage - 1}`)
                        }
                      >
                        Previous
                      </button>
                    </li>

                    {Array.from(
                      { length: totalPages },
                      (_, i) => i + 1
                    ).map((i) => (
                      <li
                        key={i}
                        className={`page-item ${
                          i === currentPage ? "active" : ""
                        }`}
                      >
                        <button
                          className="page-link"
                          onClick={() => navigate(`/?page=${i}`)}
                        >
                          {i}
                        </button>
                      </li>
                    ))}

                    <li
                      className={`page-item ${
                        currentPage === totalPages ? "disabled" : ""
                      }`}
                    >
                      <button
                        className="page-link"
                        onClick={() =>
                          navigate(`/?page=${currentPage + 1}`)
                        }
                      >
                        Next
                      </button>
                    </li>
                  </ul>
                </nav>

                <button
                  className="btn btn-primary float-right"
                  onClick={handleWriteClick}
                >
                  게시글 작성
                </button>
              </div>
            </div>
          </div>
        </div>

        <Footer />
      </div>
    </div>
  );
  
}

export default MainPage;
