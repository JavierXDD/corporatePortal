<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<link rel="stylesheet" type="text/css" href="/LiTian/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/LiTian/manager/css/main.css"/>
    <script type="text/javascript" src="/LiTian/manager/js/libs/modernizr.min.js"></script>
<body>
<div class="container clearfix">
    <div class="sidebar-wrap">
        <div class="sidebar-title">
            <h1>菜单</h1>
        </div>
        <div class="sidebar-content">
            <ul class="sidebar-list">
                <li>
                    <a><i class="icon-font">&#xe003;</i>常用操作</a>
                    <ul class="sub-menu">
                    	<c:forEach items="${parents}" var="list">
                        <li><a target="right" href='<c:url value="/ClassifyServlet?method=findBy${list.cId }&cid=${list.cId }"></c:url>'><i class="icon-font">&#xe006;</i>${list.cName }</a></li>
                    	</c:forEach>          
                    </ul>
                </li>
                <li>
                    <a><i class="icon-font">&#xe018;</i>系统管理</a>
                    <ul class="sub-menu">
                        <li><a target="right" href='<c:url value="/indexServlet?method=findByInfo"></c:url>'><i class="icon-font">&#xe017;</i>网站信息</a></li>
                        <li><a   target="right" href='<c:url value="/UserServlet?method=Delete"></c:url>'"><i class="icon-font">&#xe037;</i>管理员维护</a></li>
                        <li><a target="right" href='<c:url value="/manager/indexImage/imageList.jsp"></c:url>'><i class="icon-font">&#xe046;</i>首页轮播图</a></li>
                        <li><a target="right" href='<c:url value="ClassifyServlet?method=findByParent&return=manager/menu/firstMenuList.jsp"></c:url>'><i class="icon-font">&#xe045;</i>菜单管理</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <!--/sidebar-->
   
</div>
</body>
    </html>    

