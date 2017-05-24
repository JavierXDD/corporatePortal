<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<div class="top_back newsback clearfix" id="secondbanner">
    	<div class="top_backin">
          <h2>${c.parents.cName }</h2>
          <p>您当前的位置：</p>
          <ol class="breadcrumb">
            <li><a href='<c:url value="/index.jsp"></c:url>'>首页</a></li>
            <li>${c.parents.cName }</li>
			<li><a >${c.cName }</a></li>
          </ol>
          <ul class="nav">
           <c:forEach items="${menulist }" var="child2"> 
           <c:if test="${child2.cId eq '1'}">
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
   <!--新闻列表--> 
   <div class="middle_text">
   		<div class="news_nav">
   		<h4>${pb.beanList[0].nTypes.cName }</h4>
        </div>
   		<div class="news clearfix">
           
            <ul class="list-group">
            <c:forEach items="${pb.beanList }" var="list10">
              <li class="list-group-item"><a target="_self" href='<c:url value="/indexServlet?method=findNewByNid&nid=${list10.nId }"></c:url>' target="_blank" ><i class="newstitle">${list10.nTheme }</i> <i class="time">${list10.nTime }</i></a></li>
             </c:forEach>
            </ul>
        </div>
        <!--分页-->
        <nav>
          <ul class="pagination">
          		<c:if test="${pb.pc > 1 }">
						
					<li>
            			  <a href="${pb.url }&pc=${pb.pc-1}" aria-label="Previous">
            			    <span aria-hidden="true">&laquo;</span>
              			  <span class="sr-only">Previous</span>
             			 </a>
           			 </li>
				</c:if>
				<c:choose>
						<%-- 如果总页数不足10页，那么把所有的页数都显示出来！ --%>
						<c:when test="${pb.tp <= 10 }">
							<c:set var="begin" value="1" />
							<c:set var="end" value="${pb.tp }" />
						</c:when>
						<c:otherwise>
							<%-- 当总页数>10时，通过公式计算出begin和end --%>
							<c:set var="begin" value="${pb.pc-5 }" />
							<c:set var="end" value="${pb.pc+4 }" />
							<%-- 头溢出 --%>
							<c:if test="${begin < 1 }">
								<c:set var="begin" value="1" />
								<c:set var="end" value="10" />
							</c:if>
							<%-- 尾溢出 --%>
							<c:if test="${end > pb.tp }">
								<c:set var="begin" value="${pb.tp - 9 }" />
								<c:set var="end" value="${pb.tp }" />
							</c:if>
						</c:otherwise>
					</c:choose>
            <%-- 循环遍历页码列表 --%>
					<c:forEach var="i" begin="${begin }" end="${end }">
						<c:choose>
							<c:when test="${i eq pb.pc }">
								 <li><a>${i }</a></li>
							</c:when>
							<c:otherwise>
							 <li><a href="${pb.url }&pc=${i}">${i }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>        
            <c:if test="${pb.pc < pb.tp }">
							
						<li>
             			 <a href="${pb.url }&pc=${pb.pc+1}" aria-label="Next">
              			  <span aria-hidden="true">&raquo;</span>
              			  <span class="sr-only">Next</span>
             			 </a>
           				 </li>
			</c:if> 
          </ul>
        </nav>
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
