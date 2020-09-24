<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>SQLErrorCodeSQLExceptionTranslator
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>首页跳转</title>
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${not empty aLiPayInfo}">
			<table align="center" width="800">
				<tr>
					<th width="60%">费用：</th>
					<td width="30%">${aLiPayInfo.total_amount}元（￥）</td>
				</tr>
				<tr>
					<th width="60%">描述：</th>
					<td width="30%">${aLiPayInfo.subject}</td>
				</tr>
				<tr>
					<th width="60%">详情：</th>
					<td width="30%">${aLiPayInfo.body}</td>
				</tr>
				<tr><th colspan="2">
					<c:choose>
						<c:when test="${aLiPayInfo.code != '10000'}">${aLiPayInfo.code} : ${aLiPayInfo.msg}</c:when>
						<c:when test="${not empty src}"><img src="<%=basePath%>${src}" width="200" height="200" /></c:when>
						<c:otherwise>${aLiPayInfo.msg}</c:otherwise>
					</c:choose></th>
				</tr>
			</table>
		</c:when>
		<c:when test="${not empty payInfo}">
			<table align="center" width="800">
				<tr>
					<th width="60%">费用：</th>
					<td width="30%">${payInfo.total_fee / 100}元（￥）</td>
				</tr>
				<tr>
					<th width="60%">描述：</th>
					<td width="30%">${payInfo.body}</td>
				</tr>
				<tr>
					<th width="60%">详情：</th>
					<td width="30%">${payInfo.detail}</td>
				</tr>
				<tr>
					<th colspan="2">
						<c:choose>
							<c:when test="${(not empty return_msg && payInfo.return_msg != 'OK')}">${payInfo.return_msg}</c:when>
							<c:when test="${not empty payInfo.err_code_des}">${payInfo.err_code_des}</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${payInfo.trade_type == 'JSAPI'}">
		<!-- 								<a href="javascript:callpay();" >支付</a> -->
										<a href="${payInfo.code_url}" >${payInfo.code_url}</a>
									</c:when>
									<c:when test="${payInfo.trade_type == 'NATIVE'}"><img src="<%=basePath%>${src}" width="200" height="200" /></c:when>
									<c:when test="${payInfo.trade_type == 'APP' }"><a href="${payInfo.code_url}" >${payInfo.code_url}</a></c:when>
									<c:when test="${payInfo.trade_type == 'MICROPAY'}"></c:when>
									<c:otherwise><img src="<%=basePath%>${src}" width="200" height="200" /></c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</th>
				</tr>
			</table>
		</c:when>
	</c:choose>
	
	<script type="text/javascript">
		function jsApiCall() {
// 			var $dialog = $('#dialog2');
// 			var $dialog1 = $('#dialog3');
			WeixinJSBridge.invoke('getBrandWCPayRequest', {
				"appId" : '${payInfo.appId}',
				"timeStamp" : '${payInfo.timeStamp}',
				"nonceStr" : '${payInfo.nonce_str}',
				"package" : '${payInfo.packages}',
				"signType" : '${payInfo.sign_type}',
				"paySign" : '${payInfo.paySign}'
			}, function(res) {				
				if (res.err_msg == "get_brand_wcpay_request:ok") {					
					WeixinJSBridge.call('closeWindow');
				} else if(res.err_msg == "get_brand_wcpay_request:cancel") {
				alert("用户取消支付！");
// 					$dialog.show();
// 					$dialog.find('#submitBtn').on('click', function() {
// 						$dialog.hide();
// 					});
				}else {
				alert("支付失败！");
// 					$dialog1.show();
// 					$dialog1.find('#submitBtn').on('click', function() {
// 						$dialog1.hide();
// 					});
				}
			});
		}
		function callpay() {
			if (typeof WeixinJSBridge == "undefined") {
				if (document.addEventListener) {
					document.addEventListener('WeixinJSBridgeReady', jsApiCall,false);
				} else if (document.attachEvent) {
					document.attachEvent('WeixinJSBridgeReady', jsApiCall);
					document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
				}
			} else {
				jsApiCall();
			}
		}
	</script>
</body>
</html>
