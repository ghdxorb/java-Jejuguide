package com.mnu.jeju.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.model.BoardDAO;

@WebServlet("/boardDeletePro.do")
public class BoardDeleteProServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        int num = Integer.parseInt(request.getParameter("num"));
        String pw = request.getParameter("pw");

        BoardDAO dao = new BoardDAO();

        // 비밀번호 확인
        if (pw != null && !pw.trim().isEmpty()) {
            if (!dao.checkPassword(num, pw)) {
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("alert('비밀번호가 일치하지 않습니다.');");
                out.println("history.back();");
                out.println("</script>");
                return;
            }
        }

        // 게시글 삭제
        dao.deleteBoard(num);

        // 삭제 후 목록으로 이동
        response.sendRedirect("boardList.do");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}