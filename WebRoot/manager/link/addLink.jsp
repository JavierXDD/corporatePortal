<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link rel="stylesheet" type="text/css" href="<c:url value='/jquery/jquery.datepick.css'/>">

	<script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>

	<script type="text/javascript" src="<c:url value='/jquery/jquery.datepick.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/jquery/jquery.datepick-zh-CN.js'/>"></script>
	<script type="text/javascript" src='<c:url value="/editor/ueditor.config.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/editor/ueditor.all.js"></c:url>'></script>
	
	<script type="text/javascript">
	$(function(){
		$("#btn").click(function(){
			var iName=$("#title").val();
			var iValue=$("#addr").val();
			if(!iName||!iValue){
				alert("请仔细检查是否有为空项!");
				return false;
			}
			$("#myform").submit();
		});
	})
    </script>  

</head> 
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i>增加新链接</div>
        </div>
        <br>
  		<div class="result-wrap">
            <div class="result-content">
                <form action="<c:url value='/LinkServlet?method=addLink'/>" method="POST" id="myform">
                    <table class="insert-tab" width="100%">
                        <tbody>
                            <tr>
                                <th><i class="require-red">*</i>友情网站名称</th>
                                <td>
                                    <input class="common-text required" id="title" name="iName" size="50" value="" type="text">
                                </td>
                            </tr>                        	
                            <tr>
                                <th><i class="require-red">*</i>链接地址</th>
                                <td>
                                    <input class="common-text required" id="addr" name="iValue" size="50" value="" type="text">
                                </td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>
                                    <input class="btn btn-primary btn6 mr10" value="提交" id="btn" type="submit">
                                    <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                                </td>
                            </tr>
                        </tbody>
                        </table>
                        <br>
                </form>
            </div>
        </div>
  		
    </div> 
    <!--/main-->
    </div>
  </body>
</html>
