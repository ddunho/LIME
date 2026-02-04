import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";
import Sidebar from "../components/Sidebar";
import Topbar from "../components/Topbar";
import Footer from "../components/Footer";

const MAX_FILE_COUNT = 5;

function Modify() {
  const { postUid } = useParams();
  const navigate = useNavigate();

  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [originFiles, setOriginFiles] = useState([]);
  const [newFiles, setNewFiles] = useState([]);

  /* ================= 게시글 정보 로딩 ================= */
  useEffect(() => {
    fetchPost();
  }, []);

  const fetchPost = async () => {
  try {
    const res = await axios.get("/modify", {
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

    newFiles.forEach((file) =>
      formData.append("uploadFile", file)
    );

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
                          maxLength={4000}
                          value={title}
                          onChange={(e) =>
                            setTitle(e.target.value)
                          }
                        />
                      </div>
                      <div className="col-md-2 text-right">
                        <button
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
                      className="form-control mb-3"
                      rows="12"
                      maxLength={4000}
                      style={{ resize: "none" }}
                      value={content}
                      onChange={(e) =>
                        setContent(e.target.value)
                      }
                    />

                    {/* 기존 파일 */}
                    <div className="mb-3">
                      <label className="font-weight-bold">
                        기존 첨부파일
                      </label>
                      <ul className="list-group">
                        {originFiles.length > 0 ? (
                          originFiles.map((f) => (
                            <li
                              key={f.FILEUID}
                              className="list-group-item"
                            >
                              {f.ORIGINALNAME}
                            </li>
                          ))
                        ) : (
                          <li className="list-group-item text-muted">
                            첨부파일 없음
                          </li>
                        )}
                      </ul>
                    </div>

                    {/* 새 파일 */}
                    <div className="form-group mt-3">
                      <label className="font-weight-bold">
                        파일 선택
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

                      {newFiles.length > 0 && (
                        <ul className="list-group mt-2">
                          {newFiles.map((file, idx) => (
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

export default Modify;
