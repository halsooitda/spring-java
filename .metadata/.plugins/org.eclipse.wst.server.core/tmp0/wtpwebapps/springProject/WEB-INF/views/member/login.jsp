<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log In</title>
<style type="text/css">
	form, .lBtn{
		margin: 20px; 
	}
	.form-control{
		width: 400px;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<!-- security를 탈려면 method는 반드시 post로 해야 함. -->
<form action="/member/login" method="post">
	<div class="form-floating mb-3">
	  <input type="email" class="form-control" name="email" id="floatingInput" placeholder="name@example.com">
	  <label for="floatingInput">Email address</label>
	</div>
	<div class="form-floating">
	  <input type="password" class="form-control" name="pwd" id="floatingPassword" placeholder="Password">
	  <label for="floatingPassword">Password</label>
	</div>

	<c:if test="${not empty param.errMsg }">
		<div class="text-danger mb-3">
			<c:choose>
				<c:when test="${param.errMsg eq 'Bad credentials' }">
					<c:set var="errText" value="이메일 or 비밀번호가 일치하지 않습니다." />
				</c:when>
				<c:otherwise>
					<c:set var="errText" value="존재하지 않는 이메일입니다." />
				</c:otherwise>
			</c:choose>
			<br>
			${errText }
		</div>
	</c:if>
	
	<button type="submit" class="btn btn-secondary lBtn">LogIn</button>
</form>

<script type="text/javascript">
const isOk = `<c:out value="${isOk }" />`;
console.log(isOk);
if(isOk == 1){
	alert('회원 정보 수정 완료');
}
</script>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>