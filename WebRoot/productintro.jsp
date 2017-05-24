<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <!-- Required meta tags always come first -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>陕西西安力天有限责任公司</title>
  <link rel="shortcut icon" href="images/logo.png"> 
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/reset.css">
  </head>
  
  
  
  <body class="container-fluid" id="all">
    <div class="top">
    	<div class="top_color">
        	
        </div>
        
        <div class="top_banner clearfix">
        	<div class="banner">
            	<div class="row">
            		<!--logo-->
                    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 hidden-xs-down">
                      <div class="banner_left">
                          <img src="images/logo.jpg">
                      </div>
                    </div>
                	
                    <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
                       <div class="banner_right ">
                            <!--导航-->
                            <div id="lgnav">
                                <nav class="navbar navbar-light">
                                <div class="navbar-header clearfix">
                                <button class="navbar-toggler hidden-sm-up pull-right" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar2">
                                  &#9776;
                                </button>
                                <a class="nav-brand hidden-sm-up">力天筑路</a>
                                </div>
                                  <div class="collapse navbar-toggleable-xs pull-right" id="exCollapsingNavbar2">
                                    <ul class="nav navbar-nav">
                                      <li class="nav-item active">
                                        <a class="nav-link tactive" href='<c:url value="/index.jsp"></c:url>'>主页 <span class="sr-only">(current)</span></a>
                                      </li>
                                      <c:forEach items="${parent }" var="list9">
                                      <c:forEach items="${list9.children }" var="listchild">
                                      <li class="nav-item">
                                        <a class="nav-link" href='<c:url value="/indexServlet?method=${listchild.cAddr }&cid=${listchild.cId }"></c:url>'>${list9.cName }</a>
                                      </li>
                                      </c:forEach>
                                    </c:forEach>
                                    </ul>
                                  </div>
                                </nav>
                            </div>
                         </div>   
                   	   </div>
            	</div>    
            </div>
        </div>
    </div>
    <!--路径导航-->
	<div class="top_back proback clearfix" id="secondbanner">
    	<div class="top_backin">
          <h2>${p.pTypes.parents.cName }</h2>
          <p>您当前的位置：</p>
          <ol class="breadcrumb">
            <li><a href='<c:url value="/index.jsp"></c:url>'>首页</a></li>
            <li>${p.pTypes.parents.cName }</li>
            <li>${p.pTypes.cName }</li>
            <li class="active">详情</li>
          </ol>
          <ul class="nav">
            <c:forEach items="${menulist }" var="child2"> 
           <c:if test="${child2.cId eq '2'}">
           		<c:forEach items="${child2.children }" var="child3">
          	  <li class="nav-item">
              <a href='<c:url value="/indexServlet?method=${child3.cAddr }&cid=${child3.cId }"></c:url>' class="nav-link">${child3.cName }</a>
           	 </li>
           	 </c:forEach>	
           </c:if>
           </c:forEach>  
          </ul>
        </div>
    </div>
    <!--正文-->
   <div class="middle_text">
   <div class="news_nav">
   		<h4>${p.pTypes.cName }</h4>
        </div>
	<div class="row">
    		
        <div class="col-md-12">
        
          <div class="prointro">
         
          <p>${p.pText}</p>
          </div>
        </div>
    </div>
            
   </div>
        
        
   <!--底部--> 
	<div class="footer" id="bofo">
        <div class="footerin clearfix hidden-md-down">
        <c:forEach items="${menulist }" var="list6">
          <div class="col_2">
            <ul>
              <li>
                <h2>${list6.cName }</h2>
              </li>
              <c:forEach items="${list6.children }" var="child">
              	<c:choose>
              		<c:when test="${!empty child.parents }"><li> <a href='<c:url value="/indexServlet?method=${child.cAddr }&cid=${child.cId }"></c:url>'>${child.cName }</a></li></c:when>
              		<c:otherwise><li><a href="${child.cAddr }">${child.cName }</a></li></c:otherwise>
              		
              	</c:choose>
             	
              </c:forEach>
            </ul>
          </div>
          
         </c:forEach>
         
        </div>
        <div class="copyright">
    	<p>西安力天有限责任公司&copy;2015 版权所有</p>
        <p><a href='<c:url value="/UserServlet?method=isLogin"></c:url>'>登陆</a></p>
        
       
    </div>
    </div>
    <!-- jQuery first, then Bootstrap JS. -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/jquery.sliphover.min.js"></script>
  </body>
</html>
