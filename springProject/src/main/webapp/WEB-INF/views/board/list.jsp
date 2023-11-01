<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
<style type="text/css">
	table, .col-sm-12{
		margin: 20px;
	}
	.paging{
		display: flex;
		justify-content: center;
		margin-top: 20px;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<!-- 검색 라인 -->
<div class="col-sm-12 col-md-6">
	<form action="/board/list" method="get">
	    <div class="input-group mb-3">
	    	<c:set value="${ph.pgvo.type }" var="typed" />
			<select class="form-select" name="type" id="inputGroupSelect01">
				<option ${typed eq null ? 'selected' : '' }>Choose</option>
				<option value="t" ${typed eq 't' ? 'selected' : '' }>Title</option>
				<option value="w" ${typed eq 'w' ? 'selected' : '' }>Writer</option>
				<option value="c" ${typed eq 'c' ? 'selected' : '' }>Content</option>
				<option value="tw" ${typed eq 'tw' ? 'selected' : '' }>Title+Writer</option>
				<option value="tc" ${typed eq 'tc' ? 'selected' : '' }>Title+Content</option>
				<option value="wc" ${typed eq 'wc' ? 'selected' : '' }>Writer+Content</option>
				<option value="twc" ${typed eq 'twc' ? 'selected' : '' }>Title+Writer+Content</option>
			</select>
			
			<!-- 검색 후 페이징을 하기 위해서 보내는 값 -->
			<input type="hidden" name="pageNo" value="1">
												<!-- 검색 후 현재 페이지넘버가 아니라 무조건 1페이지로 가도록 -->
			<input type="hidden" name="qty" value="${ph.pgvo.qty }">
    		
		   <input type="text" class="form-control" name="keyword" value="${ph.pgvo.keyword }" placeholder="Search" aria-label="Recipient's username" aria-describedby="button-addon2">
		   <button class="btn btn-secondary" type="submit" id="button-addon2">Search
		   		<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
	    			${ph.totalCount }
	    		</span>
		   </button>
	    </div>
	</form>
</div>

<table class="table">
	<thead>
		<tr>
			<th>#</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>댓글수</th>
			<th>파일수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="bvo">
			<tr>
				<td>${bvo.bno }</td>
				<td> <a href="/board/detail?bno=${bvo.bno }">${bvo.title }</a> </td>
				<td>${bvo.writer }</td>
				<td>${bvo.regAt }</td>
				<td>${bvo.readCount }</td>
				<td>${bvo.cmtQty }</td>
				<td>${bvo.hasFile }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- 페이징 라인 -->
<div class="paging">
<nav aria-label="Page navigation example">
  <ul class="pagination">
  
  	<!-- 이전 -->
    <li class="page-item ${(ph.prev eq false) ? 'disabled' : ''}">
      <a class="page-link" href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    
    <c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
	    <li class="page-item"><a class="page-link" href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i}</a></li>
    </c:forEach>
    
    <!-- 다음 -->
    <li class="page-item ${(ph.next eq false) ? 'disabled' : ''}">
      <a class="page-link" href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
    
  </ul>
</nav>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>