package com.mnu.jeju.service.food;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.service.Action;

public class FoodAction implements Action {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("로컬 맛집 페이지로 이동");

		RequestDispatcher rd = request.getRequestDispatcher("food.do");
		rd.forward(request, response);
		return "boardList.do";
	}

}
