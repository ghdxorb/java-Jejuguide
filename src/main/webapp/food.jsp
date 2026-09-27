<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - ローカルの名店</title>
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

	<div style="width: 800px; margin: 50px auto;">
		<h2 style="text-align: center;">🍜 ローカルの名店 🍜</h2>
		<p style="font-size: 14px; color: gray; text-align: center; background: none; height: auto;">
			済州島に来たら絶対に食べるべき絶品グルメ！<br>
			
		</p>
		
		<table class="info_table">
			<tr>
				<!-- 파일 이름이 pork.jpg 라고 가정했을 때 -->
				<td width="20%" align="center">
    					<img src="images/blackpork.jpg" alt="黒豚" style="width: 150px; height: 150px; border-radius: 10px; object-fit: cover;">
				</td>
				<td width="80%">
					<div class="info_title">1. 黒豚  - トンサドン </div>
					<div class="info_desc">
						済州島と言えば黒豚！分厚いお肉を炭火でジューシーに焼き上げます。ミョルチジョッ(カタクチイワシの塩辛)につけて食べるのが地元流です。<br>
						
					</div>
				</td>
			</tr>
			<tr>
				<!-- 파일 이름이 pork.jpg 라고 가정했을 때 -->
				<td width="20%" align="center">
    					<img src="images/gogigugsu.jpg" alt="コギグクス" style="width: 150px; height: 150px; border-radius: 10px; object-fit: cover;">
				</td>
				<td>
					<div class="info_title">2. コギグクス - オルメクッス </div>
					<div class="info_desc">
						豚骨をじっくり煮込んだ濃厚なスープに、柔らかいゆで豚がのった済州島の伝統的な麺料理です。辛いものが苦手な方にもおすすめ！<br>
						
					</div>
				</td>
			</tr>
			<tr>
				<!-- 파일 이름이 pork.jpg 라고 가정했을 때 -->
			<td width="20%" align="center">
    				<img src="images/myeongjinjeonbok.jpg" alt="アワビ" style="width: 150px; height: 150px; border-radius: 10px; object-fit: cover;">
			</td>
				<td>
					<div class="info_title">3. アワビ - ミョンジンチョンボク </div>
					<div class="info_desc">
						新鮮なアワビをたっぷり使った釜飯(トルソッパプ)やバター焼きが絶品。海を見ながら新鮮な海鮮を楽しめるお店です。<br>
						
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>