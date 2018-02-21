<!--微信支付 AJAX 跳转-->
<script>
//设置每隔1000毫秒执行一次 load() 方法
setInterval(function(){ load() }, {$checkTime});
function load() {
	$.ajax({
		cache: false,
		type: "GET",
		url: "{$systemurl}/modules/gateways/WePay/order_query.php",//提交的URL
		data: { out_trade_no: "{$invoiceid}" },
		dataType:"json",
		async: true,
		success: function (data) {
			// 判断是否成功
			if (data.code == "SUCCESS") {
	            $(".PayIMG").hide();
	            $(".Paytext").html("支付成功");
	            setTimeout(function(){ window.location.href="{$returnurl}" }, 2000);
			} else if (data.code == "USERPAYING") {
	            $(".Paytext").html("正在等待支付结果 请勿关闭当前页面");
			}
		}
	});
}

window.jQuery || document.write("<script src=\"//cdnjs.neworld.org/ajax/libs/jquery/3.1.0/jquery.min.js\"><\/script>");
</script>
<style>
.PayCode {
    margin: 20px auto 0;
    position: relative;
    background-color: #FFF;
}
.PayIMG {
	padding: 2px;
	position: relative;
	margin-bottom: 10px;
}
.PayIMG .WePay {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 48px;
    height: 48px;
    padding: 5px;
    margin-left: -24px;
    margin-top: -24px;
    background-color: #FFF;
	border-radius: 50px;
}
.PayIMG img {
	border-radius: 4px;
	width: 100%;
	height: 100%;
}
.Paytext {
	color: #FFF;
	text-align: center;
	padding: 5px 10px;
    background-color: #31AD37;
    border-radius: 50px;
}
</style>
<script src="{$WEB_ROOT}/modules/gateways/WePay/qrcode.min.js"></script>
<div class="PayDiv">
    <div class="PayCode" id="PayCode">
    	<div class="PayIMG" id="qrcode">
	    	<img class="WePay" src="{$WEB_ROOT}/modules/gateways/WePay/WePay-icon.png" alt="" />
    	</div>
    	<div class="Paytext">
	    	打开微信客户端 扫一扫继续付款
	    </div>
    </div>
</div>
<script>
(function() {
    var qrcode = new QRCode("qrcode", {
        text: '{$qrcode}',
        width: 500,
        height: 500,
        colorDark : "#000",
        colorLight : "#FFF",
        correctLevel : QRCode.CorrectLevel.L
    });
})();
</script>