package com.xawl.link.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.xawl.classify.domain.Classify;
import com.xawl.classify.service.ClassifyService;
import com.xawl.link.domain.Link;
import com.xawl.link.service.LinkService;
import com.xawl.news.domain.News;
import com.xawl.news.domain.PageBean;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class LinkServlet extends BaseServlet {
	private LinkService linkService = new LinkService();
	private ClassifyService service = new ClassifyService();

	// 获取pageCode 当前页数
	private int getPC(HttpServletRequest request) {
		String pc = request.getParameter("pc");
		if (pc == null || pc.trim().isEmpty()) {
			return 1;
		}
		return Integer.parseInt(pc);
	}

	// 截取URL
	private String getUrl(HttpServletRequest request) {
		String contextPath = request.getContextPath();// 获取项目名
		String servletPath = request.getServletPath();// 获取servletPath
		String queryString = request.getQueryString();// 获取问号之后的参数部份

		// 判断参数部份中是否包含pc这个参数，如果包含，需要截取下去，不要这一部份。
		if (queryString.contains("&pc=")) {
			int index = queryString.lastIndexOf("&pc=");
			queryString = queryString.substring(0, index);
		}

		return contextPath + servletPath + "?" + queryString;
	}

	// 查找所有链接
	public String findLink(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String mark = request.getParameter("mark");
		int pc = getPC(request);
		int ps = 10;
		PageBean<Link> pb = linkService.findLink(pc, ps, mark);
		pb.setUrl(getUrl(request));
		request.setAttribute("pb", pb);
		return "f:/manager/link/linkList.jsp";
	}

	// 添加链接
	public String addLink(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Link link = CommonUtils.toBean(request.getParameterMap(), Link.class);
		link.setiId(CommonUtils.uuid());
		link.setIsImage("2");
		link.setiLocation("0");
		linkService.addLink(link);
		request.setAttribute("msg1", "添加新连接成功！");
		return findLink(request, response);
	}

	// 按iId查找单条链接
	public String findLinkByiId(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String iId = request.getParameter("iId");
		Link link = linkService.findLinkByiId(iId);
		request.setAttribute("list", link);
		return "f:/manager/link/editLink.jsp";
	}

	// 编辑
	public String editLink(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String iId = request.getParameter("iId");
		Link link = linkService.findLinkByiId(iId);
		String iName = request.getParameter("iName");
		String iValue = request.getParameter("iValue");
		link.setiName(iName);
		link.setiValue(iValue);
		linkService.editLink(link);
		request.setAttribute("msg1", "编辑成功！");
		return findLink(request, response);
	}

	// 删除
	public String deleteLink(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int n = JOptionPane.showConfirmDialog(null, "确认删除吗?", "确认删除框",
				JOptionPane.YES_NO_OPTION);
		if (n == JOptionPane.YES_OPTION) {
			String iId = request.getParameter("iId");
			linkService.deletLink(iId);
			request.setAttribute("msg1", "删除成功！");
			return findLink(request, response);
		} else{
			return findLink(request, response);
		}
	}

}
