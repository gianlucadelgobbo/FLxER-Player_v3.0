class comp.squareButton extends MovieClip {
	var x:Number;
	var y:Number;
	var w:Number;
	var h:Number;
	var fnz:String;
	var fnzOver:String;
	var param:String;
	var fnzTrgt:MovieClip;
	var src:String;
	var tipo:String;
	///////
	var puls:MovieClip;
	var owner:squareButton;
	//
	function squareButton() {
		this._x = x;
		this._y = y;
		trace(w+" o "+h)
		if (src) {
			var col = _root.myDrawerFunc.playerColors["colorBkgOver"];
			_root.myDrawerFunc.drawer(this, "puls", 0, 0, w, h, col, null, 100);
			var myMcl = new main.mcLoader(_root.myPath+src, this, this, "appare", "loadProg");
			if (tipo == "flv" || tipo == "mp3" || tipo == "swf") {
				if (tipo == "flv") {
					var tmp = "VIDEO"
				} else if (tipo == "swf") {
					var tmp = "FLASH MOVIE"
				} else {
					var tmp = "AUDIO"
				}
				_root.myDrawerFunc.textDrawer(this, "tipoTxt", tmp, 5, h-24, w-10, 19);
			}
			this.puls.owner = this;
			this.puls.onPress = function() {
				owner.fnzTrgt[owner.fnz](owner.param);
				_root.bip.play();
				onRollOut()
			};
			this.puls.onRollOver = function() {
				_root.bip.play();
				if (owner.fnzOver) {
					owner.fnzTrgt[owner.fnzOver](owner.param);
				}
				if (owner._parent.lista.childNodes[owner.param+owner._parent.thumbPage].childNodes[1] != undefined) {
					var tmp = {x:this._x+(owner.w/2), y:this._y+(owner.h/2)};
					this.localToGlobal(tmp);
					_root.alt.avvia(owner._parent.lista.childNodes[owner.param+owner._parent.thumbPage].childNodes[1], tmp);
				}
			};
			this.puls.onRollOut = function() {
				if (owner.fnzOut) {
					owner.fnzTrgt[owner.fnzOut](owner.param);
				}
			};
		} else {
			var col = _root.myDrawerFunc.playerColors["colorBkg"];
			_root.myDrawerFunc.drawer(this, "puls", 0, 0, w, h, col, null, 100);
		}
	}
}
