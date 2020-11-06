<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>게시판</title>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='writeForm']");
		
		$(document).on("click","#fileDel", function(){
			$(this).parent().remove();
		})
		
		fn_addFile();
		
		$(".writeBnt").on("click", function(){
			if(fnValiChk()){
				return false;
			}
			
			formObj.attr("action", "/board/write");
			formObj.attr("method", "post");
			formObj.submit();
		});
		fn_addFile();
	});
	
	function fnValiChk(){
		var writeForm = $("form[name='writeForm'].chk").length;
		for(var i=0; i<writeForm; i++){
			if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}
	
	function fn_addFile(){
		var fileIndex = 1;
		//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
		$(".fileAdd_btn").on("click", function(){
			$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
		});
		$(document).on("click","#fileDelBtn", function(){
			$(this).parent().remove();
			
		});
	}
	
	var fileNoArry = new Array();
	var fileNameArry = new Array();
	
	function fn_del(value, name){
		fileNoArry.push(value);
		fileNameArry.push(name);
		$("#fileNoDel").attr("value", fileNoArry);
		$("#fileNameDel").attr("value", fileNameArry);
	}
	
</script>
<body>
	<div id="root">
		<header>
			<h1>게시판</h1>
		</header>
		<hr/>
		
		<div>
			<%@include file="nav.jsp" %>
		</div>
		<hr/>
		
		<section id="container">
			<form name="writeForm" role="form" method="post" action="/board/write" enctype="multipart/form-data">
				<input type="hidden" name="bno" value="${write.bno}" readonly="readonly"/>
				<input type="hidden" id="page" name="page" value="${scri.page}"> 
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
				<input type="hidden" id="fileNoDel" name="fileNoDel[]" value=""> 
				<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">
				
				<table>
					<tbody>
						<c:if test="${member.userId != null }">
							<tr>
								<td>
									<label for="title">제목</label>
									<input type="text" id="title" name="title" class="chk" title="제목을 입력하세요."/>
								</td>
							</tr>
							<tr>
								<td>
									<label for="content">내용</label>
									<textarea id="content" name="content" class="chk" title="내용을 입력하세요."></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer">작성자</label>
									<input type="text" id="writer" name="writer" class="chk" title="작성자를 입력하세요."/>
								</td>
							</tr>
							<tr>
								<td id="fileIndex">
									<c:forEach var="file" items="${file}" varStatus="var">
									<div>
										<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
										<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
										<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
										<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');" type="button">삭제</button><br>
									</div>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td>
									<button type="submit" class="writeBnt" id="writeBnt" name="writeBnt">등록</button>
									<button class="fileAdd_bnt" type="button">파일추가</button>
								</td>
							</tr>
						</c:if>
						
						<c:if test="${member.userId == null }">
							<p>로그인 후에 작성하실 수 있습니다.</p>
						</c:if>
					</tbody>
				</table>
			</form>
		</section>
		<hr />
	</div>
</body>
</html>