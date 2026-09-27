package com.mnu.jeju.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {

    // 오라클 DB 접속 정보 (BoardDAO와 동일 설정)
    private final String driver = "oracle.jdbc.driver.OracleDriver";
    private final String url = "jdbc:oracle:thin:@localhost:41521:xe";
    private final String uid = "jeju_project";
    private final String upw = "1234";

    // DB 연결 메서드
    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, uid, upw);
        } catch (Exception e) {
            System.err.println("[MemberDAO DB 연결 실패] " + e.getMessage());
        }
        return conn;
    }

    // DB 자원 해제 메서드
    public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 1. 회원가입 (C)
    public int insertMember(MemberDTO dto) {
        int result = 0;
        Connection conn = getConnection();
        if (conn == null) return 0;

        PreparedStatement pstmt = null;
        String sql = "INSERT INTO member (id, pw, name, email, regdate) VALUES (?, ?, ?, ?, SYSDATE)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPw());
            pstmt.setString(3, dto.getName());
            pstmt.setString(4, dto.getEmail());

            result = pstmt.executeUpdate(); // 성공 시 1 리턴
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
        return result;
    }

    // 2. 아이디 중복 체크
    public boolean checkId(String id) {
        boolean isExist = false;
        Connection conn = getConnection();
        if (conn == null) return false;

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT id FROM member WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                isExist = true; // 아이디가 이미 존재함
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return isExist;
    }

    // 3. 로그인 체크
    public MemberDTO userCheck(String id, String pw) {
        MemberDTO dto = null;
        Connection conn = getConnection();
        if (conn == null) return null;

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM member WHERE id = ? AND pw = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new MemberDTO();
                dto.setId(rs.getString("id"));
                dto.setName(rs.getString("name"));
                dto.setEmail(rs.getString("email"));
                dto.setRegdate(rs.getString("regdate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return dto;
    }
}