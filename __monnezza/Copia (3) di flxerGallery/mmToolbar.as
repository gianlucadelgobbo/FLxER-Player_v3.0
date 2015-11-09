class flxerGallery.mmToolbar extends MovieClip {
	var mmSelTit;
	var col;
	var tipo;
	var barr_width;
	var tit;
	var w;
	var h;
	var myKeyL;
	var owner;
	var single;
	var lab_i, fw, rw, contr, volume_ctrl, stampa, scarica, indice, selector, testa, piedeInt, piedeEst, piede;
	var noImg;
	function mmToolbar() {
		_root.myDrawerFunc.textDrawerSP(this.piede, "myMenu", "bella", w-144, -120-17, 140, 120, false);
		piede["myMenu"]._visible = false;
		piede["myMenu"].background = true;
		piede["myMenu"].border = true;
		piede["myMenu"].backgroundColor = _root.myDrawerFunc.testo["colorBkg"];
		piede["myMenu"].borderColor = _root.myDrawerFunc.testo["colorBorder"];
		piede.contr.selector._visible = piede.ss._visible=piede.m._visible=false;
		piede.toppa._visible = true;
		avviaPuls();
		setPos(w, h);
		trace("mmToolbar3 "+single);
		if (single) {
			piede.contr.selector._visible = false;
			piede.ss._visible = false;
			//this["ppBig"]._visible = false;
		} else {
			piede.contr.selector._visible = true;
			piede.ss._visible = true;
		}
		//
		piede.toppa.onPress = function() {
		};
		piede.toppa.useHandCursor = false;
		//
		piede.contr.volume_ctrl.slider.onPress = function() {
			startDrag(this, false, this._parent.path._x, this._parent.path._y+this._parent.path._height-this._height, this._parent.path._x, this._parent.path._y);
			this._parent._parent._parent._parent._parent["mySuperPlayer"].volume_onPress();
		};
		piede.contr.volume_ctrl.slider.onRelease = function() {
			this._parent.prevFrame();
			stopDrag();
			this._parent._parent._parent._parent._parent["mySuperPlayer"].volume_onRelease();
		};
		piede.contr.volume_ctrl.slider.onReleaseOutside = function() {
			onRelease();
		};
		myKeyL = new Object();
		myKeyL.owner = this;
		myKeyL.onKeyDown = function() {
			if (Key.getCode() == Key.LEFT) {
				if (owner.piede.contr.rw.puls.enabled) {
					trace("owner.piede.contr.rw");
					owner.piede.contr.rw.puls.onPress();
				}
			}
			if (Key.getCode() == Key.RIGHT) {
				if (owner.piede.contr.fw.puls.enabled) {
					trace("owner.piede.contr.fw");
					owner.piede.contr.fw.puls.onPress();
				}
			}
			if (Key.getCode() == Key.SPACE) {
				if (owner.piede.contr.playpause.puls.enabled) {
					trace("owner.piede.contr.playpause");
					owner.piede.contr.playpause.puls.onPress();
				}
			}
		};
		Key.addListener(myKeyL);
	}
	function stopScratch(t) {
		if (piede.contr.playpause._currentframe == 2 && this._parent["mySuperPlayer"].tipo == "flv") {
			this._parent["mySuperPlayer"].ns.pause(false);
		}
		this._parent["mySuperPlayer"].myLoop = this._parent.myLoop;
		avvia_indice();
		t.stopDrag();
	}
	function scratch(t) {
		trace("scratch"+t);
		avvia_scratch();
		this._parent["mySuperPlayer"].myLoop = false;
		t.startDrag(false, 0, t._y, piede.indice.barr._width, t._y);
	}
	function avviaPuls() {
		piede.indice.curs.fnzTrgt = piede.contr.playpause.fnzTrgt=piede.contr.fw.fnzTrgt=piede.contr.rw.fnzTrgt=piede.m.fnzTrgt=piede.contr.selector.fnzTrgt=piede.ss.fnzTrgt=this;
		piede.indice.curs.alt = "scratch";
		piede.indice.curs.fnz = "scratch";
		piede.indice.curs.fnzOut = "stopScratch";
		//
		piede.ss.fnz = "avviaSS";
		piede.ss.txt = "slideshow";
		piede.ss.alt = "Avvia slideshow";
		//
		piede.contr.selector.fnz = "avviaSelector";
		piede.contr.selector.txt = "playlists";
		piede.contr.selector.alt = "Mostra playlists";
		//
		piede.m.fnz = "apriMenu";
		piede.m.txt = "menu";
		piede.m.alt = "Mostra opzioni menu";
		//
		piede.contr.fw.fnz = "avanti";
		piede.contr.fw.alt = "Vai avanti (arrow right)";
		//
		piede.contr.rw.fnz = "indietro";
		piede.contr.rw.alt = "Torna indietro (arrow left)";
		//
		piede.contr.playpause.fnz = "myPlaypause";
		piede.contr.playpause.alt = "Stop/Play (space bar)";
		//
	}
	function avvia(s, n) {
		noImg = n;
		piede.m._visible = true;
		single = s;
		setPos(w, h);
		if (single) {
			piede.contr.selector._visible = false;
			piede.ss._visible = false;
			//this["ppBig"]._visible = false;
		} else {
			piede.contr.selector._visible = true;
			piede.ss._visible = true;
		}
	}
	function visualizzappBig() {
		this.attachMovie("playpause", "ppBig", this.getNextHighestDepth(), {_x:(w-66)/2, _y:(h-66)/2, _xscale:600, _yscale:600});
		this["ppBig"].fnz = "myPlaypause";
		this["ppBig"].fnzTrgt = this;
	}
	function setPos(w, h) {
		trace("setPos "+single);
		testa._width = piedeEst._width=w;
		lab_i._width = w-10;
		piede._y = h-piede.piedeEst._height;
		piede.piedeEst._width = w;
		piede.piedeInt._width = piede.toppa._width=w-2;
		var deltaW = 0;
		if (single) {
			deltaW = 55;
		}
		piede.contr._x = w-piede.contr._width-piede.m._width+deltaW-10;
		piede.indice.barr._width = piede.contr._x-piede.indice._x-piede.indice.counter._width;
		piede.indice.counter._x = piede.indice.barr._width+3;
		piede.indice.barrEst._width = piede.indice.barr._width+2;
		barr_width = piede.indice.barr._width;
		piede.m._x = w-piede.m._width-3;
		piede.ss._x = w-95;
		piede["myMenu"]._x = w-piede["myMenu"]._width-4;
		//piede.toppa._visible=false
	}
	//
	function itemHandler(obj, item) {
		trace("itemHandler"+_root.galleryPath);
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["mySelector"].resizza_onoff = _root.galleryPath["mySuperPlayer"].resizza_onoff=true;
		_root.galleryPath["mySuperPlayer"].resizza();
	}
	function itemHandler2(obj, item) {
		trace("itemHandler2");
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["mySelector"].resizza_onoff = _root.galleryPath["mySuperPlayer"].resizza_onoff=false;
		_root.galleryPath["mySuperPlayer"].resizza();
	}
	function itemHandler3(obj, item) {
		trace("itemHandler3"+_root.galleryPath["myToolbar"])
		//fscommand("fullscreen", true);
		_root.galleryPath["myToolbar"].fs(obj, item);
	}
	function itemHandler4(obj, item) {
		trace("itemHandler4"+_root.galleryPath["mySuperPlayer"])
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		if (_root.galleryPath["myToolbar"].piede.contr.playpause._currentframe == 2) {
			_root.galleryPath["myToolbar"].piede.contr.playpause.puls.onPress();
		}
		_root.galleryPath["mySuperPlayer"].cacheAsBitmap = true
		var pageCount:Number = 0;
		var my_pj:PrintJob = new PrintJob();
		if (my_pj.start()) {
			if (my_pj.addPage(_root.galleryPath, {xMin:0, xMax:w, yMin:0, yMax:h}, {printAsBitmap:true})) {
				pageCount++;
			}
		}
		if (pageCount>0) {
			my_pj.send();
		}
		delete my_pj;
		//this._parent["mySuperPlayer"].cacheAsBitmap = false
	}
	function itemHandler5(obj, item) {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["myToolbar"].dw(obj, item);
	}
	function apriEmbed() {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["myToolbar"].attachMovie("myEmbed", "myEmbed", _root.galleryPath["myToolbar"].getNextHighestDepth(), {_x:int(_root.galleryPath["myToolbar"].w/2), _y:int(_root.galleryPath["myToolbar"].h/2)});
		if (_root.galleryPath.startUrl.indexOf("http://") != -1) {
			var tmp = _root.mySitePath+_root.embePath+_root.galleryPath.startUrl;
		} else {
			var tmp = _root.mySitePath+_root.embePath+_root.mySitePath+_root.galleryPath.startUrl;
		}
		_root.galleryPath["myToolbar"]["myEmbed"].lab_i.text = "<object type=\"application/x-shockwave-flash\" data=\""+tmp+"\" width=\""+(_root.galleryPath["myToolbar"].w)+"\" height=\""+(_root.galleryPath["myToolbar"].h)+"\">\n	<param name=\"movie\" value=\""+tmp+"\" />\n</object>";
		_root.galleryPath["myToolbar"]["myEmbed"].c.fnz = "chiudiEmbed";
		_root.galleryPath["myToolbar"]["myEmbed"].c.fnzTrgt = _root.galleryPath["myToolbar"];
	}
	//
	function dw(obj, item) {
		var tmp = this._parent["mySuperPlayer"].currMov.split(",");
		getURL(_root.mySitePath+_root.downPath+_root.myStarter.myReplace(tmp[0], _root.mySitePath, ""));
		trace("download "+_root.mySitePath+_root.downPath+_root.myStarter.myReplace(tmp[0], _root.mySitePath, ""));
	}
	function fs(obj, item) {
		piede["myMenu"]._visible = false;
		if (piede.contr.playpause._currentframe == 2) {
			piede.contr.playpause.puls.onPress();
		}
		if (single) {
			var tmp = this._parent.startUrl.split(",");
			if (tmp[0].indexOf("http://") != -1) {
				trace(_root.mySitePath+_root.myFsPath+_root.myStarter.myReplace(tmp[0], _root.mySitePath, "")+"&tit="+tmp[1]+"&out=true");
				getURL(_root.mySitePath+_root.myFsPath+_root.myStarter.myReplace(tmp[0], _root.mySitePath, "")+"&tit="+tmp[1]+"&out=true", "_blank");
			} else {
				trace("javascript:popupwindow('FULL','FULL','"+_root.myFsPath+_root.myStarter.myReplace(tmp[0], _root.mySitePath, "")+"&tit="+tmp[1]+"','FLXERPLAYER','no','yes');");
				getURL("javascript:popupwindow('FULL','FULL','"+_root.myFsPath+_root.myStarter.myReplace(tmp[0], _root.mySitePath, "")+"&tit="+tmp[1]+"','FLXERPLAYER','no','yes');");
			}
		} else {
			var tmp = this._parent.startUrl;
			if (tmp.indexOf("http://") != -1) {
				trace(_root.mySitePath+_root.myFsPath+_root.myStarter.myReplace(tmp, _root.mySitePath, "")+"&out=true");
				getURL(_root.mySitePath+_root.myFsPath+_root.myStarter.myReplace(tmp, _root.mySitePath, "")+"&out=true", "_blank");
			} else {
				trace("javascript:popupwindow('FULL','FULL','"+_root.myFsPath+_root.myStarter.myReplace(tmp, _root.mySitePath, "")+"','FLXERPLAYER','no','yes');");
				getURL("javascript:popupwindow('FULL','FULL','"+_root.myFsPath+_root.myStarter.myReplace(tmp, _root.mySitePath, "")+"','FLXERPLAYER','no','yes');");
			}
		}
	}
	function avviaSS() {
		trace("avviaSS");
		this.piede["myMenu"]._visible = false;
		this._parent["mySelector"].mySlidesShow();
		this.piede.toppa._visible = this.piede.ss._visible=false;
	}
	function avviaSelector() {
		var trgt = this;
		trgt.piede["myMenu"]._visible = false;
		trgt.piede.toppa._visible = true;
		trace("CCCCCCCCC "+noImg);
		trgt.piede.ss._visible = !trgt.noImg;
		trgt._parent["mySuperPlayer"].resetta();
		trgt._parent["mySuperPlayer"]._visible = false;
		trgt._parent["mySelector"]._visible = true;
		trgt.lab_i.htmlText = trgt.mmSelTit;
		trgt.resetta();
	}
	function chiudiEmbed() {
		_root.alt.stoppa();
		this["myEmbed"].removeMovieClip();
	}
	function avanti() {
		this._parent["mySuperPlayer"]["avanti_"+tipo]();
	}
	function indietro() {
		this._parent["mySuperPlayer"]["indietro_"+tipo]();
	}
	function myPlaypause() {
		if (this["ppBig"]) {
			this["ppBig"].removeMovieClip();
		}
		trace("myPlaypause");
		this._parent["mySuperPlayer"]["stop_play_"+tipo]();
	}
	function apriMenu() {
		var menuTxt = "";
		if (!piede["myMenu"]._visible) {
			if (piede.toppa._visible) {
				if (!single) {
					if (!noImg) {
						menuTxt += "<a href=\"asfunction:"+this+".avviaSS\">Slideshow</a><br/>";
					} else {
						menuTxt += "Slideshow (no images)<br/>";
					}
				}
				menuTxt += "Scale: Fit player size<br/>";
				menuTxt += "Scale: 100%<br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler3\">Fullscreen</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler4\">Print this content</a><br/>";
				menuTxt += "Download<br/>";
				menuTxt += "<a href=\"asfunction:"+this+".apriEmbed\">Embed</a>";
			} else {
				if (!single) {
					menuTxt += "<a href=\"asfunction:"+this+".avviaSelector\">Playlist</a><br/>";
				}
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler\">Scale: Fit player size</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler2\">Scale: 100%</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler3\">Fullscreen</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler4\">Print this content</a><br/>";
				//menuTxt += "<a href=\"asfunction:"+this+".itemHandler5\">Download</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".apriEmbed\">Embed</a>";
			}
			piede["myMenu"].htmlText = "<p class=\"playerMenu\">"+menuTxt+"</p>";
			trace(piede["myMenu"].htmlText);
			piede["myMenu"]._height = piede["myMenu"].textHeight+5;
			piede["myMenu"]._y = -piede["myMenu"]._height+3;
		}
		piede["myMenu"]._visible = !piede["myMenu"]._visible;
	}
	function avvia_indice() {
		trace("avvia_indice "+tipo)
		delete this.onEnterFrame;
		if (tipo == "mp3") {
			this._parent["mySuperPlayer"].mp3player.start(int(((piede.indice.curs._x/(barr_width))*this._parent["mySuperPlayer"].mp3player.duration)/1000));
		}
		this.onEnterFrame = function() {
			this["indice_"+tipo]();
		};
	}
	function myTime(mm) {
		//trace("myTime "+this._parent["mySuperPlayer"]["monitor"].video.vid_flv._x);
		if (mm>60) {
			var tmp = int(mm/60);
			if (tmp.toString().length<2) {
				var min = "0"+tmp;
			} else {
				var min = tmp;
			}
			var tmp2 = int(mm-(60*tmp));
			if (tmp2.toString().length<2) {
				var sec = "0"+tmp2;
			} else {
				var sec = tmp2;
			}
		} else {
			var min = "00";
			if (int(mm).toString().length<2) {
				var sec = "0"+int(mm);
			} else {
				var sec = int(mm);
			}
		}
		return min+":"+sec;
	}
	function indice_flv() {
		if (this._parent["mySuperPlayer"].myDuration != undefined) {
			if (this._parent["mySuperPlayer"].ns.bytesLoaded<this._parent["mySuperPlayer"].ns.bytesTotal) {
				//this.lab_i.htmlText = this.tit+": Playing "+myTime(this._parent["mySuperPlayer"].ns.time)+" / "+myTime(this._parent["mySuperPlayer"].myDuration);
				this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"].ns.time)+" | "+myTime(this._parent["mySuperPlayer"].myDuration);
				/*if (this._parent["mySuperPlayer"].info) {
				this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"].ns.bytesLoaded/1024)+" / "+int(this._parent["mySuperPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}*/
				piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"].ns.bytesLoaded/this._parent["mySuperPlayer"].ns.bytesTotal);
			} else if (this._parent["mySuperPlayer"].ns.bytesLoaded == this._parent["mySuperPlayer"].ns.bytesTotal && this._parent["mySuperPlayer"].myloaded == false) {
				this._parent["mySuperPlayer"].myloaded = true;
				piede.indice.barr._width = barr_width;
			} else {
				//this.lab_i.htmlText = this.tit+": Playing "+myTime(this._parent["mySuperPlayer"].ns.time)+" / "+myTime(this._parent["mySuperPlayer"].myDuration);
				this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"].ns.time)+" | "+myTime(this._parent["mySuperPlayer"].myDuration);
				/*if (this._parent["mySuperPlayer"].info) {
				this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}*/
			}
			piede.indice.curs._x = (barr_width)*(this._parent["mySuperPlayer"].ns.time/this._parent["mySuperPlayer"].myDuration);
			piede.indice.path._width = piede.indice.curs._x;
			piede.indice.curs.enabled = true;
		} else {
			if (this._parent["mySuperPlayer"].ns.bytesLoaded<this._parent["mySuperPlayer"].ns.bytesTotal) {
				this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"].ns.time);
				/*this.lab_i.htmlText = this.tit+": Playing "+myTime(this._parent["mySuperPlayer"].ns.time)+" sec.";
				if (this._parent["mySuperPlayer"].info) {
				this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"].ns.bytesLoaded/1024)+" / "+int(this._parent["mySuperPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}*/
				piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"].ns.bytesLoaded/this._parent["mySuperPlayer"].ns.bytesTotal);
			} else if (this._parent["mySuperPlayer"].ns.bytesLoaded == this._parent["mySuperPlayer"].ns.bytesTotal && this._parent["mySuperPlayer"].myloaded == false) {
				this._parent["mySuperPlayer"].myloaded = true;
				piede.indice.barr._width = barr_width;
			} else {
				this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"].ns.time);
				/*this.lab_i.htmlText = this.tit+": Playing "+int(this._parent["mySuperPlayer"].ns.time)+" sec.";
				if (this._parent["mySuperPlayer"].info) {
				this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}*/
			}
			piede.indice.curs._x = 0;
			piede.indice.curs.enabled = false;
		}
	}
	function indice_swf() {
		piede.indice.curs._x = (barr_width)*(this._parent["mySuperPlayer"]["monitor"].mon.trgt._currentframe/this._parent["mySuperPlayer"]["monitor"].mon.trgt._totalframes);
	}
	function indice_mp3() {
		if (this._parent["mySuperPlayer"].mp3player.getBytesLoaded()<this._parent["mySuperPlayer"].mp3player.getBytesTotal()) {
			//this.lab_i.htmlText = this.tit+": Playing "+int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.position/1000)-(int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)*60))+" / "+int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.duration/1000)-(int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)*60))+" min. (Size: "+int(this._parent["mySuperPlayer"].mp3player.getBytesLoaded()/1024)+" / "+int(this._parent["mySuperPlayer"].mp3player.getBytesTotal()/1024)+" Kb )";
			this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"].mp3player.position)+" | "+this._parent["mySuperPlayer"].mp3player.duration;
			piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"].mp3player.bytesLoaded/this._parent["mySuperPlayer"].mp3player.bytesTotal);
		} else if (this._parent["mySuperPlayer"].mp3player.getBytesLoaded() == this._parent["mySuperPlayer"].mp3player.getBytesTotal() && this._parent["mySuperPlayer"].myloaded == false) {
			this._parent["mySuperPlayer"].myloaded = true;
			piede.indice.barr._width = barr_width;
		} else {
			//this.lab_i.htmlText = this.tit+": Playing "+int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.position/1000)-(int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)*60))+" / "+int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.duration/1000)-(int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)*60))+" min. (Size: "+int(this._parent["mySuperPlayer"].mp3player.getBytesTotal()/1024)+" Kb )";
			this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"].mp3player.position)+" | "+this._parent["mySuperPlayer"].mp3player.duration;
		}
		piede.indice.curs._x = (barr_width)*(this._parent["mySuperPlayer"].mp3player.position/this._parent["mySuperPlayer"].mp3player.duration);
	}
	function avvia_scratch() {
		delete this.onEnterFrame;
		this._parent["mySuperPlayer"].ns.pause(true);
		if (tipo == "mp3") {
			this._parent["mySuperPlayer"].mp3player.stop();
		} else {
			this.onEnterFrame = function() {
				this["scratch_"+tipo]();
			};
		}
		this._parent["mySuperPlayer"].mp3player.stop();
	}
	function scratch_swf() {
		if (this._parent["mySuperPlayer"].play_status) {
			var tmp = "gotoAndPlay";
		} else {
			var tmp = "gotoAndStop";
		}
		this._parent["mySuperPlayer"]["monitor"].mon.trgt[tmp](int((piede.indice.curs._x/(barr_width))*this._parent["mySuperPlayer"]["monitor"].mon.trgt._totalframes));
	}
	function scratch_flv() {
		this._parent["mySuperPlayer"].ns.seek(((piede.indice.curs._x/(barr_width))*this._parent["mySuperPlayer"].myDuration));
	}
	function resetta() {
		delete this.onEnterFrame;
		piede.contr.playpause.gotoAndStop(1);
		piede.indice.curs._x = 0;
		bottoni(true);
	}
	function bottoni(val) {
		piede.indice.curs.enabled = val;
		piede.contr.playpause.puls.enabled = val;
		piede.contr.fw.puls.enabled = val;
		piede.contr.rw.puls.enabled = val;
	}
}
