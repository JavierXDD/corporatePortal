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
	<link rel="stylesheet" type="text/css" href="<c:url value='/manager/main.css'/>">
  </head>
 
 <!--  <style>
 html{
 width:100%;
 overflow:hidden;
 }
 
 body{
 margin:0px;
 padding:0px;
 }
 .i1{
 	width:100%;
 	height:50px;
 }
.i2{
	width:15%;
	height:100%;
}
.i3{
	float:right;
	width:85%;
	height:100%;
}
	
 </style>-->
  <!-- <body>
<iframe name="top" class="i1" frameborder="no" border="0" scrolling="no" src='<c:url value="/manager/top.jsp"></c:url>'></iframe>
  <iframe   id="left1" name="left" frameborder="no" src='<c:url value="/ClassifyServlet?method=findByParent&return=manager/left.jsp"></c:url>' border="0" scrolling="no" class="i2"></iframe>
  <iframe  name="right"  frameborder="no" src='<c:url value="/manager/right.jsp"></c:url>' border="0" scrolling="yes" class="i3"></iframe>
  </body>-->
  <body>
  <table class="table" align="center">
	<tr class="trTop">
		<td colspan="2" class="tdTop">
			<iframe frameborder="0" scrolling="no" src='<c:url value="/manager/top.jsp"></c:url>' name="top"></iframe>
		</td>
	</tr>
	<tr>
		<td class="tdLeft" rowspan="2">
			<iframe frameborder="0" scrolling="no" src='<c:url value="/ClassifyServlet?method=findByParent&return=manager/left.jsp"></c:url>' name="left"></iframe>
		</td>
		
	</tr>
	<tr>
		<td style="border-top-width: 0px;">
			<iframe frameborder="0" src='<c:url value="/manager/right.jsp"></c:url>' name="right"></iframe>
		</td>
	</tr>
</table>
  </body>
</html>
