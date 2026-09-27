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

<div style="width: 500px; margin: 50px auto; text-align: center;">
    <h2>🍊 ログイン 🍊</h2>
    
    
    <form action="login.do" method="post">
        <table border="1" width="100%" style="border-collapse: collapse; margin-top: 50px;">
            <tr>
                <td width="30%" style="padding: 10px; background: orange; color: white;">ID</td>
                <td width="70%" style="padding: 10px;">
                    <input type="text" name="id" required 
       				oninvalid="this.setCustomValidity('IDを入力してください。')" 
       				oninput="this.setCustomValidity('')" 
       				style="width: 90%;">
                </td>
            </tr>
            <tr>
                <td style="padding: 10px; background: orange; color: white;">Password</td>
                <td style="padding: 10px;">
                    <input type="password" name="pw" required 
       				oninvalid="this.setCustomValidity('パスワードを入力してください。')" 
       				oninput="this.setCustomValidity('')" 
       				style="width: 90%;">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" style="padding: 15px;">
                    <input type="submit" value="ログイン" style="padding: 10px 20px; background: #333; 
                    color: white; border: none; cursor: pointer; margin-right: 10px;">
                <button type="button" onclick="location.href='join.jsp'" 
                style="padding: 10px 20px; background: orange; color: white; border: none; cursor: pointer;">新規会員登録</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>