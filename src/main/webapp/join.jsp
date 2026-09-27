<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - 新規会員登録</title>
<style>
	h1 {
		height: 150px;
		background: orange;
		font-size: 70px;
		color: yellow; 
		font-weight: bold; 
		text-align: center;
		margin: 0;
	}
	p {
		height: 80px;
		background: orange;
		font-size: 30px;
		color: yellow; 
		font-weight: bold; 
		text-align: center;
		margin: 0;
	}
	/* --- 메뉴 배너 스타일 --- */
	.menu_bg {
		background: #333333; 
		height: 50px;
		width: 100%;
	}
	.menu_bg ul {
		width: 800px; 
		margin: 0 auto; 
		list-style: none; 
		padding-top: 13px; 
	}
	.menu_bg ul li {
		float: left; 
		width: 200px; 
		text-align: center;
	}
	.menu_bg ul li a {
		font-size: 18px;
		color: white; 
		font-weight: bold; 
		text-decoration: none; 
	}
	/* 입력칸 스타일 */
	input[type="text"], input[type="password"] {
		padding: 5px;
	}
</style>

<!-- jQuery 라이브러리 추가 -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script type="text/javascript">
$(function(){
	// 초기 설정: 이메일 폼과 인증번호 폼 숨기기
	$("#smscheck").hide();
	$("#emailcheck").hide();
	$("#email_row").hide();

	// 라디오 버튼(인증 방법) 선택 시 화면 전환
	$("input[name='mode']").change(function() {
		if ($("#mode1").is(":checked")) { // 핸드폰 선택 시
			$("#phone_row").show();
			$("#email_row").hide();
			$("#smscheck").hide();
			$("#emailcheck").hide();
		} else { // 이메일 선택 시
			$("#email_row").show();
			$("#phone_row").hide();
			$("#smscheck").hide();
			$("#emailcheck").hide();
		}
	});
	
	// 아이디 중복(길이) 확인 (AJAX 대신 임시 프론트엔드 검사로 세팅, 나중에 서블릿 연결 가능)
	$("#userid").on("change", function(){
		var userid = $('#userid').val();
		if(userid.length >= 5){
			$('#userID_c').html('<font color="blue">使用可能です。</font>');
		} else {
			$('#userID_c').html('<font color="red">5文字以上入力してください。</font>');
		}
	});
	
	// 비밀번호 일치 확인
	$("#repasswd").on("change", function(){
		var passwd = $("#passwd").val();
		var repasswd = $("#repasswd").val();
		if(passwd == repasswd && passwd != ""){
			$('#repasswd_c').html('<font color="blue">確認されました。</font>');
		} else {
			$('#repasswd_c').html('<font color="red">パスワードが一致しません。</font>');
			$("#repasswd").val('');
			$("#repasswd").focus();
		}
	});
	
	// 이메일 도메인 선택 (직접입력 vs 네이버, 구글 등)
	$("#email3").on("change", function(){
		if($(this).val() != "0"){
			$('#email2').prop('readonly', true);
			$('#email2').val($(this).val());
		} else {
			$('#email2').prop('readonly', false);
			$('#email2').val('');
		}
	});
	
	// 인증번호 받기 버튼 이벤트
	$("#phoneBtn1").click(function(){ $("#smscheck").show(); });
	$("#emailBtn1").click(function(){ $("#emailcheck").show(); });
	
	// 최종 유효성 검사 및 폼 제출
	$("#btn_write").click(function(){
		if($("#name").val() == ''){
			alert("名前を入力してください。");
			$("#name").focus();
			return;
		}
		if($("#userid").val() == ''){
			alert("IDを入力してください。");
			$("#userid").focus();
			return;
		}
		if($("#passwd").val() == ''){
			alert("パスワードを入力してください。");
			$("#passwd").focus();
			return;
		}
		// 모든 검사 통과 시 서블릿으로 전송
		$("#userForm").submit();
	});
});
</script>
</head>
<body>
	<h1>🍊ようこそ！ JEJU（ジェジュ島）へ🍊</h1>
	<p>~地元の人が推薦する済州の味と魅力~</p>
<div class="menu_bg">
    <ul style="width: 1000px;"> <%-- 메뉴 개수 추가 시 폭 조정 --%>
        <li><a href="index.jsp">🏠 ホーム</a></li>
        <li><a href="food.do">🍜 ローカルの名店</a></li>
        <li><a href="spot.do">🌴 観光名所</a></li>
        <li><a href="boardList.do">💬 コミュニティ</a></li>
        
        <c:choose>
            <c:when test="${empty sessionScope.loginUser}">
                <li><a href="login.jsp">🔑 ログイン</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="logout.do">🔒 ログアウト</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</div>

	<div style="width: 700px; margin: 50px auto;">
		<h2 style="text-align: center;">🍊 新規会員登録 🍊</h2>
		
		<!-- 폼 시작 -->
		<form id="userForm" name="userForm" method="post" action="memberJoin.do">
			<table border="1" width="100%" style="border-collapse: collapse; margin-top: 20px; text-align: left;">
				<tr>
					<td width="30%" style="padding: 10px; background: orange; color: white; font-weight: bold;">名前<font color="red">*</font></td>
					<td width="70%" style="padding: 10px;">
						<input type="text" id="name" name="name" size="20" placeholder="名前を入力">
					</td>
				</tr>
				<tr>
					<td style="padding: 10px; background: orange; color: white; font-weight: bold;">ID <font color="red">*</font></td>
					<td style="padding: 10px;">
						<input type="text" id="userid" name="userid" size="15">
						<span id="userID_c" style="font-size: 13px;">[5〜16文字 英字/数字]</span>
					</td>
				</tr>
				<tr>
					<td style="padding: 10px; background: orange; color: white; font-weight: bold;">パスワード<font color="red">*</font></td>
					<td style="padding: 10px;">
						<input type="password" id="passwd" name="passwd" size="15">
						<span style="font-size: 13px;">[6〜12文字以内]</span>
					</td>
				</tr>
				<tr>
					<td style="padding: 10px; background: orange; color: white; font-weight: bold;">パスワード確認<font color="red">*</font></td>
					<td style="padding: 10px;">
						<input type="password" id="repasswd" name="repasswd" size="15">
						<span id="repasswd_c" style="font-size: 13px; color: red;">*もう一度入力してください.</span>
					</td>
				</tr>
				
				<!-- 인증 방법 선택 라디오 버튼 -->
				<tr>
					<td style="padding: 10px; background: orange; color: white; font-weight: bold;">認証方法<font color="red">*</font></td>
					<td style="padding: 10px;">
						<input type="radio" id="mode1" name="mode" value="핸드폰" checked> 携帯電話 &nbsp;
						<input type="radio" id="mode2" name="mode" value="이메일"> メール
					</td>
				</tr>
				
				<!-- 휴대폰 인증 행 (기본 표시) -->
				<tr id="phone_row">
					<td style="padding: 10px; background: orange; color: white; font-weight: bold;">電話番号<font color="red">*</font></td>
					<td style="padding: 10px;">
						<input type="text" id="tel" name="tel" size="15" placeholder="-なし">
						<input type="button" id="phoneBtn1" value="認証番号取得">
					</td>
				</tr>
				<tr id="smscheck">
					<td style="padding: 10px; background: orange; color: white; font-weight: bold;">認証番号<font color="red">*</font></td>
					<td style="padding: 10px;">
						<input type="text" id="resms" name="resms" size="10">
						<input type="button" value="認証">
					</td>
				</tr>
				
				<!-- 이메일 인증 행 (기본 숨김) -->
				<tr id="email_row">
					<td style="padding: 10px; background: orange; color: white; font-weight: bold;">メール<font color="red">*</font></td>
					<td style="padding: 10px;">
						<input type="text" id="email1" name="email1" size="10"> @ 
						<input type="text" id="email2" name="email2" size="12">
						<select id="email3" name="email3">
							<option value="0">直接入力</option>
							<option value="gmail.com">gmail.com</option>
							<option value="yahoo.co.jp">yahoo.co.jp</option>
						</select>
						<input type="button" id="emailBtn1" value="認証番号取得">
					</td>
				</tr>
				<tr id="emailcheck">
					<td style="padding: 10px; background: orange; color: white; font-weight: bold;">認証番号 <font color="red">*</font></td>
					<td style="padding: 10px;">
						<input type="text" id="reemail" name="reemail" size="10">
						<input type="button" value="認証">
					</td>
				</tr>
				
				<!-- 제출/취소 버튼 -->
				<tr>
					<td colspan="2" align="center" style="padding: 20px;">
						
						<input type="button" id="btn_write" value="登録する" style="padding: 10px 20px; background: #333; color: white; border: none; cursor: pointer; margin-right: 10px; font-weight: bold;">
						<input type="button" onclick="history.back()" value="キャンセル" style="padding: 10px 20px; background: gray; color: white; border: none; cursor: pointer; font-weight: bold;">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>