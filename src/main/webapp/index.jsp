<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE</title>
<style>
	h1{
	height:150px;
	background:orange;
	font-size: 70px;
	color:yellow; 
	font-weight:bold; 
	text-decoration:none;
	text-align: center;
	margin: 0;
	}
	p{
	height:80px;
	background:orange;
	font-size: 30px;
	color:yellow; 
	font-weight:bold; 
	text-decoration:none;
	text-align: center;
	margin: 0;
	}
/* --- 메뉴 배너 스타일 --- */
.menu_bg {
    background: #333333; 
    height: 50px;
    width: 100%;
}

/* ul 앞에 .menu_bg를 붙여서 메뉴 배경 안의 ul에만 적용되게 합니다 */
.menu_bg ul {
    width: 1000px; 
    margin: 0 auto; 
    list-style: none; 
    padding-top: 13px; 
}

/* 마찬가지로 메뉴 안의 li에만 가로 정렬(float)을 적용합니다[cite: 1] */
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
</style>
</head>
<body>
	<h1>🍊ようこそ！　JEJU（ジェジュ島）へ🍊</h1>
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
<div style="width: 800px; margin:40px auto;">
	<h2 style="border-bottom:3px solid orange; padding-bottom: 10px; margin-bottom: 20px;">
		🍜 今月のおすすめグルメ
	</h2>
	<table border="1" width="100%" style="border-collapse: collase;">
		<tr>
			<td width="40%" align="center" style="padding: 15px;">
    				<img src="images/blackpork.jpg" alt="식당 사진" width="250" style="height: 150px; object-fit: cover; border-radius: 5px;">
			</td>
			<td width="60%" style="padding: 15px;">
				<h3 style="color: #333; margin-bottom; 10px;">📍 食堂</h3>
				<ul style="list-style: square; margin-left: 20px;">
					<li style="margin-bottom: 5px;"><b>カテゴリー : </b>ローカルの名店</li>
					<li style="margin-bottom: 5px;"><b>特徴 : </b>済州産の材料を使った料理</li>
					<li><b>おすすめ理由 : </b>とても美味しい</li>
				</ul>
			</td>
		</tr>
	</table>
</div>
<div style="width: 800px; margin:40px auto;">
	<h2 style="border-bottom:3px solid orange; padding-bottom: 10px; margin-bottom: 20px;">
		🌴 今月のおすすめスポット
	</h2>
	<table border="1" width="100%" style="border-collapse: collase;">
		<tr>
			<td width="40%" align="center" style="padding: 15px;">
   				 <img src="images/subjikoji.jpg" alt="식당 사진" width="250" style="height: 150px; object-fit: cover; border-radius: 5px;">
			</td>
			<td width="60%" style="padding: 15px;">
				<h3 style="color: #333; margin-bottom; 10px;">📍 ソプジコジ</h3>
				<ul style="list-style: square; margin-left: 20px;">
					<li style="margin-bottom: 5px;"><b>カテゴリー : </b>自然名所</li>
					<li style="margin-bottom: 5px;"><b>特徴 : </b>美しい海岸の絶景と散策路</li>
					<li><b>おすすめ理由 : </b>広々とした海を背景に、最高の写真を残すことができます。</li>
				</ul>
			</td>
		</tr>
	</table>
</div>
</body>
</html>