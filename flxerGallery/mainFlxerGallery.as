class flxerGallery.mainFlxerGallery extends MovieClip {
	// pref
	var x:Number;
	var y:Number;
	var w:Number;
	var h:Number;
	var tw:Number;
	var th:Number;
	var toolbar:Boolean;
	var autostop:Boolean;
	var myLoop:Boolean;
	var resizza_onoff:Boolean;
	var centra_onoff:Boolean;
	var ss_time:Number;
	var info:Boolean;
	//
	var lista:XML;
	var single;
	var trgt;
	var resizer;
	var flv;
	var img;
	var mp3;
	var swf;
	var owner:mainFlxerGallery;
	var noImg;
	var firstIsImg;
	var txt;
	var mRoot:ContextMenu;
	var mPlay:ContextMenu;
	var startUrl;
	function mainFlxerGallery() {
		_root.myDrawerFunc=new main.drawerFunc();
		_root.galleryPath=this;
		if (toolbar) {
			this.attachMovie("toolbar","myToolbar",this.getNextHighestDepth(),{w:w,h:h});
		}
		if (this._parent == _root) {
			w = Stage.width;
			h = Stage.height;
			resizer=new Object  ;
			resizer.owner=this;
			resizer.onResize=function() {
				owner.galleryResizer(Stage.width,Stage.height);
			};
			Stage.addListener(resizer);
		}
		_root.myClassedMC(flxerGallery.flxerPlayer,this,"mySuperPlayer",{x:0,y:0,w:w,h:h,resizza_onoff:resizza_onoff,centra_onoff:centra_onoff,ss_time:ss_time,info:info,autostop:autostop,myLoop:myLoop});
	}
	function galleryResizer(w,h) {
		this["mySuperPlayer"].setPos(w,h);
		this["myToolbar"].setPos(w,h);
		if (! single) {
			this["mySelector"].setPos(w,h);
		}
	}
	function avvia(xml) {
		if (this["mySelector"]) {
			this["mySelector"].removeMovieClip();
		}
		/*if (_root["myFlxerGallery"]["myToolbar"]["ppBig"]) {
			this["myToolbar"]["ppBig"].removeMovieClip();
		}*/
		if (xml.childNodes[0].childNodes.length == 1) {
			this["myToolbar"].single=single=true;
			this["mySuperPlayer"].avvia(xml.childNodes[0],0,false);
		} else {
			this["myToolbar"].single=single=false;
			parseXml(xml);
			this["myToolbar"].avvia("selector", null, noImg);
			this["mySuperPlayer"].resetta();
			avviaSelector(xml);
		}
		creaContextMenu();
	}
	function parseXml(xml) {
		flv=0;
		img=0;
		mp3=0;
		swf=0;
		var str="";
		noImg=true;
		firstIsImg=false;
		txt="";
		this["mySuperPlayer"]._visible=false;
		for (var a=0; a < xml.childNodes[0].childNodes.length; a++) {
			txt+= xml.childNodes[0].childNodes[a].childNodes[1].childNodes[0] + "\n";
			var tmp=xml.childNodes[0].childNodes[a].childNodes[0].childNodes[0].toString();
			var tmp=tmp.substring(tmp.length - 3,tmp.length).toLowerCase();
			if (tmp == "flv") {
				flv++;
			} else if (tmp == "mp3") {
				mp3++;
			} else if (tmp == "swf") {
				swf++;
			} else if (tmp == "jpg" || tmp == "png" || tmp == "gif") {
				if (a == 0) {
					firstIsImg=true;
				}
				img++;
			}
		}
		if (flv > 0) {
			str+= "VIDEO[" + flv + "] ";
		}
		if (mp3 > 0) {
			str+= "AUDIO[" + mp3 + "] ";
		}
		if (swf > 0) {
			str+= "SWF[" + swf + "] ";
		}
		if (img > 0) {
			str+= "IMAGES[" + img + "] ";
		}
		this["myToolbar"].mmSelTit = str
		if (img > 1) {
			noImg=false;
		}
	}
	function avviaSelector(xml) {
		_root.myClassedMC(flxerGallery.mmSelector,this,"mySelector",{lista:xml.childNodes[0],x:0,y:0,w:w,h:h,tw:tw,th:th,noImg:noImg});
		if (xml.childNodes[0].childNodes[1].length > 0 || xml.childNodes.length > 0) {
			if (! autostop) {
				if (firstIsImg) {
					this["myToolbar"].piede.ss["puls"].onPress();
				} else {
					this["mySelector"]["puls0"]["puls"].onPress();
				}
			}
		}
	}
	function creaContextMenu() {
		mRoot=new ContextMenu  ;
		mRoot.hideBuiltInItems();
		mPlay=new ContextMenu  ;
		mPlay.hideBuiltInItems();
		if (! single) {
			mRoot.customItems.push(new ContextMenuItem("Slideshow",this["myToolbar"].avviaSS));
			mPlay.customItems.push(new ContextMenuItem("Playlist",this["myToolbar"].avviaSelector));
			if (noImg) {
				mRoot.customItems[0].enabled=false;
				mRoot.customItems[0].caption="Slideshow (no images)";
			}
		}
		mRoot.customItems.push(new ContextMenuItem("Scale: Fit player size",this["myToolbar"].itemHandler,false,false));
		mRoot.customItems.push(new ContextMenuItem("Scale: 100%",this["myToolbar"].itemHandler2,false,false));
		mRoot.customItems.push(new ContextMenuItem("Fullscreen",this["myToolbar"].itemHandler3));
		mRoot.customItems.push(new ContextMenuItem("Print this content",this["myToolbar"].itemHandler4));
		if (this._parent.pref.downPath) {
			mRoot.customItems.push(new ContextMenuItem("Download", this["myToolbar"].itemHandler5, false, false));
		}
		mRoot.customItems.push(new ContextMenuItem("Embed",this["myToolbar"].apriEmbed));
		this._parent.menu=mRoot;
		mPlay.customItems.push(new ContextMenuItem("Scale: Fit player size",this["myToolbar"].itemHandler));
		mPlay.customItems.push(new ContextMenuItem("Scale: 100%",this["myToolbar"].itemHandler2));
		mPlay.customItems.push(new ContextMenuItem("Fullscreen",this["myToolbar"].itemHandler3));
		mPlay.customItems.push(new ContextMenuItem("Print this content",this["myToolbar"].itemHandler4));
		if (this._parent.pref.downPath) {
			mPlay.customItems.push(new ContextMenuItem("Download", this["myToolbar"].itemHandler5));
		}
		mPlay.customItems.push(new ContextMenuItem("Embed",this["myToolbar"].apriEmbed));
		this["mySuperPlayer"].menu=mPlay;
		if (toolbar) {
			this["myToolbar"].swapDepths(this.getNextHighestDepth());
		}
	}
}