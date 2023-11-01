<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Detail</title>
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
	<table class="table">
		<tr>
			<th>E-MAIL</th>
			<td>${mvo.email }</td>
		</tr>
		<tr>
			<th>NICKNAME</th>
			<td>${mvo.nickName }</td>
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
	<a href="/member/modify?email=${mvo.email }"><button class="btn btn-secondary">정보수정</button></a>
	<a href="/member/remove?email=${mvo.email }"><button class="btn btn-secondary">회원탈퇴</button></a>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>