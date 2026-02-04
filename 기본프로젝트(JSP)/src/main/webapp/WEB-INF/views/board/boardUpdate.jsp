<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn"%>
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
      <div id="content-wrapper" class="d-flex flex-column">
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
                <form
                  action="#"
                  method="post"
                  class="h-100"
                  id="updateForm"
                  name="updateForm"
                >
                  <input
                    type="hidden"
                    name="postsNo"
                    value="${resultList.POSTS_NO}"
                  />
                  <div class="card shadow mb-4 h-100">
                    <div class="card-header py-3">
                      <div class="col-sm-11 float-left">
                        <input
                          type="text"
                          id="postsTitle"
                          name="postsTitle"
                          class="form-control"
                          placeholder="제목"
                          value="${resultList.POSTS_TITLE}"
                        />
                      </div>
                      <button
                        type="button"
                        class="btn btn-primary btn float-right ml-1"
                        id="update"
                      >
                        수정완료
                      </button>
                    </div>
                    <div class="card-body h-100">
                      <textarea
                        id="postsContent"
                        name="postsContent"
                        cols="30"
                        class="form-control h-100"
                        placeholder="내용
                        "
                        style="resize: none"
                      >
${resultList.POSTS_CONTENT}</textarea
                      >
                    </div>
                    <div class="card-body fileUpLoad">
                      <div>
                        <c:choose>
                          <c:when test="${fn:length(fileList) > 0}">
                            <div id="fileName" class="fileName">
                              <c:forEach var="file" items="${fileList}">
                                <a href="#" data-file-name="${file.FILE_NAME }"
                                  >${file.FILE_NAME }</a
                                >
                              </c:forEach>
                            </div>
                          </c:when>
                          <c:otherwise> 파일 없음. </c:otherwise>
                        </c:choose>
                      </div>
                    </div>
                    <div class="card-body fileUpLoad">
                      <label class="fileUpLoadBtn" for="upLoadFile"
                        >파일 업로드</label
                      >
                      <input
                        type="file"
                        class="fileUpLoadInput"
                        id="upLoadFile"
                        name="upLoadFile"
                        multiple="true"
                        aria-describedby="inputGroupFileAddon04"
                        aria-label="Upload"
                      />
                    </div>
                  </div>
                </form>
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
  <script>
    $(function () {
      $("#update").click(function () {
        ajaxCall("/updatePosts", "POST", "updateForm", updateCallbackFnc);
      });
      $("#upLoadFile").change(function () {
        for (var i; i < $(this)[0].files.length; i++) {
          $("#fileName").text($(this)[i].files[0].name);
        }
      });
    });

    /* 게시판 파일 다운로드 */
    $("#fileName a").click(function () {
      location.href = "/fileDownload?fileName=" + this.dataset.fileName;
    });

    function updateCallbackFnc(res) {
      if (res.result == true) {
        gfnAlert("변경사항이 저장 되었습니다.");
        location.href = "/boardDetail?postsNo=" + res.postsNo;
      } else {
        gfnAlert("수정중 오류가 발생했습니다. 관리자에게 문의 바랍니다.");
      }
    }
  </script>
</html>
