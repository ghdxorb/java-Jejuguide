<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JEJU TOUR GUIDE - 編集</title>
<style>
	/* 공통 헤더 및 메뉴 스타일 */
	h1 { height: 150px; background: orange; font-size: 70px; color: yellow; font-weight: bold; text-align: center; margin: 0; line-height: 150px; }
	p { height: 50px; background: orange; font-size: 24px; color: yellow; font-weight: bold; text-align: center; margin: 0; }
	.menu_bg { background: #333333; height: 50px; width: 100%; }
	.menu_bg ul { width: 800px; margin: 0 auto; list-style: none; padding-top: 13px; }
	.menu_bg ul li { float: left; width: 200px; text-align: center; }
	.menu_bg ul li a { font-size: 18px; color: white; font-weight: bold; text-decoration: none; }

	/* 게시글 수정 테이블 스타일 */
	.update_table { width: 100%; border-collapse: collapse; margin-top: 20px; border-top: 2px solid orange; }
	.update_table th { background: #f8f8f8; color: #333; padding: 12px; border-bottom: 1px solid #ddd; width: 20%; text-align: center; font-weight: bold; }
	.update_table td { padding: 10px; border-bottom: 1px solid #ddd; text-align: left; }
	
	.input_text { width: 98%; padding: 8px; border: 1px solid #ccc; font-size: 14px; box-sizing: border-box; }
	.readonly_input { background: #f0f0f0; color: #666; border: 1px solid #ddd; cursor: not-allowed; }
	.textarea_content { width: 98%; height: 250px; padding: 8px; border: 1px solid #ccc; resize: vertical; font-family: inherit; font-size: 14px; box-sizing: border-box; }

	/* 버튼 스타일 */
	.btn_group { margin-top: 20px; text-align: center; }
	.btn {
		display: inline-block;
		padding: 10px 24px;
		background: #333;
		color: white;
		text-decoration: none;
		font-weight: bold;
		border: none;
		cursor: pointer;
		font-size: 15px;
	}
	.btn_orange { background: orange; }
	.btn_gray { background: #666; }
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
		<h2>✏️ 投稿の編集</h2>

		<form action="boardUpdatePro.do" method="post" enctype="multipart/form-data">
			<!-- 수정할 게시글 번호 hidden 전달 -->
			<input type="hidden" name="num" value="${board.num}">

			<table class="update_table">
				<tr>
					<th>作成者</th>
					<td>
						<input type="text" name="writer" value="<c:out value='${board.writer}' />" class="input_text readonly_input" readonly>
					</td>
				</tr>
				<tr>
					<th>パスワード <span style="color: red;">*</span></th>
					<td>
						<input type="password" name="pw" class="input_text" placeholder="作成時に設定したパスワードを入力してください" required style="width: 50%;">
					</td>
				</tr>
				<tr>
					<th>題目 <span style="color: red;">*</span></th>
					<td>
						<input type="text" name="title" value="<c:out value='${board.title}' />" class="input_text" required>
					</td>
				</tr>
				<tr>
					<th>添付ファイル</th>
					<td>
						<c:if test="${not empty board.filename}">
							<div style="margin-bottom: 8px; font-size: 13px; color: #555;">
								 既存ファイル: <strong><c:out value="${board.filename}" /></strong>
							</div>
						</c:if>
						<input type="file" name="file">
						<div style="font-size: 12px; color: #888; margin-top: 4px;">
							* 新しいファイルを添付すると、既存のファイルが置き換えられます。
						</div>
					</td>
				</tr>
				<tr>
					<th>内容 <span style="color: red;">*</span></th>
					<td>
						<textarea name="content" class="textarea_content" required><c:out value="${board.content}" /></textarea>
					</td>
				</tr>
			</table>

			<div class="btn_group">
				<button type="submit" class="btn btn_orange">修正完了</button>
				<a href="boardDetail.do?num=${board.num}" class="btn btn_gray">キャンセル</a>
			</div>
		</form>
	</div>
</body>
</html>