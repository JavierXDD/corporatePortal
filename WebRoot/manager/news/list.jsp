<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>力天筑路后台管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	     <script type="text/javascript" src='<c:url value="/js/jquery-1.5.1.js"></c:url>'></script>
	<link rel="stylesheet" type="text/css" href="/LiTian/manager/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/LiTian/manager/css/main.css"/>
    <script type="text/javascript" src="/LiTian/manager/js/libs/modernizr.min.js"></script>

  </head>
  <script>
  	//对删除进行确认操作
  	$(function(){
  			$("table tr td").find("a:first").click(function(){
  				if(window.confirm("确定删除?")){
  					var nid=$(this).attr("id");
  					$.ajax({
  						url:"/LiTian/NewsServlet",
  						data:{method:"ajaxDelete",nId:nid},
  						type:"POST",
  						dataType:"text",
  						async:false,
  						cache:false,
  						success:function(result){
  							//俩种方案  一是重新加载该页面 2 是 用js删去该节点
  								// 1 window.location.reload();
  								$("."+nid).remove();
  								if($(".abc").length==0){
  										$("#msg").text("没有新闻了，都被你删光了");
  								}
  								alert(result);
  						}
  					});
  					
  				}
  				
  			});
  	  	
  	 });
  	//删除管理员
  	
  
  	
  </script>
  <body>
  <div class="container clearfix" style="margin-left:-191px">
    <div class="main-wrap">
    <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i>新闻管理</div>
        </div>
			<div class="result-wrap">
                <div class="result-title">
                    <div class="result-list">
                        <a href="${pageContext.request.contextPath }/manager/news/addNews.jsp"><i class="icon-font"></i> 增加新闻</a>
                    </div>
                </div>
                <div class="result-content">  
            <c:if test="${!empty requestScope.pb.beanList }">
        	<table class="result-tab" width="100%">
        	<tr>
                <th>类型</th>
        		<th>编辑者</th>
        		<th>主题</th>
        		<th>编辑时间</th>
     			<th>操作</th>
            </tr>
        	<tbody >
        <c:forEach items="${pb.beanList}" var="newlist">
        	<tr class="${newlist.nId} abc">
        		<td>${newlist.nTypes.cName }</td>
        		<td>${newlist.nEditors.uName }</td>
        		<td>${newlist.nTheme }</td>
        		<td>${newlist.nTime }</td>
				<td><a id="${newlist.nId}" style="cursor:pointer;" >删除</a>  <a href='<c:url value="NewsServlet?method=editShowNew&nid=${newlist.nId }"></c:url>'>编辑</a></td>
        	</tr>	 	
      	 </c:forEach>
        </tbody>
        </table>
         </c:if>
		<c:if test="${empty requestScope.pb.beanList }">
 			没有新闻！
		</c:if> 
		<p id="msg"></p>
		</div>
		
		<div class="list-page">
		<center>
					第${pb.pc }页/共${pb.tp }页 <a href="${pb.url }&pc=1">首页</a>
					<c:if test="${pb.pc > 1 }">
						<a href="${pb.url }&pc=${pb.pc-1}">上一页</a>
					</c:if>

					<%-- 计算begin、end --%>
					<c:choose>
						<%-- 如果总页数不足10页，那么把所有的页数都显示出来！ --%>
						<c:when test="${pb.tp <= 10 }">
							<c:set var="begin" value="1" />
							<c:set var="end" value="${pb.tp }" />
						</c:when>
						<c:otherwise>
							<%-- 当总页数>10时，通过公式计算出begin和end --%>
							<c:set var="begin" value="${pb.pc-5 }" />
							<c:set var="end" value="${pb.pc+4 }" />
							<%-- 头溢出 --%>
							<c:if test="${begin < 1 }">
								<c:set var="begin" value="1" />
								<c:set var="end" value="10" />
							</c:if>
							<%-- 尾溢出 --%>
							<c:if test="${end > pb.tp }">
								<c:set var="begin" value="${pb.tp - 9 }" />
								<c:set var="end" value="${pb.tp }" />
							</c:if>
						</c:otherwise>
					</c:choose>
					<%-- 循环遍历页码列表 --%>
					<c:forEach var="i" begin="${begin }" end="${end }">
						<c:choose>
							<c:when test="${i eq pb.pc }">
								[${i }]
							</c:when>
							<c:otherwise>
								<a href="${pb.url }&pc=${i}">[${i }]</a>
							</c:otherwise>
						</c:choose>

					</c:forEach>

					<c:if test="${pb.pc < pb.tp }">
						<a href="${pb.url }&pc=${pb.pc+1}">下一页</a>
					</c:if>
					<a href="${pb.url }&pc=${pb.tp}">尾页</a>
				</center>
		</div>
	</div>
	</div>
    </div> 
    <!--/main-->

  </body>
</html>
