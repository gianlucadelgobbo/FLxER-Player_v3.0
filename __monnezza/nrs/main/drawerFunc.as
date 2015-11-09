class main.drawerFunc extends MovieClip {
	var playerColors:TextFormat;
	var testo:TextFormat;
	var styles:TextField.StyleSheet;
	var styles2:TextField.StyleSheet;
	//
	function drawerFunc(trgt, myName, x, y, w, h, col) {
		playerColors = new TextFormat();
		playerColors["colorBkg"] = 0x000000;
		playerColors["colorBkg2"] = 0x000000;
		playerColors["colorBkgOver"] = 0xFF0000;
		testo = new TextFormat();
		testo["colorBorder"] = 0xFFFFFF;
		testo["colorBkg"] = 0x000000;
		testo["colorBkgOver"] = 0xFF0000;
		styles = new TextField.StyleSheet();
		styles.setStyle("p", {fontFamily:'myFont', fontSize:'8px', color:'#FFFFFF', marginLeft:'3px'});
		styles.setStyle("a:link", {color:'#FFFFFF'});
		styles.setStyle("a:visited", {color:'#FFFFFF'});
		styles.setStyle("a:active", {color:'#FFFFFF'});
		styles.setStyle("a:hover", {color:'#FF0000'});
		styles.setStyle("div", {color:'#999999'});
		styles2 = new TextField.StyleSheet();
		styles2.setStyle("p", {fontFamily:'myFont', fontSize:'8px', color:'#000000', marginLeft:'3px'});
	}
	function textDrawer(trgt, myName, txt, x, y, w, h) {
		trgt.createTextField(myName, trgt.getNextHighestDepth(), x, y, w, h);
		with (trgt[myName]) {
			background = true;
			border = true;
			html = true;
			multiline = true;
			selectable = false;
			wordWrap = true;
			embedFonts = true;
			//htmlText = txt;
		}
		trgt[myName].backgroundColor = testo["colorBkg"];
		trgt[myName].borderColor = testo["colorBorder"];
		trgt[myName].styleSheet = styles;
		trgt[myName].htmlText = "<p>"+txt+"</p>";
	}
	function drawer(trgt, myName, x, y, w, h, col, o_col, alpha) {
		trgt.createEmptyMovieClip(myName, trgt.getNextHighestDepth());
		if (alpha == undefined) {
			alpha = 100;
		}
		with (trgt[myName]) {
			if (o_col != null) {
				lineStyle(0, o_col, alpha);
			}
			beginFill(col, alpha);
			moveTo(0, 0);
			lineTo(w, 0);
			lineTo(w, h);
			lineTo(0, h);
			lineTo(0, 0);
			_x = x;
			_y = y;
		}
	}
}
