<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Detail</title>
<style type="text/css">
	table, .buttons, .cvoContent{
		margin: 20px;
	}
	.commentLine{
		width: 600px;
		margin: 20px;
	}
	#cmtTextMod{
		margin: 10px 0;
	}
	.modBtn, .delBtn{
		margin: 5px;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>
<c:set value="${bdto.bvo }" var="bvo"></c:set>

<table class="table">
	<tr>
		<th>BNO</th>
		<td>${bvo.bno }</td>
	</tr>
	<tr>
		<th>TITLE</th>
		<td>${bvo.title }</td>
	</tr>
	<tr>
		<th>WRITER</th>
		<td>${bvo.writer }</td>
	</tr>
	<tr>
		<th>CONTENT</th>
		<td>${bvo.content }</td>
	</tr>
	
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
							</div>
						</c:when>
					</c:choose>
					<div>
						<div class="fw-bold">${fvo.fileName }</div>
					</div>
					<span class="badge rounded-pill text-bg-success">${fvo.fileSize }Byte</span>
				</td>
		</tr>
			</c:forEach>		
	</c:if>
	
	<tr>
		<th>REG_DATE</th>
		<td>${bvo.regAt }</td>
	</tr>
	<c:if test="${bvo.regAt ne bvo.modAt }">
		<tr>
			<th>MOD_DATE</th>
			<td>${bvo.modAt }</td>
		</tr>
	</c:if>
	<tr>
		<th>READ</th>
		<td>${bvo.readCount }</td>
	</tr>
</table>

<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.mvo.nickName" var="authNick" />	
<c:if test="${authNick eq bvo.writer }">
	<div class="buttons">
		<a href="/board/modify?bno=${bvo.bno }">
			<button type="button" class="btn btn-secondary">수정</button>
		</a>
		<a href="/board/remove?bno=${bvo.bno }">
			<button type="button" class="btn btn-secondary">삭제</button>
		</a>
	</div>
</c:if>
</sec:authorize>

<!-- 댓글 라인 -->
<div class="commentLine">

<!-- 권한이 있는 사람만 작성 가능 -->
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.mvo.nickName" var="authNick" />	
	<!-- 댓글 작성 라인 -->
	<div class="input-group mb-3">
	  <span class="input-group-text" id="cmtWriter">${authNick }</span>
	  <input type="text" class="form-control" id="cmtText" placeholder="Add Comment">
	  <button type="button" class="btn btn-outline-secondary" id="cmtPostBtn">등록</button>
	</div>
	<!-- 모달창 라인 -->
	<div class="modal" id="myModal" tabindex="-1">
		<div class="modal-dialog">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title">${authNick }</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      
		      <div class="modal-body">
		        <div class="input-group mb-3">
		      	  <input type="text" class="form-control" id="cmtTextMod" placeholder="Modify Comment">
		        </div>
		      </div>
		      
		      <div class="modal-footer">
		      	<button type="button"  class="btn btn-secondary" id="cmtModBtn">수정</button>
		      </div>
		      
		    </div>
		</div>
	</div>
</sec:authorize>

	<!-- 댓글 표시 라인 -->
	<ul class="list-group" id="cmtListArea">
	  <li class="list-group-item">
	  	<div>
	  		<div class="fw-bold">Writer <span class="badge rounded-pill text-bg-secondary">regAt</span></div>
	  		Content
	  	</div>
	  </li>
	</ul>
	
	<!-- 댓글 페이징 라인 -->
	<div>
		<div>
			<button type="button" id="moreBtn" data-page="1" class="btn btn-outline-secondary" style="visibility:hidden">MORE+</button>
		</div>
	</div>
	
</div>


<script type="text/javascript">
let isOk = '<c:out value="${isOk}"/>';
if(parseInt(isOk)) {
	alert('수정 성공');
}

//bno 보내주기
let bnoVal = `<c:out value="${bvo.bno}"/>`;
console.log(bnoVal);

//수정 삭제버튼용
let id = `<c:out value="${authNick}"/>`;
console.log(id);
</script>

<script type="text/javascript" src="/resources/js/boardComment.js"></script>

<script type="text/javascript">
getCommentList(bnoVal);
</script>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>