<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>力天筑路后台管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/main.css"/>
    <script type="text/javascript" src="js/libs/modernizr.min.js"></script>
     <script type="text/javascript" src='<c:url value="/js/jquery-1.5.1.js"></c:url>'></script>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
   <script>
  	//对删除进行确认操作
  	$(function(){
  			$("button").click(function(){
  				if(window.confirm("确定删除?")){
  					var uid=$(this).attr("id");
  					$.ajax({
  						url:"/LiTian/UserServlet",
  						data:{method:"ajaxRemode",uId:uid},
  						type:"POST",
  						dataType:"text",
  						async:false,
  						cache:false,
  						success:function(result){
  							//俩种方案  一是重新加载该页面 2 是 用js删去该节点
  								// 1 window.location.reload();
  								
  								$("."+uid).remove();
  								//判断下列表是否为空
  								if($(".abc").length==0){
  									$("#msg").text("对不起，木有管理员了");
  									
  								}
  								alert(result);
  						}
  					});
  					
  				}
  				
  			});
  	  	
  	 });
  	//删除管理员
  	
  
  	
  </script>
  <body>
<div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">

        <div class="crumb-wrap">
     <div class="crumb-list"><i class="icon-font"></i>管理员管理</div>
        </div>

 <c:choose>
 	<c:when test="${root eq 2 }"><div class="result-wrap">
                <div class="result-title">
                    <div class="result-list">
                        <a href="${pageContext.request.contextPath }/manager/admin/Add.jsp"><i class="icon-font"></i>增加管理员</a>
                        
                    </div>
                </div>
                <div class="result-content">
                <c:if test="${!empty requestScope.userlist }">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>姓名</th>
                            <th>ID</th>
                            <th>添加时间</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${requestScope.userlist}" var="list">
                        <tr class="${list.uId} abc">
                       		<td class="tc"><input name="id" value="59" type="checkbox"></td>
  							<td>${list.uName}</td>
  							<td>${list.uId}</td>
  							<td>${list.uTime }</td>
  							<td><button id="${list.uId}" class="del">删除</button></td>
  						</tr>
  						</c:forEach> 
                    </table>
                    </c:if>
                    <c:if test="${empty requestScope.userlist }">
 						<p>对不起，没有管理员！</p>
 					</c:if>
 					<p id="msg"></p>
                </div>
        </div></c:when>
 
 	<c:otherwise>
 		 <div class="result-list">
 				<h1 align="center">对不起，您没有该权限！</h1>
 		 </div>
 	</c:otherwise>
 </c:choose>
  		
   </div>
    <!--/main-->
    </div>
	
  </body>
</html>
