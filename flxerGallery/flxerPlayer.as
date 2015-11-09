import flash.display.*;
import flash.geom.*;
class flxerGallery.flxerPlayer extends MovieClip {
	var x:Number;
	var y:Number;
	var w:Number;
	var h:Number;
	//
	var ns:NetStream;
	var nc;
	var owner;
	var autostop;
	var myLoop;
	var listaSS;
	//
	var myCol;
	var lista:XML;
	var resizza_onoff:Boolean;
	var centra_onoff:Boolean;
	var ss_time:Number;
	var info:Boolean;
	//
	var play_status:Boolean;
	//
	var mcLoaded:Boolean;
	var loadedMov:String;
	var currMov:String;
	var ssInt:Number;
	var stopper:Number;
	var autostopInt:Number;
	var volInt:Number;
	//
	var l:Number;
	var n:Number;
	//
	var tipo:String;
	var myDuration:Number;
	var myloaded:Boolean;
	var mp3player:Sound;
	var swf_started:Boolean;
	var firstTime;
	var firstTime2;
	var index;
	var nsclosed;
	var swfW = 400;
	var swfH = 300;
	//
	var testaH = 0;
	function flxerPlayer() {
		this._x = x;
		if (this._parent["myToolbar"].testa) {
			testaH = this._parent["myToolbar"].testa._height+1;
		}
		this._y = y+testaH;
		//this._y = 0;
		h = h-(testaH+this._parent["myToolbar"].piede.piedeEst._height+1);
		trace("Altezza Schermo: "+h);
		trace("Larghezza Schermo: "+w);
		if (_root.myFlxerPlayerStyles.playerColors["colorBkgPlayer"]) {
			_root.myDrawerFunc.drawer(this,"fondo",0,0,w,h,_root.myFlxerPlayerStyles.playerColors["colorBkgPlayer"],null,100);
		} else {
			drawer(this,"fondo",0,0,w,h,null);
		}
		this.createEmptyMovieClip("monitor",this.getNextHighestDepth());
		//if (this._parent._parent == _root) {
		drawer(this,"mask",0,0,w,h,0x000000);
		this["monitor"].setMask(this["mask"]);
		//}
		play_status = false;
	}
	function setPos(ww, hh) {
		w = ww;
		h = hh-(testaH+this._parent["myToolbar"].piede.piedeEst._height+1);
		this["fondo"]._width = w;
		this["fondo"]._height = h;
		this["mask"]._width = w;
		this["mask"]._height = h;
		resizza();
	}
	function avvia(myXml, i, ss):Void {
		this._visible = true;
		/*if (autostop) {
		this._parent["myToolbar"].attachMovie("playpause","ppBig",this._parent["myToolbar"].getNextHighestDepth(),{_x:(w-66)/2, _y:(h-66)/2, _xscale:600, _yscale:600});
		this._parent["myToolbar"]["ppBig"].fnz = "myPlaypause";
		this._parent["myToolbar"]["ppBig"].fnzTrgt = this._parent["myToolbar"];
		}*/
		lista = myXml;
		index = i;
		resetta();
		firstTime = true;
		firstTime2 = true;
		if (ss) {
			tipo = "jpg";
		} else {
			var tmp = lista.childNodes[index].childNodes[0].childNodes[0].toString();
			tipo = tmp.substring(tmp.lastIndexOf(".")+1, tmp.length).toLowerCase();
		}
		trace("flxerPlayer "+tipo);
		this._parent["myToolbar"].avvia("player",tipo,ss);
		if (autostop && tipo != "jpg") {
			this._parent["myToolbar"].visualizzappBig();
		}


		this["avvia_"+tipo](index);
	}
	/* IMMAGINI /////////////////*/
	function avvia_jpg(index) {
		listaSS = [];
		generaListaSS();
		for (var a = 0; a<listaSS.length; a++) {
			if (lista.childNodes[index].childNodes[0].childNodes[0].toString() == lista.childNodes[listaSS[a]].childNodes[0].childNodes[0].toString()) {
				index = a;
			}
		}
		if (index != undefined || index == 0) {
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
			n = index;
			play_status = true;
		} else {
			this._parent["myToolbar"].mRoot.customItems[0].enabled = true;
			play_status = false;
		}
		this._parent["myToolbar"].piede.indice.curs.puls.enabled = false;
		load_foto();
	}
	function generaListaSS() {
		for (var a = 0; a<this.lista.childNodes.length; a++) {
			var tmp = this.lista.childNodes[a].childNodes[0].childNodes[0].toString();
			tmp = tmp.substring(tmp.length-3, tmp.length);
			if (tmp == "jpg") {
				listaSS.push(a);
			}
		}
	}
	function load_foto() {
		clearInterval(ssInt);
		this["monitor"].createEmptyMovieClip("foto_"+l,this["monitor"].getNextHighestDepth());
		this["monitor"]["foto_"+l]._alpha = 0;
		if (_root.myFlxerPlayerStyles.playerColors["colorBkgPlayerFoto"] != undefined) {
			_root.myDrawerFunc.drawer(this["monitor"]["foto_"+l],"fondo",0,0,w,h,_root.myFlxerPlayerStyles.playerColors["colorBkgPlayerFoto"],null,100);
		}
		var tmp = lista.childNodes[listaSS[n]].childNodes[0].childNodes[0].toString();
		if (tmp.lastIndexOf("cnt=") != -1) {
			tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
		}
		currMov = tmp;
		load_jpg_swf(tmp,this["monitor"]["foto_"+l]);
		if (lista.childNodes.length>1) {
			this._parent["myToolbar"].tit = (n+1)+" / "+listaSS.length+" - "+lista.childNodes[listaSS[n]].childNodes[1].childNodes[0].toString();
			//this._parent["myToolbar"].tit = lista.childNodes[listaSS[n]].childNodes[1].childNodes[0].toString();
			this._parent["myToolbar"].piede.indice.counter.htmlText = (n+1)+" / "+listaSS.length;
			this._parent["myToolbar"].piede.indice.curs._x = (((this._parent["myToolbar"].barr_width)/(listaSS.length-1))*n);
			l++;
			if (n>listaSS.length-2) {
				n = 0;
			} else {
				n++;
			}
		} else {
			this._parent["myToolbar"].piede.indice.counter.htmlText = (n+1)+" / "+listaSS.length;
			this._parent["myToolbar"].tit = lista.childNodes[listaSS[n]].childNodes[1].childNodes[0].toString();
		}
	}
	/* SWF /////////////////*/
	function avvia_swf() {
		//ss = false;
		var tmp = lista.childNodes[index].childNodes[0].childNodes[0].toString();
		if (tmp.lastIndexOf("cnt=") != -1) {
			tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
		}
		this["monitor"].createEmptyMovieClip("mon",this["monitor"].getNextHighestDepth());
		play_status = true;
		load_jpg_swf(tmp,this["monitor"].mon);
		mp3player = new Sound(this["monitor"].mon);
		this._parent["myToolbar"].tit = lista.childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();
		this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit;
	}
	/* JPG / SWF /////////////////*/
	function load_jpg_swf(mov, trgt) {
		trgt.mcl = new main.mcLoader(mov, trgt, this, "MovieClipLoader_succes", "MovieClipLoader_progress");
		currMov = mov;
	}
	function fotografa(target_mc) {
		clearInterval(stopper)
		trace("fotografa"+target_mc._parent)
		var pict = new BitmapData(w, h, true, 0x00FFFF);
		//Snapshot della image caricata
		pict.draw(target_mc);
		target_mc._parent.createEmptyMovieClip("thumb",target_mc._parent.getNextHighestDepth())
		target_mc._parent.thumb.attachBitmap(pict, 100)
		//Non ho più bisogno della clip con l'image cosi la rimuovo
		target_mc.removeMovieClip()
		//this._parent["myToolbar"]["ppBig"]._visible = true;
		this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(1);
		//target_mc._parent["myMcl"].unloadClip(target_mc)
	}
	function avviaFotografa(target_mc) {
		stopper = setInterval(this, "fotografa", 400, target_mc);
	}
	function MovieClipLoader_progress(target_mc, loadedBytes, totalBytes) {
		this._parent["myToolbar"].piede.indice.barr._width = this._parent["myToolbar"].barr_width*(loadedBytes/totalBytes);
		if (tipo == "swf" && target_mc._currentframe && !swf_started) {
			if (autostop && firstTime) {
				play_status = autostop = firstTime = false;
				avviaFotografa(target_mc)
				//target_mc.stop();
			} else {
				this._parent["myToolbar"].avvia_indice();
				this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
				swf_started = true;
			}
			resizza(target_mc);
		}
	}
	function MovieClipLoader_succes(target_mc) {
		loadedMov = currMov;
		mcLoaded = true;
		if (tipo == "swf" && !swf_started) {
			if (autostop && firstTime) {
				firstTime = false;
				play_status = false;
				target_mc.stop();
				//this._parent["myToolbar"]["ppBig"]._visible = true;
			} else {
				target_mc.play();
				this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
				swf_started = true;
			}
			this._parent["myToolbar"].avvia_indice();
		}
		resizza(target_mc);
		if (tipo == "jpg") {
			if (l>1 && target_mc._parent._parent["foto_"+(l-2)]) {
				target_mc._parent._parent["foto_"+(l-2)].myTween = new main.myTween(target_mc._parent._parent["foto_"+(l-2)], "_alpha", mx.transitions.easing.Regular.easeIn, 100, 0, 10, this, "removePrev");
			}
			var tmp = "";
			if (play_status && lista.childNodes.length>1) {
				tmp = "loadNext";
			}
			target_mc._parent.myTween = new main.myTween(target_mc._parent, "_alpha", mx.transitions.easing.Regular.easeIn, 0, 100, 10, this, tmp);
		}
		var tmp = this._parent["myToolbar"].tit;
		if (info) {
			tmp += "   (size: "+int(target_mc.getBytesTotal()/1024)+" Kb / W: "+target_mc._width+" px / H: "+target_mc._height+" px)";
		}
		this._parent["myToolbar"].lab_i.htmlText = tmp;
	}
	function loadNext() {
		clearInterval(ssInt);
		ssInt = setInterval(this, "load_foto", ss_time);
	}
	function removePrev(target_mc) {
		target_mc.removeMovieClip();
	}
	/* MP3 /////////////////*/
	function avvia_mp3() {
		if (!mp3player) {
			mp3player = new Sound();
			mp3player["owner"] = this;
			mp3player.onLoad = function() {
				if (!owner.autostop) {
					this.start(0);
					owner.play_status = true;
					owner.loadedMov = owner.currMov;
					owner._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
				}
			};
			mp3player.onSoundComplete = function() {
				trace(owner.myLoop)
				if (owner.myLoop) {
					this.start(0);
				} else {
					if (owner._parent["myToolbar"].piede.contr.selector._visible) {
						owner._parent["myToolbar"].piede.contr.selector.puls.onPress();
					}
				}
			};
		}
		this._parent["myToolbar"].tit = lista.childNodes[index].childNodes[1].childNodes[0].toString();
		this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit;
		var tmp = lista.childNodes[index].childNodes[0].childNodes[0].toString();
		//tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
		//descr = lista.childNodes[index].childNodes[1];
		load_mp3(tmp);
	}
	function load_mp3(mov) {
		mp3player.loadSound(mov,false);
		currMov = mov;
		this._parent["myToolbar"].avvia_indice();
	}
	/* FLV /////////////////*/
	function avvia_flv() {
		if (!this["monitor"]["myFlvPlayer"]) {
			_root.myClassedMC(main.flvPlayer,this["monitor"],"myFlvPlayer",{w:w, h:h, trgtF:this, meta:"nsOnMetaData", stat:"nsOnStatus"});
		}
		//this["monitor"]["myFlvPlayer"]["myVideo"].vid_flv._visible = false;     
		this._parent["myToolbar"].tit = lista.childNodes[index].childNodes[1].childNodes[0].toString();
		this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit+": Buffering...";
		var tmp = lista.childNodes[index].childNodes[0].childNodes[0].toString();
		if (tmp.lastIndexOf("cnt=") != -1) {
			tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
		}
		//this._parent["myToolbar"].bottoni(false);     
		currMov = tmp;
		this["monitor"]["myFlvPlayer"].ns.play(tmp);
	}
	function nsOnMetaData(ns, obj:Object) {
		trace("onMetaData");
		myDuration = obj.duration;
	}
	function nsOnStatus(ns, infoObject) {
		//trace(infoObject.code+" "+this.play_status+" "+this.firstTime);
		if (infoObject.code == "NetStream.Play.Start" && firstTime) {
			this._parent["myToolbar"].avvia_indice();
			resizza(this["monitor"]["myFlvPlayer"]["myVideo"].vid_flv);
			firstTime = false;
			play_status = true;
			loadedMov = this.currMov;
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
			this._parent["myToolbar"].bottoni(true);
			nsclosed = false;
			if (autostop) {
				stopper = setInterval(this, "stoppaInizFlv", 400);
			}
		}
		if (infoObject.code == "NetStream.Play.Stop" && myLoop) {
			if (this._parent["myToolbar"].piede.contr.selector._visible) {
				this._parent["myToolbar"].piede.contr.selector.puls.onPress();
			} else {
				this["monitor"]["myFlvPlayer"].ns.seek(0);
			}
		}
		if (infoObject.code == "NetStream.Buffer.Full" && firstTime2) {
			firstTime2 = false;
			this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit;
		}
	}
	/*function stoppa() {
	this.stop_play_flv();
	if (this._parent["myToolbar"].single) {
	this._parent["myToolbar"]["ppBig"]._visible = true;
	}
	clearInterval(autostopInt);
	}*/
	/* TOOLS /////////////////*/
	function volume_onPress() {
		volInt = setInterval(this, "MySetVolume", 30);
	}
	function MySetVolume() {
		if (tipo == "flv") {
			this["monitor"]["myFlvPlayer"].mp3player.setVolume(-(this._parent["myToolbar"].piede.contr.volume_ctrl.slider._y+10+this._parent["myToolbar"].piede.contr.volume_ctrl.slider._height));
		} else {
			mp3player.setVolume(-(this._parent["myToolbar"].piede.contr.volume_ctrl.slider._y+10+this._parent["myToolbar"].piede.contr.volume_ctrl.slider._height));
		}
	}
	function volume_onRelease() {
		clearInterval(volInt);
	}
	//
	function avanti_swf() {
		if (play_status) {
			var tmp = "gotoAndPlay";
		} else {
			var tmp = "gotoAndStop";
		}
		var tmp2 = this["monitor"].mon.trgt._currentframe+int(this["monitor"].mon.trgt._totalframes/10);
		if (tmp2>this["monitor"].mon.trgt._totalframes) {
			tmp2 = this["monitor"].mon.trgt._totalframes;
		}
		this["monitor"].mon.trgt[tmp](tmp2);
	}
	function indietro_swf() {
		if (play_status) {
			var tmp = "gotoAndPlay";
		} else {
			var tmp = "gotoAndStop";
		}
		var tmp2 = this["monitor"].mon.trgt._currentframe-int(this["monitor"].mon.trgt._totalframes/10);
		if (tmp2<0) {
			tmp2 = 0;
		}
		this["monitor"].mon.trgt[tmp](tmp2);
	}
	function avanti_mp3() {
		mp3player.stop();
		play_status = true;
		var tmp2 = int((mp3player.position/1000)+(mp3player.duration/10000));
		if (tmp2>mp3player.duration/1000) {
			tmp2 = mp3player.duration/1000;
		}
		mp3player.start(tmp2);
		this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
	}
	function indietro_mp3() {
		mp3player.stop();
		play_status = true;
		var tmp2 = int((mp3player.position/1000)-(mp3player.duration/10000));
		if (tmp2<0) {
			tmp2 = 0;
		}
		mp3player.start(tmp2);
		this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
	}
	function avanti_jpg() {
		if (this._parent["myToolbar"].piede.contr.playpause._currentframe == 2) {
			this._parent["myToolbar"].piede.contr.playpause.puls.onPress();
		}
		if (lista.childNodes.length>1) {
			if (n<lista.childNodes.length-1) {
				load_foto();
			}
		}
	}
	function indietro_jpg() {
		if (this._parent["myToolbar"].piede.contr.playpause._currentframe == 2) {
			this._parent["myToolbar"].piede.contr.playpause.puls.onPress();
		}
		if (lista.childNodes.length>1) {
			if (n-2>=0) {
				n -= 2;
				load_foto();
			}
			if (n == 0) {
				n = listaSS.length-2;
				load_foto();
			}
		}
	}
	function indietro_flv() {
		var tmp2 = int((this["monitor"]["myFlvPlayer"].ns.time)-(this.myDuration/10));
		if (tmp2<0) {
			tmp2 = 0;
		}
		this["monitor"]["myFlvPlayer"].ns.seek(0);
	}
	function avanti_flv() {
		var tmp2 = int((this["monitor"]["myFlvPlayer"].ns.time)+(this.myDuration/10));
		if (tmp2>this.myDuration) {
			tmp2 = this.myDuration;
		}
		this["monitor"]["myFlvPlayer"].ns.seek(tmp2);
	}
	function stop_play_flv() {
		trace(nsclosed+"stop_play_flv "+play_status);
		if (nsclosed) {
			this._parent["myToolbar"].bottoni(false);
			myloaded = false;
			firstTime = true;
			play_status = true;
			this["monitor"]["myFlvPlayer"].ns.play(currMov);
		} else {
			if (play_status) {
				this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(1);
				play_status = false;
			} else {
				this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
				play_status = true;
			}
			this["monitor"]["myFlvPlayer"].ns.pause(!play_status);
		}
	}
	function stoppaInizFlv() {
		clearInterval(stopper);
		autostop = false;
		this["monitor"]["myFlvPlayer"].ns.close();
		this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit+": Stopped";
		stop_play_flv();
		nsclosed = true;
		/*if (this._parent["myToolbar"].single) {
			this._parent["myToolbar"]["ppBig"]._visible = true;
		}*/
	}
	function stop_play_jpg() {
		if (play_status) {
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(1);
			clearInterval(ssInt);
			play_status = false;
		} else {
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
			load_foto();
			play_status = true;
		}
	}
	function stop_play_swf() {
		if (play_status) {
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(1);
			this["monitor"].mon.trgt.stop();
			play_status = false;
		} else {
			trace("cazzo"+this["monitor"].mon.thumb)
			if (this["monitor"].mon.thumb) {
				this["monitor"].mon.thumb.removeMovieClip()
				load_jpg_swf(currMov,this["monitor"].mon)
			} else {
				this["monitor"].mon.trgt.play();
			}
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
			play_status = true;
		}
	}
	function stop_play_mp3() {
		if (play_status) {
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(1);
			mp3player.stop();
			play_status = false;
		} else {
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
			if (mp3player.duration != mp3player.position) {
				mp3player.start(mp3player.position/1000);
			} else {
				mp3player.start(0);
			}
			play_status = true;
		}
	}
	function resetta() {
		this._parent["myToolbar"].resetta();
		myloaded = mcLoaded=swf_started=play_status=false;
		l = 0;
		n = 0;
		clearInterval(ssInt);
		this["monitor"]["myFlvPlayer"].ns.close();
		mp3player.stop();
		this["monitor"].mov.myMcl.unloadClip(this["monitor"].mov.trgt);
		this["monitor"]["myFlvPlayer"]["myVideo"].vid_flv.clear();
		for (var item in this["monitor"]) {
			if (item.indexOf("foto_") != -1 || item.indexOf("mon") != -1) {
				this["monitor"][item].removeMovieClip();
			}
		}
	}
	function resizza() {
		trace("resizza");
		if (resizza_onoff) {
			if (tipo == "flv") {
				var trgt = this["monitor"]["myFlvPlayer"]["myVideo"].vid_flv;
				trgt._width = w;
				trgt._height = h;
				if (trgt._xscale>trgt._yscale) {
					trgt._xscale = trgt._yscale;
				} else {
					trgt._yscale = trgt._xscale;
				}
			} else if (tipo == "jpg") {
				for (var item in this["monitor"]) {
					if (item.indexOf("foto_") != -1) {
						var trgt = this["monitor"][item];
						trgt.fondo._width = w;
						trgt.fondo._height = h;
						trgt.trgt._width = w;
						trgt.trgt._height = h;
						trgt.trgt._xscale = trgt.trgt._yscale;
						/*if ((trgt.trgt._xscale/trgt.trgt._yscale)>(w/h)) {
						trgt.trgt._xscale = trgt.trgt._yscale;
						} else {
						trgt.trgt._yscale = trgt.trgt._xscale;
						}*/
					}
				}
			} else if (tipo == "swf") {
				var trgt = this["monitor"].mon.trgt;
				if ((swfW/swfH)>(w/h)) {
					trgt._xscale = trgt._yscale=(w/swfW)*100;

				} else {
					trgt._yscale = trgt._xscale=(h/swfH)*100;
				}
				/**/
			}
		} else {
			if (tipo == "flv") {
				var trgt = this["monitor"]["myFlvPlayer"]["myVideo"].vid_flv;
				trgt._width = trgt.width;
				trgt._height = trgt.height;
			} else if (tipo == "jpg") {
				for (var item in this["monitor"]) {
					if (item.indexOf("foto_") != -1) {
						var trgt = this["monitor"][item];
						trgt.fondo._width = w;
						trgt.fondo._height = h;
						trgt.trgt._yscale = 100;
						trgt.trgt._xscale = 100;
					}
				}
			} else if (tipo == "swf") {
				var trgt = this["monitor"].mon;
				trgt.trgt._xscale = trgt.trgt._yscale=100;
			}
		}
		if (centra_onoff) {
			if (tipo == "flv") {
				trgt._x = (w-trgt._width)/2;
				trgt._y = (h-trgt._height)/2;
			} else if (tipo == "jpg") {
				for (var item in this["monitor"]) {
					if (item.indexOf("foto_") != -1) {
						var trgt = this["monitor"][item];
						trgt.fondo._width = w;
						trgt.fondo._height = h;
						trgt.trgt._x = (w-trgt.trgt._width)/2;
						trgt.trgt._y = (h-trgt.trgt._height)/2;
					}
				}
			} else if (tipo == "swf") {
				var trgt = this["monitor"].mon.trgt;
				//trgt.fondo._width = w;
				//trgt.fondo._height = h;
				trgt._x = (w-((400*trgt._xscale)/100))/2;
				trgt._y = (h-((300*trgt._yscale)/100))/2;
			}
		}
		trgt._visible = true;
	}
	function drawer(trgt, myName, x, y, w, h, col) {
		trgt.createEmptyMovieClip(myName,trgt.getNextHighestDepth());
		with (trgt[myName]) {
			var myBitmapData:BitmapData = BitmapData.loadBitmap("texture");
			var matrix = new Matrix();
			var repeat = true;
			var smoothing = false;
			beginBitmapFill(myBitmapData,matrix,repeat,smoothing);
			moveTo(0,0);
			lineTo(w,0);
			lineTo(w,h);
			lineTo(0,h);
			lineTo(0,0);
			_x = x;
			_y = y;
		}
	}
}