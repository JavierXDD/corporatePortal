package com.xawl.index.servlet;
/*
 * 修改为用fileupload插件
 */
import java.awt.Image;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.ImageIcon;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import Util.ImageYsUtil;

import cn.itcast.commons.CommonUtils;

import com.xawl.index.domain.index;
import com.xawl.index.service.indexService;

public class UploadImage extends HttpServlet {
	private indexService service=new indexService();
	
	/*public void init(ServletConfig config) throws ServletException {
		
	super.init(config);
	this.config=config;
	}
private ServletConfig config;*/
//前台da图片上传服务
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int count=0;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
			PrintWriter out=response.getWriter();
			java.io.File f1=new java.io.File(request.getRealPath("\\editor\\jsp\\upload"));
			java.io.File f2=new java.io.File(request.getRealPath("\\editor\\jsp\\upload\\image"));
			if(!f1.exists()){
				f1.mkdir();
				
			}
			if(!f2.exists()){
				f2.mkdir();
			}
		//插件工厂
			FileItemFactory factory=new DiskFileItemFactory();
			ServletFileUpload upload=new ServletFileUpload(factory);
			//获取表单项
			upload.setSizeMax(1024*1024*10);//10M
			upload.setHeaderEncoding("utf-8");
			//解析表单项
			List<FileItem> fileItem=null;
			try {
				fileItem=upload.parseRequest(request);
			} catch (FileUploadException e) {
				//文件大小超出限制了
				this.error("您上传的文件超出了10M！请选择<=10M的图片",request,response);
				return;
			}
			//到这说明表单解析完毕先将普通表单项装到map中
			Map<String,Object> map=new HashMap<String, Object>();
		
			for(FileItem item:fileItem){
				if(item.isFormField()){
					map.put(item.getFieldName(),item.getString("UTF-8"));
				}
			}
			//检查图片的大小 和后缀名是否合格
			FileItem item2=fileItem.get(3);//获取图片
			String filename=item2.getName();
			//截图名字名 部分浏览器给的是绝对路径
			int  indes=filename.lastIndexOf("\\");
			if(indes!=-1){
				filename=filename.substring(indes+1);
				
			}
		
			filename=new Date().getTime()+filename;
			//校验后缀
			if(!ext(filename)){
				error("对不起，后缀名有误！目前支持.jpg格式",request,response);
				return ;
			}
			//校验图片的尺寸 但是检验图片的尺寸必须得先写入磁盘中才可以  So .
			String savePath=this.getServletContext().getRealPath("/editor/jsp/upload/image");
			File imgfile=new File(savePath, filename); //绝对路径的文件
			
			
			if(((String)map.get("isImage")).equals("1")){
				
				index i2=service.findisLocation((String)map.get("iLocation"));
					if(i2==null)
						{
							//开始保存写入磁盘中 并且检验尺寸 如果是指定大小 就不进行压缩 如果有出入 则压缩大小
								try {
									item2.write(imgfile);
								} catch (Exception e) {
									throw new RuntimeException(e);
								}
				
							//开始判断图片大小  如果差距小于50的像素的不进行压缩 其他一律压缩  交给一个函数
							this.ImageSize(imgfile, (String)map.get("isImage"),"1"); //上传压缩好
								//开始压缩缩略图
								this.ImageSize(imgfile, (String)map.get("isImage"), "2");
								//压缩完毕 开始封装到数据库中
								index i=CommonUtils.toBean(map, index.class);
								i.setiId(CommonUtils.uuid());
								i.setiValue("/LiTian/editor/jsp/upload/image/"+filename);
								service.addInfo(i);
							
							out.write("<script>alert('上传成功！');window.location.href='"+request.getContextPath()+"/manager/indexImage/addImage.jsp'</script>");
						}else{
							//一级存在 覆盖 删除
							//1先删除之间的图片
							String s = i2.getiValue();
							int x=s.lastIndexOf(".");
							
							String s2=s.substring(0,x)+"_s"+".jpg";
							String path2=getServletContext().getRealPath(s2.substring(8));
							String path = getServletContext().getRealPath(s.substring(8));
							java.io.File f = new java.io.File(path);
							java.io.File f3 = new java.io.File(path2);
							f.delete();
							f3.delete();
				//然后修改 编辑
						
							try {
								item2.write(imgfile);
							} catch (Exception e) {
								
								throw new RuntimeException(e);
							}
							this.ImageSize(imgfile, (String)map.get("isImage"),"1"); //上传压缩好
							//开始压缩缩略图
							this.ImageSize(imgfile, (String)map.get("isImage"), "2");
						service.editMinImage((String)map.get("iLocation"), request.getContextPath()+"/editor/jsp/upload/image/"+filename, (String)map.get("iName"), i2.getiId());
						out.write("<script>alert('上传成功！');window.location.href='"+request.getContextPath()+"/manager/indexImage/addImage.jsp'</script>");
						}
							
			}else{
				//大图   直接压缩 上传
				
				map.remove("iLocation");
				try {
					item2.write(imgfile);
				} catch (Exception e) {
					
					throw new RuntimeException(e);
				}
				this.ImageSize(imgfile, (String)map.get("isImage"),"1"); //上传压缩好
				//开始压缩缩略图
				this.ImageSize(imgfile, (String)map.get("isImage"), "2");
				//保存成功后封到数据库中
				index i=CommonUtils.toBean(map, index.class);
				i.setiId(CommonUtils.uuid());
				
			
				//iName=URLDecoder.decode(iName,"utf-8");
			//String iName = new String(mysmart.getRequest().getParameter("iName").trim().getBytes("gbk"),"UTF-8"); 
				//String iName=mysmart.getRequest().getParameter("iName");
				
				
				
				i.setiValue(request.getContextPath()+"/editor/jsp/upload/image/"+filename);
				service.addInfo(i);
				out.write("<script>alert('上传成功！');window.location.href='"+request.getContextPath()+"/manager/indexImage/addImage.jsp'</script>");	
			}
			
//			
//			try {
//				
//				mysmart.initialize(config, request, response);
//				mysmart.setAllowedFilesList("bmp,jpg,tiff,gif,pcx,tga,exif,fpx,svg,psd,,png,cdr,pcd,dxf,ufo,eps,ai,raw");
//				mysmart.setDeniedFilesList("exe,bat,jsp,html,htm");
//				mysmart.upload();
//				File myfile=mysmart.getFiles().getFile(0);
//			
//				if(!myfile.isMissing()){
//					
//					if(mysmart.getRequest().getParameter("isImage").equals("1")){
//						
//							index i2=service.findisLocation(mysmart.getRequest().getParameter("iLocation"));
//						if(i2==null){  //说明不存在
//							String filename=new Date().getTime()+myfile.getFileName();
//							myfile.saveAs("/editor/jsp/upload/image/"+filename,mysmart.SAVE_VIRTUAL);
//							//保存成功后封到数据库中
//							index i=new index();
//							i.setiId(CommonUtils.uuid());
//							i.setIsImage("1");
//							String iName= mysmart.getRequest().getParameter("iName");
//							//iName=URLDecoder.decode(iName,"utf-8");
//							//String iName = new String(mysmart.getRequest().getParameter("iName").trim().getBytes("gbk"),"UTF-8"); 
//							//String iName=mysmart.getRequest().getParameter("iName");
//							i.setiName(iName);
//							String iLocation=	mysmart.getRequest().getParameter("iLocation");
//							i.setiLocation(iLocation);
//							i.setiValue(request.getContextPath()+"/editor/jsp/upload/image/"+filename);
//							service.addInfo(i);
//							out.write("<script>alert('上传成功！');window.location.href='"+request.getContextPath()+"/manager/indexImage/addImage.jsp'</script>");
//						
//						}else{
//							//已经存在 覆盖
//							//1先删除之间的图片
//							String s = i2.getiValue();
//							String path = getServletContext().getRealPath(s.substring(8));
//							java.io.File f = new java.io.File(path);
//							f.delete();
//					//然后修改 编辑
//							String iName= mysmart.getRequest().getParameter("iName");
//							String iLocation=	mysmart.getRequest().getParameter("iLocation");
//							String filename=new Date().getTime()+myfile.getFileName();
//							myfile.saveAs("/editor/jsp/upload/image/"+filename,mysmart.SAVE_VIRTUAL);
//							service.editMinImage(iLocation, request.getContextPath()+"/editor/jsp/upload/image/"+filename, iName, i2.getiId());
//							out.write("<script>alert('上传成功！');window.location.href='"+request.getContextPath()+"/manager/indexImage/addImage.jsp'</script>");
//						}
//						
//						
//					} else{
//						String filename=new Date().getTime()+myfile.getFileName();
//						myfile.saveAs("/editor/jsp/upload/image/"+filename,mysmart.SAVE_VIRTUAL);
//						//保存成功后封到数据库中
//						index i=new index();
//						i.setiId(CommonUtils.uuid());
//						i.setIsImage("3");
//						String iName= mysmart.getRequest().getParameter("iName");
//						//iName=URLDecoder.decode(iName,"utf-8");
//						//String iName = new String(mysmart.getRequest().getParameter("iName").trim().getBytes("gbk"),"UTF-8"); 
//						//String iName=mysmart.getRequest().getParameter("iName");
//						i.setiName(iName);
//						
//						
//						i.setiValue(request.getContextPath()+"/editor/jsp/upload/image/"+filename);
//						service.addInfo(i);
//						out.write("<script>alert('上传成功！');window.location.href='"+request.getContextPath()+"/manager/indexImage/addImage.jsp'</script>");
//					
//					
//					}
//				}
//				
//			} catch (Exception e) {
//				out.write("<script>alert('上传失败，请检查后缀名！');window.location.href='"+request.getContextPath()+"/manager/indexImage/addImage.jsp'</script>");
//				e.printStackTrace();
//			}
//		
//	}
	}
	public void error(String msg,HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("error",msg);
		request.getRequestDispatcher("/manager/indexImage/addImage.jsp").forward(request, response);
	}
	//检查图片的大小是否合格   范围控制在50内  这个函数是对上传的时候压缩的  对于后台的
	private void ImageSize(File file,String type,String isHoutai) throws IOException{
			
		ImageIcon imageicon=new ImageIcon(file.getAbsolutePath())	;
		Image image=imageicon.getImage();	
		int width=image.getWidth(null);
		int height=image.getHeight(null);
		if(isHoutai.equals("1")){
			
								// 上传的压缩
								if(type.equals("3")){  //格式化大图
									
									if(!(width<=1440+50&&width>=1440-50&&height<=400+50&&height>=400-50)){
													//进来说明不满足条件进行压缩
											ImageYsUtil util=new ImageYsUtil(file.getAbsolutePath());
												util.resize(1440, 400, 0);//压缩好了
												
											}
								}else if(type.equals("1")){
									//小图
									if(!(width<=494+50&&width>=494-50&&height<=244+50&&height>=244-50)){
										//进来说明不满足条件进行压缩
								ImageYsUtil util=new ImageYsUtil(file.getAbsolutePath());
									util.resize(494, 244, 0);//压缩好了
									
								}
								}
			
		}else if(isHoutai.equals("2")){
			//缩略图  	
				if(type.equals("1")){
					
					ImageYsUtil util=new ImageYsUtil(file.getAbsolutePath());
					util.resize(355, 175, 1);//压缩好了
						
				}else{
				
					ImageYsUtil util=new ImageYsUtil(file.getAbsolutePath());
					util.resize(555, 154, 1);//压缩好了
				}
			}
		
		
	}
	//检查后缀名
	private Boolean ext(String filename){
		String ends=".jpg";
	
				if(!filename.toLowerCase().endsWith(ends)){
					
					return false;
				
		}
		return true;
	}
}
