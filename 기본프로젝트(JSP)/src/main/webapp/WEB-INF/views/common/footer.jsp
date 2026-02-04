<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<style>
#loader {
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: fixed;
    display: block;
    opacity: 0.8;
    background: rgb(156, 154, 154);
    z-index: 99;
    text-align: center;
}

#loader>div {
    position: absolute;
    top: 50%;
    left: 50%;
    z-index: 100;
}
</style>
        <footer class="sticky-footer bg-white">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright &copy; Your Website 2020</span>
            </div>
          </div>
        </footer>
        <div id="loader" style="display:none;">
		    <div class="spinner-border text-info position-absolute top-50 start-50" role="status">
		        <span class="visually-hidden">Loading...</span>
		    </div>
		</div>
</html>