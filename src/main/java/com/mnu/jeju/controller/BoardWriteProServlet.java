package com.mnu.jeju.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.mnu.jeju.model.BoardDAO;
import com.mnu.jeju.model.BoardDTO;

@WebServlet("/boardWritePro.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 개별 파일 최대 10MB
    maxRequestSize = 1024 * 1024 * 50    // 총 요청 최대 50MB
)
public class BoardWriteProServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String writer = request.getParameter("writer");
        String pw = request.getParameter("pw");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // 파일 업로드 처리
        Part part = request.getPart("file");
        String fileName = getFileName(part);

        if (fileName != null && !fileName.trim().isEmpty()) {
            // 서버 내 upload 폴더 실제 경로 가져오기
            String uploadPath = getServletContext().getRealPath("/upload");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            // 파일 디스크에 저장
            part.write(uploadPath + File.separator + fileName);
        }

        BoardDTO dto = new BoardDTO();
        dto.setWriter(writer);
        dto.setPw(pw);
        dto.setTitle(title);
        dto.setContent(content);
        dto.setFilename(fileName); // DTO에 파일명 세팅

        BoardDAO dao = new BoardDAO();
        dao.insertBoard(dto);

        response.sendRedirect("boardList.do");
    }

    // Part의 헤더 정보에서 원본 파일명을 추출하는 유틸 메서드
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}