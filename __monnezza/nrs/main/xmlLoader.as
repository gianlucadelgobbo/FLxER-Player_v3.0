class main.xmlLoader {
	var c
	var owner
	function xmlLoader(myUrl, trgt, myName, trgtF, fnz) {
		trgt[myName] = new XML();
		trgt[myName].ignoreWhite = true;
		trgt[myName].owner = this
		trgt[myName].onLoad = function(s:Boolean) {
			if (s) {
				trgtF[fnz](trgt[myName]);
			} else {
				trgtF["xmlLoadFailed"]();
			}
			//clearInterval(owner.c)
		};
		trgt[myName].load(myUrl);
		//c = setInterval(this, "xmlLoading", 30, trgt[myName]);
	}
	function xmlLoading(t) {
		_root.myMiniHeader["path"]["myText"]["myText"].htmlText = "<p>Loading: "+int(100/(t.getBytesTotal()/t.getBytesLoaded()))+"%</p>";
	}
}
