class starterGallery extends MovieClip {
	var pref:Object;
	function starterGallery() {
		System.useCodepage = true;
		System.security.allowDomain("*");
		Stage.scaleMode = "noScale";
		Stage.align = "TL";
		_root.myDrawerFunc = new main.drawerFunc();
		_root.myClassedMC = function(classe, trgt, myName, obj) {
			Object.registerClass("empty", classe);
			trgt.attachMovie("empty", myName, trgt.getNextHighestDepth(), obj);
		};
		pref = {x:0, y:0, w:Stage.width, h:Stage.height, tw:128, th:96, col:_root.myDrawerFunc.playerColors["colorBkg"], toolbar:true, single:true, autostop:false, resizza_onoff:true, centra_onoff:true, ss_time:3000, info:false, att:"href"};
		_root.myPath = "";
		//_root.mySitePath = "http://www.flxer.net";
		_root.mySitePath = "http://www.nonrassegnatastampa.it";
		_root.myUserPath = "/abusers/";
		_root.myFsPath = "/flxerplayer/fullscreen.php?mm=";
		_root.downPath = _root.mySitePath+"/flxerplayer/mediaDownload.php?file=";
		//// LOCAL TEST ///////////////
		if (_root.avvia_con) {
			_root.cnt = _root.avvia_con;
		}
		if (!_root.cnt) {
			//FLxER
			_root.myPath = "http://www.flxer.net";
			_root.cnt = "/warehouse/_flxer/library/no_hole/occhio_02.swf,OCCHIO,0,6689,5480";
			_root.cnt = "/warehouse/_flxer/liveset/volvo1231.flv,GUARDA+IL+VIDEO,1,4151,1965";
			_root.cnt = "/flxerplayer/?id=73";
			_root.cnt = "/warehouse/_videos/sonar2006.flv,SONAR 2006 - The Video";
		}
		if (_root.cnt) {
			avviaJs();
		}
	}
	function avvia() {
		trace("avvia");
		pref.lista = _root["home"].childNodes[0];
		pref.single = false;
		pref.autostop = false;
		_root.myClassedMC(main.flxerGallery, _root, "myFlxerGallery", pref);
	}
	function avviaJs() {
		//getURL("javascript:alert('"+_root.cnt+"');")
		if (_root["myFlxerGallery"]["myToolbar"]["ppBig"]) {
			_root["myFlxerGallery"]["myToolbar"]["ppBig"].removeMovieClip();
		}
		var tmp = _root.cnt.split(",");
		var tmp2 = tmp[0].substring(tmp[0].length-3, tmp[0].length).toLowerCase();
		if (tmp2 == "flv" || tmp2 == "mp3" || tmp2 == "swf" || tmp2 == "jpg" || tmp2 == "png" || tmp2 == "gif") {
			var tmpXml = new XML("<ul><li><a>"+tmp[1]+"</a><div>"+tmp[1]+"</div></li></ul>");
			tmpXml.childNodes[0].childNodes[0].childNodes[0].attributes.href = "/mediaViewer.php?mm="+tmp[0];
			if (!_root["myFlxerGallery"]["mySuperPlayer"]) {
				_root.myClassedMC(main.flxerGallery, _root, "myFlxerGallery", pref);
			}
			_root["myFlxerGallery"]["mySuperPlayer"].avvia(tmpXml.childNodes[0], 0);
			if (tmp[3]) {
				_root["myFlxerGallery"]["mySuperPlayer"]["monitor"].link = _root.mySitePath+_root.myUserPath+"?userId="+tmp[3]+"&postId="+tmp[4]+"&pageItem=1";
				_root["myFlxerGallery"]["mySuperPlayer"]["monitor"].onPress = function() {
					getURL(this.link, "_blank");
				};
			}
		} else {
			var tmp = _root.cnt;
			if (tmp.indexOf("http://") != -1) {
				_root.myPath = _root.mySitePath;
			}
			var tmp = myReplace(_root.cnt, ",", "&");
			if (tmp.indexOf("http://") == -1) {
				tmp = _root.myPath+tmp;
			}
			_root.myXMLloader = new main.xmlLoader(tmp, _root, "home", this, "avvia", false);
		}
	}
	function myReplace(str, search, replace) {
		var temparray = str.split(search);
		str = temparray.join(replace);
		return (str);
	}
}
