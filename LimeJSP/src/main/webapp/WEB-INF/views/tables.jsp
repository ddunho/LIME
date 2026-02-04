<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

  <title>Tables</title>

  <jsp:include page="/WEB-INF/views/common/assets.jsp"/>

  <link rel="stylesheet" href="/vendor/datatables/dataTables.bootstrap4.min.css">
</head>

<body id="page-top">
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
      <div class="container-fluid">
        <h1 class="h3 mb-2 text-gray-800">게시판</h1>

        <div class="card shadow mb-4">
          <div class="card-body">
            <div class="table-responsive">

          
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <colgroup>
                  <col width="20%" />
                  <col width="40%" />
                  <col width="30%" />
                  <col width="20%" />
                </colgroup>
                <thead>
                <tr>
                  <th>닉네임</th>
                  <th>제목</th>
                  <th>날짜</th>
                  <th>댓글</th>
                </tr>
                </thead>
				<tbody>
				  <c:forEach var="post" items="${posts}">
					<c:choose>
					  <c:when test="${post.DELETEYN eq 'N'}">
					    <tr style="cursor:pointer;"
					        onclick="location.href='/detail?postUid=${post.POSTUID}'">
					      <td>${post.USERNAME}</td>
					      <td>${post.TITLE}</td>
					      <td>${post.WRITEDATE}</td>
					      <td>
					        <c:choose>
					          <c:when test="${post.COMMENT_COUNT > 0}">
					            <span class="badge badge-primary">${post.COMMENT_COUNT}개</span>
					          </c:when>
					          <c:otherwise>
					            <span class="text-muted">0개</span>
					          </c:otherwise>
					        </c:choose>
					      </td>
					    </tr>
					  </c:when>
					  <c:otherwise>
					    <tr style="cursor:not-allowed;">
					      <td>${post.USERNAME}</td>
					      <td>
					        <span class="text-muted font-italic">
					          삭제된 게시글입니다.
					        </span>
					      </td>
					      <td>${post.WRITEDATE}</td>
					      <td>
					        <span class="text-muted">-</span>
					      </td>
					    </tr>
					  </c:otherwise>
					</c:choose>
				  </c:forEach>
				</tbody>

              </table>
			  
			  
			  <nav aria-label="Page navigation">
			    <ul class="pagination justify-content-center">

			      <!-- 이전 -->
			      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
			        <a class="page-link" href="/?page=${currentPage - 1}">Previous</a>
			      </li>

			      <!-- 페이지 번호 -->
			      <c:forEach var="i" begin="1" end="${totalPages}">
			        <li class="page-item ${i == currentPage ? 'active' : ''}">
			          <a class="page-link" href="/?page=${i}">${i}</a>
			        </li>
			      </c:forEach>

			      <!-- 다음 -->
			      <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
			        <a class="page-link" href="/?page=${currentPage + 1}">Next</a>
			      </li>

			    </ul>
			  </nav>


			  <c:choose>
			    <c:when test="${not empty LOGIN_USER}">
			      <a href="/write" class="btn btn-primary float-right">
			        게시글 작성
			      </a>
			    </c:when>
				<c:otherwise>
				    <a href="#" class="btn btn-primary float-right"
				       onclick="if(confirm('로그인 하시겠습니까?')) { location.href='/login'; } return false;">
				      게시글 작성
				    </a>
				  </c:otherwise>
			  </c:choose>


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

<script src="/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<script>
  $(function () {

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

  });
</script>

<script>
$(document).ready(function () {
  $('#dataTable').DataTable({
    paging: false,
    searching: false,
    ordering: false,
    info: false
  });
});
</script>




</body>
</html>
