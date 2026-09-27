package com.mnu.jeju.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.model.BoardDAO;
import com.mnu.jeju.model.BoardDTO;

@WebServlet("/boardUpdateForm.do")
public class BoardUpdateFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String numStr = request.getParameter("num");

        // 1. 파라미터 검증 (null 체크)
        if (numStr == null || numStr.trim().isEmpty()) {
            response.sendRedirect("boardList.do");
            return;
        }

        try {
            int num = Integer.parseInt(numStr);

            // 2. DB에서 수정할 게시글 조회
            BoardDAO dao = new BoardDAO();
            BoardDTO board = dao.getBoard(num); // 게시글 상세 조회 메서드

            if (board != null) {
                // 3. request에 board 객체 바인딩 후 JSP 포워딩
                request.setAttribute("board", board);
                request.getRequestDispatcher("boardUpdate.jsp").forward(request, response);
            } else {
                // 글이 존재하지 않는 경우 목록으로 이동
                response.sendRedirect("boardList.do");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("boardList.do");
        }
    }
}