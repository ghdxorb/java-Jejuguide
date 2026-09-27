package com.mnu.jeju.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout.do")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doProcess(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doProcess(request, response);
    }

    private void doProcess(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");

        // 1. 현재 세션 가져오기 (없으면 null 반환)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 2. 세션 완전 삭제 (로그인 정보 포함 모든 속성 제거)
            session.invalidate();
        }

        // 3. 로그아웃 완료 알림 및 메인 페이지 이동
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('로그아웃되었습니다.');");
        out.println("location.href='index.jsp';");
        out.println("</script>");
        out.close();
    }
}