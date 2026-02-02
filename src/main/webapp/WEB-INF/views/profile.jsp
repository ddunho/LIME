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
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <div id="content">

            <!-- Topbar -->
			<jsp:include page="/WEB-INF/views/common/topbar.jsp" />

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
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />

    </div>
</div>

<!-- Scroll to Top -->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

</body>
</html>
