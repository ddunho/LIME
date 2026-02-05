import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";
import CommentSection from "../components/CommentSection";
import axios from "axios";
import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

function PostDetail() {
  const { postUid } = useParams();
  const navigate = useNavigate();
  
  const [post, setPost] = useState(null);
  const [files, setFiles] = useState([]);
  const [loginUser, setLoginUser] = useState(null);

  useEffect(() => {
    if (!postUid) {
      alert("잘못된 접근입니다.");
      navigate("/");
      return;
    }
    fetchPost();
    fetchLoginUser();
  }, [postUid]);

  const fetchLoginUser = async () => {
    try {
      const res = await axios.get("/user/session");
      if (res.data.success) {
        setLoginUser(res.data.user);
      }
    } catch (error) {
      console.log("비로그인 상태");
    }
  };

  const fetchPost = async () => {
    try {
      const res = await axios.get(`/post/detail`, {
        params: { postUid },
      });

      if (res.data.success) {
        setPost(res.data.post);
        setFiles(res.data.files || []);
      }
    } catch (error) {
      console.error("게시글 로드 실패:", error);
      alert("게시글을 불러올 수 없습니다.");
      navigate("/");
    }
  };

  const deletePost = async () => {
    if (
      !window.confirm(
        "게시글을 삭제하시겠습니까?\n\n✓ 게시글의 모든 댓글이 함께 삭제됩니다.\n✓ 첨부파일도 함께 삭제됩니다.\n✓ 삭제된 내용은 복구할 수 없습니다."
      )
    )
      return;

    try {
      const res = await axios.post("/post/delete", { postUid });
      if (res.data.success) {
        alert(res.data.message || "게시글이 삭제되었습니다.");
        navigate("/");
      } else {
        alert(res.data.message || "게시글 삭제에 실패했습니다.");
      }
    } catch (error) {
      console.error("삭제 오류:", error);
      alert("게시글 삭제 중 오류가 발생했습니다.");
    }
  };

  if (!post) return <div>로딩 중...</div>;

  return (
    <div id="wrapper">
      <Sidebar />

      <div id="content-wrapper" className="d-flex flex-column">
        <div id="content">
          <Topbar />

          <div className="container-fluid">
            <h1 className="h3 mb-2 text-gray-800">게시글 상세</h1>

            <div className="card shadow mb-4">
              <div className="card-header d-flex justify-content-between">
                <div>
                  <h6 className="font-weight-bold text-primary">
                    {post.TITLE}
                  </h6>
                  <small className="text-muted">
                    작성자: {post.USERNAME} | 작성일: {post.WRITEDATE}
                  </small>
                </div>

                {loginUser?.username === post.USERNAME ? (
                  <div>
                    <button
                      className="btn btn-danger mr-2"
                      onClick={deletePost}
                    >
                      삭제
                    </button>
                    <button
                      className="btn btn-primary"
                      onClick={() => navigate(`/modify/${postUid}`)}
                    >
                      수정
                    </button>
                  </div>
                ) : (
                  <button
                    className="btn btn-secondary"
                    onClick={() => navigate("/")}
                  >
                    목록
                  </button>
                )}
              </div>

              <div className="card-body" style={{ minHeight: 300 }}>
                <p style={{ whiteSpace: "pre-wrap" }}>{post.CONTENT}</p>
              </div>

              {files.length > 0 && (
                <div className="card-body border-top">
                  <strong>첨부파일</strong>
                  <ul className="list-group mt-2">
                    {files.map((f) => (
                      <li
                        key={f.FILEUID}
                        className="list-group-item d-flex justify-content-between"
                      >
                        <span>
                          <i className="fas fa-file mr-2"></i>
                          {f.ORIGINALNAME}
                        </span>
                        <a 
                          href={`/download?fileUid=${f.FILEUID}`}
                          className="btn btn-sm btn-outline-primary"
                        >
                          <i className="fas fa-download"></i> 다운로드
                        </a>
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              <CommentSection postUid={postUid} loginUser={loginUser} />
            </div>
          </div>
        </div>

        <Footer />
      </div>
    </div>
  );
}

export default PostDetail;