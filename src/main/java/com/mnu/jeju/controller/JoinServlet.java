package com.mnu.jeju.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.model.MemberDAO;
import com.mnu.jeju.model.MemberDTO;

@WebServlet("/join.do")
public class JoinServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET 요청: 회원가입 페이지(join.jsp) 출력
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("join.jsp").forward(request, response);
    }

    // POST 요청: 회원가입 폼 데이터 DB 저장 처리
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 인코딩 설정 (한글 깨짐 방지)
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 2. 폼 파라미터 수신
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        PrintWriter out = response.getWriter();

        // 3. 필수 입력 항목 검증
        if (id == null || id.trim().isEmpty() || 
            pw == null || pw.trim().isEmpty() || 
            name == null || name.trim().isEmpty()) {
            
            out.println("<script>");
            out.println("alert('아이디, 비밀번호, 이름은 필수 입력 항목입니다.');");
            out.println("history.back();");
            out.println("</script>");
            return;
        }

        MemberDAO dao = new MemberDAO();

        // 4. 아이디 중복 체크
        if (dao.checkId(id)) {
            out.println("<script>");
            out.println("alert('이미 사용 중인 아이디입니다.');");
            out.println("history.back();");
            out.println("</script>");
            return;
        }

        // 5. DTO 객체 생성 후 DB 저장
        MemberDTO dto = new MemberDTO(id, pw, name, email);
        int result = dao.insertMember(dto);

        // 6. 결과 응답 처리
        if (result > 0) {
            out.println("<script>");
            out.println("alert('회원가입이 성공적으로 완료되었습니다.');");
            out.println("location.href='login.jsp';"); // 성공 시 로그인 페이지로 이동
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('회원가입 처리 중 오류가 발생했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    }
}