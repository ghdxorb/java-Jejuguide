<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - コミュニティ</title>
<style>
	h1 { height: 150px; background: orange; font-size: 70px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	p { height: 80px; background: orange; font-size: 30px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	/* --- 메뉴 배너 스타일 --- */
	.menu_bg { background: #333333; height: 50px; width: 100%; }
	.menu_bg ul { width: 800px; margin: 0 auto; list-style: none; padding-top: 13px; }
	.menu_bg ul li { float: left; width: 200px; text-align: center; }
	.menu_bg ul li a { font-size: 18px; color: white; font-weight: bold; text-decoration: none; }
	
	/* --- 상세보기 표 스타일 --- */
	.view_table { width: 100%; border-collapse: collapse; margin-top: 20px; border-top: 2px solid orange; border-bottom: 2px solid orange; }
	.view_table th { background: #f9f9f9; color: #333; padding: 12px; border-bottom: 1px solid #ddd; text-align: center; font-weight: bold; }
	.view_table td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
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
		<h2 style="text-align: center;">💬 コミュニティ - 詳細表示💬</h2>
		
		<table class="view_table">
			<tr>
				<th width="15%">タイトル<br>(題目)</th>
				<td colspan="3" style="font-size: 18px; font-weight: bold;">黒豚の美味しいお店はどこですか？</td>
			</tr>
			<tr>
				<th width="15%">作成者<br></th>
				<td width="35%">田中</td>
				<th width="15%">登録日<br></th>
				<td width="35%">2026.03.15</td>
			</tr>
			<tr>
				<!-- 글 내용은 길어질 수 있으니 높이를 넉넉하게 주고, 줄바꿈이 유지되도록 설정 -->
				<td colspan="4" style="padding: 20px; min-height: 300px; vertical-align: top; line-height: 1.6; white-space: pre-wrap;">来週、済州島に一人旅に行きます！
黒豚が食べたいのですが、一人でも入りやすいおすすめのお店はありますか？
西帰浦（ソギポ）周辺だと嬉しいです！

</td>
			</tr>
		</table>
		
		<!-- 하단 버튼 영역 -->
		<div style="text-align: center; margin-top: 20px;">
			<!-- 목록으로 돌아가기 -->
			<button type="button" onclick="location.href='boardList.do'" style="padding: 10px 20px; background: #333; color: white; border: none; cursor: pointer; font-weight: bold; margin-right: 5px;">
				📑 リストへ
			</button>
			
			<!-- 나중에 비밀번호를 확인하고 수정/삭제할 수 있도록 연결할 버튼들 -->
			<button type="button" onclick="alert('修正機能は準備中です！')" style="padding: 10px 20px; background: #5bc0de; color: white; border: none; cursor: pointer; font-weight: bold; margin-right: 5px;">
				✏️ 修正
			</button>
			
			<button type="button" onclick="alert('削除機能は準備中です！')" style="padding: 10px 20px; background: #d9534f; color: white; border: none; cursor: pointer; font-weight: bold;">
				🗑️ 削除
			</button>
		</div>
	</div>
</body>
</html>