package com.xawl.products.servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.ImgUtil;
import Util.StringUtil;

import com.xawl.Users.domain.Users;
import com.xawl.classify.domain.Classify;
import com.xawl.classify.service.ClassifyService;
import com.xawl.news.domain.News;
import com.xawl.products.domain.PageBean;
import com.xawl.products.domain.Products;
import com.xawl.products.service.ProductsService;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class ProductsServlet extends BaseServlet {
	private ProductsService productsService = new ProductsService();
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

	// 返回分类下的所有产品列表
	public String findByCidProducts(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String cid = request.getParameter("cid");
		int pc = getPC(request);
		int ps = 10;
		PageBean<Products> pb = productsService.findByCidProducts(pc, ps, cid);
		pb.setUrl(getUrl(request));
		request.setAttribute("pb", pb);

		return "f:/manager/products/list.jsp";
	}

	// 添加产品 开始对image进行保存
	public String addProducts(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Products productsBean = CommonUtils.toBean(request.getParameterMap(),
				Products.class);
		// 拿CID去查classify
		String cid = request.getParameter("pType");
		Classify c = classifyService.findByCid(cid);
		String title=productsBean.getpName().trim();
		productsBean.setpName(title);
		productsBean.setpTypes(c);
		String text = request.getParameter("myEditor");
		productsBean.setpText(text);
		// 开始对图片解析路径 用的2个工具类
		List list = ImgUtil.getImageSrc(text);
		String imagePath = StringUtil.listToString(list, ',');
		productsBean.setpImage(imagePath);
		productsBean.setpId(CommonUtils.uuid());
		productsService.addProducts(productsBean);
		return "r:/manager/products/msg.jsp";
	}

	// 删除产品
	public String ajaxDelete(HttpServletRequest request,
			HttpServletResponse response) // 删除新闻
			throws ServletException, IOException {
		String pid = request.getParameter("pId");
		Map<String, Object> imageMap = productsService.productsDeleteImage(pid);
		String imagePathAll = (String) imageMap.get("pImage");
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
		productsService.productsDelete(pid);
		response.getWriter().print("删除成功");
		return null;
	}

	// 编辑时回显
	public String editShowProduct(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String pid = request.getParameter("pid");
		Products n = productsService.findByProduct(pid);
		request.setAttribute("editlist", n);
		
		return "f:/manager/products/editProducts.jsp";
	}

	public String editProduct(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Products p = CommonUtils.toBean(request.getParameterMap(),
				Products.class);
		Classify c = new Classify();
		c.setcId(request.getParameter("pType"));
		p.setpTypes(c);
		String title=p.getpName().trim();
		p.setpName(title);
		// 编辑者不允许修改所以不打包了
		List list = ImgUtil.getImageSrc(request.getParameter("pText"));
		String imagePath = StringUtil.listToString(list, ',');
		p.setpImage(imagePath);
		// 调用
		productsService.editProduct(p);
	
		return "r:/manager/products/msg.jsp";
	}

}
