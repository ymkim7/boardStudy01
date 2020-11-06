<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>회원가입</title>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		
		//취소
		$(".cencle").on("click", function(){
			location.href = "/";
		});
		
		$("#submit").on("click", function(){
			if($("#userId").val() == ""){
				alert("아이디를 입력해주세요.");
				$("#userId").focus();
				
				return false;
			}
			
			if($("#userPass").val() == ""){
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				
				return false;
			}
			
			if($("#userName").val() == ""){
				alert("이름을 입력해주세요.");
				$("#userName").focus();
				
				return false;
			}
			
			var idChkVal = $("#userId").val();
			if(idChkVal == "N"){
				alert("중복된 아이디입니다.");
			} else if (idChkVal == "Y"){
				$("#regForm").submit();
			}
			
		});
	});
	
	function idChkFn(){
		$.ajax({
			url : "/member/idChk"
			, type : "post"
			, dataType : "json"
			, data : {
				"userId" : $("#userId").val()
			}
			, success : function(data){
				if(data == 1){
					alert("중복된 아이디입니다.");
				} else if (data == 0){
					$("#idChk").attr("value", "Y");
					alert("사용가능한 아이디입니다.");
				}
			}
		});
	}
	
</script>
<body>
	<section id="conteiner">
		<form action="/member/register" method="post">
			<div class="form-group has-feedback">
				<label class="control-label" for="userId">아이디</label>
				<input class="form-control" type="text" id="userId" name="userId"/>
				<button class="idChk" type="button" id="idChk" name="idChk" onclick="idChkFn();" value="N">중복확인</button>
			</div>
			
			<div class="form-group has-feedback">
				<label class="control-label" for="userPass">비밀번호</label>
				<input class="form-control" type="text" id="userPass" name="userPass"/>
			</div>
			
			<div class="form-group has-feedback">
				<label class="control-label" for="userName">이름</label>
				<input class="form-control" type="text" id="userName" name="userName"/>
			</div>
			
			<div class="form-group has-feedback">
				<button class="btn btn-success" type="submit" id="submit" name="submit">회원가입</button>
				<button class="cencle btn btn-danger" type="button">취소</button>
			</div>
		</form>
	</section>
</body>
</html>