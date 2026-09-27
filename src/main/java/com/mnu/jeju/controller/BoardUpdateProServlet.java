package com.mnu.jeju.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.mnu.jeju.model.BoardDAO;
import com.mnu.jeju.model.BoardDTO;

@WebServlet("/boardUpdatePro.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class BoardUpdateProServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        int num = Integer.parseInt(request.getParameter("num"));
        String pw = request.getParameter("pw");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        BoardDAO dao = new BoardDAO();

        // 1. 비밀번호 일치 여부 확인
        if (!dao.checkPassword(num, pw)) {
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('비밀번호가 일치하지 않습니다.');");
            out.println("history.back();");
            out.println("</script>");
            return;
        }

        // 2. 신규 첨부파일 처리
        Part part = request.getPart("file");
        String fileName = getFileName(part);

        BoardDTO dto = new BoardDTO();
        dto.setNum(num);
        dto.setTitle(title);
        dto.setContent(content);

        if (fileName != null && !fileName.trim().isEmpty()) {
            String uploadPath = getServletContext().getRealPath("/upload");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            part.write(uploadPath + File.separator + fileName);
            dto.setFilename(fileName); // 새 파일이 있는 경우 파일명 업데이트
        }

        // 3. DB 업데이트 수행
        dao.updateBoard(dto);

        // 4. 수정 완료 후 해당 게시글 상세보기 페이지로 이동
        response.sendRedirect("boardDetail.do?num=" + num);
    }

    private String getFileName(Part part) {
        if (part == null) return "";
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}