package com.xawl.Users.servlet;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;

import Util.Md5Util;
import cn.itcast.servlet.BaseServlet;

import com.xawl.Users.domain.Users;
import com.xawl.Users.service.UserService;

/*
 * 业务层
 */
public class UserServlet extends BaseServlet {
	private UserService service=new UserService();
	
	//登陆功能
	public String Login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取参数
		String uid=request.getParameter("uid");
		String password=Md5Util.createMd5(request.getParameter("password"));
		Users user=service.login(uid, password);
		String yzm=request.getParameter("code");
		if(user!=null){   //进到这里说明不是管理员就是超级管理员
			if(user.getIsSuper()==1){
				request.getSession().setAttribute("msg", "欢迎管理员");
				request.getSession().setAttribute("user", user);
				return "r:/manager/main.jsp";
			}
				request.getSession().setAttribute("msg", "欢迎超级管理员");
				request.getSession().setAttribute("user", user);
				return "r:/manager/main.jsp"; 			
	}else{           //进到这里说明用户名或者密码错误
		request.setAttribute("msg", "对不起，您的密码或者用户名错误");
		return "f:/manager/admin/Login.jsp";
	}
}
	public String Add(HttpServletRequest request, HttpServletResponse response) {  //添加管理员
		
		//得到管理员的信息 
		Users user=new Users();
		user.setuId(request.getParameter("uid"));
		SimpleDateFormat data=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String data2=data.format(new Date()).toString();
		
		user.setuTime(data2);
		user.setuName(request.getParameter("uname"));
		user.setuPassword(Md5Util.createMd5((request.getParameter("upassword"))));
		user.setIsSuper(1);  //超级管理员只能创建普通管理员
		service.add(user);
		request.getSession().setAttribute("msg", "添加成功！");
		return "r:/UserServlet?method=Delete";
	}
	public String  Delete(HttpServletRequest request, HttpServletResponse response){
		//首先要显示所有的管理员  包括超级管理员和 普通管理员 返回给Delete.jsp
			Users u=(Users)request.getSession().getAttribute("user");  //先取出来，判断一下是否是超级管理员
			if(u.getIsSuper()==2){
				List<Users> userlist=service.findAll();
				for(int i=0;i<userlist.size();i++	){
					if(userlist.get(i).getuId()==u.getuId()){
						userlist.remove(i);
					}
					}
				request.setAttribute("userlist", userlist);
				request.setAttribute("root", "2");
				return "f:/manager/admin/Delete.jsp";
			}else{
				request.setAttribute("root", "1");
				return "f:/manager/admin/Delete.jsp";
			}
			
			
	}
	public String ajaxRemode(HttpServletRequest request, HttpServletResponse response)  //获取UID 删除指定的管理员
			throws ServletException, IOException {
		String uid=request.getParameter("uId");
		service.remove(uid);
		response.getWriter().print("删除成功");
		return null;
	}
	//UID验证
	public String ajaxUid(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String uid=request.getParameter("uid");
		Boolean bool=service.ajaxFindById(uid);
		response.getWriter().print(bool);	
	   return null;
	}
	//验证码验证
	
	public String ajaxYzm(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String yzm=request.getParameter("code");
		String code=(String) request.getSession().getAttribute("vCode");
		Boolean b=code.equalsIgnoreCase(yzm);
	
		response.getWriter().print(b);
		return null;
	}

	public String Modify(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			//1 先判断旧密码是否正确
	
		String OldPassword=Md5Util.createMd5(request.getParameter("old")); //获取旧密码
		String NewPassword=Md5Util.createMd5(request.getParameter("new1"));
		String uid=((Users)request.getSession().getAttribute("user")).getuId();
		String findPassword=service.findpassword(uid);
		if(OldPassword.equals(findPassword)){
			service.modify(NewPassword, uid);
			request.getSession().setAttribute("msg", "恭喜您修改成功");
			return "f:/manager/right.jsp";
		}else{
			request.getSession().setAttribute("msg1", "对不起，您的旧密码错误，请重新输入");
			return "f:/manager/admin/change.jsp";
		}
	}
	

	public String exit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			request.getSession().removeAttribute("user");
			return "r:/manager/admin/Login.jsp";
	}
	public String ajaxPassword(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String password=Md5Util.createMd5(request.getParameter("password"));
		Users u=(Users) request.getSession().getAttribute("user");
		Boolean b=service.ajaxFindByPassword(u.getuId(), password);
		response.getWriter().print(b);
		return null;
	}
	
	//检测是否登录
	public String isLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			if(request.getSession().getAttribute("user")!=null){
				return "f:/manager/main.jsp";
			}else{
				return "r:/manager/admin/Login.jsp";
			}
	}
}
