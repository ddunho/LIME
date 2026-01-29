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
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">게시판</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0" />

      <!-- Nav Item - Pages Collapse Menu -->
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

      <!-- Nav Item - Tables -->
      <li class="nav-item active">
        <a class="nav-link" href="/tables">
          <i class="fas fa-fw fa-table"></i>
          <span>Tables</span>
        </a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block" />

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>
    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <form class="form-inline">
            <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3" type="button">
              <i class="fa fa-bars"></i>
            </button>
          </form>

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">
            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
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
          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">게시판</h1>

          <!-- DataTales Example -->
          <div class="card shadow mb-4 h-75">
            <div class="card-body">

              <!-- Basic Card Example -->
			  <form id="modifyForm" enctype="multipart/form-data">

			    <!-- postUid -->
			    <input type="hidden" name="postUid" value="${post.POSTUID}" />

			    <div class="card shadow mb-4">

			      <!-- 제목 -->
			      <div class="card-header py-3">
			        <div class="row">
			          <div class="col-md-10">
			            <input
			              type="text"
			              name="title"
			              class="form-control"
			              value="${post.TITLE}"
			              required
			              maxlength="4000"
			            />
			          </div>
			          <div class="col-md-2 text-right">
			            <button type="button" id="modifyBtn" class="btn btn-primary">
			              수정완료
			            </button>
			          </div>
			        </div>
			      </div>

			      <!-- 내용 -->
			      <div class="card-body">
			        <textarea
			          name="content"
			          class="form-control mb-3"
			          rows="12"
			          required
			          style="resize:none;"
			          maxlength="4000"
			        >${post.CONTENT}</textarea>

			        <!-- 기존 파일 -->
			        <div class="mb-2">
			          <label class="font-weight-bold">기존 첨부파일</label>
			          <ul class="list-group">
			            <c:forEach var="file" items="${fileList}">
			              <li class="list-group-item">
			                ${file.ORIGINALNAME}
			              </li>
			            </c:forEach>
			            <c:if test="${empty fileList}">
			              <li class="list-group-item text-muted">첨부파일 없음</li>
			            </c:if>
			          </ul>
			        </div>

			        <!-- 새 파일 선택 -->
			        <div class="form-group mt-3">
			          <label class="font-weight-bold">
			            파일 선택
			          </label>
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
          <a class="btn btn-primary" href="/login" id="confirmLogoutBtn">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <script>
	$(function () {
	    console.log('페이지 로드 완료');
	    
	    // 파일 개수 제한 상수
	    const MAX_FILE_COUNT = 5;
	    
	    // 파일 선택 시 미리보기 및 개수 체크
	    $('#fileInput').on('change', function () {
	        console.log('파일 선택 이벤트 발생');
	        
	        const files = this.files;
	        const $fileList = $('#fileList');
	        
	        console.log('선택된 파일 개수:', files.length);
	        
	        // 파일 개수 체크
	        if (files.length > MAX_FILE_COUNT) {
	            alert(`파일은 최대 ${MAX_FILE_COUNT}개까지만 선택할 수 있습니다.`);
	            this.value = ''; // 파일 선택 초기화
	            $fileList.empty();
	            return;
	        }

	        $fileList.empty();

	        if (files.length > 0) {
	            alert("기존 파일은 삭제되고 선택한 파일로 덮어씌워집니다.");
	            
	            $.each(files, function (index, file) {
	                console.log('파일명:', file.name);
	                const li = $('<li class="list-group-item"></li>').text(file.name);
	                $fileList.append(li);
	            });
	        }
	    });

      // 로그아웃
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

      // 수정 완료 버튼
      $("#modifyBtn").on("click", function () {
          
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

          if (!confirm("게시글을 수정하시겠습니까?")) {
              return;
          }

          const formData = new FormData($("#modifyForm")[0]);

          $.ajax({
              url: "/modify",
              type: "POST",
              data: formData,
              processData: false,
              contentType: false,
              success: function (response) {
                  if (typeof response === 'object') {
                      if (response.success) {
                          alert(response.message || "수정 완료");
                          location.href = "/";
                      } else {
                          alert(response.message || "수정 실패");
                          if (response.redirectUrl) {
                              location.href = response.redirectUrl;
                          }
                      }
                  } else {
                      alert("수정 완료");
                      location.href = "/";
                  }
              },
              error: function (xhr, status, error) {
                  console.error("Error:", error);
                  alert("서버 오류가 발생했습니다.");
              }
          });
      });
  });
  </script>

</body>
</html>