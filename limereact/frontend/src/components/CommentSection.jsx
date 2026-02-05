import { useEffect, useState } from "react";
import axios from "axios";
import CommentWrite from "./CommentWrite";
import CommentList from "./CommentList";

function CommentSection({ postUid, loginUser }) {
  const [comments, setComments] = useState([]);
  const [mode, setMode] = useState(null); // null, "edit", "reply"
  const [targetUid, setTargetUid] = useState(null);
  const [targetContent, setTargetContent] = useState("");

  const loadComments = async () => {
    try {
      const res = await axios.get("/comment/list", {
        params: { post_uid: postUid },
      });
      if (res.data.success) {
        setComments(res.data.data);
      }
    } catch (error) {
      console.error("댓글 로드 실패:", error);
    }
  };

  useEffect(() => {
    loadComments();
  }, [postUid]);

  // 수정 모드 활성화
  const handleEdit = (commentUid, content) => {
    setMode("edit");
    setTargetUid(commentUid);
    setTargetContent(content);
  };

  // 답글 모드 활성화
  const handleReply = (commentUid, username) => {
    setMode("reply");
    setTargetUid(commentUid);
    setTargetContent(username);
  };

  // 취소 또는 완료 후 초기화
  const handleReset = () => {
    setMode(null);
    setTargetUid(null);
    setTargetContent("");
    loadComments();
  };

  // 취소만
  const handleCancel = () => {
    setMode(null);
    setTargetUid(null);
    setTargetContent("");
  };

  // 댓글 개수 계산 (삭제되지 않은 댓글만)
  const activeCommentCount = comments.filter(
    (c) => c.DELETEYN !== "Y"
  ).length;

  return (
    <div className="card-body border-top comment-section">
      <h6 className="text-primary font-weight-bold mb-3">
        <i className="fas fa-comments mr-2"></i>
        댓글 <span className="badge badge-primary">{activeCommentCount}</span>
      </h6>

      {loginUser ? (
        <CommentWrite
          postUid={postUid}
          reload={handleReset}
          mode={mode}
          targetUid={targetUid}
          targetContent={targetContent}
          onCancel={handleCancel}
        />
      ) : (
        <div className="alert alert-info">
          <i className="fas fa-info-circle mr-2"></i>
          댓글을 작성하려면{" "}
          <a href="/login" className="alert-link">
            로그인
          </a>
          이 필요합니다.
        </div>
      )}

      <CommentList
        comments={comments}
        loginUser={loginUser}
        onEdit={handleEdit}
        onReply={handleReply}
        onDelete={loadComments}
      />
    </div>
  );
}

export default CommentSection;