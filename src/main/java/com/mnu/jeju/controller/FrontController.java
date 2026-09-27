package com.mnu.jeju.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 방금 만든 Action 지침서와 FoodAction 셰프를 불러와야 해!
import com.mnu.jeju.service.Action;
import com.mnu.jeju.service.board.BoardListAction;
import com.mnu.jeju.service.board.BoardWriteAction;
import com.mnu.jeju.service.food.FoodAction;
import com.mnu.jeju.service.join.JoinAction;
import com.mnu.jeju.service.spot.SpotAction;

/**
 * Servlet implementation class FrontController
 */
@WebServlet("*.do") 
public class FrontController extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public FrontController() {
        super();
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // 한글, 일본어 깨짐 방지
        doProcess(request, response);
    }

    private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 한글 깨짐 방지
        request.setCharacterEncoding("UTF-8");
        
        // 1. 주소창에서 핵심 단어만 잘라내기
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String command = requestURI.substring(contextPath.length());
        
        System.out.println("요청받은 주소: " + command);
        
        Action action = null;
        String url = null;
        
        // 2. 주소에 맞는 Action 배정하기
        if (command.equals("/food.do")) {
            action = new FoodAction();
        } else if (command.equals("/spot.do")) {
            action = new SpotAction();
        } else if (command.equals("/memberJoin.do")) {
            action = new JoinAction();
        } else if (command.equals("/boardList.do")) {
            action = new BoardListAction();
        } else if (command.equals("/boardWritePro.do")) {
            action = new BoardWriteAction();
        }
        
        // 3. Action 실행 후 지정된 JSP로 forward 이동
        if (action != null) {
            try {
                // Action 실행 및 이동할 JSP 경로 리턴 받기
                url = action.process(request, response);
                
                // 리턴받은 경로가 있다면 forward 방식으로 이동
                if (url != null) {
                    RequestDispatcher dispatcher = request.getRequestDispatcher(url);
                    dispatcher.forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}