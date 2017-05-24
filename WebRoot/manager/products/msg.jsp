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
		<script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
 	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/main.css"/>
  </head>
  <script>
  	$(function(){
  		//取所属一级菜单
  		$.ajax({
  			url:"/LiTian/ClassifyServlet",
  			data:{method:"ajaxfindone"},
  			type:"POST",
  			dataType:"json",
  			async:false,
  			cache:false,
  			success:function(arr){
  				$("#catid").append($("<option >-----请选择-------</option>"));
				for(var i=0;i<arr.length;i++){
					var option=$("<option>").val(arr[i].cId).text(arr[i].cName);
					$("#catid").append(option);
				}
			}
  	
  		});
  		
  		
  		
  		
  	});
  </script>
  
  
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
	<div class="result-wrap">
        <div class="result-content">
        	成功<a href='<c:url value="/ClassifyServlet?method=findBy2&cid=2"></c:url>'>点击返回产品中心</a>
</div>
		</div>
		</div>
    <!--/main-->
    </div>
    </form>
  </body>
</html>
