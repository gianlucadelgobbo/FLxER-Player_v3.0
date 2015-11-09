import flash.display.*;
import flash.geom.*;
class flxerGallery.flxerPlayer extends MovieClip {
	var x:Number;
	var y:Number;
	var w:Number;
	var h:Number;
	var col;
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
	var path:String;
	var att:String;
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
	//
	function flxerPlayer() {
		this._x = x;
		this._y = y+this._parent["myToolbar"].testa._height+1;
		h = h-(this._parent["myToolbar"].testa._height+this._parent["myToolbar"].piede.piedeEst._height+3);
		if (col != undefined) {
			drawer(this, "fondo", 0, 0, w, h, null);
		}
		this.createEmptyMovieClip("monitor", this.getNextHighestDepth());
		drawer(this, "mask", 0, 0, w, h, 0x000000);
		this["monitor"].setMask(this["mask"]);
		play_status = false;
	}
	function setPos(ww, hh) {
		w = ww;
		h = hh-(this._parent["myToolbar"].testa._height+this._parent["myToolbar"].piede.piedeEst._height+3);
		if (col != undefined) {
			this["fondo"]._width = w;
			this["fondo"]._height = h;
		}
		this["mask"]._width = w;
		this["mask"]._height = h;
		resizza();
	}
	function avvia(myXml, i, ss):Void {
		index = undefined;
		trace("avviaavviaavvia "+autostop);
		if (autostop) {
			this._parent["myToolbar"].attachMovie("playpause", "ppBig", this._parent["myToolbar"].getNextHighestDepth(), {_x:(w-66)/2, _y:(h-66)/2, _xscale:600, _yscale:600});
			this._parent["myToolbar"]["ppBig"].fnz = "myPlaypause";
			this._parent["myToolbar"]["ppBig"].fnzTrgt = this._parent["myToolbar"];
		}
		if (i != undefined) {
			//lista = new XML(myXml.childNodes[index]);
			lista = myXml;
			index = i;
			var tmp = lista.childNodes[index].childNodes[0].attributes[att];
			this._parent["myToolbar"].tipo = tipo=tmp.substring(tmp.lastIndexOf(".")+1, tmp.length).toLowerCase();
		} else {
			lista = myXml;
			this._parent["myToolbar"].tipo = tipo="jpg";
		}
		trace("flxerPlayer "+tipo);
		//var owner:flxerPlayer = this;
		resetta();
		/* new Video */
		nc = new NetConnection();
		nc.connect(null);
		ns = new NetStream(nc);
		ns.owner = this;
		ns["onMetaData"] = function (obj:Object) {
			trace("onMetaData");
			owner.myDuration = obj.duration;
		};
		ns.onStatus = function(infoObject) {
			trace(infoObject.code+" "+owner.play_status+" "+owner.firstTime);
			if (infoObject.code == "NetStream.Play.Start" && owner.firstTime) {
				trace("cazzarola");
				owner._parent["myToolbar"].avvia_indice();
				owner.resizza(owner["monitor"].video.vid_flv);
				owner.firstTime = false;
				owner.play_status = true;
				owner.loadedMov = owner.currMov;
				owner._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
				owner._parent["myToolbar"].bottoni(true);
				owner.nsclosed = false;
				if (owner.autostop) {
					trace("BINGOOOO");
					owner.stopper = setInterval(owner, "stoppaInizFlv", 400);
				}
			}
			if (infoObject.code == "NetStream.Play.Stop" && owner.myLoop) {
				this.seek(0);
			}
			if (infoObject.code == "NetStream.Buffer.Full" && owner.firstTime2) {
				owner.firstTime2 = false;
				owner._parent["myToolbar"].lab_i.htmlText = owner._parent["myToolbar"].tit+": Buffer Full";
			}
		};
		ns.setBufferTime(5);
		/* new Sound */
		mp3player = new Sound();
		mp3player["owner"] = this;
		mp3player.onLoad = function() {
			this.start(0);
			owner.play_status = true;
			owner.loadedMov = owner.currMov;
			owner._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
			owner._parent["myToolbar"].avvia_indice();
		};
		mp3player.onSoundComplete = function() {
			this.start(0);
		};
		/*/////////////////////////////*/
		firstTime = true;
		firstTime2 = true;
		if (ss) {
			this._parent["myToolbar"].tipo = tipo="jpg";
		}
		this["avvia_"+tipo](index);
	}
	/* IMMAGINI /////////////////*/
	function avvia_jpg(index) {
		listaSS = [];
		generaListaSS();
		for (var a = 0; a<listaSS.length; a++) {
			trace("AAA "+lista.childNodes[index].childNodes[0].attributes[att]);
			trace("BBB "+lista.childNodes[a].childNodes[0].attributes[att]);
			if (lista.childNodes[index].childNodes[0].attributes[att] == lista.childNodes[listaSS[a]].childNodes[0].attributes[att]) {
				index = a;
			}
		}
		if (index != undefined) {
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
			n = index;
			play_status = true;
		} else {
			this._parent["myToolbar"].mRoot.customItems[0].enabled = true;
			//listaSS[0] = [index];
			play_status = false;
		}
		this._parent["myToolbar"].piede.indice.curs.enabled = false;
		load_foto();
	}
	function stoppa() {
		this.stop_play_flv();
		if (this._parent["myToolbar"].single) {
			this._parent["myToolbar"]["ppBig"]._visible = true;
		}
		clearInterval(autostopInt);
	}
	function generaListaSS() {
		for (var a = 0; a<this.lista.childNodes.length; a++) {
			var tmp = this.lista.childNodes[a].childNodes[0].attributes[att];
			tmp = tmp.substring(tmp.length-3, tmp.length);
			if (tmp == "jpg") {
				trace("AAAAA "+tmp);
				listaSS.push(a);
			}
		}
	}
	function load_foto() {
		clearInterval(ssInt);
		this["monitor"].createEmptyMovieClip("foto_"+l, this["monitor"].getNextHighestDepth());
		this["monitor"]["foto_"+l]._alpha = 0;
		if (col != undefined) {
			drawer(this["monitor"]["foto_"+l], "fondo", 0, 0, w, h, col);
		}
		var tmp = lista.childNodes[listaSS[n]].childNodes[0].attributes[att];
		if (tmp.lastIndexOf("mm=") != -1) {
			tmp = tmp.substring(tmp.lastIndexOf("mm=")+3, tmp.length);
		}
		currMov = tmp;
		load_jpg_swf(tmp, this["monitor"]["foto_"+l]);
		trace("----- "+lista.childNodes[listaSS[n]].childNodes[1]);
		if (lista.childNodes.length>1) {
			this._parent["myToolbar"].tit = (n+1)+" / "+listaSS.length+" - "+lista.childNodes[listaSS[n]].childNodes[1].childNodes[0].toString();
			this._parent["myToolbar"].piede.indice.curs._x = (((this._parent["myToolbar"].barr_width)/(listaSS.length-1))*n);
			l++;
			if (n>listaSS.length-2) {
				n = 0;
			} else {
				n++;
			}
		} else {
			this._parent["myToolbar"].tit = lista.childNodes[listaSS[n]].childNodes[1].childNodes[0].toString();
		}
		this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit;
	}
	/* SWF /////////////////*/
	function avvia_swf() {
		//ss = false;
		var tmp = lista.childNodes[index].childNodes[0].attributes[att];
		if (tmp.lastIndexOf("mm=") != -1) {
			tmp = tmp.substring(tmp.lastIndexOf("mm=")+3, tmp.length);
		}
		this["monitor"].createEmptyMovieClip("mon", this["monitor"].getNextHighestDepth());
		play_status = true;
		load_jpg_swf(tmp, this["monitor"].mon);
		mp3player = new Sound(this["monitor"].mon);
		this._parent["myToolbar"].tit = lista.childNodes[index].childNodes[1].childNodes[0].toString();
		this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit;
	}
	/* JPG / SWF /////////////////*/
	function load_jpg_swf(mov, trgt) {
		trgt.mcl = new main.mcLoader(this.path+mov, trgt, this, "MovieClipLoader_succes", "MovieClipLoader_progress");
		currMov = mov;
	}
	function MovieClipLoader_progress(target_mc, loadedBytes, totalBytes) {
		this._parent["myToolbar"].piede.indice.barr._width = this._parent["myToolbar"].barr_width*(loadedBytes/totalBytes);
		if (tipo == "swf" && target_mc._currentframe && swf_started == false) {
			if (autostop && firstTime) {
				trace("ooo "+target_mc._currentframe);
				play_status = false;
				target_mc.stop();
				this._parent["myToolbar"]["ppBig"]._visible = true;
			} else {
				target_mc.play();
				this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
				swf_started = true;
			}
			this._parent["myToolbar"].avvia_indice();
		}
	}
	function MovieClipLoader_succes(target_mc) {
		loadedMov = currMov;
		mcLoaded = true;
		if (tipo == "swf" && swf_started == false) {
			if (autostop && firstTime) {
				trace("aaa "+target_mc._currentframe);
				firstTime = false;
				play_status = false;
				target_mc.stop();
				this._parent["myToolbar"]["ppBig"]._visible = true;
			} else {
				target_mc.play();
				this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
				swf_started = true;
			}
			this._parent["myToolbar"].avvia_indice();
		}
		resizza(target_mc);
		if (l>1) {
			var tmp = "loadNext";
			target_mc._parent._parent["foto_"+(l-2)].myTween = new main.myTween(target_mc._parent._parent["foto_"+(l-2)], "_alpha", mx.transitions.easing.Regular.easeIn, 100, 0, 10, this, "removePrev");
		}
		if (l>1) {
			target_mc._parent._parent["foto_"+(l-2)].myTween = new main.myTween(target_mc._parent._parent["foto_"+(l-2)], "_alpha", mx.transitions.easing.Regular.easeIn, 100, 0, 10, this, "removePrev");
		}
		if (tipo == "jpg") {
			var tmp = "";
			if (play_status) {
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
		trace("loadNext");
		if (play_status) {
			ssInt = setInterval(this, "load_foto", ss_time);
		}
	}
	function removePrev(target_mc) {
		target_mc.removeMovieClip();
	}
	/* MP3 /////////////////*/
	function avvia_mp3() {
		this._parent["myToolbar"].tit = lista.childNodes[index].childNodes[1].childNodes[0].toString();
		this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit;
		var tmp = lista.childNodes[index].childNodes[0].attributes[att];
		tmp = tmp.substring(tmp.lastIndexOf("mm=")+3, tmp.length);
		currMov = tmp;
		//descr = lista.childNodes[index].childNodes[1];
		load_mp3(tmp);
	}
	function load_mp3(mov) {
		mp3player.loadSound(path+mov, false);
		currMov = mov;
	}
	/* FLV /////////////////*/
	function avvia_flv() {
		if (!this["monitor"].video) {
			this["monitor"].attachMovie("video", "video", this["monitor"].getNextHighestDepth());
			this["monitor"].video.vid_flv._width = w;
			this["monitor"].video.vid_flv._height = h;
		}
		this["monitor"].video.vid_flv._visible = false;
		this["monitor"].video.vid_flv.attachVideo(ns);
		this["monitor"].video.vid_flv.smoothing = true;
		this["monitor"].video.vid_flv._parent.attachAudio(ns);
		this._parent["myToolbar"].tit = lista.childNodes[index].childNodes[1].childNodes[0].toString();
		this._parent["myToolbar"].lab_i.htmlText = this._parent["myToolbar"].tit+": Buffering...";
		var tmp = lista.childNodes[index].childNodes[0].attributes[att];
		if (tmp.lastIndexOf("mm=") != -1) {
			tmp = tmp.substring(tmp.lastIndexOf("mm=")+3, tmp.length);
		}
		this._parent["myToolbar"].bottoni(false);
		ns.play(path+tmp);
		currMov = tmp;
		mp3player = new Sound(this["monitor"].video.vid_flv._parent);
	}
	/* TOOLS /////////////////*/
	function volume_onPress() {
		volInt = setInterval(this, "MySetVolume", 30);
	}
	function MySetVolume() {
		mp3player.setVolume(-(this._parent["myToolbar"].piede.contr.volume_ctrl.slider._y+10));
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
		clearInterval(ssInt);
		play_status = false;
		//ssInt = 0;
		if (lista.childNodes.length>1) {
			if (n<lista.childNodes.length-1) {
				load_foto();
			}
		}
	}
	function indietro_jpg() {
		clearInterval(ssInt);
		play_status = false;
		this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(1);
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
		var tmp2 = int((ns.time)-(this.myDuration/10));
		if (tmp2<0) {
			tmp2 = 0;
		}
		ns.seek(0);
	}
	function avanti_flv() {
		var tmp2 = int((ns.time)+(this.myDuration/10));
		if (tmp2>this.myDuration) {
			tmp2 = this.myDuration;
		}
		ns.seek(tmp2);
	}
	function stop_play_flv() {
		trace(nsclosed+"stop_play_flv "+play_status);
		if (nsclosed) {
			this._parent["myToolbar"].bottoni(false);
			myloaded = false;
			firstTime = true;
			play_status = true;
			ns.play(path+currMov);
		} else {
			if (play_status) {
				this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(1);
				play_status = false;
			} else {
				this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
				play_status = true;
			}
			ns.pause(!play_status);
		}
	}
	function stoppaInizFlv() {
		clearInterval(stopper);
		autostop = false;
		this.ns.close();
		stop_play_flv();
		nsclosed = true;
		if (this._parent["myToolbar"].single) {
			this._parent["myToolbar"]["ppBig"]._visible = true;
		}
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
			this._parent["myToolbar"].piede.contr.playpause.gotoAndStop(2);
			this["monitor"].mon.trgt.play();
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
		myloaded = false;
		swf_started = false;
		play_status = false;
		l = 0;
		n = 0;
		clearInterval(ssInt);
		ns.close();
		mp3player.stop();
		this["monitor"].mov.myMcl.unloadClip(this["monitor"].mov.trgt);
		this["monitor"].video.vid_flv.clear();
		if (mcLoaded) {
			mcLoaded = !mcLoaded;
		}
		for (var item in this["monitor"]) {
			if (item.indexOf("foto_") != -1 || item.indexOf("mon") != -1) {
				this["monitor"][item].removeMovieClip();
			}
		}
	}
	function resizza() {
		if (resizza_onoff) {
			if (tipo == "flv") {
				var trgt = this["monitor"].video.vid_flv;
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
						if ((trgt.trgt._xscale/trgt.trgt._yscale)>(w/h)) {
							trgt.trgt._width = w;
							trgt.trgt._yscale = trgt.trgt._xscale;
						} else {
							trgt.trgt._height = h;
							trgt.trgt._xscale = trgt.trgt._yscale;
						}
					}
				}
			} else if (tipo == "swf") {
				var trgt = this["monitor"].mon;
				if ((trgt.trgt._xscale/trgt.trgt._yscale)>(w/h)) {
					trgt.trgt._xscale = trgt.trgt._yscale=w/4;
				} else {
					trgt.trgt._yscale = trgt.trgt._xscale=h/3;
				}
			}
		} else {
			if (tipo == "flv") {
				var trgt = this["monitor"].video.vid_flv;
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
				var trgt = this["monitor"].mon;
				//trgt.fondo._width = w;
				//trgt.fondo._height = h;
				trgt.trgt._x = (w-400*(trgt.trgt._xscale/100))/2;
				trgt.trgt._y = (h-300*(trgt.trgt._yscale/100))/2;
			}
		}
		trgt._visible = true;
	}
	function drawer(trgt, myName, x, y, w, h, col) {
		trgt.createEmptyMovieClip(myName, trgt.getNextHighestDepth());
		with (trgt[myName]) {
			var myBitmapData:BitmapData = BitmapData.loadBitmap("texture");
			var matrix = new Matrix();
			var repeat = true;
			var smoothing = false;
			beginBitmapFill(myBitmapData, matrix, repeat, smoothing);
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
