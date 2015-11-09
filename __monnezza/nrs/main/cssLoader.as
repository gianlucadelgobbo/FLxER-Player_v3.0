class main.cssLoader {
	function cssLoader(myUrl, trgt, myName, trgtF, fnz) {
		trgt[myName] = new TextField.StyleSheet();
		trgt[myName].ignoreWhite = true;
		trgt[myName].onLoad = function(s:Boolean) {
			if (s) {
				trgtF[fnz](trgt[myName]);
			}
		};
		trgt[myName].load(myUrl);
	}
}
