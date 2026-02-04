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
                  id="writeForm"
                  name="boardDetail"
                >
                  <div class="card shadow mb-4 h-100">
                    <div class="card-header py-3">
                      <div class="col-sm-11 float-left">
                        <input
                          type="text"
                          id="postsTitle"
                          name="postsTitle"
                          class="form-control"
                          placeholder="제목"
                          title="제목"
                          value=""
                          maxlength="1333"
                        />
                      </div>
                      <button
                        type="button"
                        class="btn btn-primary btn float-right ml-1"
                        id="write"
                      >
                        작성완료
                      </button>
                    </div>
                    <div class="card-body h-100">
                      <textarea
                        id="postsContent"
                        name="postsContent"
                        cols="30"
                        class="form-control h-100"
                        placeholder="내용"
                        title="내용"
                        style="resize: none"
                        maxlength="1333"
                      ></textarea>
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
      $("#write").click(function () {
        if (!gfnAlert("작성을 하시겠습니까?", "confrim")) {
          return false;
        }
        ajaxCall("/insertBoard", "POST", "writeForm", writeCallbackFnc);
      });
    });
    function writeCallbackFnc(res) {
      if (res.result == true) {
        gfnAlert("게시글이 등록 되었습니다.");
        location.href = "/board";
      } else {
        gfnAlert("게시글 등록에 실패했습니다. 관리자에게 문의바랍니다.");
      }
    }
  </script>
</html>
