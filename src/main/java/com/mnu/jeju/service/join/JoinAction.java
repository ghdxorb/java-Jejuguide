package com.mnu.jeju.service.join;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mnu.jeju.model.MemberDTO;
import com.mnu.jeju.service.Action;

public class JoinAction implements Action {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("userid");
		String pw = request.getParameter("passwd");
		String name = request.getParameter("name");
		
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		String email = "";
		if(email1 != null && email2 != null && !email.isEmpty()) {
			email = email1 + "@" + email2;
		}
		
		MemberDTO mDTO = new MemberDTO();
		mDTO.setId(id);
		mDTO.setPw(pw);
		mDTO.setName(name);
		mDTO.setEmail(email);
		
		System.out.println("ID : " + mDTO.getId());
		System.out.println("PW : " + mDTO.getPw());
		System.out.println("이름 : " + mDTO.getName());
		System.out.println("이메일 : " + mDTO.getEmail());
		
		//MemberDAO mDAO = new MemberDAO;
		//int result = mDAO.insertMember(member);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('会員登録が完了しました！');");
		out.println("location.href='login.jsp';");
		out.println("</script>");
		out.close();
		return "boardList.do";
	}

}
