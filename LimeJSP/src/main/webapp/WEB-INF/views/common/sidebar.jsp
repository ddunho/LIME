<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>

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
    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages">
      <i class="fas fa-fw fa-folder"></i>
      <span>Pages</span>
    </a>

    <div id="collapsePages" class="collapse">
      <div class="bg-white py-2 collapse-inner rounded">
        <h6 class="collapse-h
		
		eader">Login Screens:</h6>

        <c:choose>
          <c:when test="${not empty LOGIN_USER}">
            <a class="collapse-item" href="#" data-toggle="modal" data-target="#logoutModal">
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

  <li class="nav-item active">
    <a class="nav-link" href="/">
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
