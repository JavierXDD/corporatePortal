<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
    <title>力天筑路后台管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="/LiTian/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/LiTian/manager/css/main.css"/>
    <script type="text/javascript" src="/LiTian/manager/js/libs/modernizr.min.js"></script>
  </head>
  
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
<div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i>编辑轮播图</div>
        </div>
        <br>
  		<div class="result-wrap">
            <div class="result-content">
                    <table class="insert-tab" width="100%">
                        <tbody>
                            <tr>
                            <td>
   						   <a href='<c:url value="/indexServlet?method=findImage&imageid=3"></c:url>' >编辑顶端大图</a><br/>
                            </td>
                            <td>
		  					<i class="require-red">* 注意：请添加 1440*400 大小的图片</i>
                            </td>
                            </tr>                        	
                            <tr>
                            <td>
   						   <a href='<c:url value="/indexServlet?method=findImage2&imageid=1"></c:url>' >编辑中间四幅小图</a><br/>
                            </td>
                            <td>
		  					<i class="require-red">* 注意：请添加 494*244 大小的图片</i>
                            </td>
                            </tr> 
                           
                        </tbody>
                        </table>
                        <br>
            </div>
        </div>
        </div>
    <!--/main-->
    </div>
  </body>
</html>
	
