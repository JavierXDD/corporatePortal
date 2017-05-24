<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
    <title>力天筑路后台管理</title>
    <link href='<c:url value="/manager/css/admin_login.css"></c:url>' rel="stylesheet" type="text/css" />
    <script type="text/javascript" src='<c:url value="/js/jquery-1.5.1.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/Login.js"></c:url>'></script>
</head>
<body>
<script>
	if(self!=parent)
	{
		parent.location=self.location;
	}
</script>
<div class="admin_login_wrap">
    <h1>力天后台管理</h1>
    <div class="adming_login_border">
        <div class="admin_input">
         	${requestScope.msg }
  			<form  id="Form" action="<c:url value="/UserServlet?method=Login"></c:url>" method="post">
                <ul class="admin_items">
                    <li>
                        <label for="user">用户名：</label>
                        <input type="text" name="uid"  class="input" id="uid"/><label id="uidError"  class="Error" ></label>
                    </li>
                    <li>
                        <label for="pwd">密码：</label>
                        <input type="password" name="password"    class="input" id="password"/> <label class="Error" id="passwordError"></label>
                    </li>
                    <li>
                        <label for="pwd">验证码：</label>
                        <input type="text" name="code" class="input" id="code"/>
                        <img alt="为加载" id="yzm" src='<c:url value="/Code"></c:url>'><label id="codeError"></label>
                    </li>
                    <li>
                        <input type="submit" tabindex="3" value="登陆" class="btn btn-primary" />
                    </li>
                </ul>
            </form>
        </div>
    </div>
    <p class="admin_copyright"><a tabindex="5" href='<c:url value="/index.jsp"></c:url>'>返回首页</a> &copy; 2014 Powered by <a href="http://jscss.me" target="_blank">力天筑路</a></p>
</div>
</body>
</html>
