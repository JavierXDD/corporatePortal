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
	
	$("#Form2").submit(function(){
		//对表单全验证后阻止表单发送
		var bool=true;
		if(!Methodold()){
			bool=false;
		}
		
		if(!Methodnew()){
			bool=false;
		}
		
		if(!Methodrenew()){
			bool=false;
		}
		
		return bool;
	});
});



//用户名
function Methodold(){
	var id="old";
	var value=$("#"+id).val();
	if(!value){
		//空字符
		$("#oldError").text("旧密码不能为空");	
		showError($("#"+id+"Error"));
		return false;
	}
	var flg=true;
	$.ajax({
		url:"/LiTian/UserServlet",
		data:{method:"ajaxPassword",password:value},
		type:"POST",
		dataType:"json",
		async:false,
		cache:false,
		success:function(result){
			if(result){
				$("#"+id+"Error").text("旧密码错误！");
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
function Methodnew(){
	var id="new";
	var value=$("#"+id).val();
	if(!value){
		//空字符
		$("#newError").text("新密码不能为空");	
		showError($("#"+id+"Error"));
		return false;
	}
	if(value.length<6||value.length>20){
		$("#newError").text("密码长度应该在6-20之间");
		showError($("#"+id+"Error"));
		return false;
	}
	return true;
}
//验证码测试
function Methodrenew(){
	var id="renew";
	var value=$("#"+id).val();
	var value2=$("#new").val();
	if(!value){
		$("#"+id+"Error").text("新密码不能为空");
		showError($("#"+id+"Error"));
		return false;
	}
	if(value2!=value){
		
		$("#"+id+"Error").text("俩次密码不同");
		showError($("#"+id+"Error"));
		return false;
	};
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







