package com.xawl.news.servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.ImgUtil;
import Util.StringUtil;
import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

import com.xawl.Users.domain.Users;
import com.xawl.classify.domain.Classify;
import com.xawl.classify.service.ClassifyService;
import com.xawl.news.domain.News;
import com.xawl.news.domain.PageBean;
import com.xawl.news.service.NewsService;

public class NewsServlet extends BaseServlet {
	private NewsService newsService = new NewsService();
	private ClassifyService classifyService = new ClassifyService();

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

	public String findByCidNews(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String cid = request.getParameter("cid");
		int pc = getPC(request);
		int ps = 10;
		PageBean<News> pb = newsService.findByCidNew(pc, ps, cid);
		pb.setUrl(getUrl(request));

		request.setAttribute("pb", pb);
		return "f:/manager/news/list.jsp";
	}

	// 返回分类下的所有新闻列表
	/*
	 * public String findByCidNews(HttpServletRequest request,
	 * HttpServletResponse response) throws ServletException, IOException {
	 * String cid = request.getParameter("cid"); List<News> list =
	 * newsService.findByCidNew(cid); request.setAttribute("newslist", list);
	 * return "f:/manager/news/list.jsp"; }
	 */

	public String ajaxDelete(HttpServletRequest request,
			HttpServletResponse response) // 删除新闻
			throws ServletException, IOException {
		String nid = request.getParameter("nId");
		Map<String, Object> imageMap = newsService.newDeleteImage(nid);
		String imagePathAll = (String) imageMap.get("nImage");
		String imagePaths[] = imagePathAll.split(",");
		for (int i = 0; i < imagePaths.length; i++) {
			String im = imagePaths[i];
			
			if(!im.equals("")){
				String imagePath = getServletContext().getRealPath(im.substring(8));
				File image = new File(imagePath);
				if (image.exists()) {
					image.delete();
				}
			}
		}
		newsService.newDelete(nid);
		response.getWriter().print("删除成功");
		return null;
	}

	// 编辑新闻时回显新闻
	public String editShowNew(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String nid = request.getParameter("nid");
		News n = newsService.findByNew(nid);
		request.setAttribute("editlist", n);
		return "f:/manager/news/editNew.jsp";
	}

	// 添加新闻 开始对image进行保存
	public String addNew(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 对表单信息进行打包bean 鉴于ueditor强大 数据库中image可以删掉
		News newbean = CommonUtils
				.toBean(request.getParameterMap(), News.class);
		// 对类型和管理员进行添加
		newbean.setnEditors((Users) request.getSession().getAttribute("user"));
		// 拿CID去查classify
		String title=newbean.getnTheme().trim();
		newbean.setnTheme(title);
		String cid = request.getParameter("nType");
		Classify c = new Classify();
		c.setcId(cid);
		newbean.setnTypes(c);
		String text = request.getParameter("myEditor");
		newbean.setnText(text);
		// 开始对图片解析路径 用的2个工具类
		List list = ImgUtil.getImageSrc(text);
		String imagePath = StringUtil.listToString(list, ',');
		newbean.setnImage(imagePath);
		newbean.setnId(CommonUtils.uuid());
		newsService.addNews(newbean);
		
		return "r:/manager/news/msg.jsp";

	}

	// 编辑新闻
	public String editNew(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 打包表单项
		News n = CommonUtils.toBean(request.getParameterMap(), News.class);
		Classify c = new Classify();
		c.setcId(request.getParameter("nType"));
		n.setnTypes(c);
		String title=n.getnTheme().trim();
		n.setnTheme(title);
		// 编辑者不允许修改所以不打包了
		List list = ImgUtil.getImageSrc(request.getParameter("nText"));
		String imagePath = StringUtil.listToString(list, ',');
		n.setnImage(imagePath);
		// 调用
		newsService.editNew(n);
	
		return "r:/manager/news/msg.jsp";
	}

}
