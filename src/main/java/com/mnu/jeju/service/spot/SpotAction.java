package com.mnu.jeju.service.spot;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.service.Action;

public class SpotAction implements Action {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 콘솔창 확인용 
        System.out.println("관광 명소 페이지로 이동합니다...");

        // 관광 명소 화면으로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("spot.jsp");
        dispatcher.forward(request, response);
        return "boardList.do";
    }
}