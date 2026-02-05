import { useEffect, useState } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import axios from "axios";
import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";
import useAuthStore from "../store/authStore";

function MainPage() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();

  const [posts, setPosts] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);

  const isLogin = useAuthStore((state) => state.isLogin);
  const logout = useAuthStore((state) => state.logout);

  useEffect(() => {
    // 페이지 타이틀 설정
    document.title = "Tables";
  }, []);

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

  const formatDate = (dateStr) => {
    if (!dateStr) return "";
    const d = new Date(dateStr);
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
  };

  return (
    <div id="page-top">
      <div id="wrapper">
        <Sidebar />

        <div id="content-wrapper" className="d-flex flex-column">
          <div id="content">
            <Topbar />

            <div className="container-fluid">
              <h1 className="h3 mb-2 text-gray-800">게시판</h1>

              <div className="card shadow mb-4">
                <div className="card-body">
                  <div className="table-responsive">
                    <table
                      className="table table-bordered"
                      id="dataTable"
                      width="100%"
                      cellSpacing="0"
                    >
                      <colgroup>
                        <col width="20%" />
                        <col width="40%" />
                        <col width="30%" />
                        <col width="20%" />
                      </colgroup>
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
                              onClick={() => goDetail(post.POSTUID, post.DELETEYN)}
                            >
                              <td>{post.USERNAME}</td>
                              <td>{post.TITLE}</td>
                              <td>{formatDate(post.WRITEDATE)}</td>
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
                              <td>{formatDate(post.WRITEDATE)}</td>
                              <td>
                                <span className="text-muted">-</span>
                              </td>
                            </tr>
                          )
                        )}
                      </tbody>
                    </table>

                    <nav aria-label="Page navigation">
                      <ul className="pagination justify-content-center">
                        <li className={`page-item ${currentPage === 1 ? "disabled" : ""}`}>
                          <a 
                            className="page-link"
                            href={`/?page=${currentPage - 1}`}
                            onClick={(e) => {
                              e.preventDefault();
                              if (currentPage > 1) navigate(`/?page=${currentPage - 1}`);
                            }}
                          >
                            Previous
                          </a>
                        </li>

                        {Array.from({ length: totalPages }, (_, i) => i + 1).map((i) => (
                          <li
                            key={i}
                            className={`page-item ${i === currentPage ? "active" : ""}`}
                          > <a 
                            
                              className="page-link"
                              href={`/?page=${i}`}
                              onClick={(e) => {
                                e.preventDefault();
                                navigate(`/?page=${i}`);
                              }}
                            >
                              {i}
                            </a>
                          </li>
                        ))}

                        <li className={`page-item ${currentPage === totalPages ? "disabled" : ""}`}>
                          <a 
                            className="page-link"
                            href={`/?page=${currentPage + 1}`}
                            onClick={(e) => {
                              e.preventDefault();
                              if (currentPage < totalPages) navigate(`/?page=${currentPage + 1}`);
                            }}
                          >
                            Next
                          </a>
                        </li>
                      </ul>
                    </nav>

                    {isLogin ? (
                      <a 
                        href="/write"
                        className="btn btn-primary float-right"
                        onClick={(e) => {
                          e.preventDefault();
                          navigate("/write");
                        }}
                      >
                        게시글 작성
                      </a>
                    ) : (
                      <a 
                        href="#"
                        className="btn btn-primary float-right"
                        onClick={(e) => {
                          e.preventDefault();
                          if (window.confirm("로그인 하시겠습니까?")) {
                            navigate("/login");
                          }
                        }}
                      >
                        게시글 작성
                      </a>
                    )}
                  </div>
                </div>
              </div>
            </div>
          </div>

          <Footer />
        </div>
      </div>

    </div>
  );
}

export default MainPage;