<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - コミュニティ削除</title>
<style>
	h1 { height: 150px; background: orange; font-size: 70px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	p { height: 80px; background: orange; font-size: 30px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
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

	<div style="width: 450px; margin: 80px auto; border: 1px solid #ccc; padding: 30px; text-align: center; border-radius: 8px;">
		<h2>💬 投稿削除</h2>
		<p style="font-size: 14px; color: #666; height: auto; background: none; margin-bottom: 20px;">
			削除するには、投稿時に入力したパスワードを入力してください。
		</p>
		
		<form action="boardDeletePro.do" method="post">
			<input type="hidden" name="num" value="${num}">
			
			<div style="margin-bottom: 20px;">
				<input type="password" name="pw" placeholder="비밀번호 입력" required style="padding: 10px; width: 80%; border: 1px solid #ddd;">
			</div>
			
			<div>
				<input type="submit" value="削除する (삭제)" style="padding: 10px 20px; background: #dc3545; color: white; border: none; cursor: pointer; font-weight: bold; margin-right: 10px;">
				<input type="button" onclick="history.back()" value="キャンセル" style="padding: 10px 20px; background: gray; color: white; border: none; cursor: pointer; font-weight: bold;">
			</div>
		</form>
	</div>
</body>
</html>