<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> --%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<jsp:include page="common/header.jsp"/>
<jsp:include page="common/nav.jsp"/>

<h3>I wanna go home </h3>




<script type="text/javascript">
const isDel = `<c:out value="${isDel }" />`;
console.log(isDel);
if(isDel == 1){
	alert('회원 탈퇴 완료');
}
</script>


<jsp:include page="common/footer.jsp"/>
</body>
</html>
