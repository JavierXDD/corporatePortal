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
		data:{method:"ajaxfindByCid",cid:"1"},
		type:"POST",
		dataType:"json",
		async:false,
		cache:false,
		success:function(arr){
			for(var i=0;i<arr.length;i++){
				if(arr[i].cName=="${editlist.nTypes.cName}"){
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
			var time=$("#Time").val();
			var source=$("#Source").val();
			if(!classify||theme.length>20||!time||!source||editor.hasContents()){
				alert("请仔细检查是否有空项!或标题长度超过20字符!");
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
            <div class="crumb-list"><i class="icon-font"></i>编辑新闻</div>
        </div>
  		
  		<div class="result-wrap">
            <div class="result-content">
                <form action="<c:url value='/NewsServlet?method=editNew'/>" method="post" id="myform"  >
                	<input type="hidden" name="nId" value="${editlist.nId}"/>
                    <table class="insert-tab" width="100%">
                        <tbody>
                        	<tr>
                         		<th width="120"><i class="require-red">*</i>分类：</th>
                            	<td>
                                <select name="nType" id="catid" class="required">
                                	
                                </select>
                                <i style="color:red;">${errors.nType}</i>
                          	  	</td>
                        	</tr>
                            <tr>
                                <th><i class="require-red">*</i>标题：</th>
                                <td>
                                    <input class="common-text required" id="title" name="nTheme" size="50" value="${editlist.nTheme }" type="text">
                                	<i style="color:red;">${errors.nTheme}</i>
                                </td>
                            </tr>
                            <tr>
                                <th>发布者：</th>
                                <td><input class="common-text" name="nEditor" size="50" disabled="disabled" value="${sessionScope.user.uName }" type="text">
                                <i style="color:red;">${errors.nEditor}</i></td>
                            </tr>
                            <tr>
                                <th>发布时间：</th>
                                <td><input class="common-text" id="Time" name="nTime" value="${editlist.nTime }" size="50" readonly="readonly" type="text">
                                <i style="color:red;">${errors.nTime}</i></td>
                            </tr>
                            <tr>
                                <th>新闻来源：</th>
                                <td><input class="common-text" name="nSource" size="50" id="Source" value="${editlist.nSource }" type="text">
                                <i style="color:red;">${errors.nSource}</i></td>
                            </tr>
                           
                            <!--  <tr>
                                <th><i class="require-red">*</i>缩略图：</th>
                                <td><input name="nImage" id="up_file" type="file"><i style="color:red;">${msg }</i>
                                <i style="color:red;">${errors.nImage}</i></td> 
                            </tr>-->
                            <tr>
                                <th>内容：</th>
                             <td>
    							<script type="text/plain" style="width:100%;height:30%;"  id="content" name="nText">${editlist.nText}</script>	
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
