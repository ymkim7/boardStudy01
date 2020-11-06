<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>게시판</title>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='readForm']");
		
		//수정
		$(".updateBtn").on("click", function(){
			formObj.attr("action", "/board/updateView");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		//삭제
		$(".deleteBnt").on("click", function(){
			var deleteYN = confirm("삭제하시겠습니까?");
			
			if(deleteYN == true){
				formObj.attr("action", "/board/delete");
				formObj.attr("method", "post");
				formObj.submit();
			}
		});
		
		// 목록
		$(".listBnt").on("click", function(){

		location.href = "/board/list?page=${scri.page}"
						+"&perPageNum=${scri.perPageNum}"
						+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
		});
		
		$(".replyWriteBnt").on("click", function(){
			var formObj = $("form[name='replyForm']");
			
			formObj.attr("action", "/board/replyWrite");
			formObj.submit();
		});
		
		//댓글 수정 View
		$(".replyUpdateBtn").on("click", function(){
			location.href = "/board/replyUpdateView?bno=${read.bno}"
				+ "&page=${scri.page}"
				+ "&perPageNum=${scri.perPageNum}"
				+ "&searchType=${scri.searchType}"
				+ "&keyword=${scri.keyword}"
				+ "&rno="+$(this).attr("data-rno");
		});
		
		//댓글 삭제 View
		$(".replyDeleteBtn").on("click", function(){
			location.href = "/board/replyDeleteView?bno=${read.bno}"
				+ "&page=${scri.page}"
				+ "&perPageNum=${scri.perPageNum}"
				+ "&searchType=${scri.searchType}"
				+ "&keyword=${scri.keyword}"
				+ "&rno="+$(this).attr("data-rno");
		});
	});
	
	function fn_fileDown(fileNo){
		var formObj = $("form[name='readForm']");
		$("#FILE_NO").attr("value", fileNo);
		formObj.attr("action", "/board/fileDown");
		formObj.submit();
	}
	
</script>
<body>
	<div class="container">
		<header>
			<h1>게시판</h1>
		</header>
	</div>
	<hr/>
	
	<div>
		<%@include file="nav.jsp" %>
	</div>
	<hr/>
	
	<section id="container">
		<form id="readForm" name="readForm" method="post">
			<input type="hidden" id="bno" name="bno" value="${read.bno }"/>
			<input type="hidden" id="page" name="page" value="${scri.page }"/>
			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum }"/>
			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType }"/>
			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword }"/>
			<input type="hidden" id="FILE_NO" name="FILE_NO" value=""/>
		</form>
		
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">제목</label>
			<input type="text" id="title" name="title" class="form-control" value="${read.title }" readonly="readonly"/>
		</div>
		
		<div class="form-group">
			<label for="content" class="col-sm-2 control-label">내용</label>
			<textarea id="content" name="content" class="form-control" readonly="readonly"><c:out value="${read.content }"></c:out></textarea>
		</div>
		
		<div class="form-group">
			<label for="writer" class="col-sm-2 control-label">작성자</label>
			<input type="text" id="writer" name="writer" class="form-control" value="${read.writer }" readonly="readonly"/>
		</div>
		
		<div class="form-group">
			<label for="regdate" class="col-sm-2 control-label">작성일</label>
			<fmt:formatDate value="${read.regdate }" pattern="yyyy-MM-dd"/>
		</div>
		<hr>
		<span>파일 목록</span>
		<div class="fomr=group" style="border: 1px solid #dbdbdb;">
			<c:forEach var="file" items="${file}">
				<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE})<br>
			</c:forEach>
		</div>
		
		
		<div>
			<button type="button" class="updateBtn btn btn-warning" id="updateBtn" name="updateBtn">수정</button>
			<button type="button" class="deleteBnt btn btn-danger" id="deleteBnt" name="deleteBnt">삭제</button>
			<button type="button" class="listBnt btn btn-primary" id="listBnt" name="listBnt">목록</button>
		</div>
		
		<!-- 댓글 -->
		<div id="reply">
			<ol class="replyList">
				<c:forEach items="${replyList }" var="replyList">
					<li>
						<p>
							작성자 : ${replyList.writer }<br/>
							작성날짜 : <fmt:formatDate value="${replyList.regdate }" pattern="yyyy-MM-dd"/>
						</p>
						<p>${replyList.content}</p>
						<div>
							<button type="button" class="replyUpdateBtn btn btn-warning" id="replyUpdateBtn" name="replyUpdateBtn" data-rno="${replyList.rno }">수정</button>
							<button type="button" class="replyDeleteBtn btn danger" id="replyDeleteBtn" name="replyDeleteBtn" data-rno="${replyList.rno }">삭제</button>
						</div>
					</li>				
				</c:forEach>
			</ol>
		</div>
		
		<form name="replyForm" method="post" class="form-horizontal">
			<input type="hidden" id="bno" name="bno" value="${read.bno }"/>
			<input type="hidden" id="page" name="page" value="${scri.page }"/>
			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum }"/>
			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType }"/>
			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword }"/>
			
			<div class="form-group">
				<labe for="writer" class="col-sm-2 control-label">댓글 작성자</labe>
				<div class="col-sm-10">
					<input class="form-control" type="text" id="writer" name="writer"/><br/>
				</div>
			</div>
			
			<div class="form-group">
				<labe for="content" class="col-sm-2 control-label">댓글 내용</labe>
				<div class="col-sm-10">
					<input class="form-control" type="text" id="content" name="content"/>
				</div>
			</div>
			
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="replyWriteBnt btn btn-success">작성</button>
				</div>
			</div>
		</form>
	</section>
	<hr/>
</body>
</html>