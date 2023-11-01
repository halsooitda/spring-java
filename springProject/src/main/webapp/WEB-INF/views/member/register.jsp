<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Register</title>
<style type="text/css">
	form{
		margin: 20px; 
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<!-- email, pwd, nick_name  -->
<form action="/member/register" method="post">
	<h4 class="mb-3">Input your Information</h4>
	<div class="mb-3">
	  <label for="e" class="form-label">email</label>
	  <input type="email" class="form-control" name="email" id="e">
	</div>
	<div class="mb-3">
	  <label for="w" class="form-label">password</label>
	  <input type="password" class="form-control" name="pwd" id="w">
	</div>
	<div class="mb-3">
	  <label for="n" class="form-label">nickname</label>
	  <input type="text" class="form-control" name="nickName" id="n">
	</div>
	<button type="submit" class="btn btn-secondary">가입</button>
</form>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
<!-- 아이디 중복확인, 비밀번호 정규표현식, 비밀번호 두번확인 -->