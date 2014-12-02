
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
            console.log( $index );
            if( $("#thisPage").val() == "data_3" ){
                if( $index == 0 ){option_1();}
                else if( $index == 1 ){option_2();}
                else if( $index == 2 ){option_3();}                
            }
        }
    });
    try {float( ".placeholder", [{data:[["9-11",0],["9-12",0], ["9-13",0],["9-14",0],["9-15",0]],label:"暂无数据",color:2}] );}
    catch(e){};
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


function eval_divide( Key, Value, action ){
    if(Key == 0){
        return "0.00";
    }else if( Value == 0 ){
        return "0.00";
    }else{
        if(action == "%"){
            return Number(Key/Value)*100.toFixed(2);
        }else{
            return Number(Key/Value).toFixed(2);
        }
        
    }
}

//图表
// data = [{ data:[["9-11", 10], ["9-12", 8], ["9-13", 4], ["9-14", 13], ["9-15", 17], ["9-16", 9]], 
//               label: "留存数", 
//               color:2
//             },
//             { data:[["9-11", 5], ["9-12", 4], ["9-13", 2], ["9-14", 0], ["9-15", 5], ["9-16", 28]], 
//               label: "活跃数", 
//               color:3
//             }]
function float(id, data){
    var plot = $.plot(id, data, {
        series: {
            lines: {show: true},
            points: {show: true}
        },
        grid: {
            hoverable: true,
            clickable: true
        },
        xaxis: {mode: "categories",tickLength: 0},
        yaxis: {min:0}
    });

    $("<div id='tooltip'></div>").css({
        position: "absolute",
        display: "none",
        border: "1px solid #fdd",
        padding: "2px",
        "background-color": "#fee",
        opacity: 0.80
    }).appendTo("body");

    $(id).bind("plothover", function (event, pos, item) {
        if (item) {
            var x = item.datapoint[0].toFixed(2),
                y = item.datapoint[1].toFixed(2);

            $("#tooltip").html(item.series.label + y)
                .css({top: item.pageY+5, left: item.pageX+5})
                .fadeIn(200);
        } else {
            $("#tooltip").hide();
        }
    });
}