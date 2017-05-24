<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head><!-- 用户进行更改密码页面 -->
	<script type="text/javascript" src='<c:url value="/js/jquery-1.5.1.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/chang.js"></c:url>'></script>
  <body>
<div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">

        <div class="crumb-wrap">
     <div class="crumb-list"><i class="icon-font"></i>管理员管理</div>
           
        </div>
  
  <div class="result-wrap">
  			<div class="result-title">

                </div>
            <div class="result-content"><br><br>
            ${msg1}
 				<form id="Form2" action='<c:url value="/UserServlet?method=Modify"></c:url>' method="post">
                    <table class="insert-tab" width="100%">
                        <tbody>
                            <tr>
                                <th><i class="require-red">*</i>旧密码：</th>
                                <td>
									<input type="password" name="old"  id="old" class="input"/><label  class="Error"id="oldError"></label>                                </td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>新密码：</th>
                                <td><input type="password" name="new1" id="new" class="input"/><label class="Error" id="newError"></label></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>确认密码：</th>
                                <td><input type="password" name="new2" id="renew" class="input"/><label  class="Error" id="renewError"></label></td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>
                                    <input class="btn btn-primary btn6 mr10" value="提交" type="submit">
                                    <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                                </td>
                            </tr>
                        </tbody></table>
                        <br><br>
                </form>
            </div>
        </div>
 	 </div>
    <!--/main-->
    </div>
  </body>
</html>
