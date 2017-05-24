<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	
    
    <title>力天筑路后台管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
 	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/manager/css/main.css"/>
  </head>
  <script>
  	$(function(){
  		//当点击按钮是就把td变成一个编辑框
  		$("table tr td").find("a:last").click(function(){
  				var cId=$(this).attr("cid");
  				$.ajax({
  					url:"/LiTian/ClassifyServlet",
  					data:{method:"ajaxRemoveMenu",cid:cId},
  					type:"POST",
  					dataType:"json",
  					async:false,
  					cache:false,
  					success:function(result){
  						if(result){
  							alert("删除成功！");
  							$("."+cId).remove();
  							if($(".abc").length==0){
									$("#msg").text("没有了");
							}
  						}else{
  							alert("删除失败");
  						}
  					}
  					
  				});
  			
  			
  		});
  		
  		$("table tr td").find("a:first").toggle(function(){
  			//把他的2个td变成input
  			var id=$(this).attr("id");
  			var name=$(this).attr("names");
  			var desc=$(this).attr("desc");
  			var addr=$(this).attr("addr");
  			var pname=$(this).attr("pnames");
  			var pid=$(this).attr("pid");
  			//对于修改一级菜单应该是下拉框的
  			$("#"+id+"a").replaceWith("<td><input type='text' id='"+id+"1"+"' name='cName' value='"+name+"'/></td>");
  			$("#"+id+"c").replaceWith("<td><select id='"+id+"cate"+"' name='nType'></select></td>");
  			//ajax
  			
		$.ajax({
		url:"/LiTian/ClassifyServlet",
		data:{method:"ajaxfindone"},
		type:"POST",
		dataType:"json",
		async:false,
		cache:false,
		success:function(arr){
					
				for(var i=0;i<arr.length;i++){
					if(arr[i].cName==pname){
					var option=$("<option selected='true'>").val(arr[i].cId).text(arr[i].cName);
					}else{
						var option=$("<option>").val(arr[i].cId).text(arr[i].cName);
					}
					$("#"+id+"cate").append(option);
				}
			}
	});
  				
  			$("#"+id+"b").replaceWith("<td><input type='text' id='"+id+"2"+"' name='cDesc' value='"+desc+"'/></td>");
  			$("#"+id+"d").replaceWith("<td><input type='text' id='"+id+"4"+"' name='cAddr' value='"+addr+"'/></td>");
  			$(this).text("确认修改");
  		
  			$("table tr td").find("a").css("display","none");
  			$(this).css("display","");
  			
  				//提交ajax
  			},function(){
  				var id=$(this).attr("id");
  				var namenew=$("#"+id+"1").val();
  	  			var descnew=$("#"+id+"2").val();
  	  			var pnamenew=$("#"+id+"cate").val();
  	  			var addrnew=$("#"+id+"4").val();
  	  		if(namenew==""||pnamenew==""){
	  				alert("不允许关键字空字段");
	  				return false;
	  			}
  				$.ajax({
  					url:"/LiTian/ClassifyServlet",
  					data:{method:"ajaxEditTwoMenu",cid:id,cName:namenew,cDesc:descnew,cAddr:addrnew,pId:pnamenew},
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
	<div class="result-wrap">
	<c:choose>
		<c:when test="${!empty requestScope.twoclassifylist }">
        <div class="result-title">
                    <div class="result-list">
						<a  href='<c:url value="/manager/menu/addmenu.jsp"></c:url>'><i class="icon-font"></i>添加二级菜单</a>
                    </div>
        </div>
        <div class="result-content">
                <form>
                    <table class="result-tab" width="100%">
                    		<caption><h1>二级菜单</h1></caption>
                        <tr>
                            <th>菜单类型</th>
                            <th>所属一级菜单</th>
                           	
                            <th>菜单说明</th>
                            <th>操作</th>
                        </tr>
                        <tbody>
                       <c:if test="${empty requestScope.twoclassifylist }">没有分类</c:if>
                         <span id="msg"></span>
                      <c:forEach items="${requestScope.twoclassifylist }" var="list">
                      	<tr class="${list.cId } abc">
                      	
                      			<td id="${list.cId }a">${list.cName }</td>
                      			<td id="${list.cId }c">${list.parents.cName }</td>
                      			
                      			<td id="${list.cId }b">${list.cDesc }</td>
                      			<td><a href="#"  addr="${list.cAddr }"  pid=${list.parents.cId } pnames=${list.parents.cName } names="${list.cName }" desc="${list.cDesc }" id="${list.cId }">编辑</a>
                      			<a href="#" cid="${list.cId }" id="${list.cId }e">删除</a>
                      			</td>
                      			
                      	</tr>
                    
                      </c:forEach>
  						</tbody>
                    </table>    
                      </form> 
        </div>
                      </c:when>  
             <c:otherwise>
             		<p>对不起，没有内容！赶快添加二级菜单去吧</p>
             </c:otherwise>
			 </c:choose>
		
		</div>
    <!--/main-->
    </div>
  </div>
  </body>
</html>
