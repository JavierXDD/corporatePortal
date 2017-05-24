
package com.xawl.classify.servlet;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

import com.xawl.classify.domain.Classify;
import com.xawl.classify.service.ClassifyService;

public class ClassifyServlet extends BaseServlet {
	private ClassifyService service=new ClassifyService();
	
	public String findByParent(HttpServletRequest request, HttpServletResponse response) //查找一级菜单
			throws ServletException, IOException {
			List<Classify> parents=service.findByParent();
			request.setAttribute("parents", parents);
			String url=request.getParameter("return");
		
			return "f:/"+url;
	}

/*	public String findBy1(HttpServletRequest request, HttpServletResponse response) //查找2级菜单
			throws ServletException, IOException {
			String cid=request.getParameter("cid");
			request.setAttribute("twolist", service.findBy2(cid));
			return "f:/manager/news/newType.jsp";
	}*/
	
	/*public String findByn(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			String cid=request.getParameter("cid");
			request.setAttribute("twolist", service.findBy2(cid));
			Classify c= service.findByCid(cid);
			return "f:"+c.getcAddr();
	}*/
	public String findBy1(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			String cid=request.getParameter("cid");
			request.setAttribute("twolist", service.findBy2(cid));
			Classify c= service.findByCid(cid);
			return "f:/manager/news/newType.jsp";
	}
	public String findBy2(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			String cid=request.getParameter("cid");
			request.setAttribute("twolist", service.findBy2(cid));
			Classify c= service.findByCid(cid);
			return "f:/manager/products/productsType.jsp";
	}
	public String findBy3(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			String cid=request.getParameter("cid");
			request.setAttribute("twolist", service.findBy2(cid));
			Classify c= service.findByCid(cid);
			return "f:/manager/link/linkType.jsp";
	}
	public String findBy4(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			String cid=request.getParameter("cid");
			request.setAttribute("twolist", service.findBy2(cid));
			Classify c= service.findByCid(cid);
			return "f:/manager/about/aboutType.jsp";
	}
//ajax取二级菜单下拉
	public String ajaxfindByCid(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid=request.getParameter("cid");
		String json=service.ajaxfindByCids(cid);
		response.getWriter().print(json);
	
		return null;
	}
	//ajax修改一级菜单的name  desc属性
	public String ajaxEditFirstMenu(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid=request.getParameter("cid");
		String name=request.getParameter("cName");
		String desc=request.getParameter("cDesc");
		
		String json=service.ajaxeditFirstMenu(name, desc, cid).toString();
		response.getWriter().print(json);

		return null;
	}
	//返回二级菜单用于编辑修改 
	public String findBytwoMenuList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid=request.getParameter("cid");
		List<Classify> list=service.findBy2(cid);
		request.setAttribute("twoclassifylist", list);
		System.out.print(list.size());
		return "f:/manager/menu/twoMenuList.jsp";
	}
	//ajax修改二级菜单的信息
	public String ajaxEditTwoMenu(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid=request.getParameter("cid");
		String name=request.getParameter("cName");
		String desc=request.getParameter("cDesc");
		String caddr=request.getParameter("cAddr");
		String pid=request.getParameter("pId");
		String json=service.ajaxeditTwoMenu(name,desc,pid,cid).toString();
		response.getWriter().print(json);

		return null;
	}
	//ajax返回一级菜单的下拉框
	public String ajaxfindone(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String json=service.ajaxfindone();
		response.getWriter().print(json);
		return null;
	}
	//删除二级菜单
	public String ajaxRemoveMenu(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid=request.getParameter("cid");
		String json=service.ajaxremoveMenu(cid).toString();
		response.getWriter().print(json);
		return null;
	}
	public String addTowMenu(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			Classify c=CommonUtils.toBean(request.getParameterMap(),Classify.class);
			c.setcId(CommonUtils.uuid());
			Classify n=new Classify();
			
			n.setcId(request.getParameter("nType"));
			if(request.getParameter("nType").equals("2")){
				c.setcAddr("findP");
			}
			if(request.getParameter("nType").equals("1")){
				c.setcAddr("findNews");
			}
			
			c.setParents(n);
			c.setIsUse(0);
			service.addTwoMenu(c);
			request.setAttribute("msg", "添加成功！");
		return "/manager/menu/msg.jsp";
	}
	
	
	
}
