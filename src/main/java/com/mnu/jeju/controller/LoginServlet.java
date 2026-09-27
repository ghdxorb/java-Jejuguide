package com.mnu.jeju.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mnu.jeju.model.MemberDAO;
import com.mnu.jeju.model.MemberDTO;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// GET 요청 시 로그인 페이지(login.jsp)로 이동
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		// MemberDAO 연결 및 사용자 검증
		MemberDAO dao = new MemberDAO();
		MemberDTO user = dao.userCheck(id, pw);

		if (user != null) {
			// 로그인 성공 시 세션 저장 후 메인 페이지 이동
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", user);
			session.setAttribute("userId", user.getId());
			
			response.sendRedirect("index.jsp");
		} else {
			// 로그인 실패 시 알림창 후 로그인 페이지로 이동
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디 또는 비밀번호가 일치하지 않거나 존재하지 않는 회원입니다.');");
			out.println("location.href='login.jsp';");
			out.println("</script>");
			out.close();
		}
	}
}