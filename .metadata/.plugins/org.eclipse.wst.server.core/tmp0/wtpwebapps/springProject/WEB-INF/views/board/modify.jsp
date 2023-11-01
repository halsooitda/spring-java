<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Modify</title>
<style type="text/css">
	form{
		margin: 20px; 
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>
<form action="/board/modify" method="post" enctype="multipart/form-data">
<c:set value="${bdto.bvo }" var="bvo"></c:set>
<table class="table">
	<tr>
		<th>BNO</th>
		<td> <input type="text" name="bno" value="${bvo.bno }" readonly="readonly"> </td>
	</tr>
	<tr>
		<th>TITLE</th>
		<td><input type="text" name="title" value="${bvo.title }"></td>
	</tr>
	<tr>
		<th>WRITER</th>
		<td>${bvo.writer }</td>
	</tr>
	<tr>
		<th>CONTENT</th>
		<td><textarea rows="5" cols="50" name="content">${bvo.content }</textarea></td>
	</tr>
	
	<!-- 파일은 변경 불가능. 파일을 지우고 다시 넣는 개념 -->
	<c:set value="${bdto.flist }" var="flist"></c:set>
	<c:if test="${flist.size() > 0 }">
		<c:forEach items="${flist }" var="fvo">
		<tr>
			<th>FILE</th>
				<td>
					<c:choose>
						<c:when test="${fvo.fileType > 0 }">
							<div>
								<!-- /upload/year/month/day/uuid_fileName -->
								<img alt="그림없음" src="/upload/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">
								<button type="button" class="btn btn-danger fileDel" data-uuid="${fvo.uuid }">X</button>
							</div>
						</c:when>
					</c:choose>
				</td>
		</tr>
		</c:forEach>		
	</c:if>
</table>

	<!-- 파일 다시 등록 라인 -->
	<div class="mb-3">
	  <!-- 파일 버튼은 css안 먹어서 이렇게 만듦 -->
	  <input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
	  <!-- input button trigger 용도의 button -->
	  <button type="button" id="trigger" class="btn btn-success">FileUpload</button>
	</div>
	<!-- 첨부파일 표시될 영역 -->
	<div class="mb-3" id="fileZone">
		
	</div>
	
	<button type="submit" class="btn btn-secondary" id="regBtn">수정</button>
</form>

<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
<script type="text/javascript" src="/resources/js/boardModify.js"></script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>