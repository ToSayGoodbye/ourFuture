<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(path);
System.out.println(basePath);
System.out.println(request.getRequestURI());
System.out.println(application.getRealPath(request.getRequestURI()));
System.out.println(application.getRealPath("/"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>
<body style="height:100%;">
<form id="login" action="./login.do" method="post">
<table border="1" align="center">
	<tr>
		<td>用户名</td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td>密码</td>
		<td><input type="text" name="score"></td>
	</tr>
	<tr>
		<td><input type="button" value="登录" onclick="login()"></td>
		<td><input type="button" value="注册"></td>
		<td><input type="submit" value="增加"></td>
	</tr>
</table>
</form>
<div style="border:1px solid">
<form id="uploadForm" name="Form2" action="./upload.do" method="post"  enctype="multipart/form-data">
<h1></h1>
<input type="file" name="file">
<input type="file" name="file">
<input type="text" name="sport">
<input type="button" onclick="upload()" value="上传"/>
</form>
</div>
<a href="./download.do" >下载</a>  
  <script src="js/jquery-2.0.0.min.js"></script>
  <script type="text/javascript">
  function upload(){
	  var data = new FormData($("#uploadForm")[0]);  
	  $.ajax({
			 type : "POST",	
			 dataType: 'json',
			 data:data,
	    	 url : "./upload.do",
	    	 async: false,  
	          cache: false,  
	          contentType: false,  
	          processData: false, 
	    	 success: function(data){
	    		 debugger;
	    		 //alert(1);
	            }
	  });
  }
  function login(){
	  var data = $('#login').serialize();
	  $.ajax({
			 type : "POST",	
			 dataType: 'json',
			 data:data,
	    	 url : "./check.do",    			 
	    	 success: function(data){
	    		 debugger;
	    		 if(data.msg=="用户名不正确"){
	    			 alert(data.msg);
	    		 }else if(data.msg=="密码不正确"){
	    			 alert(data.msg);
	    		 }else{
	    			 document.forms[0].submit();
	    		 }
	            }
	  });
  }
  </script>
</body>
</html>
