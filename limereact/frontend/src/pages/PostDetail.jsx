import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";
import CommentSection from "../components/CommentSection";
import axios from "axios";
import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";

function PostDetail() {
  const { postUid } = useParams();
  const navigate = useNavigate();

  const [post, setPost] = useState(null);
  const [files, setFiles] = useState([]);
  const [loginUser, setLoginUser] = useState(null);

  useEffect(() => {
    fetchPost();
  }, []);

  const fetchPost = async () => {
  try {
    const res = await axios.get(`/detail`, {
      params: { postUid },
    });

    if (res.data.success) {
      setPost(res.data.post);
      setFiles(res.data.files || []);
    }
  } catch (error) {
    console.error("게시글 로드 실패:", error);
    navigate("/");
  }
};

  const deletePost = async () => {
    if (!confirm("게시글을 삭제하시겠습니까?")) return;

    await axios.post("/post/delete", { postUid });
    alert("삭제되었습니다.");
    navigate("/");
  };

  if (!post) return null;

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

                {loginUser?.username === post.username && (
                  <div>
                    <button
                      className="btn btn-danger mr-2"
                      onClick={deletePost}
                    >
                      삭제
                    </button>
                    <button
                      className="btn btn-primary"
                      onClick={() => navigate(`/post/modify/${postUid}`)}
                    >
                      수정
                    </button>
                  </div>
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
                        {f.ORIGINALNAME}
                        <a
                          href={`/download?fileUid=${f.FILEUID}`}
                          className="btn btn-sm btn-outline-primary"
                        >
                          다운로드
                        </a>
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              {/* 댓글 */}
              <CommentSection
                postUid={postUid}
                loginUser={loginUser}
              />
            </div>
          </div>
        </div>

        <Footer />
      </div>
    </div>
  );
}

export default PostDetail;
