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
  			
  			$("#myform").submit(function(){
  				if($("#cName").val()==""||$("#catid").val()=="")
  	  			{
  	  			alert("不允许关键字段为空");
  	  		return false;
  	  			}
  				
  			});
  			
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
					if(arr[i].cId!="3"&& arr[i].cId!="4"){
						var option=$("<option>").val(arr[i].cId).text(arr[i].cName);
						$("#catid").append(option);
					}
					
				}
			}
  	
  		});
  		
  		
  		
  		
  	});
  </script>
  
  
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
	<div class="result-wrap">
        <div class="result-title">
        					
                    <div class="result-list">
                        <a href=""><i class="icon-font"></i>预留</a>
                    </div>
                </div>
        <div class="result-content">
                <form method="POST" action='<c:url value="/ClassifyServlet"></c:url>' id="myform">
                	<input type="hidden" name="method" value="addTowMenu"/>
                    <table class="result-tab" width="100%">
                    		<caption><h1>添加二级菜单</h1></caption>
                        <tr>
                            <th>菜单名</th>
                            <th>所属一级</th>
                           
                            <th>说明</th>
                            <th>操作</th>
                        </tr>
                        <tbody>
                     	<tr>
                     		<td><input type="text" name="cName" id="cName"/></td>
                     		<td><select name='nType' id="catid"></select></td>
                     		
                     		<td><input type="text" name="cDesc" id=""/></td>
                     		<td><input type="submit" value="提交" /></td>
                     	</tr>
  						</tbody>
                    </table>                   
</div>
		</div>
		</div>
    <!--/main-->
    </div>
    </form>
  </body>
</html>
