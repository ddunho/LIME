<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <title>게시글 상세</title>

    <jsp:include page="/WEB-INF/views/common/assets.jsp" />
    
    <!-- ========== 댓글 스타일 ========== -->
    <style>
    .comment-section {
        background: #f8f9fc;
        border-radius: 8px;
        padding: 20px;
    }

    .comment-write {
        background: white;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }

    .comment-write textarea {
        width: 100%;
        min-height: 80px;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 10px;
        resize: vertical;
        font-size: 14px;
    }

    .comment-write .btn-group {
        margin-top: 10px;
        text-align: right;
    }

    /* 🔥 수정 모드 스타일 */
    .comment-write.edit-mode {
        border: 2px solid #4e73df;
        background: #f0f4ff;
    }

    .comment-write.edit-mode textarea {
        border-color: #4e73df;
    }

    .edit-info {
        background: #4e73df;
        color: white;
        padding: 8px 12px;
        border-radius: 4px;
        margin-bottom: 10px;
        font-size: 13px;
    }

    .comment-item {
        background: white;
        border-radius: 6px;
        margin-bottom: 8px;
        transition: background 0.2s;
    }

    .comment-item:hover {
        background: #f9f9f9;
    }

    /* 답글 시각화 개선 */
    .comment-item[style*="border-left"] {
        background: #fafbfc;
    }
    </style>
</head>

<body id="page-top">
    <div id="wrapper">

        <!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">

                <!-- Topbar -->
				<jsp:include page="/WEB-INF/views/common/topbar.jsp" />
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
                                                <c:when
                                                    test="${not empty LOGIN_USER and LOGIN_USER.username eq post.USERNAME}">
                                                    <button type="button" class="btn btn-danger" id="deleteBtn">
                                                        삭제
                                                    </button>
                                                    <a href="/modify?postUid=${post.POSTUID}">
                                                        <button type="button" class="btn btn-primary">
                                                            수정
                                                        </button>
                                                    </a>
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
                                                <li
                                                    class="list-group-item d-flex justify-content-between align-items-center">
                                                    <span>
                                                        <i class="fas fa-file mr-2"></i>
                                                        ${file.ORIGINALNAME}
                                                    </span>
                                                    <a href="/download?fileUid=${file.FILEUID}"
                                                        class="btn btn-sm btn-outline-primary">
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
                                        <i class="fas fa-comments mr-2"></i>댓글 <span id="commentCount"
                                            class="badge badge-primary">0</span>
                                    </h6>

                                    <!-- 댓글 작성 폼 -->
                                    <input type="hidden" id="postUid" value="${post.POSTUID}" />
                                    <c:choose>
                                        <c:when test="${not empty LOGIN_USER}">
                                            <div class="comment-write" id="commentWriteBox">
                                                <!-- 🔥 수정 모드 안내 -->
                                                <div id="editModeInfo" class="edit-info" style="display:none;">
                                                    <i class="fas fa-edit mr-2"></i>
                                                    <span id="editModeText"></span>
                                                </div>
                                                
                                                <textarea id="commentContent" placeholder="댓글을 입력하세요"></textarea>
                                                
                                                <!--  Hidden fields -->
                                                <input type="hidden" id="parentCommentUid" value="" />
                                                <input type="hidden" id="editCommentUid" value="" />
                                                
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-sm btn-secondary"
                                                        id="cancelBtn" style="display:none;">
                                                        취소
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-primary"
                                                        id="submitCommentBtn">
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
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
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
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
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

    <!-- ========== 개선된 댓글 JavaScript (비동기 DOM 업데이트) ========== -->
    <script>
    $(document).ready(function() {
        loadCommentList();
        
        $('#submitCommentBtn').on('click', submitComment);
        $('#cancelBtn').on('click', cancelAction);
    });

    // 댓글 목록 조회
    function loadCommentList() {
        const postUid = $('#postUid').val();
        
        if (!postUid) {
            console.warn('postUid 없음 → 댓글 조회 중단');
            return;
        }
        
		requestAjax({
		    url: '/comment/list',
		    data: { post_uid: postUid },

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
                html += generateCommentHtml(comment);
            });
        }
        
        $('#commentList').html(html);
    }

    //  댓글 HTML 생성 함수 (재사용)
    function generateCommentHtml(comment) {
        var depth = parseInt(comment.DEPTH) || 0;
        var isMyComment = '${LOGIN_USER.userUid}' == comment.USER_UID;
        var isDeleted = comment.DELETEYN === 'Y';
        
        var indentPx = depth * 30;
        var indentStyle = depth > 0 
            ? 'margin-left: ' + indentPx + 'px; border-left: 2px solid #d1d3e2; padding-left: 15px;' 
            : '';
        
        var html = '<div class="comment-item" data-comment-uid="' + comment.COMMENT_UID + '" style="padding: 15px 0; border-bottom: 1px solid #f0f0f0; ' + indentStyle + '">';
        
        if (isDeleted) {
            html += '  <div style="color:#999; font-style:italic; padding: 10px 0;">';
            html += '    <i class="fas fa-ban mr-2"></i>삭제된 댓글입니다.';
            html += '  </div>';
        } else {
            html += '  <div style="margin-bottom: 8px;">';
            
            if (depth > 0) {
                html += '    <i class="fas fa-level-up-alt fa-rotate-90 mr-1" style="color:#999; font-size:12px;"></i>';
            }
            
            html += '    <strong style="color:#333;">' + (comment.USERNAME || '익명') + '</strong>';
            html += '    <small style="color:#999; margin-left:10px;">' + comment.WRITE_DATE + '</small>';
            html += '  </div>';
            
            html += '  <div class="comment-content-text" style="margin-bottom: 10px; color:#555; white-space: pre-wrap;">' + comment.CONTENT + '</div>';
            
            html += '  <div>';
            
            if (isMyComment) {
                html += '    <button class="btn btn-sm btn-outline-primary" onclick="editComment(' + comment.COMMENT_UID + ', \'' + escapeHtml(comment.CONTENT) + '\')" style="margin-right:5px;">';
                html += '      <i class="fas fa-edit"></i> 수정';
                html += '    </button>';
                html += '    <button class="btn btn-sm btn-outline-danger" onclick="deleteComment(' + comment.COMMENT_UID + ')" style="margin-right:5px;">';
                html += '      <i class="fas fa-trash"></i> 삭제';
                html += '    </button>';
            }
            
            if ('${not empty LOGIN_USER}' == 'true') {
                html += '    <button class="btn btn-sm btn-outline-secondary" onclick="replyComment(' + comment.COMMENT_UID + ', \'' + comment.USERNAME + '\')">';
                html += '      <i class="fas fa-reply"></i> 답글';
                html += '    </button>';
            }
            
            html += '  </div>';
        }
        
        html += '</div>';
        
        return html;
    }

    // HTML 이스케이프
    function escapeHtml(text) {
        return text
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    // 댓글 등록/수정 통합 함수
    function submitComment() {
        var content = $('#commentContent').val().trim();
        if (!content) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }
        
        var editCommentUid = $('#editCommentUid').val();
        
        if (editCommentUid) {
            updateComment(editCommentUid, content);
        } else {
            insertComment(content);
        }
    }

    // 댓글 등록
    function insertComment(content) {
        var data = {
            content: content,
            post_uid: $('#postUid').val()
        };
        
        var parentUid = $('#parentCommentUid').val();
        if (parentUid) {
            data.parent_comment_uid = parentUid;
        }
        
		requestAjax({
		    url: '/comment/insert',
		    method: 'POST',
		    data: data,

		    success: function(response) {
		        if (response.success) {
		            cancelAction();
		            // 전체 댓글 목록 다시 조회 (등록은 계층 구조 때문에 전체 조회 필요)
		            loadCommentList();
		        } else {
		            alert(response.message);
		        }
		    },

		    error: function() {
		        alert('댓글 등록 중 오류가 발생했습니다.');
		    }
		});

    }

    // 댓글 수정 - DOM 직접 업데이트 (조회 API 없이)
    function updateComment(commentUid, content) {
		requestAjax({
		    url: '/comment/update',
		    method: 'POST',
		    data: {
		        comment_uid: commentUid,
		        content: content
		    },

		    success: function(response) {
		        if (response.success) {
		            // 해당 댓글의 내용만 DOM에서 직접 업데이트
		            var $commentItem = $('.comment-item[data-comment-uid="' + commentUid + '"]');
		            $commentItem.find('.comment-content-text').text(content);
		            
		            // 수정 시간 업데이트 (현재 시간으로)
		            var now = new Date();
		            var timeStr = now.getFullYear() + '-' + 
		                String(now.getMonth() + 1).padStart(2, '0') + '-' + 
		                String(now.getDate()).padStart(2, '0') + ' ' +
		                String(now.getHours()).padStart(2, '0') + ':' + 
		                String(now.getMinutes()).padStart(2, '0') + ':' + 
		                String(now.getSeconds()).padStart(2, '0');
		            
		            $commentItem.find('small').text(timeStr);
		            
		            // 수정 완료 피드백
		            $commentItem.addClass('bg-light');
		            setTimeout(function() {
		                $commentItem.removeClass('bg-light');
		            }, 1000);
		            
		            cancelAction();
		        } else {
		            alert(response.message);
		        }
		    },

		    error: function() {
		        alert('댓글 수정 중 오류가 발생했습니다.');
		    }
		});

    }

    // 수정 모드 활성화
    function editComment(commentUid, content) {
        var decodedContent = $('<textarea/>').html(content).text();
        
        $('#editCommentUid').val(commentUid);
        $('#commentContent').val(decodedContent);
        $('#editModeInfo').show();
        $('#editModeText').text('댓글을 수정하고 있습니다.');
        $('#submitCommentBtn').html('<i class="fas fa-check mr-1"></i>수정완료');
        $('#cancelBtn').show();
        $('#commentWriteBox').addClass('edit-mode');
        
        $('#commentContent').focus();
        $('html, body').animate({
            scrollTop: $('#commentWriteBox').offset().top - 100
        }, 300);
    }

    // 답글 작성
    function replyComment(commentUid, username) {
        if ($('#editCommentUid').val()) {
            cancelAction();
        }
        
        $('#parentCommentUid').val(commentUid);
        
        const textarea = $('#commentContent');
        const mention = '@' + username + ' ';
        textarea.val(mention);  // "@test " 자동 입력

        // 커서를 멘션 뒤로 이동
        textarea.focus();
        var len = textarea.val().length;
        textarea[0].setSelectionRange(len, len);
        
        $('#editModeInfo').show();
        $('#editModeText').text('@' + username + '님에게 답글 작성 중');
        $('#cancelBtn').show();
        
        $('html, body').animate({
            scrollTop: $('#commentWriteBox').offset().top - 100
        }, 300);
    }

    // 취소
    function cancelAction() {
        $('#parentCommentUid').val('');
        $('#editCommentUid').val('');
        $('#commentContent').val('');
        $('#commentContent').attr('placeholder', '댓글을 입력하세요');
        $('#editModeInfo').hide();
        $('#submitCommentBtn').html('<i class="fas fa-paper-plane mr-1"></i>등록');
        $('#cancelBtn').hide();
        $('#commentWriteBox').removeClass('edit-mode');
    }

    //  댓글 삭제 - DOM 직접 업데이트 (조회 API 없이)
    function deleteComment(commentUid) {
        if (!confirm('댓글을 삭제하시겠습니까?')) {
            return;
        }
        
		requestAjax({
		    url: '/comment/delete',
		    method: 'POST',
		    data: { commentUid: commentUid },

		    success: function(response) {
		        if (response.success) {
		            // 해당 댓글을 "삭제된 댓글입니다"로 DOM에서 직접 변경
		            var $commentItem = $('.comment-item[data-comment-uid="' + commentUid + '"]');
		            
		            $commentItem.html(
		                '<div style="color:#999; font-style:italic; padding: 10px 0;">' +
		                '  <i class="fas fa-ban mr-2"></i>삭제된 댓글입니다.' +
		                '</div>'
		            );
		            
		            // 삭제 애니메이션
		            $commentItem.fadeOut(200).fadeIn(200);
		            
		            // 댓글 개수 갱신
		            updateCommentCount();
		        } else {
		            alert(response.message);
		        }
		    },

		    error: function() {
		        alert('댓글 삭제 중 오류가 발생했습니다.');
		    }
		});

    }

    // 댓글 개수 갱신 (삭제된 댓글 제외)
    function updateCommentCount() {
        var activeComments = $('.comment-item').filter(function() {
            return $(this).find('.comment-content-text').length > 0; // 삭제되지 않은 댓글만
        }).length;
        
        $('#commentCount').text(activeComments);
    }

    // ========== 게시글 삭제 (개선) ==========
    $('#deleteBtn').on('click', function () {
        if (!confirm('게시글을 삭제하시겠습니까?\n\n✓ 게시글의 모든 댓글이 함께 삭제됩니다.\n✓ 첨부파일도 함께 삭제됩니다.\n✓ 삭제된 내용은 복구할 수 없습니다.')) {
            return;
        }

		requestAjax({
		    url: '/post/delete',
		    method: 'POST',
		    data: {
		        postUid: '${post.POSTUID}'
		    },

		    success: function (response) {
		        if (response.success) {
		            alert(response.message || '게시글이 삭제되었습니다.');
		            location.href = '/';
		        } else {
		            alert(response.message || '게시글 삭제에 실패했습니다.');
		        }
		    },

		    error: function (xhr) {
		        console.error('삭제 오류:', xhr);
		        console.error('Response:', xhr.responseText);
		        
		        var errorMessage = '게시글 삭제 중 오류가 발생했습니다.';
		        if (xhr.responseJSON && xhr.responseJSON.message) {
		            errorMessage += '\n\n상세: ' + xhr.responseJSON.message;
		        }
		        alert(errorMessage);
		    }
		});

    });
    </script>

</body>

</html>
