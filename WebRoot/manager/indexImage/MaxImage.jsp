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
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="/LiTian/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/LiTian/manager/css/main.css"/>
    <script type="text/javascript" src="/LiTian/manager/js/libs/modernizr.min.js"></script>
    <script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
  </head>
  <script>
  $(function(){
  $("tbody tr td").find("a:last").click(function(){
			
		var iids=$(this).attr("iid");
		$.ajax({
			url:"/LiTian/indexServlet",
			data:{method:"removeImage",iId:iids},
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
		//
		$("tbody tr td").find("a:first").toggle(function(){
  			  
  				
  			//把他的1个td变成input
  			
  			var id=$(this).attr("id");
  			var name=$(this).attr("names");
  			
  			
  			$("#"+id+"a").replaceWith("<td><input type='text' id='"+id+"1"+"' name='iName' value='"+name+"'/></td>");
  			
  			$("table tr td").find("a").css("display","none");
  			$(this).css("display","");
  			$(this).text("确认修改");
  	
  				//提交ajax
  			},function(){
  				
  				var id=$(this).attr("id");
  				var namenew=$("#"+id+"1").val();
  	  			
  	  			if(namenew==""){
  	  				alert("不允许关键字空字段");
  	  				return false;
  	  			}
  				$.ajax({
  					url:"/LiTian/indexServlet",
  					data:{method:"ajaxedidInfo",iId:id,iName:namenew},
  					type:"POST",
  					dataType:"json",
  					async:false,
  					cache:false,
  					success:function(arr){
  						if(arr){
  							alert("修改成功");
  							window.location.reload();
  							
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
            <div class="crumb-list"><i class="icon-font"></i>编辑轮播图</div>
        </div>
    <div class="result-wrap">
           <div class="result-title">
                    <div class="result-list">
                    <a id="add" href='<c:url value="/manager/indexImage/addImage.jsp"></c:url>' ><i class="icon-font"></i> 添加/修改</a>
                    </div>
           </div>
                <div class="config-items">

                    <div class="result-content">
                    <p id="msg"></p>
                     <form action="/think/admin/system/save" method="post" id="myform" name="myform">
                 	 <table class="result-tab" width="100%">
                    		<caption><h1>主页信息设置</h1></caption>
                        <tr>
                        	<th>提示语</th>
                            <th>图片</th>
                          	
                            <th>操作</th>
                        </tr>
                        <tbody id="tb">
                        	<c:forEach items="${MaxImageList}" var="list" >
                   			<tr class="${list.iId } abc">
                   				<td id="${list.iId }a">${list.iName }</td>
                   				
                   				<td><img width="555" height="154" src="${list.sImage}"/></td>
                   				<td><a names="${list.iName }" href="#" id="${list.iId }">重命名</a>  <a href="#" iid=${list.iId }>删除</a></td>
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
