package com.mnu.jeju.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {



    // DB 연결 메서드 (null 방어 로직 추가)
    public Connection getConnection() {
        Connection conn = null;
		String myDriver="oracle.jdbc.OracleDriver";
		String myURL="jdbc:oracle:thin:@localhost:41521:xe";
		String myID="jeju_user";
		String myPass="1234";
        try {
            Class.forName(myDriver);
            conn = DriverManager.getConnection(myURL, myID, myPass);
        } catch (Exception e) {
            System.err.println("--------------------------------------------------");
            System.err.println("[DB 연결 실패] 아이디, 비밀번호, 포트 번호를 확인하세요!");
            System.err.println("오류 메시지: " + e.getMessage());
            System.err.println("--------------------------------------------------");
        }
        return conn;
    }

    // DB 자원 해제 공통 메서드
    public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 1. 전체 게시글 목록 조회 (R)
    public List<BoardDTO> getBoardList() {
        List<BoardDTO> list = new ArrayList<>();
        Connection conn = getConnection();
        if (conn == null) return list; // DB 연결 실패 시 바로 빈 리스트 반환

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM board ORDER BY num DESC";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setWriter(rs.getString("writer"));
                dto.setPw(rs.getString("pw"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setReadcount(rs.getInt("readcount"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return list;
    }

    // 2. 게시글 작성 (C)
    public int insertBoard(BoardDTO dto) {
        int result = 0;
        Connection conn = getConnection();
        if (conn == null) return 0; // DB 연결 실패 시 바로 반환

        PreparedStatement pstmt = null;
        String sql = "INSERT INTO board (num, writer, pw, title, content, regdate, readcount) "
                   + "VALUES (board_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, 0)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getWriter());
            pstmt.setString(2, dto.getPw());
            pstmt.setString(3, dto.getTitle());
            pstmt.setString(4, dto.getContent());

            result = pstmt.executeUpdate(); 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
        return result;
    }

    // 3. 게시글 상세 보기 (R)
    public BoardDTO getBoard(int num) {
        BoardDTO dto = null;
        Connection conn = getConnection();
        if (conn == null) return null;

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM board WHERE num = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setWriter(rs.getString("writer"));
                dto.setPw(rs.getString("pw"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setReadcount(rs.getInt("readcount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return dto;
    }

    // 4. 조회수 1 증가
    public void updateReadcount(int num) {
        Connection conn = getConnection();
        if (conn == null) return;

        PreparedStatement pstmt = null;
        String sql = "UPDATE board SET readcount = readcount + 1 WHERE num = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
    }

    // 5. 게시글 수정 (U)
    public int updateBoard(BoardDTO dto) {
        int result = 0;
        Connection conn = getConnection();
        if (conn == null) return 0;

        PreparedStatement pstmt = null;
        String sql = "UPDATE board SET title = ?, content = ? WHERE num = ? AND pw = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getNum());
            pstmt.setString(4, dto.getPw());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
        return result;
    }

    // 6. 게시글 삭제 (D)
    public int deleteBoard(int num, String pw) {
        int result = 0;
        Connection conn = getConnection();
        if (conn == null) return 0;

        PreparedStatement pstmt = null;
        String sql = "DELETE FROM board WHERE num = ? AND pw = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.setString(2, pw);

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
        return result;
    }

    // 7. 검색 조건에 맞는 전체 게시글 수 구하기
    public int getBoardCount(String searchType, String keyword) {
        int count = 0;
        Connection conn = getConnection();
        if (conn == null) return 0;

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT COUNT(*) FROM board";
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " WHERE " + searchType + " LIKE ?";
        }

        try {
            pstmt = conn.prepareStatement(sql);
            if (keyword != null && !keyword.trim().isEmpty()) {
                pstmt.setString(1, "%" + keyword + "%");
            }
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return count;
    }

    // 8. 페이징 및 검색 조건이 적용된 게시글 목록 가져오기
    public List<BoardDTO> getBoardList(int startRow, int endRow, String searchType, String keyword) {
        List<BoardDTO> list = new ArrayList<>();
        Connection conn = getConnection();
        if (conn == null) return list;

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM ( ");
        sql.append("    SELECT ROWNUM rnum, A.* FROM ( ");
        sql.append("        SELECT * FROM board ");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("        WHERE ").append(searchType).append(" LIKE ? ");
        }
        
        sql.append("        ORDER BY num DESC ");
        sql.append("    ) A WHERE ROWNUM <= ? ");
        sql.append(") WHERE rnum >= ?");

        try {
            pstmt = conn.prepareStatement(sql.toString());
            
            int paramIdx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                pstmt.setString(paramIdx++, "%" + keyword + "%");
            }
            pstmt.setInt(paramIdx++, endRow);
            pstmt.setInt(paramIdx++, startRow);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setWriter(rs.getString("writer"));
                dto.setPw(rs.getString("pw"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setReadcount(rs.getInt("readcount"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return list;
    }

    // 9. 비밀번호 확인
    public boolean checkPassword(int num, String pw) {
        boolean isCheck = false;
        Connection conn = getConnection();
        if (conn == null) return false;

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT pw FROM board WHERE num = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (rs.getString("pw").equals(pw)) {
                    isCheck = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return isCheck;
    }

    // 10. 게시글 수정 (파일 첨부 지원)
    public void updateBoard1(BoardDTO dto) {
        Connection conn = getConnection();
        if (conn == null) return;

        PreparedStatement pstmt = null;
        String sql = "";
        if (dto.getFilename() != null && !dto.getFilename().isEmpty()) {
            sql = "UPDATE board SET title=?, content=?, filename=? WHERE num=?";
        } else {
            sql = "UPDATE board SET title=?, content=? WHERE num=?";
        }

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());

            if (dto.getFilename() != null && !dto.getFilename().isEmpty()) {
                pstmt.setString(3, dto.getFilename());
                pstmt.setInt(4, dto.getNum());
            } else {
                pstmt.setInt(3, dto.getNum());
            }

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
    }

    // 11. 게시글 삭제
    public void deleteBoard(int num) {
        Connection conn = getConnection();
        if (conn == null) return;

        PreparedStatement pstmt = null;
        String sql = "DELETE FROM board WHERE num = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
    }
}