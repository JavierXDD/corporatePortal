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
  		//当点击按钮是就把td变成一个编辑框
  		$("table tr td").find("a:first").toggle(function(){
  			  
  			
  			//把他的2个td变成input
  			
  			var id=$(this).attr("id");
  			var name=$(this).attr("names");
  			var desc=$(this).attr("desc");
  			
  			$("#"+id+"a").replaceWith("<td><input type='text' id='"+id+"1"+"' name='cName' value='"+name+"'/></td>");
  			$("#"+id+"b").replaceWith("<td><input type='text' id='"+id+"2"+"' name='cDesc' value='"+desc+"'/></td>");
  			$(this).text("确认修改");
  			$("table tr td").find("a").css("display","none");
  			$(this).css("display","");
  			$("#"+id+"c").hide();
  	
  				//提交ajax
  			},function(){
  				
  				var id=$(this).attr("id");
  				var namenew=$("#"+id+"1").val();
  	  			var descnew=$("#"+id+"2").val();
  	  			if(namenew==""){
  	  				alert("不允许关键字空字段");
  	  				return false;
  	  			}
  				$.ajax({
  					url:"/LiTian/ClassifyServlet",
  					data:{method:"ajaxEditFirstMenu",cid:id,cName:namenew,cDesc:descnew},
  					type:"POST",
  					dataType:"json",
  					async:false,
  					cache:false,
  					success:function(arr){
  						if(arr){
  							alert("修改成功");
  							window.location.reload();
  							window.parent.frames[1].location.reload();//刷新菜单框架
  						}else{
  							
  							alert("修改失败");
  							window.location.reload();

  						}
  					}
  				});
  				
  			
  		});
  	});
  			
  		
  		
  		

  	
  </script>
  
  
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
		<div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i>菜单管理</div>
        </div>
        <div class="result-wrap">
        	 <div class="result-title">
          <c:choose>
          	<c:when test="${sessionScope.user.isSuper eq 2 }">
                  	  	<div class="result-list">
                  	 			  <a  href='<c:url value="/manager/menu/addmenu.jsp"></c:url>'><i class="icon-font"></i>添加二级菜单</a>
               			 </div>
          			 <div class="result-content">
                <form>
                    <table class="result-tab" width="100%">
                    		<caption style="font-size:25px;">一级菜单</caption>
                        <tr>
                            <th>菜单类型</th>
                            <th>菜单说明</th>
                            <th>操作</th>
                        </tr>
                        <tbody>
                      <c:forEach items="${requestScope.parents }" var="list">
                      	<tr>
                      			<td id="${list.cId }a">${list.cName }</td>
                      			<td id="${list.cId }b">${list.cDesc }</td>
                      			<td><a names="${list.cName }" desc="${list.cDesc }" id="${list.cId }">编辑</a>
                      			<c:if test="${list.cId eq '1' or list.cId eq '2'  }"><a id="${list.cId }c"href='<c:url value="/ClassifyServlet?method=findBytwoMenuList&cid=${list.cId }"></c:url>'>编辑二级</a></c:if>
                      			
                      			</td>
                      			
                   	   	</tr>
                      
                   	   </c:forEach>
  						</tbody>
                   	 </table>         
                       </form>          
			</div>
          	</c:when>
          	<c:otherwise>
          		 <div class="result-list">
 					<h1 align="center">对不起，您没有该权限！</h1>
 				 </div>
			</c:otherwise>
   		</c:choose>    	
		</div>
    <!--/main-->
   </div>
   </div>
   </div>
  </body>
</html>
