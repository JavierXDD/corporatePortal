<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>力天筑路后台管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/main.css"/>
    <script type="text/javascript" src="js/libs/modernizr.min.js"></script>
  </head>
  
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
    	<div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i>友情链接管理</div>
        </div><br>
	<div class="result-wrap">		
                	<div class="result-list">
                        <a href="${pageContext.request.contextPath }/manager/link/addLink.jsp"><i class="icon-font"></i> 增加链接</a>
                    </div><br>
     	<div class="result-content">
                    <table class="result-tab" style="margin:0 auto;" width="50%">
                        <tr>
                            <th>链接管理</th>
                            <th><a  class="del" href='<c:url value="/LinkServlet?method=findLink&mark=2"></c:url>'>进入</a></th>
                        </tr>					
                    </table>
                    <br><br>                   
		</div>   	
		</div>
		</div>
    <!--/main-->
    </div>
  </body>
</html>
