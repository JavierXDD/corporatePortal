<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title>力天筑路后台管理</title>
    
   <meta charset="utf-8">
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
    <script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
  </head>
  <script>
  $(function(){
	  	$("#img").css("display","none");
	  	$("#xiaotu").css("display","none");
	  	$("#sc").click(function(){
	  		var name=$("#iName").val();
	  		var img=$("#img").attr("src");
	  			
	  		if(!name||!img)
	  		{
	  			  alert("请检查上传图片和图片名!");
				  return false;
	  		}
	  		return true;
	  	});
	  	
	  	$("#image").change(function(){
	  		var type=$("#image").val();
	  		if(type==1){
	  			$("#xiaotu").css("display","");
	  			$("#msg").text("* 注意：请添加494*244大小的图片");
	  		}else{
	  			$("#xiaotu").css("display","none");
	  			$("#msg").text("* 注意：请添加1440*400大小的图片");
	  		}
	  		
	  		
	  		
	  	});
	  	
	  	
	  	
  });
  /*window.onload=function(){
	  document.getElementById("img").style.display="none";
	  document.getElementById("sc").onclick=function(){
		  //上传表单检查
		  
		  var name=document.getElementById("iName").value;
		  var img=document.getElementById("img").src;
		  
		  if(name==""||img=="")
		  {
			  alert("请检查上传图片和图片名!");
			  return false;
		  }
		  return true;	
 	 }
  }*/
  function show(){ 
	  var file = document.getElementById("f").files[0]; 
	  var fileReader = new FileReader(); 
	  fileReader.readAsDataURL(file); 
	  fileReader.onload = function(){ 
		  document.getElementById("img").style.display="";
	  document.getElementById("img").src = fileReader.result; 
	 
	  } 
	 }
  </script>
  
  <body>
  <p>${error }</p>
   <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
    	<div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i>添加图片</div>
        </div><br>
	<div class="result-wrap">		
 	  	<table border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
     <td height="50" align="center" valign="middle">
<form action='<c:url value="/UploadImage"></c:url>' method="post" enctype="multipart/form-data" name="form1">
<table class="insert-tab" width="100%">
   <tbody>
   <tr>
      	<th width="120"><i class="require-red">*</i>请选择图片位置</th>
      
      <td>
     <select id="image" name="isImage">
		<option value="3">首页轮播大图</option>
		<option value="1">首页中间小图</option>
	</select>
		<i id="msg" class="require-red">* 注意：请添加1440*400大小的图片,不满足格式系统会自动压缩！</i>
      </td>
      
	</tr>     
	<tr id="xiaotu">
	<th width="120"><i class="require-red">*</i>请选择小图位置</th>
	<td ><select id="image1" name="iLocation">
		<option value="1">左上图</option>
		<option value="2">右上图</option>
		<option value="3">左下图</option>
		<option value="4">右下图</option>
	</select></td>
	</tr>
	<tr>
      <th><i class="require-red">*</i>请输入图片名</th>
      <td>
		<input type="text" id="iName" name="iName" /> 
        <input type="file" onChange="show()" id="f" name="file"/>
      </td>
	</tr>
	<tr>
      <th></th>
      <td>
	<input type="submit" id="sc"  name="Submit" value="上传">
      </td>
	</tr>
	</tbody>
</table>	
     </form>
     </td>
 <tr>
 <td><img  width="400"  height="260" id='img' /></td></tr>
 <tr>
 	请与您配置的产品中心的二级菜单顺序一一对应！
 </tr>
</table>
		</div>
		</div>
    <!--/main-->
    </div>
  
  

  </body>
</html>
