package com.xawl.Users.servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xawl.Users.domain.Users;

public class Filters implements Filter{

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest)arg0;
		HttpServletResponse response=(HttpServletResponse)arg1;
		Users admin=(Users)request.getSession().getAttribute("user");
		if(admin!=null){
			arg2.doFilter(arg0, arg1);
	
			return;
		}else{
			//request.setAttribute("msg", "对不起，您未登陆，请先登陆！");
		//	request.getRequestDispatcher("/manager/admin/Login.jsp").forward(arg0, arg1);
			String CONTENT_TYPE = "text/html; charset=utf-8";
			 response.setContentType(CONTENT_TYPE);
			 
		    java.io.PrintWriter out = response.getWriter();  
		  
		   out.println("<html>");  
		    out.println("<script>alert('您没有登录，请先登陆!');");  
		    out.println("window.open ('/LiTian/manager/admin/Login.jsp','_parent');");   
		    out.println("</script>");  
	    out.println("</html>"); 
		//	response.sendRedirect("/manager/admin/Login.jsp");   
		    
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}


	

}
