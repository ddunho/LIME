<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>

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

		    <c:choose>
		      <c:when test="${not empty LOGIN_USER}">
		        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
		           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          <span class="mr-2 d-none d-lg-inline text-gray-600 small">
		            ${LOGIN_USER.username}
		          </span>
		          <img class="img-profile rounded-circle" src="/img/undraw_profile.svg" />
		        </a>
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

		    <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
		         aria-labelledby="userDropdown">
		      <a class="dropdown-item" href="#">
		        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
		        Profile
		      </a>
		      <div class="dropdown-divider"></div>

		      <c:choose>
		        <c:when test="${not empty LOGIN_USER}">
		          <a class="dropdown-item" href="#"
		             data-toggle="modal" data-target="#logoutModal">
		            <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
		            Logout
		          </a>
		        </c:when>
		        <c:otherwise>
		          <a class="dropdown-item" href="/login">
		            <i class="fas fa-sign-in-alt fa-sm fa-fw mr-2 text-gray-400"></i>
		            Login
		          </a>
		        </c:otherwise>
		      </c:choose>
		    </div>

		  </li>
        </ul>
      </nav>
      <!-- End of Topbar -->