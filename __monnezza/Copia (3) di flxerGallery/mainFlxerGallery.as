class flxerGallery.mainFlxerGallery extends MovieClip {
	var w:Number;
	var h:Number;
	var tw:Number;
	var th:Number;
	var col;
	var toolbar;
	var lista:XML;
	var resizza_onoff;
	var centra_onoff;
	var ss_time;
	var info;
	var att;
	var single;
	var autostop;
	var myLoop;
	//
	var trgt;
	var resizer;
	var flv;
	var img;
	var mp3;
	var swf;
	var str;
	var owner:mainFlxerGallery;
	var noImg;
	var isFlv;
	var mRoot:ContextMenu;
	var mPlay:ContextMenu;
	var startUrl;
	function mainFlxerGallery() {
		_root.galleryPath = this
		trace("myLoop "+myLoop);
		if (toolbar) {
			this.attachMovie("toolbar", "myToolbar", this.getNextHighestDepth(), {col:col, w:w, h:h});
		}
		_root.myClassedMC(flxerGallery.flxerPlayer, this, "mySuperPlayer", {x:0, y:0, w:w, h:h, col:col, path:"", resizza_onoff:resizza_onoff, centra_onoff:centra_onoff, ss_time:ss_time, info:info, att:att, autostop:autostop, myLoop:myLoop});
		if (this._parent == _root) {
			resizer = new Object();
			resizer.owner = this;
			resizer.onResize = function() {
				owner["mySuperPlayer"].setPos(Stage.width, Stage.height);
				owner["myToolbar"].setPos(Stage.width, Stage.height);
				if (!owner.single) {
					owner["mySelector"].setPos(Stage.width, Stage.height);
				}
			};
			Stage.addListener(resizer);
		}
	}
	function avviaSelector(lista) {
		flv = 0;
		img = 0;
		mp3 = 0;
		swf = 0;
		str = "";
		noImg = true;
		single = false;
		trace("myToolbar1 "+single)
		if (this["mySelector"]) {
			this["mySelector"].removeMovieClip();
		}
		isFlv = false;
		var txt = "";
		trace(lista.childNodes.length)
		if (lista.childNodes.length == 1) {
			single = true;
		}
		for (var a = 0; a<lista.childNodes.length; a++) {
				//trace("bella "+lista.childNodes[a].childNodes[1].childNodes[0])
				txt += lista.childNodes[a].childNodes[1].childNodes[0]+"\n";
				var tmp = lista.childNodes[a].childNodes[0].attributes.href;
				var tmp = tmp.substring(tmp.length-3, tmp.length).toLowerCase();
				if (tmp == "flv") {
					if (a == 0) {
						isFlv = true;
					}
					flv++;
				} else if (tmp == "mp3") {
					mp3++;
				} else if (tmp == "swf") {
					swf++;
				} else if (tmp == "jpg" || tmp == "png" || tmp == "gif") {
					img++;
				}
			}
			if (flv>0) {
				str += "VIDEO["+flv+"] ";
			}
			if (mp3>0) {
				str += "AUDIO["+mp3+"] ";
			}
			if (swf>0) {
				str += "SWF["+swf+"] ";
			}
			if (img>0) {
				str += "IMAGES["+img+"] ";
				this["myToolbar"].noImg = noImg=false;
			}
			_root.myClassedMC(flxerGallery.mmSelector, this, "mySelector", {lista:lista, x:0, y:0, w:w, h:h, tw:tw, th:th, col:col, noImg:noImg});
			creaContextMenu();
	
		this["mySuperPlayer"].autostop = false;
		trace("myToolbar2 "+single)
		this["myToolbar"].avvia(single,noImg);
		if (lista.childNodes[0].childNodes[1].length>0 || lista.childNodes.length>0) {
			if (!autostop) {
				if (isFlv) {
					trace("isFlvTRUE "+noImg)
					this["mySelector"]["puls0"]["puls"].onPress()
				} else {
					trace("isFlvFALSE "+this["myToolbar"].piede.ss["puls"])
					this["myToolbar"].piede.ss["puls"].onPress()
				} 
			}
		}
	}
	function avvia(a, b) {
		single = true;
		this["myToolbar"].avvia(single);
		if (this["mySelector"]) {
			this["mySelector"].removeMovieClip();
		}
		this["mySuperPlayer"]._visible = true;
		this["mySuperPlayer"].avvia(a, b);
		creaContextMenu();
	}
	function creaContextMenu() {
		trace("creaContextMenu"+this["myToolbar"].itemHandler);
		mRoot = new ContextMenu();
		mRoot.hideBuiltInItems();
		mPlay = new ContextMenu();
		mPlay.hideBuiltInItems();
		if (!single) {
			mRoot.customItems.push(new ContextMenuItem("Slideshow", this["myToolbar"].avviaSS));
			mPlay.customItems.push(new ContextMenuItem("Playlist", this["myToolbar"].avviaSelector));
			if (noImg) {
				mRoot.customItems[0].enabled = false;
				mRoot.customItems[0].caption = "Slideshow (no images)";
			}
		}
		mRoot.customItems.push(new ContextMenuItem("Scale: Fit player size", this["myToolbar"].itemHandler, false, false));
		mRoot.customItems.push(new ContextMenuItem("Scale: 100%", this["myToolbar"].itemHandler2, false, false));
		mRoot.customItems.push(new ContextMenuItem("Fullscreen", this["myToolbar"].itemHandler3));
		mRoot.customItems.push(new ContextMenuItem("Print this content", this["myToolbar"].itemHandler4));
		//mRoot.customItems.push(new ContextMenuItem("Download", this["myToolbar"].itemHandler5, false, false));
		mRoot.customItems.push(new ContextMenuItem("Embed", this["myToolbar"].apriEmbed));
		this._parent.menu = mRoot;
		mPlay.customItems.push(new ContextMenuItem("Scale: Fit player size", this["myToolbar"].itemHandler));
		mPlay.customItems.push(new ContextMenuItem("Scale: 100%", this["myToolbar"].itemHandler2));
		mPlay.customItems.push(new ContextMenuItem("Fullscreen", this["myToolbar"].itemHandler3));
		mPlay.customItems.push(new ContextMenuItem("Print this content", this["myToolbar"].itemHandler4));
		//mPlay.customItems.push(new ContextMenuItem("Download", this["myToolbar"].itemHandler5));
		mPlay.customItems.push(new ContextMenuItem("Embed", this["myToolbar"].apriEmbed));
		this["mySuperPlayer"].menu = mPlay;
		if (toolbar) {
			this["myToolbar"].swapDepths(this.getNextHighestDepth());
			this["myToolbar"].lab_i.htmlText = this["myToolbar"].mmSelTit=str;
		}
	}
}
