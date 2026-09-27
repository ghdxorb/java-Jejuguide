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

@WebServlet("/boardList.do")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 1. 파라미터 수신 (페이지 번호, 검색 조건, 키워드)
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");

		// 칼럼명 이탈 방지 검증 
		if (searchType == null || (!searchType.equals("title") && !searchType.equals("content") && !searchType.equals("writer"))) {
			searchType = "title";
		}
		if (keyword == null) {
			keyword = "";
		}

		// 2. 페이징 계산 변수 설정
		int pageSize = 10; // 한 페이지에 보여줄 글 수
		int pageBlock = 5;  // 하단에 표시할 페이지 번호 개수 (1~5, 6~10)

		int startRow = (page - 1) * pageSize + 1;
		int endRow = page * pageSize;

		// 3. DB 조회
		BoardDAO dao = new BoardDAO();
		int totalCount = dao.getBoardCount(searchType, keyword);
		List<BoardDTO> list = dao.getBoardList(startRow, endRow, searchType, keyword);

		// 4. 페이지 블록 계산
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);
		int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
		int endPage = Math.min(startPage + pageBlock - 1, totalPages);

		// 5. JSP로 값 전달
		request.setAttribute("boardList", list);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("searchType", searchType);
		request.setAttribute("keyword", keyword);

		request.getRequestDispatcher("boardList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}