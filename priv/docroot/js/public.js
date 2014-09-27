
$(function(){
    $("#sidePanel ul li").click(function(){
        var $index = $(this).index();
        $("#sidePanel ul li").removeClass( "selected" );
        $("#sidePanel ul li").eq($index).addClass( "selected" );
        var $iframeUrl = $("#sidePanel ul li").eq($index).attr( "data" );
        $("#gm_iframe").attr( "src", $iframeUrl );
        
    });
    $("#conPanel .title_tab li").click(function(){
        if($(this).attr("class") != "selected"){
            $(this).attr( "class", "selected" );
            $(this).siblings().removeClass( "selected" );
            var $index = $(this).index();
            $("#select_option").val( $index );
            $("#conPanel>div").hide();
            $("#conPanel>div").eq($index).show();
        }
    });

})

//iframe自适应高度
function reinitIframe( id ){
    var iframe = document.getElementById(id);
    var bHeight = iframe.contentWindow.document.body.scrollHeight;
    var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
    var height = Math.max(bHeight, dHeight);
    if( height >= 500 ){
        iframe.height =  height;    
    }else{
        iframe.height =  500;
    }
}
function parentIframe( id ){
    var iframe = self.parent.frames[id];
    var height = document.body.scrollHeight;
    if( height >= 500 ){
        iframe.height =  height;    
    }else{
        iframe.height =  500;
    }
}

function setCookie(key,value,expiredays)
{
    var exdate=new Date()
    exdate.setDate(exdate.getDate()+expiredays)
    document.cookie=key+ "=" +escape(value)+
    ((expiredays==null) ? "" : ";expires="+exdate.toGMTString())
}

function getCookie(key)
{
    if (document.cookie.length>0)
    {
        c_start=document.cookie.indexOf(key + "=")
        if (c_start!=-1){ 
            c_start=c_start + key.length+1 
            c_end=document.cookie.indexOf(";",c_start)
            if (c_end==-1) c_end=document.cookie.length
            return unescape(document.cookie.substring(c_start,c_end))
        } 
    }
    return ""
}

//ajax 发送数据给服务端
function ajax($url, $callback){
    $("#errorBg").show();
    $("#loading span").show();
    $.ajax({
        url:$url,
        dataType: "json",
        error:function(){
            $("#errorBg").hide();
            alert( "链接服务器失败，请稍后重试！" );
        },
        success:function(data){
            $("#errorBg").hide();
            $("#loading span").hide();
            callback( data, $callback );
        }
    })
}

function now_to_time(now){
    var year=now.getFullYear();
    var month=now.getMonth()+1;
    var date=now.getDate();
    return year+"/"+month+"/"+date;
}
