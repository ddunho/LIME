<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<c:set var="contextPath" value="/WEB-INF/views" scope="application" />
<!DOCTYPE html>
<html>
  <jsp:include page="../common/head.jsp" />
  <body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
      <!-- Sidebar -->
      <jsp:include page="../common/sidebar.jsp" />
      <!-- End of Sidebar -->
      <!-- Content Wrapper -->
      <div id="content-wrapper" class="flex-column">
        <!-- Main Content -->
        <div id="content">
          <!-- Topbar -->

          <jsp:include page="../common/header.jsp" />
          <!-- End of Topbar -->

          <!-- Begin Page Content -->
          <div class="container-fluid h-100">
            <!-- Page Heading -->
            <h1 class="h3 mb-2 text-gray-800">게시판</h1>

            <!-- DataTales Example -->
            <div class="card shadow mb-4 h-75">
              <div class="card-body">
                <!-- Basic Card Example -->
                <div class="card shadow mb-4 h-100">
                  <div class="card-header py-3">
                    <h6
                      class="m-0 font-weight-bold text-primary btn float-left"
                    >
                      ${resultList.POSTS_TITLE}
                    </h6>
                    <c:if test="${user.userNo eq resultList.USER_NO}">
                      <button
                        type="button"
                        data-postsNo="${resultList.POSTS_NO}"
                        data-url="boardUpdate"
                        class="btn btn-primary btn float-right ml-1"
                      >
                        수정
                      </button>
                      <button
                        type="button"
                        data-postsNo="${resultList.POSTS_NO}"
                        data-url="boardDelete"
                        class="btn btn-danger btn float-right"
                      >
                        삭제
                      </button>
                    </c:if>
                  </div>
                  <div
                    class="card-body navbar-nav-scroll"
                    style="height: 290px !important"
                  >
                    ${resultList.POSTS_CONTENT}
                  </div>
                  <div class="card-body fileUpLoad">
                    <label class="fileUpLoadBtn">파일</label>
                    <div id="fileName" class="fileName">
                      <c:forEach var="file" items="${fileList}">
                        <a href="#" data-file-name="${file.FILE_NAME }"
                          >${file.FILE_NAME }</a
                        >
                      </c:forEach>
                    </div>
                  </div>
                  <div class="card-footer">
                    <form action="#" id="replyForm" name="replyForm">
                      <input
                        type="hidden"
                        name="postsNo"
                        value="${resultList.POSTS_NO}"
                      />
                      <input type="hidden" name="parentNo" value="0" />
                      <input type="hidden" name="commentsNo" value="0" />
                      <ul
                        id="commentDiv"
                        style="
                          max-height: 500px;
                          overflow-y: scroll;
                          overflow-x: hidden;
                        "
                      >
                        <c:forEach var="comment" items="${commentList}">
                          <li
                            data-no="${comment.COMMENTS_NO}"
                            data-name="${comment.USER_NM}"
                            data-date="${comment.REG_DTM}"
                            data-parent="${comment.PARENT_NO}"
                          >
                            <div
                              class="commentDiv"
                              style="padding-left: ${comment.COMMENT_LEVEL + 2}rem;"
                            >
                              <div class="commentHead">
                                <div class="commentHead1">
                                  <c:if test="${comment.DEL_YN eq 'N'}">
                                    <div class="commentName">
                                      ${comment.USER_NM}
                                    </div>
                                    <div class="commentDate">
                                      ${comment.REG_DTM}
                                    </div>
                                  </c:if>
                                </div>
                                <c:if test="${not empty user}">
                                  <div class="commentHead2">
                                    <c:if test="${comment.DEL_YN eq 'N'}">
                                      <div class="commentReply">답글</div>
                                      <c:if
                                        test="${user.userNo eq comment.USER_NO}"
                                      >
                                        <div class="commentUpdate">수정</div>
                                        <div class="commentDelete">삭제</div>
                                      </c:if>
                                      <div
                                        class="commentCancle"
                                        style="display: none"
                                      >
                                        취소
                                      </div>
                                    </c:if>
                                  </div>
                                </c:if>
                              </div>
                              <div class="comment">
                                <c:if test="${comment.DEL_YN eq 'N'}">
                                  <pre>${comment.COMMENTS_CONTENT}</pre>
                                </c:if>
                                <c:if test="${comment.DEL_YN eq 'Y'}">
                                  <p>삭제된 댓글입니다.</p>
                                </c:if>
                              </div>
                            </div>
                            <hr class="sidebar-divider d-none d-md-block" />
                          </li>
                        </c:forEach>
                      </ul>
                    </form>
                    <c:if test="${not empty user}"> 
                     <form action="#" class="flex" id="commentForm" name="commentForm">
                           <input type="hidden" name="postsNo" value="${resultList.POSTS_NO}">
                           <input type="hidden" name="parentNo" value="${resultList.PARENT_NO}">
                           <textarea
                              id="a3"
                              cols="30"
                              row="5"
                              name="commentsContent"
                              class="form-control flex"
                              style="width: 90%"
                              placeholder="내용
                              "
                              style="resize: none"
                           ></textarea>
                           <a href="#" class="commentAdd flex"
                              style="width: 9%">
                              <button
                                 type="button"
                                 class="btn btn-primary btn ml-1"
                                 style="margin-top: 0.75rem;width: 100%"
                              >등록</button>
                           </a>
                        </form>
                    </c:if>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- /.container-fluid -->
        </div>
        <!-- End of Main Content -->

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp" />
        <!-- End of Footer -->
      </div>
      <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->

    <!-- logoutModal -->
    <jsp:include page="../common/logoutModal.jsp" />
    <!-- logoutModal -->
  </body>
  <form
    action="#"
    method="post"
    class="h-100"
    id="detailForm"
    name="detailForm"
  >
    <input type="hidden" name="postsNo" value="${resultList.POSTS_NO}" />
    <input type="hidden" name="parentNo" value="${resultList.PARENT_NO}" />
  </form>
  <script type="text/html" id="commentElement">
    <li data-no="" data-name="" data-date="" data-parent="">
      <div class="commentDiv">
        <div class="commentHead">
          <div class="commentHead1">
            <div class="commentName"></div>
            <div class="commentDate"></div>
          </div>
          <div class="commentHead2">
            <div class="commentReply">답글</div>
            <div class="commentUpdate">수정</div>
            <div class="commentDelete">삭제</div>
            <div class="commentCancle" style="display:none;">취소</div>
          </div>
        </div>
        <div class="comment"><pre></pre></div>
      </div>
      <hr class="sidebar-divider d-none d-md-block" />
    </li>
  </script>
  <script type="text/html" id="replyElement">
    <div class="flex replyElement">
      <textarea
        id="a3"
        cols="30"
        row="5"
        name="commentsContent"
        class="form-control flex"
        style="width: 90%"
        placeholder="내용
            "
        style="resize: none"
      ></textarea>
      <a href="#" class="flex commentAdd" style="width: 9%">
        <button
          type="button"
          class="btn btn-primary btn ml-1"
          style="margin-top: 0.75rem;width: 100%"
        >등록</button>
      </a>
    </div>
  </script>
  <script>
    /**
     * ===============
     * Document Ready
     * (문서가 완전히 로드된 후 실행되는 초기화 코드)
     * ===============
     */
    $(function () {
      /* 게시판 삭제 및 수정 */
      $("button[data-postsNo]").click(function () {
        var postsNo = $(this).attr("data-postsNo");
        var postsUrl = $(this).attr("data-url");
        if ("boardDelete" == postsUrl) {
          ajaxCall("/" + postsUrl, "POST", "detailForm", deleteCallbackFnc);
        } else if ("boardUpdate" == postsUrl) {
          location.href = "/" + postsUrl + "?postsNo=" + postsNo;
        }
      });

      /* 게시판 파일 다운로드 */
      $("#fileName a").click(function () {
        location.href = "/fileDownload?fileName=" + this.dataset.fileName;
      });

      /* 댓글 등록 및 수정 */
      $("form").on("click", ".commentAdd", function () {
        var url = "";
        var form = $(this).parents("form");

        if (this.modify == "Y") {
          url = "/commentUpdate";
          form
            .find("input[name=commentsNo]")
            .val($(this).parents("[data-no]").attr("data-no"));
          this.modify = "N";
        } else {
          url = "/commentWrite";
        }

        ajaxCall(url, "POST", form, commentCallbackFnc);
      });

      /* 취소 버튼 */
      $("#commentDiv").on("click", ".commentCancle", function () {
        commentCancle(this);
        $("#commentForm").show();
      });

      /* 답글 및 수정 버튼 */
      $("#commentDiv").on("click", ".commentUpdate,.commentReply", function () {
        for (var i = 0; i < $(".commentCancle:visible").length; i++) {
          commentCancle($(".commentCancle:visible")[i]);
        }

        var commentItem = $(this).parents("[data-no]");

        commentItem.find(".commentHead2 div").hide();
        commentItem.find(".commentHead2 div.commentCancle").show();

        $("#commentForm").hide();

        if (this.className == "commentUpdate") {
          commentItem[0].currentText = commentItem.find(".comment pre").text();

          commentItem.find(".comment pre").html($("#replyElement").html());
          commentItem
            .find("[name=commentsContent]")
            .val(commentItem[0].currentText);

          commentItem.find(".commentAdd")[0].modify = "Y";
        } else if (this.className == "commentReply") {
          var name = "@" + commentItem.attr("data-name") + " ";

          commentItem.find(".commentDiv").append($("#replyElement").html());
          commentItem.find("[name=commentsContent]").val(name);
          commentItem
            .parents("form")
            .find("[name=parentNo]")
            .val(commentItem.attr("data-no"));

          commentItem.find(".commentAdd")[0].modify = "N";
        }
        if (
          commentItem.find(".commentDiv").css("padding-left") != "32px" ||
          this.className == "commentReply"
        ) {
          commentItem.find("[name=commentsContent]")[0].content = commentItem.find("[name=commentsContent]").val().split(" ")[0] + " ";
          commentItem.on("keydown", "[name=commentsContent]", function (e) {
            var text = this.content;
			console.log("text", text);
            if (
              (this.selectionStart <= text.length && e.keyCode == 8) ||
              this.selectionStart < text.length
            ) {
              e.preventDefault();
              this.selectionStart = text.length;
              this.selectionEnd = text.length;
            }
          });
        }
      });

      /* 댓글 삭제 버튼 */
      $("#commentDiv").on("click", ".commentDelete", function () {
        if (!gfnAlert("댓글을 삭제하시겠습니까?", "confirm")) {
          return false;
        }
        var commentsNo = $(this).parents("li").attr("data-no");
        var data = {
          commentsNo: commentsNo,
        };
        ajaxCall("/commentDelete", "POST", data, commentDeleteCallbackFnc);
      });
    });

    /**
     * =================================
     * Functions (함수 모음)
     * =================================
     */

    /* 댓글 취소 */
    function commentCancle(e) {
      var commentItem = $(e).parents("[data-no]");

      commentItem.find(".commentHead2 div").hide();
      commentItem.find(".commentHead2 div:not(.commentCancle)").show();

      if (commentItem.find(".comment pre .replyElement").length == 0) {
        commentItem.find(".replyElement").remove();
      } else {
        commentItem.find(".comment pre").text(commentItem[0].currentText);
        commentItem[0].currentText = undefined;
      }
    }

    /**
     * =================================
     * Callback Functions (콜백 함수 모음)
     * =================================
     */

    /* 게시판 글 삭제  */
    function deleteCallbackFnc(res) {
      if (res.result == true) {
        gfnAlert("삭제 되었습니다.");
        location.href = "/board";
      } else {
        gfnAlert("글 삭제에 실패했습니다. 관리자에게 문의 바랍니다.");
      }
    }

    /* 댓글 삭제 */
    function commentDeleteCallbackFnc(res) {
      if (res.result == true) {
        var commentElement = $("li[data-no=" + res.commentsNo + "]");
        commentElement.find(".commentHead1").empty();
        commentElement.find(".commentHead2").empty();
        commentElement.find(".comment pre").html("삭제된 댓글입니다.");
        gfnAlert("댓글이 삭제 되었습니다.");
      } else {
        gfnAlert("댓글 삭제에 실패했습니다. 관리자에게 문의 바랍니다.");
      }
    }

    /* 댓글 등록 */
    function commentCallbackFnc(res) {
      if (res.result == true) {
        $("#commentDiv").empty();
        var list = res.commentList;
									
        for (var i in list) {
          var data = list[i];
          var commentElement = $($("#commentElement").text());
          commentElement.attr("data-no", data.COMMENTS_NO);
          commentElement.attr("data-name", data.USER_NM);
          commentElement
            .find(".commentDiv")
            .css("padding-left", Number(data.COMMENT_LEVEL) + 2 + "rem");
			
		  commentElement.find(".commentName").text(data.USER_NM);
          commentElement.find(".comment pre").text(data.COMMENTS_CONTENT);
          commentElement.find(".commentDate").text(data.REG_DTM);
          

          if (data.userCheck == "N") {
            commentElement.find(".commentUpdate").remove();
            commentElement.find(".commentDelete").remove();
          }
		  
		  if(data.DEL_YN == "Y"){
	          commentElement.find(".commentHead1").empty();
	          commentElement.find(".commentHead2").empty();
	          commentElement.find(".comment pre").html("삭제된 댓글입니다.");
          }
		  
          $("#commentDiv").append(commentElement);
        }

        if ($("#commentForm:visible").length == 0) {
          $(".commentCancle:visible")
            .parents("[data-no]")
            .after(commentElement);

          for (var i = 0; i < $(".commentCancle:visible").length; i++) {
            commentCancle($(".commentCancle:visible")[i]);
          }
          $("#commentForm").show();
        } else {
          $("#commentDiv").scrollTop($("#commentDiv")[0].scrollHeight);
          $("textarea[name=commentsContent]").val("");
        }
      } else {
        gfnAlert("댓글 작성에 실패했습니다. 관리자에게 문의 바랍니다.");
      }
    }
  </script>
  <style>
       .commentHead{
          display: flex;
          justify-content: space-between;
          min-height: 24px;
       }
       
       .commentHead1{
          display: flex;
          align-items: center;
       }
       
       .commentHead2{
          display: flex;
             opacity: 0.8;
       }
       .commentDiv{
             padding-left: 1rem;
          padding-right: 1rem;
       }
       .commentContent{
          font-size: 1.1rem;
          font-weight: 500;
          position: relative;
       }
       
       .commentDate{
          padding-left: 0.3rem;
          font-size: 0.8rem;
          opacity: 0.8;
       }
       .commentHead2 > div{
          padding-left: 0.15rem;
          padding-right: 0.15rem;
          cursor: pointer;
       }
       
       ul{
           list-style-type: none;
           padding: 0; 
           margin: 0;
       }
         .flex {
           display:flex;
       }
  </style>
</html>
