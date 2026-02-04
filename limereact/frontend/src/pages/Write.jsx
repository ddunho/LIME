import { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";

const MAX_FILE_COUNT = 5;

function Write() {
  const navigate = useNavigate();

  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [files, setFiles] = useState([]);

  /* ================= 파일 선택 ================= */
  const handleFileChange = (e) => {
    const selectedFiles = Array.from(e.target.files);

    if (selectedFiles.length > MAX_FILE_COUNT) {
      alert(`파일은 최대 ${MAX_FILE_COUNT}개까지만 첨부할 수 있습니다.`);
      e.target.value = "";
      setFiles([]);
      return;
    }

    setFiles(selectedFiles);
  };

  /* ================= 게시글 작성 ================= */
  const handleSubmit = async () => {
    if (!title.trim()) {
      alert("제목을 입력해주세요.");
      return;
    }

    if (!content.trim()) {
      alert("내용을 입력해주세요.");
      return;
    }

    if (files.length > MAX_FILE_COUNT) {
      alert(`파일은 최대 ${MAX_FILE_COUNT}개까지만 첨부 가능합니다.`);
      return;
    }

    if (!confirm("게시글을 작성하시겠습니까?")) return;

    const formData = new FormData();
    formData.append("title", title);
    formData.append("content", content);
    files.forEach((file) => formData.append("uploadFile", file));

    try {
      const res = await axios.post("/write", formData, {
        headers: { "Content-Type": "multipart/form-data" },
      });

      if (res.data.success) {
        alert(res.data.message || "게시글이 등록되었습니다.");
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
    <div id="wrapper">
      <Sidebar />

      <div id="content-wrapper" className="d-flex flex-column">
        <div id="content">
          <Topbar />

          <div className="container-fluid">
            <h1 className="h3 mb-2 text-gray-800">게시판</h1>

            <div className="card shadow mb-4">
              <div className="card-body">
                <div className="card shadow">

                  {/* 제목 */}
                  <div className="card-header py-3">
                    <div className="row">
                      <div className="col-md-10">
                        <input
                          type="text"
                          className="form-control"
                          placeholder="제목"
                          maxLength={4000}
                          value={title}
                          onChange={(e) => setTitle(e.target.value)}
                        />
                      </div>
                      <div className="col-md-2 text-right">
                        <button
                          className="btn btn-primary"
                          onClick={handleSubmit}
                        >
                          작성완료
                        </button>
                      </div>
                    </div>
                  </div>

                  {/* 내용 */}
                  <div className="card-body">
                    <textarea
                      className="form-control mb-3"
                      rows="12"
                      placeholder="내용"
                      maxLength={4000}
                      style={{ resize: "none" }}
                      value={content}
                      onChange={(e) => setContent(e.target.value)}
                    />

                    {/* 파일 업로드 */}
                    <div className="form-group mt-2">
                      <label className="font-weight-bold">
                        파일 업로드
                      </label>
                      <input
                        type="file"
                        className="form-control-file"
                        multiple
                        onChange={handleFileChange}
                      />
                      <small className="form-text text-muted">
                        파일은 최대 5개까지 첨부 가능합니다.
                      </small>

                      {files.length > 0 && (
                        <ul className="list-group mt-2">
                          {files.map((file, idx) => (
                            <li
                              key={idx}
                              className="list-group-item"
                            >
                              {file.name}
                            </li>
                          ))}
                        </ul>
                      )}
                    </div>
                  </div>

                </div>
              </div>
            </div>
          </div>
        </div>

        <Footer />
      </div>
    </div>
  );
}

export default Write;
