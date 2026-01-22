<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

    <title>게시글 수정</title>

    <jsp:include page="/WEB-INF/views/common/assets.jsp"/>
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
            <a class="nav-link" href="/tables">
                <i class="fas fa-fw fa-table"></i>
                <span>Tables</span>
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

        <!-- Main Content -->
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

                <h1 class="h3 mb-2 text-gray-800">게시글 수정</h1>

                <div class="card shadow mb-4 h-75">
                    <div class="card-body">

                        <form action="/board/modify"
                              method="post"
                              class="h-100">

                            <div class="card shadow mb-4 h-100">

                                <div class="card-header py-3">
                                    <div class="col-sm-11 float-left">
                                        <input type="text"
                                               name="title"
                                               class="form-control"
                                               value="test 제목"
                                               placeholder="제목"/>
                                    </div>

                                    <button type="submit"
                                            class="btn btn-primary
                                                   float-right ml-1">
                                        수정완료
                                    </button>
                                </div>

                                <div class="card-body h-100">
                                    <textarea name="content"
                                              class="form-control h-100"
                                              style="resize:none;"
                                              placeholder="내용">test 내용</textarea>
                                </div>

                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </div>

        <!-- Footer -->
        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>풋터</span>
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
