import { useEffect, useState } from "react";
import axios from "axios";
import CommentWrite from "./CommentWrite";
import CommentList from "./CommentList";

function CommentSection({ postUid, loginUser }) {
  const [comments, setComments] = useState([]);

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
  }, []);

  return (
    <div className="card-body border-top">
      <h6 className="text-primary font-weight-bold">
        댓글 <span className="badge badge-primary">{comments.length}</span>
      </h6>

      {loginUser ? (
        <CommentWrite
          postUid={postUid}
          reload={loadComments}
        />
      ) : (
        <div className="alert alert-info">
          로그인 후 댓글 작성이 가능합니다.
        </div>
      )}

      <CommentList
        comments={comments}
        loginUser={loginUser}
        reload={loadComments}
      />
    </div>
  );
}

export default CommentSection;
