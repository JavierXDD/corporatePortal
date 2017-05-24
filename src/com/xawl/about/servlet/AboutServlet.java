package com.xawl.about.servlet;

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
import com.xawl.about.domain.About;
import com.xawl.about.service.AboutService;
import com.xawl.classify.domain.Classify;
import com.xawl.news.domain.PageBean;

public class AboutServlet extends BaseServlet {
	private AboutService aboutService = new AboutService();
	
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
		//查出指定类下的项目
		public String findAboutByCid(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			String cid = request.getParameter("cid");
			int pc = getPC(request);
			int ps = 10;
			PageBean<About> pb = aboutService.findAboutByCid(pc, ps,cid);
			pb.setUrl(getUrl(request));
			request.setAttribute("pb", pb);
			return "f:/manager/about/aboutList.jsp";
		}
		// 添加条目 开始对image进行保存
		public String addAbout(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			About newbean = CommonUtils
					.toBean(request.getParameterMap(), About.class);
			// 对类型和管理员进行添加
			newbean.setaEditors((Users) request.getSession().getAttribute("user"));
			// 拿CID去查classify
			String title=newbean.getaTitle().trim();
			newbean.setaTitle(title);
			String cid = request.getParameter("aType");
			Classify c = new Classify();
			
			c.setcId(cid);
			newbean.setaTypes(c);
			String text = request.getParameter("myEditor");
			newbean.setaText(text);
			// 开始对图片解析路径 用的2个工具类
			List list = ImgUtil.getImageSrc(text);
			String imagePath = StringUtil.listToString(list, ',');
			newbean.setaImage(imagePath);
			newbean.setaId(CommonUtils.uuid());
			aboutService.addAbout(newbean);
					return "r:/manager/about/msg.jsp";

		}
		public String ajaxDelete(HttpServletRequest request,
				HttpServletResponse response) 
				throws ServletException, IOException {
			String aid = request.getParameter("aid");
			
			Map<String, Object> imageMap = aboutService.aboutDeleteImage(aid);
			String imagePathAll = (String) imageMap.get("aImage");
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
			aboutService.aboutDelete(aid);
			response.getWriter().print("删除成功");
			return null;
		}
		public String editShowAbout(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			String aid = request.getParameter("aId");
			About a = aboutService.findByAbout(aid);
			request.setAttribute("editlist", a);
			return "f:/manager/about/editAbout.jsp";
		}
		public String editAbout(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			// 打包表单项
			About a = CommonUtils.toBean(request.getParameterMap(), About.class);
			String title=a.getaTitle().trim();
			a.setaTitle(title);
			Classify c = new Classify();
			c.setcId(request.getParameter("aType"));
			a.setaTypes(c);
			// 编辑者不允许修改所以不打包了
			List list = ImgUtil.getImageSrc(request.getParameter("aText"));
			String imagePath = StringUtil.listToString(list, ',');
			a.setaImage(imagePath);
			// 调用
			aboutService.editAbout(a);

			return "r:/manager/about/msg.jsp";
		}
	
}
