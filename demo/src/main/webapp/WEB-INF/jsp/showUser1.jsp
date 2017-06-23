<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>  
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
  <head>  
    <title>首页</title>  
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery.plupload.queue/css/jquery.plupload.queue.css">
  </head>  
    <%
	String name = (String)session.getAttribute("user");
	%>
  <body>  
    你好,<%=session.getAttribute("user")%>!
  <table id="accountTable"></table>
	                <div id="pluploader"  class="easyui-dialog" style="width:800px;height:350px;padding:0px" closed="true" >
	                    <p>你的浏览器不支持 Flash, Silverlight, Gears, BrowserPlus 或者 HTML5</p>
	                </div>
  <script src="${pageContext.request.contextPath}/js/jquery-min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
  <script src="${pageContext.request.contextPath}/js/plupload.full.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/i18n/zh_CN.js"></script>
  <script src="${pageContext.request.contextPath}/js/jquery.plupload.queue/jquery.plupload.queue.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){ 

      function toOpen(){
    	  var uploader = $("#pluploader").pluploadQueue({
              runtimes: 'html5,flash,silverlight,html4',
              url: './upload.do',
              max_file_size : '20mb',//最大文件大小
    			max_file_count: 200,//最大文件数量
    			filters : [
    				{title : "图片文件", extensions : "jpeg,jpg,gif,png"}/* ,
    				{title : "压缩文件", extensions : "zip,rar"},
    				{title : "视频文件", extensions : "Avi,MP4"} */
    			],
    			rename: true,
    			sortable: true,
    			dragdrop: true,
    			views: {
    				list: true,
    				thumbs: true, // Show thumbs
    				active: 'thumbs'
    			},
              flash_swf_url: './js/Moxie.swf',
              silverlight_xap_url: './js/Moxie.xap',
              init: {
    				FileUploaded: function (up, file, info){
    				},
    				UploadComplete:function (up, files){
    					$.messager.alert("提示信息", "您选择的文件已经全部上传，总计共"+files.length+"个文件。");
    					//$("#pluploader").dialog("close");
    					$("#pluploader").pluploadQueue().refresh();
    				}
    			}
          });
      }
  
	  $('#accountTable').datagrid({
			loadMsg : "请等待,正在加载数据......",
			singleSelect: true,
			url: "./queryUsers.do",
			width: "auto",			
			recordName:'rows',			
		    rownumbers:true,
			pageSize:10,
			pageList:[10,20,30],
			pagination:true,
			fitColumns:false,
			singleSelect:false,
			autoRowHeight:false, 
			columns:[[
				{title : '全选', field : 'ck', checkbox:true, width : 150, align : 'center'},
			    {title : '姓名', field : 'name', width : 90, align : 'left'},
			    {title : '最爱', field : 'sport', width : 90, align : 'left'},
			    {title : '描述', field : 'description', width : 90, align : 'left'}
			]],
			toolbar: [{ 
	            text: '添加', 
	            iconCls: 'icon-add', 
	            handler: function() { 
	            	toOpen();
	                $('#pluploader').dialog("open");
	                $('#pluploader_container').css("padding","0px");
	            } 
	        }]
		});
  });
 
  </script>
  </body>
</html>  