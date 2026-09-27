<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - コミュニティ作成</title>
<style>
	h1 { height: 150px; background: orange; font-size: 70px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	p { height: 80px; background: orange; font-size: 30px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	/* --- 메뉴 배너 스타일 --- */
	.menu_bg { background: #333333; height: 50px; width: 100%; }
	.menu_bg ul { width: 800px; margin: 0 auto; list-style: none; padding-top: 13px; }
	.menu_bg ul li { float: left; width: 200px; text-align: center; }
	.menu_bg ul li a { font-size: 18px; color: white; font-weight: bold; text-decoration: none; }
</style>
</head>
<body>
	<h1>🍊ようこそ！ JEJU（ジェジュ島）へ🍊</h1>
	<p>~地元の人が推薦する済州の味と魅力~</p>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		<h2 style="text-align: center;">💬 コミュニティ - 投稿する💬</h2>
		
		<!-- 폼 데이터를 boardWritePro.do(글쓰기 처리 서블릿)로 보냄 -->
		<form action="boardWritePro.do" method="post" enctype="multipart/form-data">
			<table border="1" width="100%" style="border-collapse: collapse; margin-top: 20px; text-align: left;">
				<c:choose>
					<%-- 1. 로그인한 회원인 경우 --%>
					<c:when test="${not empty sessionScope.loginUser}">
						<tr>
							<td width="20%" style="padding: 10px; background: orange; color: white; font-weight: bold; text-align: center;">作成者<br></td>
							<td colspan="3" style="padding: 10px;">
								<input type="text" name="writer" value="${sessionScope.loginUser.name}" readonly style="width: 90%; padding: 5px; background-color: #f0f0f0;">
								<input type="hidden" name="pw" value="${sessionScope.loginUser.pw}">
							</td>
						</tr>
					</c:when>

					<%-- 2. 비회원인 경우 --%>
					<c:otherwise>
						<tr>
							<td width="20%" style="padding: 10px; background: orange; color: white; font-weight: bold; text-align: center;">作成者<br></td>
							<td width="30%" style="padding: 10px;">
								<input type="text" name="writer" required 
								       oninvalid="this.setCustomValidity('作成者を入力してください。')" 
								       oninput="this.setCustomValidity('')" 
								       style="width: 90%; padding: 5px;" placeholder="ニックネーム入力">
							</td>
							<td width="20%" style="padding: 10px; background: orange; color: white; font-weight: bold; text-align: center;">パスワード<br></td>
							<td width="30%" style="padding: 10px;">
								<input type="password" name="pw" required 
								       oninvalid="this.setCustomValidity('パスワードを入力してください。')" 
								       oninput="this.setCustomValidity('')" 
								       style="width: 90%; padding: 5px;" placeholder="記事の編集/削除用パスワード">
							</td>
						</tr>
					</c:otherwise>
				</c:choose>

				<tr>
					<td style="padding: 10px; background: orange; color: white; font-weight: bold; text-align: center;">タイトル<br></td>
					<td colspan="3" style="padding: 10px;">
						<input type="text" name="title" required 
						       oninvalid="this.setCustomValidity('タイトルを入力してください。')" 
						       oninput="this.setCustomValidity('')" 
						       style="width: 97%; padding: 5px;">
					</td>
				</tr>
				<tr>
					<td style="padding: 10px; background: orange; color: white; font-weight: bold; text-align: center;">内容<br></td>
					<td colspan="3" style="padding: 10px;">
						<textarea name="content" rows="12" required 
						          oninvalid="this.setCustomValidity('内容を入力してください。')" 
						          oninput="this.setCustomValidity('')" 
						          style="width: 97%; padding: 5px; resize: none;" 
						          placeholder="旅行の質問やおすすめ情報を自由に作成してください。"></textarea>
					</td>
				</tr>
				<tr>
        				<td style="padding: 10px; background: orange; color: white; font-weight: bold; text-align: center;">첨부파일</td>
       				<td colspan="3" style="padding: 10px;">
            			<input type="file" name="file">
        				</td>
    				</tr>
				<tr>
					<td colspan="4" align="center" style="padding: 20px;">
						<input type="submit" value="登録する" style="padding: 10px 20px; background: #333; color: white; border: none; cursor: pointer; font-weight: bold; margin-right: 10px;">
						<input type="button" onclick="history.back()" value="キャンセル" style="padding: 10px 20px; background: gray; color: white; border: none; cursor: pointer; font-weight: bold;">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>