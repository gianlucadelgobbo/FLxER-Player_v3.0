﻿class flxerGallery.mmSelector extends MovieClip {
	var x:Number;
	var y:Number;
	var w:Number;
	var h:Number;
	var tw:Number;
	var th:Number;
	var lista:XML;
	var oldA;
	var thumbNx;
	var thumbNy;
	var resizza_onoff;
	var noImg
	//
	var thumbPage = 0;
	function mmSelector() {
		this._x = x;
		this._y = y+this._parent["myToolbar"].testa._height+1;
		thumbDrawer(w, h);
	}
	function setPos(ww, hh) {
		w = ww;
		h = hh;
		thumbPage = 0;
		for (var a = 0; a<thumbNx*thumbNy; a++) {
			this["puls"+a].removeMovieClip();
		}
		thumbDrawer(w, h);
	}
	function thumbDrawer(w, h) {
		h = h-(this._parent["myToolbar"].testa._height+this._parent["myToolbar"].piede.piedeEst._height+3);
		var contaX = 0;
		var contaY = 0;
		thumbNx = int(w/tw);
		thumbNy = int(h/th);
		var marginX = (w-(thumbNx*tw))/(thumbNx-1);
		var marginY = (h-(thumbNy*th))/(thumbNy-1);
		var a;
		if (noImg) {
			this._parent["myToolbar"].piede.ss._visible = false;
		}
		for (a=0; a<thumbNx*thumbNy; a++) {
			var myX = (tw+marginX)*contaX;
			var myY = (th+marginY)*contaY;
			if (this["puls"+a]) {
				this["puls"+a]._x = myX;
				this["puls"+a]._y = myY;
			} else {
				var tmp = lista.childNodes[a+thumbPage].childNodes[0].attributes.href;
				var tipo = tmp.substring(tmp.lastIndexOf(".")+1, tmp.length).toLowerCase();
				_root.myClassedMC(comp.squareButton, this, "puls"+a, {x:myX, y:myY, w:tw, h:th, fnzTrgt:this, fnz:"myOnPress", fnzOver:"myOnOver", param:a, src:lista.childNodes[a+thumbPage].childNodes[0].childNodes[0].attributes.src, tipo:tipo});
			}
			contaX++;
			if (contaX == thumbNx) {
				contaX = 0;
				contaY++;
			}
			if (contaY == thumbNy+1) {
				contaY = 0;
			}
		}
		trace(thumbPage);
		if (thumbPage>0) {
			if (this["pageDn"]) {
				this["pageDn"]._x = 45;
				this["pageDn"]._y = int((h-33)/2)+33;
			} else {
				this.attachMovie("fw_rw", "pageDn", this.getNextHighestDepth(), {_x:45, _y:int((h-33)/2)+33, _xscale:300, _yscale:300, _rotation:180, _alpha:70});
				this["pageDn"].onPress = function() {
					this._parent.pager(-1);
				};
			}
		} else {
			this["pageDn"].removeMovieClip();
		}
		if (thumbPage+(thumbNx*thumbNy)<lista.childNodes.length) {
			if (this["pageUp"]) {
				this["pageUp"]._x = w-45;
				this["pageUp"]._y = int((h-33)/2);
			} else {
				this.attachMovie("fw_rw", "pageUp", this.getNextHighestDepth(), {_x:w-45, _y:int((h-33)/2), _xscale:300, _yscale:300, _rotation:0, _alpha:70});
				this["pageUp"].onPress = function() {
					this._parent.pager(1);
				};
			}
		} else {
			this["pageUp"].removeMovieClip();
		}
		this["pageDn"].swapDepths(this.getNextHighestDepth());
		this["pageUp"].swapDepths(this.getNextHighestDepth());
		for (var b = a; this["puls"+b]; b++) {
			this["puls"+b].removeMovieClip();
		}
	}
	function pager(a) {
		thumbPage += a*(thumbNx*thumbNy);
		for (var a = 0; a<thumbNx*thumbNy; a++) {
			this["puls"+a].removeMovieClip();
		}
		thumbDrawer(w, h);
	}
	function mySlidesShow() {
		this._parent["mySuperPlayer"]._visible = true;
		this._parent["mySuperPlayer"].avvia(lista, 0, true);
		this._visible = false;
	}
	function myOnPress(a) {
		this._parent["myToolbar"].piede.toppa._visible = this._parent["myToolbar"].piede.ss._visible=false;
		oldA = a;
		this["puls"].lab._visible = true;
		this["puls"].puls.enabled = true;
		this._parent["mySuperPlayer"]._visible = true;
		this._parent["mySuperPlayer"].avvia(lista, a+thumbPage);
		this._visible = false;
	}
}
