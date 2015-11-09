class comp.graButton extends MovieClip {
	var w:Number;
	var txt:String;
	var fnzTrgt:MovieClip;
	var fnz:String;
	var param:String;
	///////
	var lab:MovieClip;
	var puls:MovieClip;
	var pulsInt:MovieClip;
	//
	function graButton() {
		if (txt) {
			lab._width = lab.textWidth+4;
			puls._width = lab.textWidth+5;
			pulsInt._width = lab.textWidth+3;
		}
		puls.onPress = function() {
			this._parent.fnzTrgt[this._parent.fnz]();
			onRollOut()
		};
		puls.onRollOver = function() {
			trace(this["puls"]);
			var col = new Color(this);
			col.setRGB(_root.myDrawerFunc.playerColors["colorBkgOver"]);
			if (this._parent.alt) {
				_root.alt.avvia(this._parent.alt);
			}
		};
		puls.onRollOut = function() {
			var col = new Color(this);
			col.setRGB(_root.myDrawerFunc.playerColors["colorBkg"]);
			_root.alt.stoppa();
		};
	}
}
