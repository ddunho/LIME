<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>SB Admin 2 - 404</title>

    <jsp:include page="/WEB-INF/views/common/assets.jsp"/>
</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
        id="accordionSidebar">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center"
           href="/">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">게시판</div>
        </a>

        <hr class="sidebar-divider my-0" />

        <!-- Pages -->
        <li class="nav-item">
            <a class="nav-link collapsed"
               href="#"
               data-toggle="collapse"
               data-target="#collapsePages">
                <i class="fas fa-fw fa-folder"></i>
                <span>Pages</span>
            </a>

            <div id="collapsePages" class="collapse">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Login Screens:</h6>
                    <a class="collapse-item" href="/login">Login</a>
                    <a class="collapse-item" href="/membership">Membership</a>
                </div>
            </div>
        </li>

        <!-- Tables -->
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
    <!-- End Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                <button id="sidebarToggleTop"
                        class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>

                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle"
                           href="#"
                           id="userDropdown"
                           data-toggle="dropdown">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                                닉네임
                            </span>
                            <img class="img-profile rounded-circle"
                                 src="/img/undraw_profile.svg" />
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- End Topbar -->

            <!-- Page Content -->
            <div class="container-fluid">

                <div class="text-center">
                    <div class="error mx-auto" data-text="ERROR">ERROR</div>
                    <p class="lead text-gray-800 mb-5">Page Not Found</p>
                    <p class="text-gray-500 mb-0">
                        It looks like you found a glitch in the matrix...
                    </p>
                    <a href="/">&larr; Back to Dashboard</a>
                </div>

            </div>
        </div>

        <!-- Footer -->
        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>Copyright &copy; Your Website</span>
                </div>
            </div>
        </footer>

    </div>
</div>

<!-- Scroll to Top -->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal 그대로 유지 가능 -->
</body>
</html>
