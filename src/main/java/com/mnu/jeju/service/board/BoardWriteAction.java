package com.mnu.jeju.service.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mnu.jeju.model.BoardDAO;
import com.mnu.jeju.model.BoardDTO;
import com.mnu.jeju.model.MemberDTO;
import com.mnu.jeju.service.Action;

public class BoardWriteAction implements Action {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 1. 세션에서 로그인 회원 정보 확인
        HttpSession session = request.getSession();
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        // 2. 화면(boardWrite.jsp)에서 넘어온 입력값 받기
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String pw = request.getParameter("pw");
        String writer = request.getParameter("writer");

        // 3. DTO 객체 생성 (변수명을 board로 통일)
        BoardDTO board = new BoardDTO();
        board.setTitle(title);
        board.setContent(content);
        board.setPw(pw);

        // 4. 회원 / 비회원에 따라 작성자 이름 세팅
        if (loginUser != null) {
            // 로그인한 회원인 경우: 세션에 저장된 회원 이름 사용
            board.setWriter(loginUser.getName());
        } else {
            // 비회원인 경우: 폼에서 직접 입력한 작성자 닉네임 사용
            board.setWriter(writer);
        }

        // 5. DB에 저장
        BoardDAO dao = new BoardDAO();
        dao.insertBoard(board);

        // 6. 일본어 알림창 출력 후 목록 페이지로 이동
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('投稿が完了しました！');");
        out.println("location.href='boardList.do';");
        out.println("</script>");
        out.close();

        return null;
    }
}