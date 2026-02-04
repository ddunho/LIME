<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <body>
    <!-- Sidebar -->
    <ul
      class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
      id="accordionSidebar"
    >
      <!-- Sidebar - Brand -->
      <a
        class="sidebar-brand d-flex align-items-center justify-content-center"
        href="/"
      >
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">게시판</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0" />

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          href="#"
          data-toggle="collapse"
          data-target="#collapsePages"
          aria-expanded="true"
          aria-controls="collapsePages"
        >
          <i class="fas fa-fw fa-folder"></i>
          <span>Pages</span>
        </a>
        <div
          id="collapsePages"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Login Screens:</h6>
            <c:choose>
              <c:when test="${empty user}">
                <a class="collapse-item" id="doLogin">Login</a>
              </c:when>
              <c:otherwise>
                <a
                  class="collapse-item"
                  id="doLogout"
                  data-toggle="modal"
                  data-target="#logoutModal"
                  >Logout</a
                >
              </c:otherwise>
            </c:choose>
            <a class="collapse-item" id="doMembership">membership</a>
          </div>
        </div>
      </li>

      <!-- Nav Item - Tables -->
      <li class="nav-item active">
        <a class="nav-link" id="doBoard">
          <i class="fas fa-fw fa-table"></i>
          <span>Tables</span></a
        >
        <a class="nav-link" id="doCompany">
          <i class="fas fa-fw fa-table"></i>
          <span>company</span></a
        >
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block" />

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>
    </ul>
    <!-- End of Sidebar -->
    <script type="text/javascript">
      $(function () {
        $("#doLogin").click(function () {
          location.href = "/login";
        });
        $("#doMembership").click(function () {
          location.href = "/membership";
        });
        $("#doBoard").click(function () {
          location.href = "/";
        });
      });
    </script>
  </body>
</html>
