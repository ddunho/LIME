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
          <div class="container-fluid">
            <!-- Page Heading -->
            <h1 class="h3 mb-2 text-gray-800">게시판</h1>
            <!-- DataTales Example -->
            <div class="card shadow mb-4">
              <div class="card-body">
                <div class="table-responsive">
                  <table
                    class="table table-bordered"
                    id=""
                    width="100%"
                    cellspacing="0"
                  >
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
                      <c:forEach var="list" items="${resultList}">
                        <tr>
                          <td>${list.USER_NM}</td>
                          <td>
                            <a data-postsNo="${list.POSTS_NO}"
                              >${list.POSTS_TITLE}</a
                            >
                          </td>
                          <td>${list.REG_DTM}</td>
                          <td>${list.REPLY_CNT}개</td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                  <c:if test="${not empty user}">
                    <a href="#" id="write"
                      ><button
                        type="button"
                        class="btn btn-primary btn float-right"
                      >
                        게시글 작성
                      </button></a
                    >
                  </c:if>
                  <nav aria-label="Page navigation example">
                    <ul
                      class="pagination"
                      style="justify-content: center"
                      id="pagingBar"
                    >
                      <c:if test="${page.pageCnt > 1}">
                        <li class="page-item">
                          <a class="page-link" href="?pageCnt=${page.prevPage}"
                            >Previous</a
                          >
                        </li>
                      </c:if>
                      <c:forEach
                        var="i"
                        begin="${page.startPage}"
                        end="${page.endPage}"
                        step="1"
                      >
                        <c:choose>
                          <c:when test="${i eq page.pageCnt}">
                            <li class="page-item">
                              <p class="page-link"><strong>${i}</strong></p>
                            </li>
                          </c:when>
                          <c:otherwise>
                            <li class="page-item">
                              <a class="page-link" href="?pageCnt=${i}">${i}</a>
                            </li>
                          </c:otherwise>
                        </c:choose>
                      </c:forEach>
                      <c:if test="${page.pageCnt < page.totalPages}">
                        <li class="page-item">
                          <a class="page-link" href="?pageCnt=${page.nextPage}"
                            >Next</a
                          >
                        </li>
                      </c:if>
                    </ul>
                  </nav>
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
  <script>
    $(function () {
      $("a[data-postsNo]").click(function () {
        var postsNo = $(this).attr("data-postsNo");
        location.href = "/boardDetail?postsNo=" + postsNo;
      });
      $("#write").click(function () {
        location.href = "/boardWrite";
      });
    });
  </script>
</html>
