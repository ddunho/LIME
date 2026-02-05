import { useState, useEffect } from "react";
import axios from "axios";

function CommentWrite({ postUid, reload, mode, targetUid, targetContent, onCancel }) {
  const [content, setContent] = useState("");

  useEffect(() => {
    if (mode === "edit" && targetContent) {
      setContent(targetContent);
    } else if (mode === "reply" && targetContent) {
      setContent(`@${targetContent} `);
    } else {
      setContent("");
    }
  }, [mode, targetContent]);

  const submitComment = async () => {
    if (!content.trim()) {
      alert("댓글 내용을 입력해주세요.");
      return;
    }

    try {
      if (mode === "edit") {
        // 수정
        const res = await axios.post("/comment/update", {
          comment_uid: targetUid,
          content,
        });

        if (res.data.success) {
          setContent("");
          reload();
        } else {
          alert(res.data.message);
        }
      } else {
        // 등록 또는 답글
        const data = {
          post_uid: postUid,
          content,
        };

        if (mode === "reply") {
          data.parent_comment_uid = targetUid;
        }

        const res = await axios.post("/comment/insert", data);

        if (res.data.success) {
          setContent("");
          reload();
        } else {
          alert(res.data.message);
        }
      }
    } catch (error) {
      alert("댓글 처리 중 오류가 발생했습니다.");
      console.error(error);
    }
  };

  const handleCancel = () => {
    setContent("");
    onCancel();
  };

  return (
    <div
      className={`comment-write mb-3 p-3 bg-white rounded ${
        mode ? "border border-primary" : ""
      }`}
    >
      {mode && (
        <div
          className="edit-info mb-2 p-2 rounded"
          style={{ background: "#4e73df", color: "white", fontSize: "13px" }}
        >
          <i className="fas fa-edit mr-2"></i>
          {mode === "edit"
            ? "댓글을 수정하고 있습니다."
            : `@${targetContent}님에게 답글 작성 중`}
        </div>
      )}

      <textarea
        className="form-control"
        rows="3"
        placeholder="댓글을 입력하세요"
        value={content}
        onChange={(e) => setContent(e.target.value)}
      />

      <div className="text-right mt-2">
        {mode && (
          <button
            className="btn btn-sm btn-secondary mr-2"
            onClick={handleCancel}
          >
            취소
          </button>
        )}
        <button className="btn btn-sm btn-primary" onClick={submitComment}>
          <i className="fas fa-paper-plane mr-1"></i>
          {mode === "edit" ? "수정완료" : "등록"}
        </button>
      </div>
    </div>
  );
}

export default CommentWrite;