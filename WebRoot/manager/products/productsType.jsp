<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/main.css"/>
    <script type="text/javascript" src="js/libs/modernizr.min.js"></script>
  </head>
  
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
    	<div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i>产品类型</div>
        </div>
	<div class="result-wrap">
       
                <c:choose>
                	<c:when test="${!empty requestScope.twolist }">
                	 <div class="result-title">
                    <div class="result-list">
                        <a href="${pageContext.request.contextPath }/manager/products/addProducts.jsp"><i class="icon-font"></i> 添加产品</a>
                    </div>
                    </div>
                			    <div class="result-content">
                
                    <table class="result-tab" width="100%">
                        <tr>
                            
                            <th>产品类型</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${requestScope.twolist}" var="list">
                        <tr>
                       		
  							<td>${list.cName}</td>
  							<td><a  class="del" href='<c:url value="/ProductsServlet?method=findByCidProducts&cid=${list.cId}"></c:url>'>进入</a></td>
  						</tr>
  						</c:forEach> 
  						
 						
 					
                    </table>                   
</div>
                	
                	
                	</c:when>
                <c:otherwise>
                		<p>对不起，没有内容！赶快添加二级菜单去吧</p>
                
                </c:otherwise>
                
                
                </c:choose>
		</div>
		</div>
    <!--/main-->
    </div>
  </body>
</html>
