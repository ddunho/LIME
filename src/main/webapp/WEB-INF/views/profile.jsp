<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

    <title>프로필</title>
    
    <jsp:include page="/WEB-INF/views/common/assets.jsp"/>

    <style>
        .mn-h-24 {
            min-height: 24px !important;
        }
    </style>
</head>

<body id="page-top">

<div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
        id="accordionSidebar">

        <a class="sidebar-brand d-flex align-items-center justify-content-center"
           href="/">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">게시판</div>
        </a>

        <hr class="sidebar-divider my-0"/>

        <li class="nav-item active">
            <a class="nav-link" href="/profile">
                <i class="fas fa-fw fa-user"></i>
                <span>Profile</span>
            </a>
        </li>

        <hr class="sidebar-divider d-none d-md-block"/>

        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0"
                    id="sidebarToggle"></button>
        </div>
    </ul>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white
                        topbar mb-4 static-top shadow">
                <button id="sidebarToggleTop"
                        class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>

                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#">
                            <span class="mr-2 d-none d-lg-inline
                                         text-gray-600 small">
                                닉네임
                            </span>
                            <img class="img-profile rounded-circle"
                                 src="/img/undraw_profile.svg"/>
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Page Content -->
            <div class="container-fluid h-100">

                <h1 class="h3 mb-2 text-gray-800">내 정보</h1>

                <div class="card shadow mb-4 h-75">
                    <div class="card-body">

                        <div class="card shadow mb-4 h-100">

                            <div class="ml-4">
                                <p class="mt-3">닉네임</p>
                            </div>
                            <hr class="sidebar-divider my-0"/>

                            <div class="ml-4">
                                <p class="mt-3">이메일주소</p>
                            </div>
                            <hr class="sidebar-divider my-0"/>

                            <div class="ml-4">
                                <p class="mt-3">휴대폰번호</p>
                            </div>
                            <hr class="sidebar-divider my-0"/>

                            <div class="ml-4">
                                <p class="mt-3">주소</p>
                            </div>
                            <hr class="sidebar-divider my-0"/>

                            <div class="ml-4">
                                <p class="mt-3">상세주소</p>
                            </div>
                            <hr class="sidebar-divider my-0"/>

                            <div class="form-group row">
                                <div class="ml-4 col-sm-5">
                                    <p class="mt-3">우편번호</p>
                                </div>
                                <div class="ml-4 col-sm-5">
                                    <p class="mt-3">참고사항</p>
                                </div>
                            </div>

                            <hr class="sidebar-divider my-0"/>

                            <a href="/profile/modify"
                               class="btn btn-primary btn-user btn-block">
                                정보 수정
                            </a>

                        </div>

                    </div>
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

</body>
</html>
