<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Register</title>
<style type="text/css">
	form{
		margin: 20px; 
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<sec:authentication property="principal.mvo.nickName" var="authNick"/>

<form action="/board/register" method="post" enctype="multipart/form-data">
	<div class="mb-3">
	  <label for="t" class="form-label">title</label>
	  <input type="text" class="form-control" name="title" id="t">
	</div>
	<div class="mb-3">
	  <label for="w" class="form-label">writer</label>
	  <input type="text" class="form-control" name="writer" id="w" value="${authNick }" readonly="readonly">
	</div>
	<div class="mb-3">
	  <label for="c" class="form-label">content</label>
	  <textarea class="form-control" name="content" id="c" rows="3"></textarea>
	</div>
	
	<!-- 파일 -->
	<div class="mb-3">
	  <!-- 파일 버튼은 css안 먹어서 이렇게 만듦 -->
	  <input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
	  <!-- input button trigger 용도의 button -->
	  <button type="button" id="trigger" class="btn btn-success">FileUpload</button>
	</div>
	<!-- 첨부파일 표시될 영역 -->
	<div class="mb-3" id="fileZone">
		
	</div>
	
	<button type="submit" class="btn btn-secondary" id="regBtn">등록</button>
</form>

<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
<jsp:include page="../common/footer.jsp"/>

</body>
</html>