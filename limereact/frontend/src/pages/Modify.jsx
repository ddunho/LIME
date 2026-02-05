import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";
import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";
import useAuthStore from "../store/authStore";

const MAX_FILE_COUNT = 5;

function Modify() {
  const { postUid } = useParams();
  const navigate = useNavigate();

  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [originFiles, setOriginFiles] = useState([]);
  const [newFiles, setNewFiles] = useState([]);

  useEffect(() => {
    document.title = "Tables";
  }, []);

  /* ================= 게시글 정보 로딩 ================= */
  useEffect(() => {
    fetchPost();
  }, [postUid]);

  const fetchPost = async () => {
    try {
      const res = await axios.get("/post/modify", {
        params: { postUid },
      });

      if (res.data.success) {
        setTitle(res.data.post.TITLE);
        setContent(res.data.post.CONTENT);
        setOriginFiles(res.data.fileList || []);
      } else {
        alert(res.data.message);
        navigate("/");
      }
    } catch (error) {
      console.error("게시글 로드 실패:", error);
      navigate("/");
    }
  };

  /* ================= 파일 선택 ================= */
  const handleFileChange = (e) => {
    const files = Array.from(e.target.files);

    if (files.length > MAX_FILE_COUNT) {
      alert(`파일은 최대 ${MAX_FILE_COUNT}개까지만 선택할 수 있습니다.`);
      e.target.value = "";
      setNewFiles([]);
      return;
    }

    if (files.length > 0) {
      alert("기존 파일은 삭제되고 선택한 파일로 덮어씌워집니다.");
    }

    setNewFiles(files);
  };

  /* ================= 수정 ================= */
  const handleModify = async () => {
    if (!title.trim()) {
      alert("제목을 입력해주세요.");
      return;
    }

    if (!content.trim()) {
      alert("내용을 입력해주세요.");
      return;
    }

    if (!confirm("게시글을 수정하시겠습니까?")) return;

    const formData = new FormData();
    formData.append("postUid", postUid);
    formData.append("title", title);
    formData.append("content", content);

    newFiles.forEach((file) => formData.append("uploadFile", file));

    try {
      const res = await axios.post("/modify", formData, {
        headers: { "Content-Type": "multipart/form-data" },
      });

      if (res.data?.success !== false) {
        alert(res.data?.message || "수정 완료");
        navigate("/");
      } else {
        alert(res.data.message || "수정 실패");
        if (res.data.redirectUrl) {
          navigate(res.data.redirectUrl);
        }
      }
    } catch (error) {
      console.error("Error:", error);
      alert("서버 오류가 발생했습니다.");
    }
  };

  return (
    <div id="page-top">
      {/* Page Wrapper */}
      <div id="wrapper">
        {/* Sidebar */}
        <Sidebar />
        {/* End of Sidebar */}

        {/* Content Wrapper */}
        <div id="content-wrapper" className="d-flex flex-column">
          {/* Main Content */}
          <div id="content">
            {/* Topbar */}
            <Topbar />
            {/* End of Topbar */}

            {/* Begin Page Content */}
            <div className="container-fluid h-100">
              {/* Page Heading */}
              <h1 className="h3 mb-2 text-gray-800">게시판</h1>

              {/* DataTales Example */}
              <div className="card shadow mb-4 h-75">
                <div className="card-body">
                  {/* Basic Card Example */}
                  <form id="modifyForm" encType="multipart/form-data">
                    {/* postUid */}
                    <input type="hidden" name="postUid" value={postUid} />

                    <div className="card shadow mb-4">
                      {/* 제목 */}
                      <div className="card-header py-3">
                        <div className="row">
                          <div className="col-md-10">
                            <input
                              type="text"
                              name="title"
                              className="form-control"
                              value={title}
                              onChange={(e) => setTitle(e.target.value)}
                              required
                              maxLength={4000}
                            />
                          </div>
                          <div className="col-md-2 text-right">
                            <button
                              type="button"
                              id="modifyBtn"
                              className="btn btn-primary"
                              onClick={handleModify}
                            >
                              수정완료
                            </button>
                          </div>
                        </div>
                      </div>

                      {/* 내용 */}
                      <div className="card-body">
                        <textarea
                          name="content"
                          className="form-control mb-3"
                          rows="12"
                          required
                          style={{ resize: "none" }}
                          maxLength={4000}
                          value={content}
                          onChange={(e) => setContent(e.target.value)}
                        />

                        {/* 기존 파일 */}
                        <div className="mb-2">
                          <label className="font-weight-bold">기존 첨부파일</label>
                          <ul className="list-group">
                            {originFiles.length > 0 ? (
                              originFiles.map((file) => (
                                <li key={file.FILEUID} className="list-group-item">
                                  {file.ORIGINALNAME}
                                </li>
                              ))
                            ) : (
                              <li className="list-group-item text-muted">
                                첨부파일 없음
                              </li>
                            )}
                          </ul>
                        </div>

                        {/* 새 파일 선택 */}
                        <div className="form-group mt-3">
                          <label className="font-weight-bold">파일 선택</label>
                          <input
                            type="file"
                            id="fileInput"
                            name="uploadFile"
                            className="form-control-file"
                            multiple
                            onChange={handleFileChange}
                          />
                          <small className="form-text text-muted">
                            <i className="fas fa-info-circle"></i> 파일은 최대 5개까지
                            첨부 가능합니다.
                          </small>
                          <ul id="fileList" className="list-group mt-2">
                            {newFiles.map((file, idx) => (
                              <li key={idx} className="list-group-item">
                                {file.name}
                              </li>
                            ))}
                          </ul>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
            {/* /.container-fluid */}
          </div>
          {/* End of Main Content */}

          {/* Footer */}
          <Footer />
          {/* End of Footer */}
        </div>
        {/* End of Content Wrapper */}
      </div>
      {/* End of Page Wrapper */}
    </div>
  );
}

export default Modify;