<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
          <a class="collapse-item" href="/login">Login</a>
          <a class="collapse-item" href="/membership">membership</a>
        </div>
      </div>
    </li>

    <!-- 현재 페이지 active -->
    <li class="nav-item active">
      <a class="nav-link" href="/tables">
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
    <!-- Main Content -->
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
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <span class="mr-2 d-none d-lg-inline text-gray-600 small">닉네임</span>
              <img class="img-profile rounded-circle" src="/img/undraw_profile.svg" />
            </a>

            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
              <a class="dropdown-item" href="#">
                <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                Profile
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                Logout
              </a>
            </div>
          </li>
        </ul>
      </nav>
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
                <tr>
                  <td>홍길동</td>
                  <td><a href="/detail">System Architect</a></td>
                  <td>2011-04-25</td>
                  <td>0개</td>
                </tr>
                </tbody>
              </table>

              <a href="/write">
                <button type="button" class="btn btn-primary btn float-right">
                  게시글 작성
                </button>
              </a>

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
          <span>Copyright &copy; Your Website 2020</span>
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
        <a class="btn btn-primary" href="/login">Logout</a>
      </div>
    </div>
  </div>
</div>

<script src="/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="/js/demo/datatables-demo.js"></script>
<script>
$(document).ready(function () {

    $("#logoutBtn").on("click", function (e) {
        e.preventDefault();

        $.ajax({
            url: "/logout",
            type: "GET",
            success: function () {
                location.href = "/";
            }
        });
    });

});
</script>

</body>
</html>
