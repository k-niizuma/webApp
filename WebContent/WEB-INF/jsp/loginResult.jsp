<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User"%>
<%
	// セッションスコープからユーザー情報を取得
	User loginUser = (User) session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>どこつぶ</title>
<link href="css/login.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/nextPage.js"></script>
</head>
</head>
<body>
	<div class="parent">
		<div class="result-title">つぶやきアプリログイン</div>
	</div><br>

	<form class="form-container" method="post">
		<p class="form-text">ログインに成功しました<br>
			ようこそ　<%=loginUser.getName()%>　さん
		</p>

		<div class="submit-container">
			<button class="submit-button" type="button"
				onclick="nextPege('/webSample/Main')">つぶやき投稿・閲覧へ</button>
			<button class="submit-button" type="button"
				onclick="nextPege('/webSample/Logout')">ログアウト</button>
		</div>
	</form>

</body>
</html>