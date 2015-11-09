class flxerGallery.buttonTools extends MovieClip {
	var w:Number;
	var txt:String;
	var fnzTrgt:MovieClip;
	var fnz:String;
	var fnzOut:String;
	var param:String;
	///////
	var lab:MovieClip;
	var puls:MovieClip;
	var pulsInt:MovieClip;
	//
	function buttonTools() {
		trace("buttonTools");
		avvia();
	}
	function avvia() {
		trace("avviaavviaavvia "+txt);
		if (txt) {
			/* STANDARD 
			var deltaT =  4*/
			/* NGA FONT */
			var deltaT = 6;
			lab._width = lab.textWidth+deltaT;
			puls._width = lab._width;
			pulsInt._width = puls._width-2;
		}
		puls.onPress = function() {
			trace(this._parent.fnzTrgt);
			trace(this._parent.fnz);
			this._parent.fnzTrgt[this._parent.fnz](this._parent);
			onRollOut();
		};
		if (fnzOut) {
			puls.onRelease = function() {
				this._parent.fnzTrgt[this._parent.fnzOut](this._parent);
				onRollOut();
			};
			puls.onReleaseOutside = function() {
				onRelease();
			};
		}
		puls.onRollOver = function() {
			if (this._parent["simb"]) {
				var trgt = this._parent["simb"];
			} else {
				var trgt = this;
			}
			var col = new Color(trgt);
			col.setRGB(_root.myDrawerFunc.toolsColors["colorBkgOver"]);
			if (this._parent.alt) {
				_root.altPlayer.avvia(this._parent.alt);
			}
		};
		puls.onRollOut = function() {
			if (this._parent["simb"]) {
				var trgt = this._parent["simb"];
			} else {
				var trgt = this;
			}
			var col = new Color(trgt);
			col.setRGB(_root.myDrawerFunc.toolsColors["colorBkg"]);
			_root.altPlayer.stoppa();
		};
	}
}
