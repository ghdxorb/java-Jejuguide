package com.mnu.jeju.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReplyDAO {

    // DB 연결 메서드 
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/oracle"); 
        return ds.getConnection();
    }

    // 자원 해제 메서드
    private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 1. 댓글 작성
    public void insertReply(int bno, String writer, String content) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO board_reply (rno, bno, writer, content, regdate) VALUES (reply_seq.NEXTVAL, ?, ?, ?, SYSDATE)";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bno);
            pstmt.setString(2, writer);
            pstmt.setString(3, content);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
    }

    // 2. 특정 게시글의 댓글 목록 가져오기
    public List<ReplyDTO> getReplyList(int bno) {
        List<ReplyDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT rno, bno, writer, content, TO_CHAR(regdate, 'YYYY-MM-DD HH24:MI') regdate FROM board_reply WHERE bno = ? ORDER BY rno ASC";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bno);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ReplyDTO dto = new ReplyDTO();
                dto.setRno(rs.getInt("rno"));
                dto.setBno(rs.getInt("bno"));
                dto.setWriter(rs.getString("writer"));
                dto.setContent(rs.getString("content"));
                dto.setRegdate(rs.getString("regdate"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return list;
    }

    // 3. 댓글 삭제
    public void deleteReply(int rno) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM board_reply WHERE rno = ?";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, rno);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
    }
}