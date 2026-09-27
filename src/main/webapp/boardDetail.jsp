<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - 詳細</title>
<style>
	/* 공통 헤더 및 메뉴 스타일 */
	h1 { height: 150px; background: orange; font-size: 70px; color: yellow; font-weight: bold; text-align: center; margin: 0; line-height: 150px; }
	p { height: 50px; background: orange; font-size: 24px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	.menu_bg { background: #333333; height: 50px; width: 100%; }
	.menu_bg ul { width: 800px; margin: 0 auto; list-style: none; padding-top: 13px; }
	.menu_bg ul li { float: left; width: 200px; text-align: center; }
	.menu_bg ul li a { font-size: 18px; color: white; font-weight: bold; text-decoration: none; }

	/* 게시글 상세 보기 테이블 스타일 */
	.detail_table { width: 100%; border-collapse: collapse; margin-top: 20px; border-top: 2px solid orange; }
	.detail_table th { background: #f8f8f8; color: #333; padding: 12px; border-bottom: 1px solid #ddd; width: 15%; text-align: center; font-weight: bold; }
	.detail_table td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
	
	.content_box { min-height: 200px; vertical-align: top; white-space: pre-wrap; word-break: break-all; line-height: 1.6; }

	/* 버튼 스타일 */
	.btn_group { margin-top: 20px; text-align: right; }
	.btn {
		display: inline-block;
		padding: 8px 18px;
		background: #333;
		color: white;
		text-decoration: none;
		font-weight: bold;
		border: none;
		cursor: pointer;
		font-size: 14px;
	}
	.btn_orange { background: orange; }
	.btn_red { background: #d9534f; }

	/* 댓글 영역 스타일 */
	.reply_container { margin-top: 40px; border-top: 2px solid orange; padding-top: 20px; }
	.reply_form { background: #f9f9f9; padding: 15px; border: 1px solid #ddd; margin-bottom: 25px; }
	.reply_form input[type="text"] { padding: 6px; width: 200px; border: 1px solid #ccc; margin-bottom: 8px; }
	.reply_form textarea { width: 98%; height: 70px; padding: 8px; border: 1px solid #ccc; resize: none; font-family: inherit; }
	
	.reply_item { border-bottom: 1px solid #eee; padding: 12px 5px; position: relative; }
	.reply_writer { font-weight: bold; color: #333; }
	.reply_date { font-size: 12px; color: #888; margin-left: 10px; }
	.reply_content { margin-top: 8px; color: #444; white-space: pre-wrap; }
	.reply_delete_btn {
		position: absolute;
		right: 5px;
		top: 10px;
		color: #999;
		text-decoration: none;
		font-size: 12px;
	}
	.reply_delete_btn:hover { color: #d9534f; font-weight: bold; }
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

	<div style="width: 800px; margin: 40px auto 80px auto;">
		<h2>📄 投稿詳細を見る</h2>

		<!-- 1. 게시글 본문 영역 -->
		<table class="detail_table">
			<tr>
				<th>題目</th>
				<td colspan="3" style="font-weight: bold; font-size: 16px;">
					<c:out value="${board.title}" />
				</td>
			</tr>
			<tr>
				<th>作成者</th>
				<td width="35%"><c:out value="${board.writer}" /></td>
				<th>作成日 / 閲覧数</th>
				<td>${board.regdate} / ${board.readcount}회</td>
			</tr>
			
			<!-- 첨부파일이 있는 경우에만 표시 -->
			<c:if test="${not empty board.filename}">
				<tr>
					<th>添付ファイル</th>
					<td colspan="3">
						<a href="upload/${board.filename}" download="${board.filename}" style="color: #0056b3; text-decoration: underline; font-weight: bold;">
							 <c:out value="${board.filename}" /> (ダウンロード)
						</a>
					</td>
				</tr>
			</c:if>

			<tr>
				<th>内容</th>
				<td colspan="3" class="content_box">
					<c:out value="${board.content}" />
				</td>
			</tr>
		</table>

		<!-- 버튼 그룹 -->
		<div class="btn_group">
			<a href="boardList.do" class="btn">一覧へ</a>
			<a href="boardUpdate.do?num=${board.num}" class="btn btn_orange">修整</a>
			<a href="boardDeletePro.do?num=${board.num}" class="btn btn_red" onclick="return confirm('本当に削除しますか？');">削除</a>
		</div>

		<!-- 2. 댓글 작성 영역 -->
		<div class="reply_container">
			<h3>💬 コメント</h3>
			
			<div class="reply_form">
				<form action="replyWritePro.do" method="post">
					<input type="hidden" name="bno" value="${board.num}">
					<div>
						<input type="text" name="writer" placeholder="작성자 닉네임" required>
					</div>
					<div>
						<textarea name="content" placeholder="댓글을 입력하세요..." required></textarea>
					</div>
					<div style="text-align: right; margin-top: 8px;">
						<button type="submit" class="btn btn_orange">コメント登録</button>
					</div>
				</form>
			</div>

			<!-- 3. 댓글 목록 영역 -->
			<div class="reply_list">
				<c:choose>
					<c:when test="${empty replyList}">
						<p style="text-align: center; color: #888; background: none; font-size: 15px; margin: 30px 0;">
							コメントはまだありません。 最初のコメントを残してみてください
						</p>
					</c:when>
					<c:otherwise>
						<c:forEach var="reply" items="${replyList}">
							<div class="reply_item">
								<span class="reply_writer"><c:out value="${reply.writer}" /></span>
								<span class="reply_date">${reply.regdate}</span>
								
								<!-- 댓글 삭제 링크 -->
								<a href="replyDeletePro.do?rno=${reply.rno}&bno=${board.num}" 
								   class="reply_delete_btn" 
								   onclick="return confirm('まだコメントはありません。 最初のコメントを残してみてください！');">削除</a>
								
								<div class="reply_content"><c:out value="${reply.content}" /></div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</body>
</html>