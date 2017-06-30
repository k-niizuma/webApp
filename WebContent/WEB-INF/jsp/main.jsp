<%-- リスト10-17の状態 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User,model.Mutter,java.util.List"%>
<%
	// セッションスコープに保存されたユーザー情報を取得
	User loginUser = (User) session.getAttribute("loginUser");
	// アプリケーションスコープに保存されたつぶやきリストを取得
	@SuppressWarnings("unchecked")
	List<Mutter> mutterList = (List<Mutter>) application.getAttribute("mutterList");
	// リクエストスコープに保存されたエラーメッセージを取得
	String errorMsg = (String) request.getAttribute("errorMsg");
	int year = Integer.parseInt(request.getAttribute("year").toString());
	int month = Integer.parseInt(request.getAttribute("month").toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>つぶやきアプリ</title>
<link href="css/main.css" rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/search.js"></script>
</head>
<body>

	<!--トップのラベル -->
	<div class="top">
		<div class="topImg">
			<div class = "logout"><%=loginUser.getName()%>さん、ログイン中 <a href="/webSample/Logout">ログアウト</a></div>
			<a href="/webSample/Main"><img src="image/eyecatch.png"></a>
		</div>
	</div>

	<!-- カレンダー -->
	<div class="calendar-body">
		<form action="/webSample/Main" method="get">
			<b><%=request.getAttribute("year")%>年<%=request.getAttribute("month")%>月のカレンダー</b>
			<br>
			<%=request.getAttribute("calender")%>
			<br> <select id="year" name="year">
				<%
					for (int i = year - 10; i <= year + 10; i++) {
				%>
				<option value="<%=i%>" <%if (i == year) {%> selected <%}%>><%=i%>年
				</option>
				<%
					}
				%>
			</select> <select id="moneth" name="month">
				<%
					for (int i = 1; i <= 12; i++) {
				%>
				<option value="<%=i%>" <%if (i == month) {%> selected <%}%>><%=i%>月
				</option>
				<%
					}
				%>
			</select> <br> <br> <input class="submit-button" type="submit"
				id="ok" name="ok" value="送信">
		</form>
		<br>
	</div>

	<!-- つぶやき入力フォーム -->
	<div class="main-form">
		<div class="parent">
			<div class="main-title">つぶやきアプリメイン</div>
		</div>
		<br>
		<div class="label">つぶやき</div>
		<form action="/webSample/Main" method="post">
			<textarea class="form-field" rows="150" name="text" wrap="soft"
				onkeyup="ShowLength(value);"></textarea>
			<br>
			<p id="inputlength">0/150</p>
			<input class="submit-button" type="submit" value="つぶやく">
		</form>

		<!-- エラー表記 -->
		<%
			if (errorMsg != null) {
		%>
		<%=errorMsg%>
		<%
			}
		%>
	</div>

	<!-- 検索フォーム -->
	<div class="wrapper">
		<div class="search-area">
			<form>
				<input type="text" id="search-text" placeholder="検索ワードを入力">
			</form>
			<div class="search-result">
				<div class="search-result__hit-num"></div>
				<div id="search-result__list"></div>
			</div>
		</div>

		<!-- つぶやき出力 -->
		<div class="target-area">
			<%
				for (Mutter mutter : mutterList) {
			%>
			<p class="contents"><%=mutter.getUserName()%>：<br><%=mutter.getText().replaceAll("\n", "<br>")%></p>
			<%
				}
			%>
		</div>

	</div>

</body>
</html>