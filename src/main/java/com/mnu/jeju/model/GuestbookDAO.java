package com.mnu.jeju.model;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.mnu.jeju.util.DBManager;

public class GuestbookDAO {
    // 1. 방명록 등록 메서드 (INSERT)
    public void insertGuestbook(GuestbookDTO dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
       
        String sql = "INSERT INTO board (num, writer, pw, title, content, regdate, readcount) \"\r\n"
        		+ "                   + \"VALUES (board_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, 0)";
        
        try {
            conn = DBManager.getConnection(); 
            pstmt = conn.prepareStatement(sql);
            
            
            pstmt.setString(1, dto.getAuthor());
            pstmt.setString(2, dto.getContent());
            
            pstmt.executeUpdate(); 
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
          
        }
    }
}