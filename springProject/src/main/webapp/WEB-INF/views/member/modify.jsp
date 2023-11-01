<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Modify</title>
<style type="text/css">
	table{
		margin: 20px;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<c:set value="${mvo }" var="mvo"></c:set>
<form action="/member/modify" method="post">
	<table class="table">
		<input type="hidden" name="email" value="${mvo.email }">
		<tr>
			<th>E-MAIL</th>
			<td>${mvo.email }</td>
		</tr>
		<tr>
			<th>NICKNAME</th>
			<td><input type="text" name="nickName" value="${mvo.nickName }"></td>
		</tr>
		<tr>
			<th>PASSWORD</th>
			<td><input type="text" name="pwd" placeholder="새로운 비밀번호"></td>
		</tr>
		<tr>
			<th>REG_AT</th>
			<td>${mvo.regAt }</td>
		</tr>
		<tr>
			<th>LAST_LOGIN</th>
			<td>${mvo.lastLogin }</td>
		</tr>
	</table>
	<button type="submit" class="btn btn-secondary">수정</button>
</form>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>