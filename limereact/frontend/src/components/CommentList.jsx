function CommentList({ comments, loginUser, reload }) {
  if (comments.length === 0) {
    return (
      <div className="text-center text-muted py-4">
        댓글이 없습니다.
      </div>
    );
  }

  return (
    <div>
      {comments.map((comment) => (
        <div
          key={comment.COMMENT_UID}
          className="border-bottom py-2"
        >
          <strong>{comment.USERNAME}</strong>
          <p style={{ whiteSpace: "pre-wrap" }}>
            {comment.CONTENT}
          </p>
        </div>
      ))}
    </div>
  );
}

export default CommentList;
