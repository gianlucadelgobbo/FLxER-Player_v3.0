class main.mmToolbar extends MovieClip {
	var mmSelTit;
	var col;
	var tipo;
	var barr_width;
	var tit;
	var w;
	var h;
	var myKeyL;
	var owner;
	var lab_i, fw, rw, contr, volume_ctrl, stampa, scarica, indice, selector, testa, piedeInt, piedeEst, piede;
	var single;
	var noImg;
	function mmToolbar() {
		if (single) {
			piede.contr.selector._visible = piede.ss._visible=piede.toppa._visible=false;
			this.attachMovie("playpause", "ppBig", this.getNextHighestDepth(), {_x:(w-66)/2, _y:(h-66)/2, _xscale:600, _yscale:600});
			this["ppBig"].fnz = "myPlaypause";
			this["ppBig"].fnzTrgt = this;
			this["ppBig"]._visible = false;
		}
		_root.myDrawerFunc.textDrawer(this.piede, "myMenu", "bella", w-124, -120-17, 120, 120);
		piede["myMenu"]._visible = false;
		setPos(w, h);
		piede.ss.fnz = "avviaSS";
		piede.contr.selector.fnz = "avviaSelector";
		piede.m.fnz = "apriMenu";
		piede.contr.fw.fnz = "avanti";
		piede.contr.rw.fnz = "indietro";
		piede.contr.playpause.fnz = "myPlaypause";
		piede.contr.playpause.fnzTrgt = piede.contr.fw.fnzTrgt=piede.contr.rw.fnzTrgt=piede.m.fnzTrgt=this.piede.contr.selector.fnzTrgt=this.piede.ss.fnzTrgt=this;
		//
		piede.toppa.onPress = function() {
		};
		piede.toppa.useHandCursor = false;
		piede.indice.curs.onPress = function() {
			this._parent._parent._parent.avvia_scratch();
			startDrag(this, false, 0, this._y, this._parent._parent._parent.barr_width, this._y);
		};
		piede.indice.curs.onRelease = function() {
			if (this._parent._parent.contr.playpause._currentframe == 2) {
				this._parent._parent._parent._parent["mySuperPlayer"].ns.pause(false);
			}
			this._parent._parent._parent.avvia_indice();
			stopDrag();
		};
		piede.indice.curs.onReleaseOutside = function() {
			if (this._parent._parent._parent.contr.playpause._currentframe == 2 && this._parent._parent._parent.tipo == "flv") {
				this._parent._parent._parent._parent["mySuperPlayer"].ns.pause(false);
			}
			this._parent._parent._parent.avvia_indice();
			stopDrag();
		};
		piede.indice.curs.onRollOver = function() {
			this._parent._parent._visible = true;
		};
		piede.flxer.onPress = function() {
			getURL("http://www.flxer.net");
			onRollOut();
		};
		piede.flxer.onRollOver = function() {
			trace(this["puls"]);
			var col = new Color(this.lab_i);
			col.setRGB(_root.myDrawerFunc.playerColors["colorBkgOver"]);
			_root.alt.avvia("FLxER player<br>is developed by FLxER.net<br>a Flyer communication project<br>www.flxer.net - www.flyer.it");
		};
		piede.flxer.onRollOut = function() {
			var col = new Color(this.lab_i);
			col.setRGB(_root.myDrawerFunc.playerColors["colorBkg"]);
			_root.alt.stoppa();
		};
		//
		piede.contr.volume_ctrl.slider.onPress = function() {
			startDrag(this, false, this._parent.path._x, this._parent.path._y+this._parent.path._height, this._parent.path._x, this._parent.path._y);
			this._parent._parent._parent._parent._parent["mySuperPlayer"].volume_onPress();
		};
		piede.contr.volume_ctrl.slider.onRelease = function() {
			this._parent.prevFrame();
			stopDrag();
			this._parent._parent._parent._parent._parent["mySuperPlayer"].volume_onRelease();
		};
		piede.contr.volume_ctrl.slider.onReleaseOutside = function() {
			this._parent.prevFrame();
			stopDrag();
			this._parent._parent._parent._parent._parent["mySuperPlayer"].volume_onRelease();
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
	function setPos(w, h) {
		testa._width = piedeEst._width=w;
		lab_i._width = w-10;
		piede._y = h-piede.piedeEst._height;
		piede.piedeEst._width = w;
		piede.piedeInt._width = piede.toppa._width=w-2;
		var deltaW = 0;
		if (single) {
			deltaW = 44;
		}
		piede.contr._x = w-151+deltaW;
		piede.indice.barr._width = w-237+deltaW;
		piede.indice.barrEst._width = w-237+2+deltaW;
		barr_width = piede.indice.barr._width;
		piede.ss._x = w-95;
		piede.m._x = w-37;
		piede["myMenu"]._x = w-piede["myMenu"]._width-4;
	}
	function itemHandler(obj, item) {
		piede["myMenu"]._visible = false;
		_root.myFlxerGallery["mySelector"].resizza_onoff = _root.myFlxerGallery["mySuperPlayer"].resizza_onoff=true;
		_root.myFlxerGallery["mySuperPlayer"].resizza();
	}
	function itemHandler2(obj, item) {
		piede["myMenu"]._visible = false;
		_root.myFlxerGallery["mySelector"].resizza_onoff = _root.myFlxerGallery["mySuperPlayer"].resizza_onoff=false;
		_root.myFlxerGallery["mySuperPlayer"].resizza();
	}
	function itemHandler3(obj, item) {
		_root.myFlxerGallery["myToolbar"].fs(obj, item);
	}
	function fs(obj, item) {
		piede["myMenu"]._visible = false;
		if (piede.contr.playpause._currentframe == 2) {
			piede.contr.playpause.puls.onPress();
		}
		if (single) {
			var tmp = _root.cnt.split(",");
			if (tmp[0].indexOf("http://") != -1) {
				getURL(_root.mySitePath+_root.myFsPath+tmp[0]+"&tit="+tmp[1], "_blank");
			}
			getURL("javascript:popupwindow('FULL','FULL','"+_root.myFsPath+tmp[0]+"&tit="+tmp[1]+"','FLXERPLAYER','no','yes');");
		} else {
			var tmp = _root.cnt;
			getURL("javascript:popupwindow('FULL','FULL','"+tmp.substring(0, tmp.lastIndexOf("/")+1)+"fullscreen.php"+tmp.substring(tmp.lastIndexOf("/")+1, tmp.length)+"','FLXERPLAYER','no','yes');");
		}
	}
	function itemHandler4(obj, item) {
		piede["myMenu"]._visible = false;
		if (_root.myFlxerGallery["myToolbar"].piede.contr.playpause._currentframe == 2) {
			_root.myFlxerGallery["myToolbar"].piede.contr.playpause.puls.onPress();
		}
		var pageCount:Number = 0;
		var my_pj:PrintJob = new PrintJob();
		if (my_pj.start()) {
			if (my_pj.addPage(0, {xMin:0, xMax:595, yMin:0, yMax:841})) {
				pageCount++;
			}
		}
		if (pageCount>0) {
			my_pj.send();
		}
		delete my_pj;
	}
	function itemHandler5(obj, item) {
		piede["myMenu"]._visible = false;
		_root.myFlxerGallery["myToolbar"].dw(obj, item);
	}
	function dw(obj, item) {
		getURL(_root.downPath+_root.myFlxerGallery["mySuperPlayer"].currMov);
	}
	function apriEmbed() {
		var trgt = _root.myFlxerGallery["myToolbar"];
		piede["myMenu"]._visible = false;
		trgt.attachMovie("myEmbed", "myEmbed", trgt.getNextHighestDepth(), {_x:int(trgt.w/2), _y:int(trgt.h/2)});
		var tmp = _root.cnt;
		if (tmp.indexOf("http://") == -1) {
			tmp = _root.mySitePath+"/_swf/flxerPlayer3.swf?cnt=http://www.flxer.net"+tmp
		} else {
			tmp = _root.mySitePath+"/_swf/flxerPlayer3.swf?cnt="+tmp
		}
		trgt["myEmbed"].lab_i.text = "<object type=\"application/x-shockwave-flash\" data=\""+tmp+"\" width=\"400\" height=\"338\">\n	<param name=\"movie\" value=\""+tmp+"\" />\n</object>";
		trgt["myEmbed"].c.fnz = "chiudiEmbed";
		trgt["myEmbed"].c.fnzTrgt = trgt;
	}
	function avviaSS() {
		_root.myFlxerGallery["myToolbar"].piede["myMenu"]._visible = false;
		_root.myFlxerGallery["mySelector"].mySlidesShow();
		_root.myFlxerGallery["myToolbar"].piede.toppa._visible = _root.myFlxerGallery["myToolbar"].piede.ss._visible=false;
	}
	function avviaSelector() {
		var trgt = _root.myFlxerGallery["myToolbar"];
		trgt.piede["myMenu"]._visible = false;
		trgt.piede.toppa._visible = true;
		if (!trgt.noImg) {
			trgt.piede.ss._visible = true;
		}
		trgt._parent["mySuperPlayer"].resetta();
		trgt._parent["mySuperPlayer"]._visible = false;
		trgt._parent["mySelector"]._visible = true;
		trgt.lab_i.htmlText = trgt.mmSelTit;
		trgt.resetta();
	}
	function chiudiEmbed() {
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
		this._parent["mySuperPlayer"]["stop_play_"+tipo]();
	}
	function apriMenu() {
		var menuTxt = "";
		if (!piede["myMenu"]._visible) {
			if (piede.toppa._visible) {
				if (!single) {
					if (noImg) {
						menuTxt += "<a href=\"asfunction:"+this+".avviaSS\">Slideshow</a><br/>";
					} else {
						menuTxt += "<div>Slideshow (no images)</div>";
					}
				}
				menuTxt += "<div>Scale: Fit player size</div>";
				menuTxt += "<div>Scale: 100%</div>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler3\">Fullscreen</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler4\">Print this content</a><br/>";
				menuTxt += "<div>Download</div>";
				menuTxt += "<a href=\"asfunction:"+this+".apriEmbed\">Embed</a>";
			} else {
				if (!single) {
					menuTxt += "<a href=\"asfunction:"+this+".avviaSelector\">Playlist</a><br/>";
				}
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler\">Scale: Fit player size</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler2\">Scale: 100%</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler3\">Fullscreen</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler4\">Print this content</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler5\">Download</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".apriEmbed\">Embed</a>";
			}
			piede["myMenu"].htmlText = "<p>"+menuTxt+"</p>";
			piede["myMenu"]._height = piede["myMenu"].textHeight+5;
			piede["myMenu"]._y = -piede["myMenu"]._height+3;
		}
		piede["myMenu"]._visible = !piede["myMenu"]._visible;
	}
	function avvia_indice() {
		delete this.onEnterFrame;
		if (tipo == "mp3") {
			this._parent["mySuperPlayer"].mp3player.start(int(((piede.indice.curs._x/(barr_width))*this._parent["mySuperPlayer"].mp3player.duration)/1000));
		}
		this.onEnterFrame = function() {
			this["indice_"+tipo]();
		};
	}
	function indice_flv() {
		if (this._parent["mySuperPlayer"].myDuration != undefined) {
			if (this._parent["mySuperPlayer"].ns.bytesLoaded<this._parent["mySuperPlayer"].ns.bytesTotal) {
				this.lab_i.htmlText = this.tit+": Playing "+this._parent["mySuperPlayer"].ns.time+" / "+this._parent["mySuperPlayer"].myDuration+" sec.";
				if (this._parent["mySuperPlayer"].info) {
					this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"].ns.bytesLoaded/1024)+" / "+int(this._parent["mySuperPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}
				piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"].ns.bytesLoaded/this._parent["mySuperPlayer"].ns.bytesTotal);
			} else if (this._parent["mySuperPlayer"].ns.bytesLoaded == this._parent["mySuperPlayer"].ns.bytesTotal && this._parent["mySuperPlayer"].myloaded == false) {
				this._parent["mySuperPlayer"].myloaded = true;
				piede.indice.barr._width = barr_width;
			} else {
				this.lab_i.htmlText = this.tit+": Playing "+this._parent["mySuperPlayer"].ns.time+" / "+this._parent["mySuperPlayer"].myDuration+" sec.";
				if (this._parent["mySuperPlayer"].info) {
					this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}
			}
			piede.indice.curs._x = (barr_width)*(this._parent["mySuperPlayer"].ns.time/this._parent["mySuperPlayer"].myDuration);
			piede.indice.path._width = piede.indice.curs._x;
		} else {
			if (this._parent["mySuperPlayer"].ns.bytesLoaded<this._parent["mySuperPlayer"].ns.bytesTotal) {
				this.lab_i.htmlText = this.tit+": Playing "+this._parent["mySuperPlayer"].ns.time+" sec.";
				if (this._parent["mySuperPlayer"].info) {
					this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"].ns.bytesLoaded/1024)+" / "+int(this._parent["mySuperPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}
				piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"].ns.bytesLoaded/this._parent["mySuperPlayer"].ns.bytesTotal);
			} else if (this._parent["mySuperPlayer"].ns.bytesLoaded == this._parent["mySuperPlayer"].ns.bytesTotal && this._parent["mySuperPlayer"].myloaded == false) {
				this._parent["mySuperPlayer"].myloaded = true;
				piede.indice.barr._width = barr_width;
			} else {
				this.lab_i.htmlText = this.tit+": Playing "+this._parent["mySuperPlayer"].ns.time+" sec.";
				if (this._parent["mySuperPlayer"].info) {
					this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}
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
			this.lab_i.htmlText = this.tit+": Playing "+int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.position/1000)-(int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)*60))+" / "+int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.duration/1000)-(int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)*60))+" min. (Size: "+int(this._parent["mySuperPlayer"].mp3player.getBytesLoaded()/1024)+" / "+int(this._parent["mySuperPlayer"].mp3player.getBytesTotal()/1024)+" Kb )";
			piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"].mp3player.bytesLoaded/this._parent["mySuperPlayer"].mp3player.bytesTotal);
		} else if (this._parent["mySuperPlayer"].mp3player.getBytesLoaded() == this._parent["mySuperPlayer"].mp3player.getBytesTotal() && this._parent["mySuperPlayer"].myloaded == false) {
			this._parent["mySuperPlayer"].myloaded = true;
			piede.indice.barr._width = barr_width;
		} else {
			this.lab_i.htmlText = this.tit+": Playing "+int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.position/1000)-(int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)*60))+" / "+int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.duration/1000)-(int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)*60))+" min. (Size: "+int(this._parent["mySuperPlayer"].mp3player.getBytesTotal()/1024)+" Kb )";
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
