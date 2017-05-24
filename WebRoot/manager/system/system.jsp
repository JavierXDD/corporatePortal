<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>后台管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/main.css"/>
   
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
  </head>
  <script>

	$(function(){
			//添加
			$("#add").click(function(){
				$("table tr td").find("a").css("display","none");
				if($("input[type='text']").length!=0){
					alert("请先修改/添加完后再添加！");
					return false;
				}
				var s=$(".abc").length;
				$("#tb").append("<tr><td><input type='text' id='iName' name='iName' /></td>"+
				"<td><input id='iValue' type='text' name='iValue' /></td>"+
				"<td><input type='button'value='提交' id='up'/>  <input type='button' value='取消' id='canel'/></td></tr>");
				$("#canel").live("click",function(){
					//取消
					window.location.reload();
				});
				$("#up").live("click",function(){
					
					var iNames=$("#iName").val();
					 var iValues=$("#iValue").val();
					
						if(iNames==""||iValues==""){
							alert("不允许出现空字段")
							return false;
						}
						
					$.ajax({
						url:"/LiTian/indexServlet",
						data:{method:"ajaxaddInfo",iName:iNames,iValue:iValues},
						type:"POST",
						dataType:"json",
						async:false,
						cache:false,
						success:function(result){
							if(result){
								alert("添加成功！");
								window.location.reload();
									
							}else{
								alert("删除失败");
							}
						}
						
					});
					
					
				});
				
			});
		
		
		
		//删除
		$("table tr td").find("a:last").click(function(){
			
				var iids=$(this).attr("iid");
				$.ajax({
					url:"/LiTian/indexServlet",
					data:{method:"ajaxRemoveInfo",iId:iids},
					type:"POST",
					dataType:"json",
					async:false,
					cache:false,
					success:function(result){
						if(result){
							alert("删除成功！");
							$("."+iids).remove();
							if($(".abc").length==0){
								$("#msg").text("没有了");
						}
						}else{
							alert("删除失败");
						}
					}
					
				});
			
			
		});
		
		
		
		
		//当点击按钮是就把td变成一个编辑框
		$("table tr td").find("a:first").toggle(function(){
			  
			
			//把他的2个td变成input
			
			var id=$(this).attr("iid");
			var name=$(this).attr("names");
			var value=$(this).attr("values");
			
			$("#"+id+"a").replaceWith("<td><input type='text' id='"+id+"1"+"' name='iName' value='"+name+"'/></td>");
			$("#"+id+"b").replaceWith("<td><input type='text' id='"+id+"2"+"' name='iValue' value='"+value+"'/></td>");
			$(this).text("修改");
			$("table tr td").find("a").css("display","none");
			$(this).css("display","");
			
	
				//提交ajax
			},function(){
				
				var id=$(this).attr("iid");
				var namenew=$("#"+id+"1").val();
	  			var valuenew=$("#"+id+"2").val();
	  			if(namenew==""||valuenew==""){
					alert("不允许出现空字段")
					return false;
				}
				$.ajax({
					url:"/LiTian/indexServlet",
					data:{method:"ajaxEditInfo",iId:id,iName:namenew,iValue:valuenew},
					type:"POST",
					dataType:"json",
					async:false,
					cache:false,
					success:function(arr){
						if(arr){
							alert("修改成功");
							window.location.reload();
							window.parent.frames[1].location.reload();//刷新菜单框架
						}else{
							
							alert("修改失败");
							window.location.reload();

						}
					}
				});
				
			
		});
	});
			
		
		
				
  
  
  
  	
  
  </script>
  
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
    <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i>网站信息管理</div>
        </div>
    <div class="result-wrap">
         <div class="result-list">
            <a id="add" href="#"><i class="icon-font"></i> 增加信息</a>
         </div> 
                <div class="config-items">
                    <div class="result-content">
                    <p id="msg"></p>
                     <form action="/think/admin/system/save" method="post" id="myform" name="myform">
                 	 <table class="result-tab" width="100%">
                    		<caption><h1>主页信息设置</h1></caption>
                        <tr>
                            <th>条目名称</th>
                            <th>内容</th>
                            <th>操作</th>
                        </tr>
                        <tbody id="tb">
                   		<c:forEach items="${infolist }" var="list">
                   		<tr class="${list.iId } abc">
                   			<td id="${list.iId }a">${list.iName }</td>
                   			<td id="${list.iId }b">${list.iValue }</td>
                   			<td><a iid="${list.iId }" names="${list.iName }" values="${list.iValue }" ">编辑</a>
                   			 <a href="#" iid="${list.iId }" id="${list.iId }d">删除</a></td>
                   		</tr>
                   		</c:forEach>
  						</tbody>
                   	 </table>         
                   </form>
                    </div>
                </div>
           
        </div>
    <!--/main-->
    </div>
    </div>
  </body>
</html>
