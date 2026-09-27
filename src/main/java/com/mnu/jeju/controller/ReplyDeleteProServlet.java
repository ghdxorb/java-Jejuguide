package com.mnu.jeju.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.model.ReplyDAO;

@WebServlet("/replyDeletePro.do")
public class ReplyDeleteProServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. 파라미터 수신 (삭제할 댓글 번호 rno, 돌아갈 게시글 번호 bno)
        String rnoParam = request.getParameter("rno");
        String bnoParam = request.getParameter("bno");

        if (rnoParam != null && bnoParam != null) {
            int rno = Integer.parseInt(rnoParam);
            int bno = Integer.parseInt(bnoParam);

            // 2. ReplyDAO를 통한 댓글 삭제 수행
            ReplyDAO dao = new ReplyDAO();
            dao.deleteReply(rno);

            // 3. 삭제 완료 후 기존 상세 페이지로 이동
            response.sendRedirect("boardDetail.do?num=" + bno);
        } else {
            response.sendRedirect("boardList.do");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}