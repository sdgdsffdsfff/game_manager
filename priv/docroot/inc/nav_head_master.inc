<script type="text/javascript">
$(function(){
	var $serverId = getCookie( "serverId" );
   	if( $serverId != null && $serverId != "" ){
   		$("#serverId .show").html( $("#serverId span[title="+$serverId+"]").html() );
   		
   		$("#platformId .show").html( $("#platformId span[title="+$platformId+"]").html() );
   	}else{
   		setCookie( "serverId", "all", 365 );
   	}
   	
   	var $platformId = getCookie( "platformId" );
   	if( $platformId != null && $platformId != "" ){
   		$("#platformId .show").html( $("#platformId span[title="+$platformId+"]").html() );
   	}else{
   		setCookie( "platformId", "all", 365 );
   	}

	var $path = window.location.pathname;
	if( $path == "/" || $path == "/index.yaws" ){
		$("#nav ul li").removeClass( "selected" );
		$("#nav ul li").eq(0).addClass( "selected" );
	}
	else if( $path == "/gm/" || $path == "/gm/index.yaws" ){
		$("#nav ul li").removeClass( "selected" );
		$("#nav ul li").eq(1).addClass( "selected" );
	}
	else if( $path == "/data/" || $path == "/data/index.yaws" ){
		$("#nav ul li").removeClass( "selected" );
		$("#nav ul li").eq(2).addClass( "selected" );
	}
	else if( $path == "/userLogin/" || $path == "/userLogin/index.yaws" ){
		$("#nav ul li").removeClass( "selected" );
		$("#nav ul li").eq(3).addClass( "selected" );
	};
	
	$("#options .option").mouseover(function(){
	    var $index = $(this).index();
	    $("#options .more").eq( $index ).show();
      }).mouseout(function(){
	    var $index = $(this).index();
	    $("#options .more").eq( $index ).hide();
    });

   	$("#options .option .more_big span").click(function(){		   		
   		var $id = $(this).parent().parent().attr( "id" );
   		var $title = $(this).attr("title");
   		var $html = $(this).html();
   		if( $id == "serverId" ){
   			setCookie( "serverId", $title, 365 );
   			$("#serverId .show").html( $html );
   		}else if( $id == "platformId" ){
   			setCookie( "platformId", $title, 365 );
   			$("#platformId .show").html( $html );
   		}
   		var $iframe_src = $("#gm_iframe").attr("src");
   		var $select_option = $("#gm_iframe").contents().find("#select_option").val();
   		var obj=self.frames[0];
   		if( $select_option == 0 && $id == "serverId" ){
   			try{obj.option_1();}catch (e){}
   		}else if( $select_option == 1 && $id == "serverId" ){
   			try{obj.option_2();}catch (e){}
   		}else if( $select_option == 2 && $id == "serverId" ){
   			try{obj.option_3();}catch (e){}
   		}
   	});

})
</script>
<div id="header">
	<div class="head">
	   <ul class="nav">
	      <li><a href="http://ldp.showgames.cn/index.jsp" title="index"><span class="title_head"></span><span class="title">首页</span></a></li>
	      <li><a href="http://ldp.showgames.cn/download.jsp" title="baike"><span class="title_head"></span><span class="title">下载专区</span></a></li>
	      <li><a href="http://ldp.showgames.cn/material.jsp" title="health"><span class="title_head"></span><span class="title">游戏资料</span></a></li>
	      <li><a href="http://ldpbbs.showgames.cn/forum.php" title="circum"><span class="title_head"></span><span class="title">游戏论坛</span></a></li>
	      <li><a href="" title="shopping"><span class="title_head"></span><span class="title">关于</span></a></li>
	   </ul>
	</div>
<style type="text/css">
#options{height:30px;font-size:13px;float:right;}
#options .option{width:102px;float:left;overflow:hidden;}
#options .option span.gbma{border-style:solid dashed dashed;border-color:transparent;
                             border-top-color:silver;display:-moz-inline-box;display:inline-block;font-size:0;
                             height:0;line-height:0;width:0;border-width:3px 3px 0;padding-top:3px;}

#options a{color:#CCC;display:block;padding-top:2px;line-height:27px;}
#options .option:hover a{color:#36C;display:block;padding-top:2px;line-height:27px;background-color:white;}
#options .title{padding:0 5px;line-height:27px;display: block;
	position:relative;padding-right:9px;border-left:1px solid transparent;border-right: 1px solid transparent;}

.more{background-color:white;z-index:999;border:1px solid #BEBEBE;display:none;width:100px;padding:10px 0;min-height:100px;
    -moz-box-shadow: -1px 1px 1px rgba(0,0,0,.2);-webkit-box-shadow:0 2px 4px rgba(0, 0, 0, .2);box-shadow: 0 2px 4px rgba(0, 0, 0, .2);}

#options .option .more a{color:#36C!important;text-indent:18px;}
#options .option .more a:hover{background-color:#eee;}

.more_big{width:500px;position:absolute;right:0px;}
.more_big span{padding:0 8px;color: #36C!important;line-height: 27px;cursor: pointer;display:inline-block;}
.more_big span:hover{background-color:#eee;}

</style>
	<div id="options">
      	<div class="option" id="user">
		    <a href="/userLogin/">
		    	<span class="title"><span>%%UserData%%</span><span class="gbma"></span></span>
		    </a>
		    <div class="more">
				<div><a href="/userLogin/" onclick="location.href='/userLogin/'">个人资料</a></div>
				<div><a href="/action.yaws?action=logOut&arg=logOut" >退出</a></div>
      		</div>
      	</div>

      	<div class="option" id="serverId">
		    <a href="#"><span class="title"><span class="show" title="all">全部大区</span><span class="gbma"></span></span></a>
		    <div class="more more_big">
				%%serverId%%
	      	</div>
      	</div>

      	<div class="option" id="platformId">
		    <a href="#"><span class="title"><span class="show" title="all">全部渠道</span><span class="gbma"></span></span></a>
		    <div class="more more_big">
				%%platformId%%				
      		</div> 
		</div>
</div>
<br class="clear"/>
</div>
<div id="logo" class="wtcenter"><h1>管理平台</h1></div>
<div id="nav" class="wtcenter">
	<ul>
		<li><a href="/">首页</a></li>
		<li><a href="/gm/">GM工具</a></li>
		<li><a href="/data/">数据查询</a></li>
		<li><a href="/userLogin/">设置</a></li>
	</ul>
	<div class="clear"></div>
</div>