<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - 観光名所</title>
<style>
	h1 { height: 150px; background: orange; font-size: 70px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	p { height: 80px; background: orange; font-size: 30px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	/* --- 메뉴 배너 스타일 --- */
	.menu_bg { background: #333333; height: 50px; width: 100%; }
	.menu_bg ul { width: 800px; margin: 0 auto; list-style: none; padding-top: 13px; }
	.menu_bg ul li { float: left; width: 200px; text-align: center; }
	.menu_bg ul li a { font-size: 18px; color: white; font-weight: bold; text-decoration: none; }
	
	/* --- 리스트 표 스타일 --- */
	.info_table { width: 100%; border-collapse: collapse; margin-top: 20px; }
	.info_table td { padding: 20px; border-bottom: 1px solid #ddd; }
	.info_title { font-size: 24px; font-weight: bold; color: orange; margin-bottom: 10px; }
	.info_desc { font-size: 16px; color: #555; line-height: 1.6; }
</style>
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

	<div style="width: 800px; margin: 50px auto;">
		<h2 style="text-align: center;">🌴 済州島の観光名所 🌴</h2>
		<p style="font-size: 14px; color: gray; text-align: center; background: none; height: auto;">
			美しい自然と歴史が息づく、おすすめの観光スポットをご紹介します。<br>

		</p>
		
		<table class="info_table">
			<tr>
				<!-- 파일 이름이 pork.jpg 라고 가정했을 때 -->
				<td width="20%" align="center">
    					<img src="images/sungsanilchul.jpg" alt="城山日出峰" style="width: 150px; height: 150px; border-radius: 10px; object-fit: cover;">
				</td>
				<td width="80%">
					<div class="info_title">1. 城山日出峰 </div>
					<div class="info_desc">
						ユネスコ世界自然遺産に登録されている済州島のシンボル。頂上から見る日の出は一生の思い出になる絶景です。<br>
						
					</div>
				</td>
			</tr>
			<tr>
				<td width="20%" align="center">
    					<img src="images/hyupje.JPG" alt="挟才海水浴場" style="width: 150px; height: 150px; border-radius: 10px; object-fit: cover;">
				</td>
				<td>
					<div class="info_title">2. 挟才海水浴場</div>
					<div class="info_desc">
						エメラルドグリーンの海と白い砂浜が広がる美しいビーチ。目の前に浮かぶ飛揚島(ピヤンド)の景色も最高です。<br>
						
					</div>
				</td>
			</tr>
			<tr>
				<td width="20%" align="center">
    					<img src="images/halasan.jpg" alt="漢拏山" style="width: 150px; height: 150px; border-radius: 10px; object-fit: cover;">
				</td>
				<td>
					<div class="info_title">3. 漢拏山</div>
					<div class="info_desc">
						韓国で最も高い山。四季折々の美しい自然を楽しむことができ、ハイキングコースも充実しています。<br>
					
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>