<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery.plupload.queue/css/jquery.plupload.queue.css">
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
	
	<script src="${pageContext.request.contextPath}/js/jquery-2.0.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>  

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css"/>
    <style>
    </style>
</head>
	<%
	String name = (String)session.getAttribute("user");
	if(name==null)response.sendRedirect(request.getServletContext().getContextPath()+"/login.html");
	%>
<body onload="query(0,'','')">
   <nav class="navbar navbar-inverse">
       <div class="container-fluid">
           <!-- Brand and toggle get grouped for better mobile display -->
           <div class="navbar-header">
               <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                   <span class="sr-only">Toggle navigation</span>
                   <span class="icon-bar"></span>
                   <span class="icon-bar"></span>
                   <span class="icon-bar"></span>
               </button>
               <a class="navbar-brand" href="#" onclick="toOpen()">Brand</a>
           </div>

           <!-- Collect the nav links, forms, and other content for toggling -->
           <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
               <ul class="nav navbar-nav">
                   <li><a href="#">Link <span class="sr-only">(current)</span></a></li>
                   <li><a href="#">Link</a></li>
                   <li>
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown </a>

                   </li>
                   <li>
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown </a>

                   </li>
               </ul>
               <form class="navbar-form navbar-right">
                   <div class="form-group">
                   		 <span style="color:#A98E8E">你好,<%=session.getAttribute("user")%>!</span>
                       <input type="text" class="form-control" placeholder="Search">
                   </div>
                   <a href="" class="btn btn-default">退出</a>
                   <input type="hidden" id="onTimeCount">
               </form>
           </div><!-- /.navbar-collapse -->
       </div><!-- /.container-fluid -->
   </nav>
	<div class="container-fluid">
            <div class="row">
                <div class="col-sm-2">
                    <a href="#" class="list-group-item active"> 图片管理</a>
                    <a href="#" class="list-group-item" style="height:40px">
                        <span class="glyphicon glyphicon-home"> 内科图片</a>
                    <a href="#" class="list-group-item" style="height:40px">
                        <span class="glyphicon glyphicon-file"> 图片列表</a>
                      <a href="#" class="list-group-item" style="height:40px">
                        <span class="glyphicon glyphicon-th-large"> 图片列表</a>
                      <a href="#" class="list-group-item" style="height:40px">
                        <span class="glyphicon glyphicon-home"> 图片列表</a>
                      <a href="#" class="list-group-item" style="height:40px">
                        <span class="glyphicon glyphicon-th-large"> 图片列表</a>
                      <a href="#" class="list-group-item" style="height:40px">
                        <span class="glyphicon glyphicon-th-large"> 图片列表</a>
                      <a href="#" class="list-group-item" style="height:40px">
                        <span class="glyphicon glyphicon-th-large"> 图片列表</a>
                       <a href="#" class="list-group-item" style="height:40px">
                        <span class="glyphicon glyphicon-user"> 图片列表</a>
                	<img alt="" style="width: 200px; height: 200px" src="${pageContext.request.contextPath}/img/select.png">
                </div>
                
                <div id="myAlert" class="alert alert-warning" style="display:none;position:absolute">
				    <a href="#" class="close" data-dismiss="alert">&times;</a>
				    <strong>警告！</strong>您的网络连接有问题。
				</div>
                <div class="col-sm-10">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                      		      搜索
                        </div>
                        <div class="panel-body">
                            <form role="form" class="form-inline">
                                <div class="form-group">
                                    <label for="name">名称</label>
                                    <input type="text" class="form-control" id="name" placeholder="请输入名称">
                                </div>
                                <div class="form-group">
                                    <label for="name">状态</label>
                                    <select id="type"  class="form-control">
                                        <option value="">所有</option>
                                        <option value="1">A类</option>
                                        <option value="2">B类</option>
                                        <option value="3">C类</option>
                                        <option value="4">D类</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <a onclick="toQuery()" class="btn btn-default">搜索</a>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover" id="reportTable">
                            <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>名称</th>
                                    <th>类别</th>
                                    <th>图片简介</th>
                                    <th>备注</th>
                                    <th>状态</th>
                                    <th>上传时间</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="listBody">

                            </tbody>
                        </table>
                    </div>
                    <div class="span6" style="width:25%;" >
					 <div id="DataTables_Table_0_info" class="dataTables_info">当前第 <span id="page">1</span> 页，共 <span id="total"></span> 项</div>
					 </div>
                    <ul class="pager" style="margin-top:-30px;padding-left:-50px">
						<li>
							<a href="#" onclick="preView()">上一页</a>
						</li>
						<li>
							<a href="#" onclick="nextView()">下一页</a>
						</li>
					</ul>
                </div>
            </div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		<div class="modal-dialog">
			<div class="modal-content" style="width:810px;padding:0px";height:371px>
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel">
						上传图片
					</h4>
				</div>
				<div class="modal-body" style="padding:15px;height:470px">
						<form id="photoForm" role="form"  class="form-horizontal" action="./addPhoto.do">
						  <div class="form-group">
						    <label for="picture_name" class="col-sm-2 control-label">图片名称：</label>
						     <div class="col-sm-10">
						    	<input type="text" class="form-control" id="picture_name" placeholder="请输入图片名称">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="picture_type" class="col-sm-2 control-label">图片分类：</label>
						    <div class= "col-sm-10">
	                              <select id="picture_type" class= "form-control selectpicker">
	                                   <option value="1">A类</option >
	                                   <option  value="2">B类</option >
	                                   <option  value="3">C类</option >
	                                   <option  value="4">D类</option >
	                              </select>
	                         </div>
						  </div>
						  <div class="form-group">
						  	  <label for="upload" class="col-sm-2 control-label">选择图片：</label>
						  	  <div class="col-sm-10">
								  <img id="upload" alt="" style="width: 200px; height: 200px" src="${pageContext.request.contextPath}/img/select.png">  
							   </div>
								<!-- 隐藏file标签 -->  
								<input id="fileToUpload" onchange="changeEvent()" style="display: none" type="file" name="upfile"><br/>  
						  </div>
						  <div class="form-group">
						    <label for="picture_information" class="col-sm-2 control-label">图片描述：</label>
						    <div class="col-sm-10">
							    <textarea id="picture_information" name="picture_information" class="form-control" rows="3" placeholder="请输入图片描述"></textarea>
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="comment" class="col-sm-2 control-label">备注：</label>
						     <div class="col-sm-10">
						    	<input type="text" class="form-control" id="comment" placeholder="请输入备注">
						    </div>
						  </div>
						</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-default" onclick="addPhoto()">提交</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		<div class="modal-dialog">
			<div class="modal-content" style="width:500px;padding:0px";height:300px>
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 id="imgName" class="modal-title" id="myModalLabel">
						
					</h4>
				</div>
				<div class="modal-body" style="padding:15px;height:350px">
					  <img id="viewImg" style="width: 200px; height: 200px;margin-top:40px;margin-left:120px">  
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
</body>
<script>
$(function(){  
    //点击打开文件选择器  
    $("#upload").on('click', function() {  
        $('#fileToUpload').click();  
    });
    
    setOnTimeCount();
    
    var getting = {
            url:'./countLevel.do',
            dataType:'json',
            success:function(res) {
            	if($('#onTimeCount').val()!=res){
            		$('#onTimeCount').val(res);
            		toQuery();
            	}
             	$.ajax(getting); //关键在这里，回调函数内再次请求Ajax
    		},        
    		
            //当请求时间过长（默认为60秒），就再次调用ajax长轮询
            error:function(res){
            	$.ajax($getting);
            }

    };
    //开始
    //$.ajax(getting);
    
});   
	function setOnTimeCount(){
		$.ajax({
			url:'./countLevel.do',
            dataType:'json',
            async:false,
            success:function(res){
            	$('#onTimeCount').val(res);
            }
		})
	}
	function query(page,name,picture_type){
		//$('#reportTable').bootstrapTable('showLoading');
		 $.ajax({
			 type : "POST",	
			 dataType: 'json',
			 data:{page:page,pagesize:"16",name:name,picture_type:picture_type},
		   	 url : "./queryPhotos.do",    			 
		   	 success: function(data){
		   		 $('#page').html(data.page+1);
		   		 $('#total').html(data.total);
		   		if(data.rows.length>0){
		   			for (var i = 0; i < data.rows.length; i++) {
			   			 var trClass="";
				   		 if(data.rows[i].level==1){
				   			trClass="info";
				   		 }
		   				var path=data.rows[i].picture_path.replace(new RegExp(/\./g),'\\.').replace(new RegExp(/\//g),'\\/');
		   			 $('<tr class="'+trClass+'">'+
		   		            '<td style="padding:0px">'+data.rows[i].id+'</td>'+
		   		            '<td style="padding:0px">'+data.rows[i].picture_name+'</td>'+
		   		           '<td style="padding:0px">'+getType(data.rows[i].picture_type)+'</td>'+
		   		           '<td style="padding:0px">'+data.rows[i].picture_information+'</td>'+
		   		           '<td style="padding:0px">'+data.rows[i].comment+'</td>'+
		   		        	'<td style="padding:0px">正常</td>'+
		   		     		'<td style="padding:0px">'+data.rows[i].putin_date+'</td>'+
		   		            '<td style="padding:0px">'+
		   		                '<div class="btn-group" style="height:30px">'+
		   		                  '<a onclick="view(\'' +path+ '\',\''+data.rows[i].picture_name+'\')" class="btn btn-default" style="padding-top:2px;padding-bottom:2px;margin-top:2px">查看</a>'+
		   		                  '<a href="" class="btn btn-default" style="padding-top:2px;padding-bottom:2px;margin-top:2px">下架</a><a onclick="dele(\''+data.rows[i].id+'\')" class="btn btn-danger" style="padding-top:2px;padding-bottom:2px;margin-top:2px">删除</a>'+
		   		                '</div></td></tr>').appendTo($('#listBody'));
		   			}
		   		}
	        }
		});
	}
	function getType(type){
		switch(Number(type)){
			case 1:
				return "A类";
			case 2:
				return "B类";
			case 3:
				return "C类";
			case 4:
				return "D类";
		}
	}
	function view(path,name){
		 $("#viewImg").attr("src",path);  
		 $('#imgName').html(name);
		 $('#myModal2').modal({
		        keyboard: true
		  })
	}
   //选择文件之后执行上传  
   	function changeEvent(){
   		 $.ajaxFileUpload({  
               url:'./toUpload.do',  
               secureuri:false,  
               fileElementId:'fileToUpload',//file标签的id  
               dataType: 'json',//返回数据的类型  
               data:{name:'logan'},//一同上传的数据  
               success: function (data, status) { 
                   $("#upload").attr("src", "../photo/"+data.fileName);  
               },  
               error: function (data, status, e) {  
                   alert(e);  
               }  
           });  
   	}
        

function toOpen(){
	  $('#myModal').modal({
	        keyboard: true
	  })
	   $('#myModal').on('hide.bs.modal', function () {
	    	$('#name').val("");
	    	$('#comment').val("");
	    	$('#picture_information').val("");
	    	$("#upload").attr("src", "./img/select.png");  
	    })
}
function addPhoto(){
	var name = $('#picture_name').val();
	var picture_type = $('#picture_type').val();
	var comment = $('#comment').val();
	var picture_path = $("#upload").attr("src");
	var picture_information = $('#picture_information').val();
	$.ajax({
		 type : "POST",	
		 dataType: 'json',
		 data:{name:name,comment:comment,picture_path:picture_path,picture_information:picture_information,picture_type:picture_type},
	   	 url : "./addPhoto.do",    			 
	   	 success: function(data){
	   		 if(data.status=="success"){
	   			 toQuery();
	   			 alert("上传成功！");
	   		 }else{
	   			 alert("图片信息填加失败！");
	   		 }
         }
 	});
}
function dele(id){
	if(confirm("确认删除该图片信息？")){
		$.ajax({
			 type : "POST",	
			 dataType: 'json',
			 data:{id:id},
		   	 url : "./deletePhoto.do",    			 
		   	 success: function(data){
		   		 if(data.status=="success"){
		   			 toQuery();
		   		 }else{
		   			 alert("图片删除失败！");
		   		 }
	        }
		});
	}
}
function preView(){
	if($('#page').html()!="1"){
		$("table tbody").html("");
		var name=$('#name').val();
		var type=$('#type').val();
		query(Number($('#page').html()-2),name,type);
	}
}
function nextView(){
	if(Number($('#total').html())>10 && Number($('#page').html())*10<Number($('#total').html())){
		$("table tbody").html("");
		var name=$('#name').val();
		var type=$('#type').val();
		query(Number($('#page').html()),name,type);
	}
}
function toQuery(){
	$("table tbody").html("");
	var name=$('#name').val();
	var type=$('#type').val();
	query(0,name,type);
}
</script>
</html>