class starterGallery extends MovieClip {
	var pref:Object;
	function starterGallery(sito) {
		System.useCodepage = true;
		System.security.allowDomain("*");
		Stage.scaleMode = "noScale";
		Stage.align = "TL";
		_root.myClassedMC = function(classe, trgt, myName, obj) {
			Object.registerClass("empty",classe);
			trgt.attachMovie("empty",myName,trgt.getNextHighestDepth(),obj);
		};
		if (!_root.alt) {
			_root.attachMovie("altPlayer","altPlayer",_root.getNextHighestDepth(),{_y:-1000});
		}
		//_root.myPath = ""; 
		switch (sito) {
			case "NRS" :
				_root.myFsPath = "/flxerplayer/fullscreen.php?mm=";
				_root.downPath = "/flxerplayer/mediaDownload.php?file=";
				_root.embePath = "/_swf/flxerPlayer3.swf?cnt=";
				_root.w = 500;
				_root.h = 414;
				pref = {x:0, y:0, w:Stage.width, h:Stage.height, tw:128, th:96, toolbar:true, autostop:false, myLoop:false, resizza_onoff:true, centra_onoff:true, ss_time:3000, info:false};
				break;
			case "FLxER" :
				//_root.myUserPath = "/abusers/";
				_root.myFsPath = "http://www.flxer.net/flxerplayer/fullscreen.php?mm=";
				_root.downPath = "http://www.flxer.net/_class/mediaDownload.php?file=";
				_root.embePath = "http://www.flxer.net/_swf/flxerPlayer3.swf?cnt=";
				_root.w = 400;
				_root.h = 339;
				pref = {x:0, y:0, w:Stage.width, h:Stage.height, tw:128, th:96, toolbar:true, autostop:false, myLoop:false, resizza_onoff:true, centra_onoff:true, ss_time:3000, info:false};
				break;
			case "FOTOGRAFIA" :
				_root.myFsPath = "/2007/_asp/fullscreen.asp?mm=";
				_root.downPath = "/2007/_asp/mediaDownload.asp?file=";
				_root.embePath = "/2007/_swf/flxerPlayer3.swf?cnt=";
				_root.w = 800;
				_root.h = 539;
				pref = {x:0, y:0, w:Stage.width, h:Stage.height, tw:128, th:96, toolbar:true, autostop:true, myLoop:true, resizza_onoff:true, centra_onoff:true, ss_time:3000, info:false};
				break;
			case "LPM" :
				_root.myFsPath = "http://lpm.flyer.it/2007/_php/fullscreen.php?cnt=";
				_root.downPath = "http://lpm.flyer.it/2007/_php/mediaDownload.php?cnt=";
				_root.embePath = "http://lpm.flyer.it/2007/_swf/flxerPlayer3.swf?cnt=";
				_root.w = 680;
				_root.h = 549;
				pref = {x:0, y:0, w:Stage.width, h:Stage.height, tw:128, th:96, toolbar:true, autostop:false, myLoop:true, resizza_onoff:true, centra_onoff:true, ss_time:3000, info:false};
				break;
			case "FLYER" :
				_root.myFsPath = "/_php/fullscreen.php?cnt=";
				_root.downPath = "/_php/mediaDownload.php?cnt=";
				_root.embePath = "/_swf/flxerPlayer3.swf?cnt=";
				_root.w = 680;
				_root.h = 549;
				pref = {x:0, y:0, w:Stage.width, h:Stage.height, tw:128, th:96, toolbar:true, autostop:false, myLoop:true, resizza_onoff:true, centra_onoff:true, ss_time:3000, info:false};
				break;
			case "PROVINCIA" :
				_root.myFsPath = "_php/fullscreen.php?cnt=";
				_root.downPath = "_php/mediaDownload.php?cnt=";
				_root.embePath = "_swf/flxerPlayer3.swf?cnt=";
				_root.w = 1024;
				_root.h = 768;
				pref = {x:0, y:0, w:Stage.width, h:Stage.height, tw:128, th:96, toolbar:true, autostop:false, myLoop:true, resizza_onoff:true, centra_onoff:true, ss_time:3000, info:false};
				break;
			case "NGA" :
				_root.myFsPath = "/_php/fullscreen.php?cnt=";
				_root.downPath = "/_php/mediaDownload.php?cnt=";
				_root.embePath = "/_swf/flxerPlayer3.swf?cnt=";
				_root.w = 400;
				_root.h = 349;
				pref = {x:0, y:0, w:Stage.width, h:Stage.height, tw:128, th:96, toolbar:true, autostop:false, myLoop:true, resizza_onoff:true, centra_onoff:true, ss_time:3000, info:false};
				break;
		}
		//// LOCAL TEST ///////////////   
		if (!_root.cnt) {
			switch (sito) {
				case "NRS" :
					_root.myPath = "";
					_root.cnt = "http://www.nonrassegnatastampa.it/videos/2007-03-15_p27.flv,PUNTATA 27 - 15.03.2007";
					break;
				case "FLxER" :
					_root.cnt = "/warehouse/_videos/sonar2006.flv,SONAR 2006 - The Video";
					_root.cnt = "http://www.flxer.net/warehouse/_flxer/library/no_hole/apx_urlo2.flv,APX3,1,9703,5711";
					_root.cnt = "/warehouse/_flxer/library/no_hole/apx_urlo2.flv,APX3";
					_root.cnt = "/warehouse/_flxer/library/no_hole/elnino3.swf,elnino3";
					_root.cnt = "/warehouse/_flxer/liveset/volvo1231.flv,GUARDA+IL+VIDEO,1,4151,1965";
					_root.cnt = "http://www.flxer.net/flxerplayer/?id=1,rel=magazine_rel";
					break;
				case "FOTOGRAFIA" :
					_root.cnt = "http://www.fotografiafestival.it/2007/_asp/fotovideo.asp?id=1597";
					break;
				case "LPM" :
					_root.cnt = "http://lpm.flyer.it/2007/gallery/2006/Mikkel/lpm06edit320.flv,bella";
					_root.cnt = "http://lpm.flyer.it/2007/gallery/2006/mono.xml";
					_root.cnt = "http://lpm.flyer.it/2007/gallery/2006/selecta.xml";
					_root.cnt = "http://lpm.flyer.it/2007/gallery/2006/video.xml";
					break;
				case "PROVINCIA" :
					_root.cnt = "data.xml";
					break;
				case "NGA" :
					// multifoto
					_root.cnt = "http://www.natgeoadventure.it/_php/flxerGallery.php?id=p4968";
					// multifoto + video
					_root.cnt = "http://www.natgeoadventure.it/_php/flxerGallery.php?id=m10";
					// solo video
					_root.cnt = "http://www.natgeoadventure.it/_php/flxerGallery.php?id=p4969";
					break;
			}
		}
		builder();
	}
	function builder() {
		_root.myClassedMC(flxerGallery.mainFlxerGallery,_root,"myFlxerGallery",pref);
		if (_root.cnt) {
			avviaJs();
		}
	}
	function avviaJs() {
		_root["myFlxerGallery"].startUrl = _root.cnt;
		//getURL("javascript:alert('"+_root.cnt+"');")
		var tmp = _root.cnt.split(",");
		var tmp2 = tmp[0].substring(tmp[0].length-3, tmp[0].length).toLowerCase();
		if (tmp2 == "flv" || tmp2 == "mp3" || tmp2 == "swf" || tmp2 == "jpg" || tmp2 == "png" || tmp2 == "gif") {
			var tmpXml = new XML("<ul><li><a>"+tmp[1]+"</a><div>"+tmp[1]+"</div></li></ul>");
			tmpXml.childNodes[0].childNodes[0].childNodes[0].attributes.href = "/mediaViewer.php?cnt="+tmp[0];
			if (tmp[3]) {
				_root["myFlxerGallery"]["mySuperPlayer"]["monitor"].link = _root.mySitePath+_root.myUserPath+"?userId="+tmp[3]+"&postId="+tmp[4]+"&pageItem=1";
				_root["myFlxerGallery"]["mySuperPlayer"]["monitor"].onPress = function() {
					getURL(this.link, "_blank");
				};
			}
			_root["myFlxerGallery"].avvia(tmpXml);
		} else {
			var tmp = _root.cnt;
			if (tmp.indexOf("http://") != -1) {
				_root.myPath = _root.mySitePath;
			}
			var tmp = myReplace(_root.cnt, ",", "&");
			if (tmp.indexOf("http://") == -1) {
				tmp = _root.myPath+tmp;
			}
			_root.myXMLloader = new main.xmlLoader(tmp, _root, "home", _root["myFlxerGallery"], "avvia", true);
		}
	}
	function myReplace(str, search, replace) {
		var temparray = str.split(search);
		str = temparray.join(replace);
		return str;
	}
}