<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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
  <script>
  		
  
  
  </script>
  </head>
  
  
  <body class="container-fluid" id="all">
    <div class="top">
    	<div class="top_color">	
        </div>
        <!--顶部-->
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
    

    
    <div class="midian clearfix">
        <!--滚动轮播图-->
    	<div class="midian_top">
             <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
               <ol class="carousel-indicators">
                	<c:forEach items="${quanlist }" var="list3" begin="0"  varStatus="stat" step="1">
                 
                <c:if test="${stat.first }">
                  	 <li data-target="#carousel-example-generic" data-slide-to="${list3 }" class="active"></li>
                  </c:if>
                	<c:if test="${!stat.first }">
                  <li data-target="#carousel-example-generic" data-slide-to="${list3}"></li>
                  </c:if>
                </c:forEach>
                </ol>
               
                  <div class="carousel-inner" role="listbox">
                  <c:forEach items="${MaxImagaList }" var="list" varStatus="stat" step="1" begin="0">
                  <c:if test="${stat.first }">
                  	  <div class="carousel-item active">
                   	 <img id="new"  src="${list.iValue }" alt="First slide">
               	   </div>
                  
                  </c:if>
                 <c:if test="${!stat.first }">
                  	<div class="carousel-item">
                    <img  src="${list.iValue }" alt="Second slide">
                  </div>
                  </c:if>
                  </c:forEach>
               	
                </div>
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                  <span class="icon-prev" aria-hidden="true"></span>
                  <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                  <span class="icon-next" aria-hidden="true"></span>
                  <span class="sr-only">Next</span>
                </a>
               </div>
            </div>
        
        <div class="midian_middle clearfix">
        	<div class="row">
            	<!--新闻-->
            	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-5">
                      <div class="middle_left clearfix">
                          <img src="images/news.jpg"/>
                          <ul class="list-group">
                         <c:forEach items="${newlist }" var="list8">
                            <li class="list-group-item"><a target="_self" href='<c:url value="/indexServlet?method=findNewByNid&nid=${list8.nId }"></c:url>' target="_blank" ><i class="newstitle">${list8.nTheme }</i> <i class="time">${list8.nTime }</i></a></li>
                           
                           </c:forEach>
                          </ul>
                      </div>
                  </div>
                  <div class="col-xs-0 col-sm-0 col-md-0 col-lg-1"></div>
                  <!--产品导航-->
                  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                      <div class="middle_right clearfix">
                          <img src="images/product.jpg">
                              <div class="pronav" id="container">
                                  <ul>
                                  <div class="row">
                                  	<c:forEach items="${MinImagaList }" var="list1" varStatus="loop">
                                      <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                                      <li>
                                      	<c:choose>
                                      	<c:when test="${empty plist[loop.count-1] }">
                                         <img src="${list1.iValue}" title="<h4>${list1.iName }</h4>" />
                                      	<a href='#'>
                                      	</c:when>
                                      	<c:otherwise>
                                          <a href='<c:url value="/indexServlet?method=${plist[loop.count-1].cAddr }&cid=${plist[loop.count-1].cId }"/>'>
                                          <img src="${list1.iValue}" title="<h4>${list1.iName }</h4>" />
                                          </a>
                                         </c:otherwise>
                                         </c:choose>
                                      </li>
                                      </div>
                                    </c:forEach> 
          						  </div>
                                  </ul>
                              </div>
                      </div>
                  </div>
                  
            </div>
        </div>
        
        
        <div class="midian_bottom clearfix">
           
           <div class="midian_search">
              <div class="row">
                  <!--图标-->
                  <div class="col-xs-12 col-sm-12 col-md-2 search_left">
                   <img src="images/contact.png"/>   
                  </div>
                  
                  <!--厂家信息-->
                  <div class="sr col-xs-12 col-sm-12 col-md-10">
                  	  
                      <div class="search_right">
                       
                       <c:forEach items="${xinxilist }" var="list4">
                        <p> <span class="glyphicon glyphicon" aria-hidden="true"></span> ${list4.iName }：${list4.iValue }</p>
                        </c:forEach>
                      </div>
                  </div>
                  
                  
              </div>
         
          </div>
        </div>
    </div>
    
    <!--页脚-->
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
	<script type="text/javascript">
    jQuery(function(){
    
    jQuery('#container').sliphover();
    })
    </script>
  </body>
</html>