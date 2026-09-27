package com.mnu.jeju.service.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.service.Action;
import com.mnu.jeju.model.BoardDAO;
import com.mnu.jeju.model.BoardDTO;

public class BoardListAction implements Action {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. 창고지기(DAO)를 불러서 전체 글 목록(List)을 요청
        BoardDAO dao = new BoardDAO();
        List<BoardDTO> boardList = dao.getBoardList();
        
        // 2. 화면(JSP)에서 이 데이터를 쓸 수 있도록 request 객체에 찰찰(저장)
        request.setAttribute("boardList", boardList);
        
        // 3. 데이터가 담긴 바구니를 들고 boardList.jsp 화면으로 이동
        RequestDispatcher dispatcher = request.getRequestDispatcher("boardList.jsp");
        dispatcher.forward(request, response);
        List<BoardDTO> list = dao.getBoardList();

        // 데이터 개수 확인용 출력문 추가
        System.out.println("DB에서 가져온 글 개수: " + list.size());
     
        request.setAttribute("boardList", list);
		return "boardList.jsp";
    }
}