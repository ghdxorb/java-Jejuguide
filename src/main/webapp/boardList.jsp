<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - コミュニティ</title>
<style>
	h1 { height: 150px; background: orange; font-size: 70px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	p { height: 80px; background: orange; font-size: 30px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	.menu_bg { background: #333333; height: 50px; width: 100%; }
	.menu_bg ul { width: 800px; margin: 0 auto; list-style: none; padding-top: 13px; }
	.menu_bg ul li { float: left; width: 200px; text-align: center; }
	.menu_bg ul li a { font-size: 18px; color: white; font-weight: bold; text-decoration: none; }
	
	table { width: 100%; border-collapse: collapse; margin-top: 20px; text-align: center; }
	th { background: orange; color: white; padding: 10px; }
	td { padding: 10px; border-bottom: 1px solid #ddd; }
	a.title_link { color: #333; text-decoration: none; font-weight: bold; }
	a.title_link:hover { color: orange; text-decoration: underline; }
	
	.btn_write {
		padding: 8px 15px;
		background: #333;
		color: white;
		border: none;
		cursor: pointer;
		font-weight: bold;
		text-decoration: none;
		float: right;
		margin-top: 15px;
	}

	/* 페이징 및 검색 스타일 */
	.pagination { text-align: center; margin-top: 25px; }
	.pagination a, .pagination span {
		display: inline-block;
		padding: 5px 10px;
		margin: 0 2px;
		border: 1px solid #ddd;
		color: #333;
		text-decoration: none;
	}
	.pagination .active { background: orange; color: white; border-color: orange; font-weight: bold; }
	.search_area { text-align: center; margin-top: 20px; }
</style>
</head>
<body>
	<h1>🍊ようこそ！ JEJU（ジェジュ島）へ🍊</h1>
	<p>~地元の人が推薦하는 済州の味と魅力~</p>
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
		<h2 style="text-align: center;">💬 コミュニティ💬</h2>
		
		<table>
			<tr>
				<th width="10%">番号</th>
				<th width="45%">題目</th>
				<th width="15%">作成者</th>
				<th width="20%">作成日</th>
				<th width="10%">閲覧数</th>
			</tr>
			
			<c:choose>
				<c:when test="${empty boardList}">
					<tr>
						<td colspan="5" style="padding: 30px;">検索結果または作成された投稿はありません。</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="board" items="${boardList}">
						<tr>
							<td>${board.num}</td>
							<td style="text-align: left; padding-left: 15px;">
								<a href="boardDetail.do?num=${board.num}" class="title_link">
									<c:out value="${board.title}" />
								</a>
							</td>
							<td><c:out value="${board.writer}" /></td>
							<td>${board.regdate}</td>
							<td>${board.readcount}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>

		<a href="boardWrite.jsp" class="btn_write">글 작성</a>

		<!-- 페이징 네비게이션 -->
		<c:if test="${totalPages > 0}">
			<div class="pagination">
				<%-- 이전 블록 버튼 --%>
				<c:if test="${startPage > 1}">
					<a href="boardList.do?page=${startPage - 1}&searchType=${searchType}&keyword=${keyword}">以前</a>
				</c:if>

				<%-- 페이지 번호 출력 --%>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == currentPage}">
							<span class="active">${i}</span>
						</c:when>
						<c:otherwise>
							<a href="boardList.do?page=${i}&searchType=${searchType}&keyword=${keyword}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<%-- 다음 블록 버튼 --%>
				<c:if test="${endPage < totalPages}">
					<a href="boardList.do?page=${endPage + 1}&searchType=${searchType}&keyword=${keyword}">次</a>
				</c:if>
			</div>
		</c:if>

		<!-- 검색 폼 -->
		<div class="search_area">
			<form action="boardList.do" method="get">
				<select name="searchType" style="padding: 5px;">
					<option value="title" ${searchType == 'title' ? 'selected' : ''}>題目</option>
					<option value="content" ${searchType == 'content' ? 'selected' : ''}>内容</option>
					<option value="writer" ${searchType == 'writer' ? 'selected' : ''}>作成者</option>
				</select>
				<input type="text" name="keyword" value="${keyword}" placeholder="검색어 입력" style="padding: 5px; width: 200px;">
				<input type="submit" value="검색" style="padding: 5px 12px; background: #333; color: white; border: none; cursor: pointer;">
			</form>
		</div>
	</div>
</body>
</html>