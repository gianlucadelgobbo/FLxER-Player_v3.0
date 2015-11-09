class flxerGallery.mmToolbar extends MovieClip {
	var w;
	var h;
	//
	var piede;
	var testa;
	var lab_i;
	//
	var mmSelTit
	var barr_width
	var tipo
	var single
	var myKeyL;
	var noImg;
	function mmToolbar() {
		setPos(w,h);
		//this._visible = false;
		piede.createEmptyMovieClip("myMenu",piede.getNextHighestDepth());
		piede["myMenu"]._visible = false;
		piede["myMenu"]._x = w-144;
		piede["myMenu"]._y = -120-17;
		_root.myDrawerFunc.drawer(piede["myMenu"],"fondo",-piede["myMenu"]._x,-piede["myMenu"]._y-piede._y,w,h,0xFF00FF,null,0);
		piede["myMenu"]["fondo"].onPress = function() {
			this._parent._parent._parent.apriMenu();
		};
		piede["myMenu"]["fondo"].useHandCursor = false;
		_root.myDrawerFunc.textDrawerSP(piede["myMenu"],"myMenu","bella",0,0,140,120,false);
		piede["myMenu"]["myMenu"].background = true;
		piede["myMenu"]["myMenu"].border = true;
		piede["myMenu"]["myMenu"].backgroundColor = _root.myFlxerPlayerStyles.testo["colorBkg"];
		piede["myMenu"]["myMenu"].borderColor = _root.myFlxerPlayerStyles.testo["colorBorder"];
		piede.contr.selector._visible = piede.ss._visible=piede.m._visible=false;
		piede.toppa._visible = true;
		avviaPuls();
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
		myKeyL["owner"] = this;
		myKeyL.onKeyDown = function() {
			if (Key.getCode() == Key.LEFT) {
				if (this["owner"].piede.contr.rw.puls.enabled) {
					this["owner"].piede.contr.rw.puls.onPress();
				}
			}
			if (Key.getCode() == Key.RIGHT) {
				if (this["owner"].piede.contr.fw.puls.enabled) {
					this["owner"].piede.contr.fw.puls.onPress();
				}
			}
			if (Key.getCode() == Key.SPACE) {
				if (this["owner"].piede.contr.playpause.puls.enabled) {
					this["owner"].piede.contr.playpause.puls.onPress();
				}
			}
		};
		Key.addListener(myKeyL);
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
	function avvia(stat, t, ss) {
		this._visible = true;
		piede.m._visible = true;
		piede.contr.selector._visible = !single;
		noImg = ss;
		tipo = t;
		if (stat == "player") {
			piede.ss._visible = false;
			piede.toppa._visible = false;
			/*if (piede.contr.playpause._currentframe == 2) {
			piede.contr.playpause.puls.onPress();
			}*/
			if (tipo == "jpg") {
				piede.contr.volume_ctrl._visible = false;
			} else {
				piede.contr.volume_ctrl._visible = true;
			}
		} else {
			piede.ss._visible = !ss;
			piede.toppa._visible = true;
			this._parent["mySuperPlayer"].resetta();
			this._parent["mySuperPlayer"]._visible = false;
			this._parent["mySelector"]._visible = true;
			this.lab_i.htmlText = mmSelTit;
			this.resetta();
		}
		//getURL("javascript:alert('"+w+","+h+"');");
		//trace("AAAAAAAAVVVVVVVVVVVVVVIIIIIIIIIIIAAAAAAAAAAAAAA")
		setPos(w,h);
	}
	function visualizzappBig() {
		this.attachMovie("playpause","ppBig",this.getNextHighestDepth(),{_x:(w-66)/2, _y:(h-66)/2, _xscale:600, _yscale:600});
		this["ppBig"].fnz = "myPlaypause";
		this["ppBig"].fnzTrgt = this;
	}
	function setPos(ww, hh) {
		w = ww;
		h = hh;
		trace("setPos "+w+" "+h+" "+piede.piedeEst._height);
		if (testa) {
			testa._width = w;
		}
		piede.piedeEst._width=w;
		lab_i._width = w-10;
		piede._y = h-piede.piedeEst._height;
		piede.piedeEst._width = w;
		piede.piedeInt._width = piede.toppa._width=w-2;
		var deltaW = 0;
		if (single) {
			deltaW = 48;
		}
		if (!piede.contr.volume_ctrl._visible) {
			piede.contr.selector._x = 52;
			var bbb = 1.8;
			//deltaW += 20;
		} else {
			piede.contr.selector._x = 68;
			var bbb = 1;
		}
		piede.m._x = w-(piede.m.lab.textWidth+10);
		piede.contr._x = int(w-(piede.contr.selector._x+piede.contr.selector.lab.textWidth+5)-(w-piede.m._x)+deltaW-20);
		piede.indice.barr._width = int(piede.contr._x-piede.indice._x-(piede.indice.counter._width/bbb));
		piede.indice.counter._x = piede.indice.barr._width+3;
		piede.indice.barrEst._width = piede.indice.barr._width+2;
		barr_width = piede.indice.barr._width;
		piede.ss._x = w-95;
		piede["myMenu"]._x = w-piede["myMenu"]["myMenu"]._width-4;
		piede["myMenu"]["fondo"]._x = -piede["myMenu"]._x;
	}
	//
	function itemHandler(obj, item) {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["mySelector"].resizza_onoff = _root.galleryPath["mySuperPlayer"].resizza_onoff=true;
		_root.galleryPath["mySuperPlayer"].resizza();
	}
	function itemHandler2(obj, item) {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["mySelector"].resizza_onoff = _root.galleryPath["mySuperPlayer"].resizza_onoff=false;
		_root.galleryPath["mySuperPlayer"].resizza();
	}
	function itemHandler3(obj, item) {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		//fscommand("fullscreen", true);
		_root.galleryPath["myToolbar"].fs(obj,item);
	}
	function itemHandler4(obj, item) {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		if (_root.galleryPath["myToolbar"].piede.contr.playpause._currentframe == 2) {
			_root.galleryPath["myToolbar"].piede.contr.playpause.puls.onPress();
		}
		_root.galleryPath["mySuperPlayer"].cacheAsBitmap = true;
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
		this._parent["mySuperPlayer"].cacheAsBitmap = false;
	}
	function itemHandler5(obj, item) {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["myToolbar"].dw(obj,item);
	}
	function apriEmbed() {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["myToolbar"].attachMovie("myEmbed","myEmbed",_root.galleryPath["myToolbar"].getNextHighestDepth(),{_x:int(_root.galleryPath["myToolbar"].w/2), _y:int(_root.galleryPath["myToolbar"].h/2)});
		var tmp = this._parent.embePath+_root.galleryPath.startUrl;
		_root.galleryPath["myToolbar"]["myEmbed"].lab_i.text = "<object type=\"application/x-shockwave-flash\" data=\""+tmp+"\" width=\""+(_root.galleryPath["myToolbar"].w)+"\" height=\""+(_root.galleryPath["myToolbar"].h)+"\">\n	<param name=\"movie\" value=\""+tmp+"\" />\n</object>";
		_root.galleryPath["myToolbar"]["myEmbed"].c.fnz = "chiudiEmbed";
		_root.galleryPath["myToolbar"]["myEmbed"].c.fnzTrgt = _root.galleryPath["myToolbar"];
	}
	function dw(obj, item) {
		//var tmp = this._parent["mySuperPlayer"].currMov.split(",");
		getURL(this._parent.downPath+_root.myStarter.myReplace(this._parent["mySuperPlayer"].currMov, this._parent.myPath, ""));
		trace("download "+_root.myStarter.myReplace(this._parent["mySuperPlayer"].currMov, this._parent.myPath, ""));
	}
	function fs(obj, item) {
		if (piede.contr.playpause._currentframe == 2) {
			piede.contr.playpause.puls.onPress();
		}
		if (single) {
			var tmp = this._parent.startUrl.split(",");
			if (tmp[0].indexOf("http://") != -1) {
				trace(this._parent.myFsPath+tmp[0]+"&tit="+tmp[1]+"&out=true");
				getURL(this._parent.myFsPath+tmp[0]+"&tit="+tmp[1]+"&out=true", "_blank");
			} else {
				trace("javascript:popupwindow('FULL','FULL','"+this._parent.myFsPath+tmp[0]+"&tit="+tmp[1]+"','FLXERPLAYER','no','yes');");
				getURL("javascript:popupwindow('FULL','FULL','"+this._parent.myFsPath+tmp[0]+"&tit="+tmp[1]+"','FLXERPLAYER','no','yes');");
			}
		} else {
			var tmp = this._parent.startUrl;
			if (tmp.indexOf("http://") != -1) {
				trace(this._parent.myFsPath+tmp+"&out=true");
				getURL(this._parent.myFsPath+tmp+"&out=true", "_blank");
			} else {
				trace("javascript:popupwindow('FULL','FULL','"+this._parent.myFsPath+tmp+"','FLXERPLAYER','no','yes');");
				getURL("javascript:popupwindow('FULL','FULL','"+this._parent.myFsPath+tmp+"','FLXERPLAYER','no','yes');");
			}
		}
	}
	function avviaSS() {
		_root.galleryPath["myToolbar"].piede["myMenu"]._visible = false;
		_root.galleryPath["mySelector"].mySlidesShow();
		_root.galleryPath["myToolbar"].piede.toppa._visible = _root.galleryPath["myToolbar"].piede.ss._visible=false;
	}
	function avviaSelector() {
		_root.galleryPath["myToolbar"].avvia("selector",single,this._parent.noImg);
	}
	function chiudiEmbed() {
		_root.alt.stoppa();
		this["myEmbed"].removeMovieClip();
	}
	//
	function scratch(t) {
		avvia_scratch();
		this._parent["mySuperPlayer"].myLoop = false;
		t.startDrag(false,0,t._y,piede.indice.barr._width,t._y);
	}
	function stopScratch(t) {
		if (piede.contr.playpause._currentframe == 2 && this._parent["mySuperPlayer"].tipo == "flv") {
			this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.pause(false);
		}
		this._parent["mySuperPlayer"].myLoop = this._parent.myLoop;
		avvia_indice();
		t.stopDrag();
	}

	function avanti() {
		this._parent["mySuperPlayer"]["avanti_"+tipo]();
	}
	function indietro() {
		this._parent["mySuperPlayer"]["indietro_"+tipo]();
	}
	function myPlaypause() {
		if (this["ppBig"]) {
			if (this._parent.myViPath) {
				new main.xmlLoader(this._parent.myViPath+_root.myStarter.myReplace(this._parent["mySuperPlayer"].currMov, this._parent.myPath, ""), this, "vi", this, "", true);
				trace(this._parent.myViPath+_root.myStarter.myReplace(this._parent["mySuperPlayer"].currMov, this._parent.myPath, "")+"OOOOOOOOOOO")
			}
			this["ppBig"].removeMovieClip();
		}
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
				if (this._parent._parent.pref.downPath) {
					menuTxt += "Download<br/>";
				}
				menuTxt += "<a href=\"asfunction:"+this+".apriEmbed\">Embed</a>";
			} else {
				if (!single) {
					menuTxt += "<a href=\"asfunction:"+this+".avviaSelector\">Playlist</a><br/>";
				}
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler\">Scale: Fit player size</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler2\">Scale: 100%</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler3\">Fullscreen</a><br/>";
				menuTxt += "<a href=\"asfunction:"+this+".itemHandler4\">Print this content</a><br/>";
				if (this._parent._parent.pref.downPath) {
					menuTxt += "<a href=\"asfunction:"+this+".itemHandler5\">Download</a><br/>";
				}
				menuTxt += "<a href=\"asfunction:"+this+".apriEmbed\">Embed</a>";
			}
			piede["myMenu"]["myMenu"].htmlText = "<p class=\"playerMenu\">"+menuTxt+"</p>";
			piede["myMenu"]["myMenu"]._height = piede["myMenu"]["myMenu"].textHeight+5;
			piede["myMenu"]._y = -piede["myMenu"]["myMenu"]._height+3;
			piede["myMenu"]["fondo"]._y = -piede["myMenu"]._y-piede._y;
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
	function myTime(mm) {
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
			if (this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesLoaded<this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal) {
				//this.lab_i.htmlText = this.tit+": Playing "+myTime(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time)+" / "+myTime(this._parent["mySuperPlayer"].myDuration);
				this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time)+"|"+myTime(this._parent["mySuperPlayer"].myDuration);
				/*if (this._parent["mySuperPlayer"].info) {
				this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesLoaded/1024)+" / "+int(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}*/
				piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesLoaded/this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal);
			} else if (this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesLoaded == this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal && this._parent["mySuperPlayer"].myloaded == false) {
				this._parent["mySuperPlayer"].myloaded = true;
				piede.indice.barr._width = barr_width;
			} else {
				//this.lab_i.htmlText = this.tit+": Playing "+myTime(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time)+" / "+myTime(this._parent["mySuperPlayer"].myDuration);
				this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time)+"|"+myTime(this._parent["mySuperPlayer"].myDuration);
				/*if (this._parent["mySuperPlayer"].info) {
				this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}*/
			}
			piede.indice.curs._x = (barr_width)*(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time/this._parent["mySuperPlayer"].myDuration);
			piede.indice.path._width = piede.indice.curs._x;
			piede.indice.curs.enabled = true;
		} else {
			if (this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesLoaded<this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal) {
				this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time);
				/*this.lab_i.htmlText = this.tit+": Playing "+myTime(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time)+" sec.";
				if (this._parent["mySuperPlayer"].info) {
				this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesLoaded/1024)+" / "+int(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}*/
				piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesLoaded/this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal);
			} else if (this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesLoaded == this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal && this._parent["mySuperPlayer"].myloaded == false) {
				this._parent["mySuperPlayer"].myloaded = true;
				piede.indice.barr._width = barr_width;
			} else {
				this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time);
				/*this.lab_i.htmlText = this.tit+": Playing "+int(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.time)+" sec.";
				if (this._parent["mySuperPlayer"].info) {
				this.lab_i.htmlText += " (Size: "+int(this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.bytesTotal/1024)+" Kb W:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.width+" Kb H:"+this._parent["mySuperPlayer"]["monitor"].video.vid_flv.height+" )";
				}*/
			}
			piede.indice.curs._x = 0;
			piede.indice.curs.enabled = false;
		}
	}
	function indice_swf() {
		piede.indice.curs._x = (barr_width)*(this._parent["mySuperPlayer"]["monitor"].mon.trgt._currentframe/this._parent["mySuperPlayer"]["monitor"].mon.trgt._totalframes);
		this.piede.indice.counter.htmlText = myTime((this._parent["mySuperPlayer"]["monitor"].mon.trgt._currentframe/25)*60)+"|"+myTime((this._parent["mySuperPlayer"]["monitor"].mon.trgt._totalframes/25)*60);
		if (!this._parent.single && this._parent["mySuperPlayer"]["monitor"].mon.trgt._currentframe == 1 && this._parent["mySuperPlayer"]["monitor"].mon.trgt._totalframes>1) {
			piede.contr.selector.puls.onPress();
		}
	}
	function indice_mp3() {
		if (this._parent["mySuperPlayer"].mp3player.getBytesLoaded()<this._parent["mySuperPlayer"].mp3player.getBytesTotal()) {
			trace("aaa "+this._parent["mySuperPlayer"].mp3player.getBytesLoaded())
			//this.lab_i.htmlText = this.tit+": Playing "+int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.position/1000)-(int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)*60))+" / "+int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.duration/1000)-(int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)*60))+" min. (Size: "+int(this._parent["mySuperPlayer"].mp3player.getBytesLoaded()/1024)+" / "+int(this._parent["mySuperPlayer"].mp3player.getBytesTotal()/1024)+" Kb )";
			this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"].mp3player.position)+"|"+myTime(this._parent["mySuperPlayer"].mp3player.duration);
			piede.indice.barr._width = barr_width*(this._parent["mySuperPlayer"].mp3player.getBytesLoaded()/this._parent["mySuperPlayer"].mp3player.getBytesTotal());
		} else if (this._parent["mySuperPlayer"].mp3player.getBytesLoaded() == this._parent["mySuperPlayer"].mp3player.getBytesTotal() && this._parent["mySuperPlayer"].myloaded == false) {
			this._parent["mySuperPlayer"].myloaded = true;
			piede.indice.barr._width = barr_width;
		} else {
			//this.lab_i.htmlText = this.tit+": Playing "+int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.position/1000)-(int((this._parent["mySuperPlayer"].mp3player.position/1000)/60)*60))+" / "+int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)+"."+(int(this._parent["mySuperPlayer"].mp3player.duration/1000)-(int((this._parent["mySuperPlayer"].mp3player.duration/1000)/60)*60))+" min. (Size: "+int(this._parent["mySuperPlayer"].mp3player.getBytesTotal()/1024)+" Kb )";
			this.piede.indice.counter.htmlText = myTime(this._parent["mySuperPlayer"].mp3player.position/1000)+"|"+myTime(this._parent["mySuperPlayer"].mp3player.duration/1000);
		}
		piede.indice.curs._x = (barr_width)*(this._parent["mySuperPlayer"].mp3player.position/this._parent["mySuperPlayer"].mp3player.duration);
	}
	function avvia_scratch() {
		delete this.onEnterFrame;
		this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.pause(true);
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
		this._parent["mySuperPlayer"]["monitor"]["myFlvPlayer"].ns.seek(((piede.indice.curs._x/(barr_width))*this._parent["mySuperPlayer"].myDuration));
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