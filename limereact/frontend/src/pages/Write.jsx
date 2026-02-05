import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";
import useAuthStore from "../store/authStore";

const MAX_FILE_COUNT = 5;

function Write() {
  const navigate = useNavigate();

  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [files, setFiles] = useState([]);

  useEffect(() => {
    document.title = "Tables";
  }, []);

  /* ================= 파일 선택 ================= */
  const handleFileChange = (e) => {
    const selectedFiles = Array.from(e.target.files);

    console.log(MAX_FILE_COUNT);

    if (selectedFiles.length > MAX_FILE_COUNT) {
      alert("파일은 최대 " + MAX_FILE_COUNT + "개까지만 선택할 수 있습니다.");
      e.target.value = "";
      setFiles([]);
      return;
    }

    setFiles(selectedFiles);
  };

  /* ================= 게시글 작성 ================= */
  const handleSubmit = async () => {
    // 제목과 내용 검증
    if (!title.trim()) {
      alert("제목을 입력해주세요.");
      return;
    }

    if (!content.trim()) {
      alert("내용을 입력해주세요.");
      return;
    }

    // 파일 개수 재검증
    if (files.length > MAX_FILE_COUNT) {
      alert(`파일은 최대 ${MAX_FILE_COUNT}개까지만 첨부할 수 있습니다.`);
      return;
    }

    // 작성 여부 확인
    if (!confirm("게시글을 작성하시겠습니까?")) return;

    // FormData 생성
    const formData = new FormData();
    formData.append("title", title);
    formData.append("content", content);
    files.forEach((file) => formData.append("uploadFile", file));

    try {
      const res = await axios.post("/write", formData, {
        headers: { "Content-Type": "multipart/form-data" },
      });

      if (res.data.success) {
        alert(res.data.message);
        navigate("/");
      } else {
        alert(res.data.message);
        if (res.data.redirectUrl) {
          navigate(res.data.redirectUrl);
        }
      }
    } catch {
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
                  <form id="writeForm" encType="multipart/form-data">
                    <div className="card shadow mb-4">
                      {/* ① 제목 + 작성완료 */}
                      <div className="card-header py-3">
                        <div className="row">
                          <div className="col-md-10">
                            <input
                              type="text"
                              name="title"
                              className="form-control"
                              placeholder="제목"
                              required
                              maxLength={4000}
                              value={title}
                              onChange={(e) => setTitle(e.target.value)}
                            />
                          </div>
                          <div className="col-md-2 text-right">
                            <button
                              type="button"
                              id="writeBtn"
                              className="btn btn-primary"
                              onClick={handleSubmit}
                            >
                              작성완료
                            </button>
                          </div>
                        </div>
                      </div>

                      {/* ② 내용 */}
                      <div className="card-body">
                        <textarea
                          name="content"
                          className="form-control mb-3"
                          rows="12"
                          placeholder="내용"
                          required
                          style={{ resize: "none" }}
                          maxLength={4000}
                          value={content}
                          onChange={(e) => setContent(e.target.value)}
                        />

                        {/* ③ 파일 업로드 */}
                        <div className="form-group mt-2">
                          <label className="font-weight-bold mb-1">
                            파일 업로드
                          </label>
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
                            {files.map((file, idx) => (
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

export default Write;