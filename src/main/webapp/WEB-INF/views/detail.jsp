<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

  <title>게시글 상세</title>

  <jsp:include page="/WEB-INF/views/common/assets.jsp"/>
</head>

<body id="page-top">
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">게시판</div>
      </a>

      <hr class="sidebar-divider my-0" />

	  <li class="nav-item">
	  	       <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
	  	          aria-expanded="true" aria-controls="collapsePages">
	  	         <i class="fas fa-fw fa-folder"></i>
	  	         <span>Pages</span>
	  	       </a>
	  	       <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
	  	         <div class="bg-white py-2 collapse-inner rounded">
	  	           <h6 class="collapse-header">Login Screens:</h6>
	  	  	  <c:choose>
	  	  	    <c:when test="${not empty LOGIN_USER}">
	  	  			<a class="collapse-item" href="#"
	  	  			   data-toggle="modal" data-target="#logoutModal">
	  	  			  Logout
	  	  			</a>
	  	  	    </c:when>
	  	  		<c:otherwise>
	  	  		  <a class="collapse-item" href="/login">Login</a>
	  	  		</c:otherwise>
	  	  	  </c:choose>

	  	           <a class="collapse-item" href="/membership">membership</a>
	  	         </div>
	  	       </div>
	  	     </li>

      <li class="nav-item active">
        <a class="nav-link" href="/">
          <i class="fas fa-fw fa-table"></i>
          <span>Tables</span>
        </a>
      </li>

      <hr class="sidebar-divider d-none d-md-block" />

      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>
    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
          <form class="form-inline">
            <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3" type="button">
              <i class="fa fa-bars"></i>
            </button>
          </form>

          <ul class="navbar-nav ml-auto">
            <div class="topbar-divider d-none d-sm-block"></div>

			<li class="nav-item dropdown no-arrow">
			  <c:choose>
			    <c:when test="${not empty LOGIN_USER}">
			      <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
			         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			        <span class="mr-2 d-none d-lg-inline text-gray-600 small">
			          ${LOGIN_USER.username}
			        </span>
			        <img class="img-profile rounded-circle" src="/img/undraw_profile.svg" />
			      </a>
			      
			      
			      <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
			           aria-labelledby="userDropdown">
			        <a class="dropdown-item" href="#">
			          <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
			          Profile
			        </a>
			        <div class="dropdown-divider"></div>
			        <a class="dropdown-item" href="#"
			           data-toggle="modal" data-target="#logoutModal">
			          <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
			          Logout
			        </a>
			      </div>
			    </c:when>

			    <c:otherwise>
			      <a class="nav-link" href="/login">
			        <span class="mr-2 d-none d-lg-inline text-gray-600 small">
			          guest
			        </span>
			        <img class="img-profile rounded-circle" src="/img/undraw_profile.svg" />
			      </a>
			    </c:otherwise>
			  </c:choose>

			</li>
          </ul>
        </nav>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid h-100">
          <h1 class="h3 mb-2 text-gray-800">게시글 상세</h1>

          <div class="card shadow mb-4 h-75">
            <div class="card-body">
              <div class="card shadow mb-4">
                
                <!-- 제목 + 버튼 -->
                <div class="card-header py-3">
                  <div class="row">
                    <div class="col-md-8">
                      <h6 class="m-0 font-weight-bold text-primary">${post.TITLE}</h6>
                      <small class="text-muted">
                        작성자: ${post.USERNAME} | 작성일: ${post.WRITEDATE}
                      </small>
                    </div>
					<div class="col-md-4 text-right">

					  <c:choose>
					    <c:when test="${not empty LOGIN_USER and LOGIN_USER.username eq post.USERNAME}">
					      <a href="/modify?postUid=${post.POSTUID}">
					        <button type="button" class="btn btn-primary">
					          수정
					        </button>
					      </a>
					      <button type="button" class="btn btn-danger" id="deleteBtn">
					        삭제
					      </button>
					    </c:when>
					    <c:otherwise>
					      <a href="/">
					        <button type="button" class="btn btn-secondary">
					          목록
					        </button>
					      </a>
					    </c:otherwise>

					  </c:choose>

					</div>

                  </div>
                </div>

                <!-- 내용 -->
                <div class="card-body" style="min-height: 300px;">
                  <p style="white-space: pre-wrap;">${post.CONTENT}</p>
                </div>

                <!-- 파일 목록 -->
                <c:if test="${not empty files}">
                  <div class="card-body border-top">
                    <label class="font-weight-bold">첨부파일</label>
                    <ul class="list-group">
                      <c:forEach var="file" items="${files}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                          <span>
                            <i class="fas fa-file mr-2"></i>
                            ${file.ORIGINALNAME}
                          </span>
                          <a href="/download?fileUid=${file.FILEUID}" class="btn btn-sm btn-outline-primary">
                            <i class="fas fa-download"></i> 다운로드
                          </a>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </c:if>
				
				<!-- ========== 댓글 섹션 추가 ========== -->
                <div class="card-body border-top comment-section">
                  <h6 class="font-weight-bold text-primary mb-3">
                    <i class="fas fa-comments mr-2"></i>댓글 <span id="commentCount" class="badge badge-primary">0</span>
                  </h6>

                  <!-- 댓글 작성 폼 -->
                  <c:choose>
                    <c:when test="${not empty LOGIN_USER}">
                      <div class="comment-write">
                        <textarea id="commentContent" placeholder="댓글을 입력하세요"></textarea>
                        <input type="hidden" id="postUid" value="${post.POSTUID}" />
                        <input type="hidden" id="parentCommentUid" value="" />
                        <div class="btn-group">
                          <button type="button" class="btn btn-sm btn-secondary" id="cancelReplyBtn" style="display:none;">
                            취소
                          </button>
                          <button type="button" class="btn btn-sm btn-primary" id="submitCommentBtn">
                            <i class="fas fa-paper-plane mr-1"></i>등록
                          </button>
                        </div>
                      </div>
                    </c:when>
                    <c:otherwise>
                      <div class="alert alert-info">
                        <i class="fas fa-info-circle mr-2"></i>
                        댓글을 작성하려면 <a href="/login" class="alert-link">로그인</a>이 필요합니다.
                      </div>
                    </c:otherwise>
                  </c:choose>

                  <!-- 댓글 목록 -->
                  <div id="commentList"></div>
                </div>
                <!-- ========== 댓글 섹션 끝 ========== -->
              </div>
            </div>
          </div>
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>풋터</span>
          </div>
        </div>
      </footer>
      <!-- End of Footer -->
    </div>
    <!-- End of Content Wrapper -->
  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
       aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          Select "Logout" below if you are ready to end your current session.
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="/" id="confirmLogoutBtn">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <script>
    // 로그아웃
    $(function () {
      $("#confirmLogoutBtn").on("click", function (e) {
        e.preventDefault();
        $.ajax({
          url: "/user/logout",
          type: "GET",
          success: function () {
            alert("로그아웃 성공");
            location.href = "/";
          }
        });
      });
    });

    // 댓글 기능
    $(document).ready(function() {
      loadCommentList();
      
      $('#submitCommentBtn').on('click', insertComment);
      $('#cancelReplyBtn').on('click', cancelReply);
    });

    // 댓글 목록 조회
    function loadCommentList() {
      $.ajax({
        url: '/comment/list',
        type: 'GET',
        data: { post_uid: $('#postUid').val() },
        success: function(response) {
          if (response.success) {
            displayCommentList(response.data);
            $('#commentCount').text(response.data.length);
          }
        }
      });
    }

    // 댓글 목록 표시
    function displayCommentList(comments) {
      var html = '';
      
      if (comments.length === 0) {
        html = '<div style="text-align:center; padding:40px; color:#999;">댓글이 없습니다.</div>';
      } else {
        $.each(comments, function(index, comment) {
          var depth = parseInt(comment.DEPTH) || 0;
          var isMyComment = '${LOGIN_USER.userUid}' == comment.USER_UID;
          
          // depth에 따른 들여쓰기 (10px씩)
          var indentStyle = depth > 0 ? 'margin-left: ' + (depth * 10) + 'px; border-left: 2px solid #e3e6f0; padding-left: 10px;' : '';
          
          html += '<div class="comment-item" style="' + indentStyle + '">';
          html += '  <div class="comment-header">';
          
          // 답글 표시
          if (depth > 0) {
            html += '    <i class="fas fa-reply" style="color:#999; margin-right:5px;"></i>';
          }
          
          html += '    <strong>' + (comment.USERNAME || '익명') + '</strong> ';
          html += '    <small style="color:#999;">' + comment.WRITE_DATE + '</small>';
          html += '  </div>';
          html += '  <div class="comment-content">' + comment.CONTENT + '</div>';
          html += '  <div class="comment-actions">';
          
          if (isMyComment) {
            html += '    <button class="btn btn-sm btn-outline-primary" onclick="editComment(' + comment.COMMENT_UID + ')">수정</button>';
            html += '    <button class="btn btn-sm btn-outline-danger" onclick="deleteComment(' + comment.COMMENT_UID + ')">삭제</button>';
          }
          
          // 로그인한 사용자는 모든 댓글에 답글 가능 (무한 대댓글)
          if ('${not empty LOGIN_USER}' == 'true') {
            html += '    <button class="btn btn-sm btn-outline-secondary" onclick="replyComment(' + comment.COMMENT_UID + ', \'' + (comment.USERNAME || '익명') + '\')">답글</button>';
          }
          
          html += '  </div>';
          html += '</div>';
        });
      }
      
      $('#commentList').html(html);
    }

    // 댓글 등록
    function insertComment() {
      var content = $('#commentContent').val().trim();
      if (!content) {
        alert('댓글 내용을 입력해주세요.');
        return;
      }
      
      var data = {
        content: content,
        post_uid: $('#postUid').val()
      };
      
      var parentUid = $('#parentCommentUid').val();
      if (parentUid) {
        data.parent_comment_uid = parentUid;
      }
      
      $.ajax({
        url: '/comment/insert',
        type: 'POST',
        data: data,
        success: function(response) {
          if (response.success) {
            $('#commentContent').val('');
            $('#parentCommentUid').val('');
            $('#commentContent').attr('placeholder', '댓글을 입력하세요');
            $('#cancelReplyBtn').hide();
            loadCommentList();
          } else {
            alert(response.message);
          }
        }
      });
    }

    // 답글 작성 (누구에게 답글 다는지 표시)
    function replyComment(commentUid, username) {
      $('#parentCommentUid').val(commentUid);
      $('#commentContent').attr('placeholder', username + '님에게 답글 작성 중...');
      $('#commentContent').focus();
      $('#cancelReplyBtn').show();
    }

    // 답글 취소
    function cancelReply() {
      $('#parentCommentUid').val('');
      $('#commentContent').val('');
      $('#commentContent').attr('placeholder', '댓글을 입력하세요');
      $('#cancelReplyBtn').hide();
    }

    // 댓글 수정
    function editComment(commentUid) {
      var newContent = prompt('댓글을 수정하세요:');
      if (newContent && newContent.trim()) {
        $.ajax({
          url: '/comment/update',
          type: 'POST',
          data: {
            comment_uid: commentUid,
            content: newContent
          },
          success: function(response) {
            if (response.success) {
              loadCommentList();
            } else {
              alert(response.message);
            }
          }
        });
      }
    }

    // 댓글 삭제
    function deleteComment(commentUid) {
      if (!confirm('댓글을 삭제하시겠습니까?')) {
        return;
      }
      
      $.ajax({
        url: '/comment/delete',
        type: 'POST',
        data: { comment_uid: commentUid },
        success: function(response) {
          if (response.success) {
            loadCommentList();
          } else {
            alert(response.message);
          }
        }
      });
    }
  </script>

</body>
</html>