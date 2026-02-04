<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>Tables</title>

  <jsp:include page="/WEB-INF/views/common/assets.jsp"/>
</head>

<body id="page-top">
  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
		<jsp:include page="/WEB-INF/views/common/topbar.jsp" />
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid h-100">
          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">게시판</h1>

          <!-- DataTales Example -->
          <div class="card shadow mb-4 h-75">
            <div class="card-body">

              <!-- Basic Card Example -->
			  <form id="writeForm" enctype="multipart/form-data">

			    <div class="card shadow mb-4">

			      <!--  제목 + 작성완료 -->
			      <div class="card-header py-3">
			        <div class="row">
			          <div class="col-md-10">
			            <input
			              type="text"
			              name="title"
			              class="form-control"
			              placeholder="제목"
			              required
						  maxlength="4000"
			            />
			          </div>
			          <div class="col-md-2 text-right">
						<button type="button" id="writeBtn" class="btn btn-primary">
						    작성완료
						  </button>
			          </div>
			        </div>
			      </div>

			      <!-- ② 내용 -->
			      <div class="card-body">
			        <textarea
			          name="content"
			          class="form-control mb-3"
			          rows="12"
			          placeholder="내용"
			          required
			          style="resize: none;"
					  maxlength="4000"
			        ></textarea>

			        <!-- ③ 파일 업로드 -->
					<div class="form-group mt-2">
					    <label class="font-weight-bold mb-1">파일 업로드</label>
					    <input
					      type="file"
						  id="fileInput"
					      name="uploadFile"
					      class="form-control-file"
						  multiple
					    />
						<small class="form-text text-muted">
						    <i class="fas fa-info-circle"></i> 파일은 최대 5개까지 첨부 가능합니다.
						  </small>
						<ul id="fileList" class="list-group mt-2"></ul>
					  </div>
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
          <a class="btn btn-primary" href="/login" id="confirmLogoutBtn">Logout</a>
        </div>
      </div>
    </div>
  </div>

 

  <script>
  $(function () {
      const MAX_FILE_COUNT = 5;

      // 파일 선택 시 개수 체크 및 미리보기
      $('#fileInput').on('change', function () {
          const files = this.files;
          const $fileList = $('#fileList');
			
		  console.log(MAX_FILE_COUNT);
          // 파일 개수 체크
          if (files.length > MAX_FILE_COUNT) {
			alert("파일은 최대 " + MAX_FILE_COUNT + "개까지만 선택할 수 있습니다.");
              this.value = '';
              $fileList.empty();
              return;
          }

          $fileList.empty();

          if (files.length > 0) {
              $.each(files, function (index, file) {
                  const li = $('<li class="list-group-item"></li>').text(file.name);
                  $fileList.append(li);
              });
          }
      });

      // 로그아웃
      $("#confirmLogoutBtn").on("click", function (e) {
          e.preventDefault();

		  requestAjax({
		      url: "/user/logout",

		      success: function () {
		          alert("로그아웃 성공");
		          location.href = "/";
		      }
		  });

      });

      // 게시글 작성
      $("#writeBtn").on("click", function () {
			
          // 제목과 내용 검증
          const title = $("input[name='title']").val().trim();
          const content = $("textarea[name='content']").val().trim();
          
          if (!title) {
              alert("제목을 입력해주세요.");
              $("input[name='title']").focus();
              return;
          }
          
          if (!content) {
              alert("내용을 입력해주세요.");
              $("textarea[name='content']").focus();
              return;
          }

          // 파일 개수 재검증
          const files = $('#fileInput')[0].files;
          if (files.length > MAX_FILE_COUNT) {
              alert(`파일은 최대 ${MAX_FILE_COUNT}개까지만 첨부할 수 있습니다.`);
              return;
          }

          // 작성 여부 확인
          if (!confirm("게시글을 작성하시겠습니까?")) {
              return;
          }

          // FormData 생성
          const form = document.getElementById("writeForm");
          const formData = new FormData(form);

		  requestAjax({
		    url: "/write",
		    method: "POST",
		    data: formData,
		    processData: false,
		    contentType: false,

		    success: function (response) {
		        if (response.success) {
		            alert(response.message);
		            location.href = "/";
		        } else {
		            alert(response.message);
		            if (response.redirectUrl) {
		                location.href = response.redirectUrl;
		            }
		        }
		    },

		    error: function () {
		        alert("서버 오류가 발생했습니다.");
		    }
		  });

      });

  });
  </script>



</body>
</html>
