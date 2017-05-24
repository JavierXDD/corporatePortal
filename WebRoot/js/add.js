//表单验证
$(function(){
	$(".Error").each(function(){
			showError($(this));
	});
	
	//表单控件获得焦点时不显示验证信息
	$(".input").focus(function (){
		var id=$(this).attr("id");
		var error=id+"Error";
		$("#"+error).text("");
		showError();
	});
	//失去焦点时验证
	$(".input").blur(function(){
		var id=$(this).attr("id");
		var Method="Method"+id+"()";
		
		eval(Method);  //执行对应的方法
	});
	
	$("#Form1").submit(function(){
		//对表单全验证后阻止表单发送
		var bool=true;
		
		if(!Methoduid()){
			bool=false;
		}
			
		if(!Methodpassword()){
			bool=false;
		}
		if(!Methoduname()){
			bool=false;
		}
		return bool;
	});
});



//用户名
function Methoduid(){
	var id="uid";
	var value=$("#"+id).val();
	if(!value){
		//空字符
		$("#uidError").text("用户名不能为空");	
		showError($("#"+id+"Error"));
		return false;
	}
	if(value.length<3||value.length>20){
		$("#uidError").text("用户名长度应该在3-20之间");
		showError($("#"+id+"Error"));
		return false;
	}
	//用户名UID是否存在检测
	var flg=true;
	$.ajax({
		url:"/LiTian/UserServlet",
		data:{method:"ajaxUid",uid:value},
		type:"POST",
		dataType:"json",
		async:false,
		cache:false,
		success:function(result){
			if(!result){
				$("#"+id+"Error").text("用户id已经存在！");
				showError($("#"+id+"Error"));
				flg=false;
			}
		}
	});
	if(!flg){
		return false;
	}
	return true;
}
//密码
function Methodpassword(){
	var id="password";
	var value=$("#"+id).val();
	if(!value){
		//空字符
		$("#passwordError").text("密码不能为空");	
		showError($("#"+id+"Error"));
		return false;
	}
	if(value.length<6||value.length>20){
		$("#passwordError").text("密码长度应该在6-20之间");
		showError($("#"+id+"Error"));
		return false;
	}
	return true;
}
//验证码测试
function Methoduname(){
	var id="uname";
	var value=$("#"+id).val();
	if(!value){
		$("#"+id+"Error").text("姓名不能为空");
		showError($("#"+id+"Error"));
		return false;
	}
	return true;
	
};



//标签没有内容时隐藏他
function showError(obj){
	var value=obj.text();
	if(!value){
		obj.css("display","none");
	}else{
		obj.css("display","");
	}
};







