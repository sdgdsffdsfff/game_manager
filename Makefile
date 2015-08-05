REBAR = ./rebar

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean


rar:
	tar -czf  hand_game.tar.gz ebin win.bat priv ../apps/*/ebin data
	cd _msg; svn up; mv ../hand_game.tar.gz  ./ ; svn ci -m'ci' ; cd -

svn:
	cd data; svn up; cd ../

updata:
	cd  data; svn up; cd -