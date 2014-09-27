//iframe自适应高度
function reinitIframe( id ){
	var iframe = document.getElementById(id);
	var bHeight = iframe.contentWindow.document.body.scrollHeight;
	var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
	var height = Math.max(bHeight, dHeight);
	iframe.height =  height;
}

//ajax 发送数据给服务端
function ajax($url, $callback){
    $.ajax({   
        url:$url,
        dataType: "json", 
        error : function() {
                alert( "链接服务器失败，请稍后重试！" );
        },
        success:function(data){
               callback( data, $callback );
        }
    })
}