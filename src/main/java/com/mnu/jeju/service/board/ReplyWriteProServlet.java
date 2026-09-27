package com.mnu.jeju.service.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.model.ReplyDAO;

/**
 * Servlet implementation class ReplyWriteProServlet
 */
@WebServlet("/replyWritePro.do")
public class ReplyWriteProServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int bno = Integer.parseInt(request.getParameter("bno"));
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");

        // ReplyDAO를 통해 DB에 INSERT
        ReplyDAO dao = new ReplyDAO();
        dao.insertReply(bno, writer, content);

        // 등록 완료 후 현재 보고 있던 게시글 상세 페이지로 돌아가기
        response.sendRedirect("boardDetail.do?num=" + bno);
    }
}