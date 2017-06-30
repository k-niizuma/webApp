<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="servlet.Login"%>
<%
	String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>つぶやきアプリ</title>
<link href="css/login.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div class="parent">
		<div class="title">
			<img src="image/dokotubu.png">
		</div>
	</div>

	<form class="form-container" action="/webSample/Login" method="post">

		<div class="form-title">
			<h2>Login</h2>
		</div>

		<div class="form-title">ユーザー名</div>
		<input class="form-field" type="text" name="name"><br>
		<div class="form-title">パスワード</div>
		<input class="form-field" type="text" name="pass"><br> <br>


		<span class="error"> <%if (error != null) { %> <%=error%> <% } %>
		</span>

		<div class="submit-container">
			<input class="submit-button" type="submit" value="ログイン"> <br>
			<br>
		</div>
	</form>


</body>
</html>