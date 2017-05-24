package com.xawl.index.servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

import com.sun.net.ssl.SSLContext;
import com.xawl.about.domain.About;
import com.xawl.about.service.AboutService;
import com.xawl.classify.domain.Classify;
import com.xawl.classify.service.ClassifyService;
import com.xawl.index.domain.index;
import com.xawl.index.service.indexService;
import com.xawl.news.domain.News;
import com.xawl.news.domain.PageBean;
import com.xawl.news.service.NewsService;
import com.xawl.products.domain.Products;
import com.xawl.products.service.ProductsService;

public class indexServlet extends BaseServlet {
	private indexService service = new indexService();
	private ClassifyService classifyService = new ClassifyService();
	private NewsService newsService = new NewsService();
	private AboutService aboutService = new AboutService();
	private ProductsService productService = new ProductsService();

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

	public String findByInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("infolist", service.findByInfo());
		return "f:/manager/system/system.jsp";
	}

	// 删除字段
	public String ajaxRemoveInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String iid = request.getParameter("iId");
		String json = service.ajaxremoveInfo(iid).toString();
		response.getWriter().print(json);
		return null;
	}

	// 编辑
	public String ajaxEditInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		index i = CommonUtils.toBean(request.getParameterMap(), index.class);
		i.setIsImage("0");

		String json = service.editInfo(i).toString();
		response.getWriter().print(json);
		return null;
	}

	// 添加
	public String ajaxaddInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		index i = CommonUtils.toBean(request.getParameterMap(), index.class);
		i.setIsImage("0");
		i.setiId(CommonUtils.uuid());
		String json = service.addInfo(i).toString();
		response.getWriter().print(json);
		return null;
	}
//ajax修改图片名字
	public String ajaxedidInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			String iName=request.getParameter("iName");
			String iId=request.getParameter("iId");
			String json=service.ajaxeditImage(iName, iId).toString();
			response.getWriter().print(json);
		return null;
	}
	// 查询大图
	public String findImage(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("imageid");
		request.setAttribute("MaxImageList", service.findByMaxImage(id));
		return "f:/manager/indexImage/MaxImage.jsp";
	}

	public String findImage2(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("imageid");
		request.setAttribute("MaxImageList", service.findByMaxImage(id));
		return "f:/manager/indexImage/smallImage.jsp";
	}

	// 删除
	public String removeImage(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("iId");
		index x = service.findByiId(id);
		String json = service.ajaxremoveInfo(id).toString();
		if (json.equals("true")) {
			String s = x.getiValue();
			int i=s.indexOf(".");
			String s1=s.substring(0,i)+"_s"+".jpg";
			
			String path2=getServletContext().getRealPath(s1.substring(8));
			String path = getServletContext().getRealPath(s.substring(8));
			
			File f = new File(path);
			File f2=new File(path2);
			f.delete();
			f2.delete();
		}
		response.getWriter().print(json);
		return null;
	}


	
	// --------------------------------*前 后 台 交 互*--------------------------
	// --------------------------------*前 后 台 交 互*--------------------------

	public String index(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 取数据
		// 先取轮播图
		try {
			List<index> MaxImagaList = service.findByMaxImage("3");

		//	if (MaxImagaList.isEmpty()) {
				//JOptionPane.showMessageDialog(null, "请先进入后台管理添加网站加载时所需的数据！");
				//JOptionPane.showMessageDialog(null, "添加时请参照说明文本！");
				
				
			//	return "r:/manager/admin/Login.jsp";
		//	} else {
				List<index> MinImagaList = service.findByMaxImage("1");
				request.setAttribute("MaxImagaList", MaxImagaList);
				List<Integer> quanlist = new ArrayList<Integer>();
				for (int i = 0; i < MaxImagaList.size(); i++) {
					quanlist.add(i);
				}
				List<index> xinxilist = service.findByInfo();
				request.setAttribute("xinxilist", xinxilist);
				request.setAttribute("quanlist", quanlist);

				List<Classify> menulist = this.findMenu();

				request.setAttribute("menulist", menulist);
				request.setAttribute("MinImagaList", MinImagaList);
				// 获取8条新闻信息
				List<News> newslist = newsService.findBy8();
				request.setAttribute("newlist", newslist);
				// 获取功能菜单
				List<Classify> parentlist = this.findparent();
				request.setAttribute("parent", parentlist);
				//获取产品展示
				Classify pro = menulist.get(1);
				List<Classify> p = pro.getChildren();
				request.setAttribute("plist", p);
				
		//	}
		} catch (Exception e) {
				
			throw new RuntimeException("请到后台添加网站加载时所需的数据，" + e);
			
		}finally{
			return "f:/index.jsp";
		}
	}

	// 查询新闻
	public String findNews(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		List<Classify> menulist = this.findMenu();
		request.setAttribute("menulist", menulist);


		List<Classify> parentlist = this.findparent();
		request.setAttribute("parent", parentlist);

		String cid = request.getParameter("cid");
		Classify c = classifyService.findByCid(cid);
		request.setAttribute("c", c);
		int pc = getPC(request);
		int ps = 8;
		PageBean<News> newlist = newsService.findByCidNew(pc, ps, cid);
		newlist.setUrl(getUrl(request));
		request.setAttribute("pb", newlist);

		return "f:/news.jsp";
	}

	// 返回一个新闻对象
	public String findNewByNid(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		List<Classify> menulist = this.findMenu();

		request.setAttribute("menulist", menulist);

		List<Classify> parentlist = this.findparent();
		request.setAttribute("parent", parentlist);

		String nid = request.getParameter("nid");
		News newlist = newsService.findByNew(nid);
		request.setAttribute("news", newlist);

		return "f:/newstext.jsp";
	}

	// 关于litian
	public String about(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String aid = request.getParameter("cid");
		About about = aboutService.findByAbout(aid);
		request.setAttribute("about", about);

		List<Classify> menulist = this.findMenu();

		List<Classify> parentlist = this.findparent();
		request.setAttribute("parent", parentlist);
		request.setAttribute("menulist", menulist);
		return "f:/about.jsp";
	}

	public String findP(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid = request.getParameter("cid");
		Classify c = classifyService.findByCid(cid);
		request.setAttribute("c", c);
		int pc = getPC(request);
		int ps = 4;
		com.xawl.products.domain.PageBean<Products> pb = productService
				.findByCidProducts(pc, ps, cid);
		pb.setUrl(getUrl(request));
		request.setAttribute("pb", pb);

		List<Classify> menulist = this.findMenu();

		request.setAttribute("menulist", menulist);

		List<Classify> parentlist = this.findparent();
		request.setAttribute("parent", parentlist);

		return "f:/product.jsp";
	}

	public String findPs(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String cid = request.getParameter("cid");
		Products p = productService.findByProduct(cid);
		request.setAttribute("p", p);

		List<Classify> menulist = this.findMenu();

		request.setAttribute("menulist", menulist);

		List<Classify> parentlist = this.findparent();
		request.setAttribute("parent", parentlist);
		return "f:/productintro.jsp";
	}
	
	// 查找各种中心
		/*public String findCenter(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
		
			String cid = request.getParameter("cid");
			List<Classify> menulist = this.findMenu();
			List<Classify> parent = this.findparent();
			Classify center = classifyService.findByCid(cid);
			request.setAttribute("cId", cid);
			request.setAttribute("parent", parent);		
			request.setAttribute("menulist",menulist);
			request.setAttribute("cName", center.getcName());
			request.setAttribute("cDesc", center.getcDesc());
			
			return "f:/center.jsp";	
		}*/
	// 查找一二级菜单
	public List<Classify> findMenu() {
		// 查找一二级菜单
		String cName=null;
		List<Classify> menulist = classifyService.findAll();
		for (int i = 0; i < menulist.size(); i++) {
			Classify c = menulist.get(i);
			if (c.getcId().equals("3")) {
				 cName=c.getcName();
				menulist.remove(i);
			}
		}
		List<index> youqinglist = service.findByMaxImage("2");
		Classify youqing = new Classify();
		List<Classify> child = new ArrayList<Classify>();
		for (int i = 0; i < youqinglist.size(); i++) {
			Classify c = new Classify();
			c.setcName(youqinglist.get(i).getiName());
			c.setcAddr(youqinglist.get(i).getiValue());
			child.add(c);
		}
		youqing.setcName(cName);
		youqing.setcId("3");
		youqing.setChildren(child);
		// 封装关于力天
		List<Classify> aboutclassify = new ArrayList<Classify>();

		List<About> aboutlist = aboutService.findAll();
		for (int i = 0; i < aboutlist.size(); i++) {
			Classify c = new Classify();
			c.setcId(aboutlist.get(i).getaId());
			c.setcName(aboutlist.get(i).getaTitle());
			c.setParents(new Classify());
			c.setcAddr("about");
			aboutclassify.add(c);
		}

		for (int j = 0; j < menulist.size(); j++) {
			if (menulist.get(j).getcId().equals("4")) {
				menulist.get(j).setChildren(aboutclassify);

			}
		}
		menulist.add(youqing);
		return menulist;
	}

	// 功能菜单
	//2 修改版.
	public List<Classify> findparent() {
		List<Classify> parentlist = findMenu();
			//打包分装 把友情链接删除  打包一级只分转一个二级
		for(int i=0;i<parentlist.size();i++){
			
				if(parentlist.get(i).getcId().equals("3")){
					parentlist.remove(i);
				}
			
		}
		//分装一个二级
				for(int h=0;h<parentlist.size();h++)
				{
						Classify c=parentlist.get(h).getChildren().get(0);
						List<Classify> child=new ArrayList<Classify>();
						child.add(c);
						parentlist.get(h).setChildren(child);
				}
		return parentlist;
	}

}
