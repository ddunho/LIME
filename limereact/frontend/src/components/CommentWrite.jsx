import { useState } from "react";
import axios from "axios";

function CommentWrite({ postUid, reload }) {
  const [content, setContent] = useState("");

  const submitComment = async () => {
  if (!content.trim()) {
    alert("댓글 내용을 입력해주세요.");
    return;
  }

  try {
    const res = await axios.post("/comment/insert", {
      post_uid: postUid,
      content,
    });
    
    if (res.data.success) {
      setContent("");
      reload();
    } else {
      alert(res.data.message || "댓글 등록 실패");
    }
  } catch (error) {
    alert("댓글 등록 중 오류가 발생했습니다.");
    console.error(error);
  }
};

  return (
    <div className="comment-write mb-3">
      <textarea
        className="form-control"
        rows="3"
        placeholder="댓글을 입력하세요"
        value={content}
        onChange={(e) => setContent(e.target.value)}
      />
      <div className="text-right mt-2">
        <button
          className="btn btn-sm btn-primary"
          onClick={submitComment}
        >
          등록
        </button>
      </div>
    </div>
  );
}

export default CommentWrite;
