</head>
<body>
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
	</div>
	<div id="logo" class="wtcenter"><h1>管理平台</h1></div>
	<style type="text/css">
	#login{position:absolute;top:0px;right:0px;width:100px;height:30px;font-size:13px;}

	#login a{color:#CCC;display:block;padding-top:2px;line-height:27px;}

	#login a:hover{color:#36C;display:block;padding-top:2px;line-height:27px;background-color:white;}

	#login .title {padding:0 5px;z-index:1000;line-height:27px;display: block;
	position:relative;padding-right:9px;border-left:1px solid transparent;border-right: 1px solid transparent;}

	.more{background-color:white;z-index:999;border:1px solid #BEBEBE;margin-top:-1px;display:none;width:100px;
	    -moz-box-shadow: -1px 1px 1px rgba(0,0,0,.2);-webkit-box-shadow:0 2px 4px rgba(0, 0, 0, .2);box-shadow: 0 2px 4px rgba(0, 0, 0, .2);}
	    
	.more a{color:#36C!important;padding:0 18px;line-height:27px;display:block;}
	.more a:hover{background-color:#eee;line-height:27px;}
	#serverMore{width:500px;position:absolute;right: 0px;}
	#serverMore span{margin:0 8px;color: #36C!important;line-height: 27px;cursor: pointer;}
	#login span.gbma{position:relative;top:-1px;border-style:solid dashed dashed;border-color:transparent;
	                             border-top-color:silver;display:-moz-inline-box;display:inline-block;font-size:0;
	                             height:0;line-height:0;width:0;border-width:3px 3px 0;padding-top:1px;left:4px;}
	</style>
	<script type="text/javascript">
		$(function(){
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
			else if( $path == "/user/my.yaws" ){
				$("#nav ul li").removeClass( "selected" );
				$("#nav ul li").eq(3).addClass( "selected" );
			};


			$("#userName").mouseover(function(){
			    $("#userMore").show();	    
		      }).mouseout(function(){
			    $("#userMore").hide();
		    });
		    $("#serverId").mouseover(function(){
			    $("#serverMore").show();	    
		      }).mouseout(function(){
			    $("#serverMore").hide();
		    });
		    $("body").click(function(){
			    if( $("#more_div").css("display") == "block" )
			    {
				  $("#more").removeClass( "more" );
				  $("#more_div").hide();
			    }
      		});
      
})

	</script>
	<div id="login">
	      	<div style="width:50px;float:left;" id="userName">
			    <a href="user/my.yaws">
			    	<span class="title"><span>%%user%%</span><span class="gbma"></span></span>
			    </a>
			    <div id="userMore" class="more">
					<div style="padding:10px 0">
						<div><a href="user/my.yaws" onclick="location.href='user/my.yaws'"><span>个人资料</span></a></div>
						<div><a href="action.yaws?action=logOut&arg=logOut" ><span>退出</span></a></div>
					</div>
	      		</div>
			    
	      	</div>
	      	<div style="width:50px;float:left;" id="serverId">
			    <a href="#"><span class="title"><span>1服</span><span class="gbma"></span></span></a>
			    <div id="serverMore" class="more">
				  	<div style="padding:10px 0">
						<div>
							<span>1服</span><span>2服</span><span>3服</span>
							<span>4服</span><span>5服</span><span>6服</span>
							<span>7服</span><span>8服</span><span>9服</span>
							<span>10服</span><span>11服</span></div>
						<div>
							<span>12服</span><span>13服</span><span>14服</span>
							<span>15服</span><span>16服</span><span>17服</span>
							<span>18服</span><span>19服</span><span>20服</span>
							<span>21服</span><span>22服</span></div>
						<div>
							<span>23服</span><span>24服</span><span>25服</span>
							<span>26服</span><span>27服</span><span>28服</span>
							<span>29服</span><span>30服</span><span>31服</span>
							<span>32服</span><span>33服</span></div>
						<div>
							<span>34服</span><span>35服</span><span>36服</span>
							<span>37服</span><span>38服</span><span>39服</span></div>
				 	</div>
		      </div>
	      	</div> 	
	</div>
	
	<div id="nav" class="wtcenter">
		<ul>
			<li><a href="/">首页</a></li>
			<li><a href="/gm/">GM工具</a></li>
			<li><a href="/data/">数据查询</a></li>
			<li><a href="/user/my.yaws">设置</a></li>
		</ul>
	<div class="clear"></div>
	</div>