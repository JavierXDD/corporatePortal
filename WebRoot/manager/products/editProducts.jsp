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
	$(function() {
		
		$("#Time").datepick({dateFormat:"yy-mm-dd"});
		$.ajax({
		url:"/LiTian/ClassifyServlet",
		data:{method:"ajaxfindByCid",cid:"2"},
		type:"POST",
		dataType:"json",
		async:false,
		cache:false,
		success:function(arr){
			for(var i=0;i<arr.length;i++){
				if(arr[i].cName=="${editlist.pTypes.cName}"){
					var option=$("<option selected='selected' >").val(arr[i].cId).text(arr[i].cName);
				}else{
				var option=$("<option>").val(arr[i].cId).text(arr[i].cName);
				}
				$("#catid").append(option);
			}
		}
	});
		
		$("#btn").click(function(){
			var classify=$("#catid").val();
			var theme=$("#title").val();
			
			if(!classify||!theme||editor.hasContents()){
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
            <div class="crumb-list"><i class="icon-font"></i>编辑产品</div>
        </div> 		
  		<div class="result-wrap">
            <div class="result-content">
                <form action="<c:url value='/ProductsServlet?method=editProduct'/>" method="post" id="myform"  >
                	<input type="hidden" name="pId" value="${editlist.pId}"/>
                    <table class="insert-tab" width="100%">
                        <tbody>
                        	<tr>
                         		<th width="120"><i class="require-red">*</i>分类：</th>
                            	<td>
                                <select name="pType" id="catid" class="required">
                                	
                                </select>
                                <i style="color:red;">${errors.nType}</i>
                          	  	</td>
                        	</tr>
                            <tr>
                                <th><i class="require-red">*</i>产品名称：</th>
                                <td>
                                    <input class="common-text required" id="title" name="pName" size="50" value="${editlist.pName}" type="text">
                                	<i style="color:red;">${errors.nTheme}</i>
                                </td>
                            </tr>
                            <tr>
                                <th>内容：</th>
                             <td>
    							<script type="text/plain" style="width:100%;height:30%;"  id="content" name="pText">${editlist.pText}</script>	
  							</td> 
  							
                            <script type="text/javascript">
     						   var ue = UE.getEditor('content');
   							 </script>
                            </tr>
                            <tr>
                                <th></th>
                                <td>
                                    <input id="btn" class="btn btn-primary btn6 mr10" value="编辑" type="submit">
                                    <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                                </td>
                            </tr>
                        </tbody></table>
                </form>
            </div>
        </div>
  		
    </div> 
    <!--/main-->
    </div>
  </body>
</html>
