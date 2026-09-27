package com.mnu.jeju.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.model.BoardDAO;
import com.mnu.jeju.model.BoardDTO;
import com.mnu.jeju.model.ReplyDAO;
import com.mnu.jeju.model.ReplyDTO;

@WebServlet("/boardDetail.do")
public class BoardDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. 게시글 번호(num) 파라미터 수신
        String numParam = request.getParameter("num");

        if (numParam == null || numParam.trim().isEmpty()) {
            response.sendRedirect("boardList.do");
            return;
        }

        int num = Integer.parseInt(numParam);

        // 2. 게시글 조회수 증가 및 상세 내용 조회
        BoardDAO boardDao = new BoardDAO();
        boardDao.updateReadcount(num); // 조회수 +1
        BoardDTO board = boardDao.getBoard(num); // 게시글 DTO 수신

        // 3. 해당 게시글(bno = num)에 달린 댓글 목록 조회
        ReplyDAO replyDao = new ReplyDAO();
        List<ReplyDTO> replyList = replyDao.getReplyList(num);

        // 4. JSP 전달을 위해 request 객체에 저장
        request.setAttribute("board", board);
        request.setAttribute("replyList", replyList);

        // 5. boardDetail.jsp로 포워딩
        request.getRequestDispatcher("boardDetail.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}