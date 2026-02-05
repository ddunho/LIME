import { useState } from "react";
import axios from "axios";

function CommentList({ comments, loginUser, onEdit, onReply, onDelete }) {
  if (comments.length === 0) {
    return (
      <div className="text-center text-muted py-4">
        댓글이 없습니다.
      </div>
    );
  }

  // 댓글 삭제
  const deleteComment = async (commentUid) => {
    if (!window.confirm("댓글을 삭제하시겠습니까?")) return;

    try {
      const res = await axios.post("/comment/delete", { commentUid });
      if (res.data.success) {
        onDelete(); // 삭제 후 콜백
      } else {
        alert(res.data.message);
      }
    } catch (error) {
      alert("댓글 삭제 중 오류가 발생했습니다.");
    }
  };

  return (
    <div>
      {comments.map((comment) => {
        const depth = parseInt(comment.DEPTH) || 0;
        const isMyComment = loginUser && loginUser.userUid === comment.USER_UID;
        const isDeleted = comment.DELETEYN === "Y";

        const indentStyle = depth > 0
          ? {
              marginLeft: depth * 30 + "px",
              borderLeft: "2px solid #d1d3e2",
              paddingLeft: "15px",
            }
          : {};

        return (
          <div
            key={comment.COMMENT_UID}
            className="comment-item border-bottom py-3"
            style={indentStyle}
            data-comment-uid={comment.COMMENT_UID}
          >
            {isDeleted ? (
              <div style={{ color: "#999", fontStyle: "italic" }}>
                <i className="fas fa-ban mr-2"></i>
                삭제된 댓글입니다.
              </div>
            ) : (
              <>
                <div className="mb-2">
                  {depth > 0 && (
                    <i
                      className="fas fa-level-up-alt fa-rotate-90 mr-1"
                      style={{ color: "#999", fontSize: "12px" }}
                    ></i>
                  )}
                  <strong>{comment.USERNAME || "익명"}</strong>
                  <small className="text-muted ml-2">
                    {comment.WRITE_DATE}
                  </small>
                </div>

                <div
                  className="comment-content-text mb-2"
                  style={{ whiteSpace: "pre-wrap", color: "#555" }}
                >
                  {comment.CONTENT}
                </div>

                <div>
                  {isMyComment && (
                    <>
                      <button
                        className="btn btn-sm btn-outline-primary mr-2"
                        onClick={() => onEdit(comment.COMMENT_UID, comment.CONTENT)}
                      >
                        <i className="fas fa-edit"></i> 수정
                      </button>
                      <button
                        className="btn btn-sm btn-outline-danger mr-2"
                        onClick={() => deleteComment(comment.COMMENT_UID)}
                      >
                        <i className="fas fa-trash"></i> 삭제
                      </button>
                    </>
                  )}

                  {loginUser && (
                    <button
                      className="btn btn-sm btn-outline-secondary"
                      onClick={() => onReply(comment.COMMENT_UID, comment.USERNAME)}
                    >
                      <i className="fas fa-reply"></i> 답글
                    </button>
                  )}
                </div>
              </>
            )}
          </div>
        );
      })}
    </div>
  );
}

export default CommentList;