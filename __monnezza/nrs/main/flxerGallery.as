class main.flxerGallery extends MovieClip {
	var x:Number;
	var y:Number;
	var w:Number;
	var h:Number;
	var tw:Number;
	var th:Number;
	var col;
	var toolbar;
	var lista:XML;
	var resizza_onoff;
	var centra_onoff
	var ss_time
	var info
	var att
	var single;
	var autostop;
	//
	var trgt;
	var resizer;
	var flv = 0;
	var img = 0;
	var mp3 = 0;
	var swf = 0;
	var str = "";
	var owner:flxerGallery;
	var noImg = true;
	var mRoot:ContextMenu;
	var mPlay:ContextMenu;
	function flxerGallery() {
		this._x = x;
		this._y = y;
		if (toolbar) {
			this.attachMovie("toolbar", "myToolbar", this.getNextHighestDepth(), {col:col, w:w, h:h, single:single});
		}
		_root.myClassedMC(main.flxerPlayer, this, "mySuperPlayer", {x:0, y:0, w:w, h:h, col:col, path:_root.myPath, resizza_onoff:resizza_onoff, centra_onoff:centra_onoff, ss_time:ss_time, info:info, att:att, autostop:autostop});
		if (!single) {
			if (lista.childNodes[0].childNodes[1].length>1 || lista.childNodes.length>1) {
				this["mySuperPlayer"]._visible = false;
				for (var a = 0; a<lista.childNodes.length; a++) {
					var tmp = lista.childNodes[a].childNodes[0].attributes.href;
					var tmp = tmp.substring(tmp.length-3, tmp.length).toLowerCase();
					if (tmp == "flv") {
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
				_root.myClassedMC(main.mmSelector, this, "mySelector", {lista:lista, x:0, y:0, w:w, h:h, tw:tw, th:th, col:col, noImg:noImg});
			}
		}
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
		mRoot.customItems.push(new ContextMenuItem("Download", this["myToolbar"].itemHandler5, false, false));
		mRoot.customItems.push(new ContextMenuItem("Embed", this["myToolbar"].apriEmbed));
		_root.menu = mRoot;
		mPlay.customItems.push(new ContextMenuItem("Scale: Fit player size", this["myToolbar"].itemHandler));
		mPlay.customItems.push(new ContextMenuItem("Scale: 100%", this["myToolbar"].itemHandler2));
		mPlay.customItems.push(new ContextMenuItem("Fullscreen", this["myToolbar"].itemHandler3));
		mPlay.customItems.push(new ContextMenuItem("Print this content", this["myToolbar"].itemHandler4));
		mPlay.customItems.push(new ContextMenuItem("Download", this["myToolbar"].itemHandler5));
		mPlay.customItems.push(new ContextMenuItem("Embed", this["myToolbar"].apriEmbed));
		this["mySuperPlayer"].menu = mPlay;
		if (toolbar) {
			this["myToolbar"].swapDepths(this.getNextHighestDepth());
			this["myToolbar"].lab_i.htmlText = this["myToolbar"].mmSelTit=str;
		}
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
