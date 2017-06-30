package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Mutter;
import model.PostMutterLogic;
import model.User;

@WebServlet("/Main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * main画面の初期表示のメソッド
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//つぶやきリストを取得
		ServletContext application = this.getServletContext();
		@SuppressWarnings("unchecked")
		List<Mutter> mutterList = (List<Mutter>) application.getAttribute("mutterList");

		//取得できなかった場合はつぶやきリストを新規作成
		if (mutterList == null) {
			mutterList = new ArrayList<Mutter>();
			application.setAttribute("mutterList", mutterList);
		}

		//Login確認の為、ユーザー情報を取得
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		//ログインしていない場合はリダイレクト。そうでなければ画面遷移
		if (loginUser == null) {
			response.sendRedirect("/docoTsubuSample/");
		} else {
			calendarData(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/main.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * つぶやきの内容とカレンダーを画面に出力するためのメソッド
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String text = request.getParameter("text");

		//つぶやきが入力されていたら、つぶやきリストを取得
		if (text != null && text.length() != 0) {
			ServletContext application = this.getServletContext();
			@SuppressWarnings("unchecked")
			List<Mutter> mutterList =
					(List<Mutter>) application.getAttribute("mutterList");
			//ユーザー情報を取得
			HttpSession session = request.getSession();
			User loginUser = (User) session.getAttribute("loginUser");

			//つぶやきをつぶやきリストに追加
			Mutter mutter = new Mutter(loginUser.getName(), text);
			PostMutterLogic postMutterLogic = new PostMutterLogic();
			postMutterLogic.execute(mutter, mutterList);

			application.setAttribute("mutterList", mutterList);
		} else {
			//つぶやきが入力されてなかったらエラーを返す
			request.setAttribute("errorMsg", "つぶやきが入力されていません");
		}

		//カレンダーのデータを取得
		calendarData(request);

		//mein画面に遷移
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/main.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * カレンダーを作成するメソッド
	 * @param request
	 */
	private void calendarData(HttpServletRequest request) {

		int startDay;
		int lastDay;

		Calendar cal = Calendar.getInstance();

		// 年が設定されていれば、値を取得。そうでなければ、現在の年をいれる。
		if(request.getParameter("year") == null){
			request.setAttribute("year", cal.get(Calendar.YEAR)); //現在の年
		}else{
			request.setAttribute("year", request.getParameter("year"));
		}
		// 月が設定されていれば、値を取得。壮でなければ、現在の月を入れる
		if(request.getParameter("month") == null){
			request.setAttribute("month", cal.get(Calendar.MONTH)+1);
		}else{
			request.setAttribute("month", request.getParameter("month"));
		}

		int year = Integer.parseInt(request.getAttribute("year").toString());
		int month = Integer.parseInt(request.getAttribute("month").toString());

		//月初めの曜日
		cal.set(year, month -1, 1);
		startDay = cal.get(Calendar.DAY_OF_WEEK);
		//月末の日付
		cal.add(Calendar.MONTH, 1);
		cal.add(Calendar.DATE, -1);
		lastDay = cal.get(Calendar.DATE);
		//カレンダーのデータ
		int date = 1;
		int maxDay = 6 * 7;
		StringBuilder sb = new StringBuilder();
		sb.append("<table>");
		sb.append("<tr>");
		sb.append("<th class = \"sunday\">日</th>");
		sb.append("<th>月</th><th>火</th><th>水</th><th>木</th><th>金</th>");
		sb.append("<th th class = \"saturday\">土</th>");
		sb.append("</tr>");
		sb.append("<tr>");
		for(int i = 1; i <= maxDay; i++){
			if(i < startDay || i > lastDay + startDay -1){
				sb.append("<td></td>");
			}else{
				sb.append("<td>" + date + "</td>");
				date++;
			}
			if(i % 7 == 0){
				sb.append("</tr>");
				if(i > startDay + lastDay -1){
					break;
				}
				if(date < lastDay){
					sb.append("<tr>");
				}else{
					//最後だったらループを抜ける
					break;
				}
			}
		}
		sb.append("</table>");
		request.setAttribute("calender", sb);
		return;

	}

}




