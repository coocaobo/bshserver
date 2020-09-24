<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage="" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>操作失败</title>
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<!-- <link rel="stylesheet" href="<%=basePath%>css/jqueryMobile/jquery.mobile-1.4.5.min.css"> -->
<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<link rel="stylesheet" href="<%=basePath%>css/weUI/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/weUI/main.css" />
<!-- <script type="text/javascript" src="<%=basePath%>js/jqueryMobile/jquery.mobile-1.4.5.min.js"></script> -->
<script language="JavaScript">
	var times = setInterval(timeOut, 1000);
	var i = 9;
	function timeOut(){
		$("#msgs").html( i + "秒后关闭页面！");
		if(i == 0){
			window.location = "${nextPage}";
// 			WeixinJSBridge.invoke('closeWindow');
// 			times.clearInterval();
		}
		i--;
	}
// 		$(document).ready(function() {
// 		});
</script>
</head>
<body style="font-size: 12px;">
<div class="page">
    <div class="weui_msg">
        <div class="weui_icon_area"><i class="weui_icon_warn weui_icon_msg"></i></div>
        <div class="weui_text_area">
            <h2 class="weui_msg_title">操作失败</h2>
            <p class="weui_msg_desc"><font color="red" size="4">${msg }</font></p>
            <p class="weui_msg_desc" id="msgs">10秒后关闭页面！</p>
        </div>
        <div class="weui_opr_area">
            <p class="weui_btn_area">
                <a href="javascript:WeixinJSBridge.invoke('closeWindow');" class="weui_btn weui_btn_primary">确定</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>