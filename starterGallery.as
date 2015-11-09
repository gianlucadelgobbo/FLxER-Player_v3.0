class starterGallery extends MovieClip {
	var pref:Object;
	function starterGallery(p) {
		trace("/////"+p)
		pref = p
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
		pref.x = 0;
		pref.y = 0;
		pref.w = Stage.width;
		pref.h = Stage.height;
		_root.myClassedMC(flxerGallery.mainFlxerGallery,_root,"myFlxerGallery",pref);
		avviaJs();
	}
	function avviaJs() {
		_root["myFlxerGallery"].startUrl = _root.cnt;
		//getURL("javascript:alert('"+_root.cnt+"');")
		var tmp = _root.cnt.split(",");
		var tmp2 = tmp[0].substring(tmp[0].length-3, tmp[0].length).toLowerCase();
		if (tmp2 == "flv" || tmp2 == "mp3" || tmp2 == "swf" || tmp2 == "jpg" || tmp2 == "png" || tmp2 == "gif") {
			var tmpXml = new XML("<ul><li><a>"+tmp[0]+"</a><tit>"+tmp[1]+"</tit></li></ul>");
			if (tmp[2]) {
				_root["myFlxerGallery"]["mySuperPlayer"]["monitor"].link = pref.myPath+pref.myUserPath+tmp[2];
				_root["myFlxerGallery"]["mySuperPlayer"]["monitor"].onPress = function() {
					getURL(this.link, "_blank");
				};
			}
			_root["myFlxerGallery"].avvia(tmpXml);
		} else {
			/*var tmp = _root.cnt;
			if (tmp.indexOf("http://") != -1) {
				_root.myPath = _root.mySitePath;
			}
			var tmp = myReplace(_root.cnt, ",", "&");
			if (tmp.indexOf("http://") == -1) {
				tmp = _root.myPath+tmp;
			}*/
			_root.myXMLloader = new main.xmlLoader(tmp, this, "home", this, "avviaMyFlxerGallery", true);
		}
	}
	function avviaMyFlxerGallery(xml) {
		trace("OOOOOOOOOOOOOOOOO "+xml)
		trace("OOOOOOOOOOOOOOOOO "+xml.childNodes[0].attributes.page_url)
		if (xml.childNodes[0].attributes.page_url) {
			_root["myFlxerGallery"]["mySuperPlayer"]["monitor"].link = pref.myUserPath+xml.childNodes[0].attributes.page_url;
			_root["myFlxerGallery"]["mySuperPlayer"]["monitor"].onPress = function() {
				getURL(this.link, "_blank");
			};
		}
		for (var a = 0; a<xml.childNodes[0].childNodes.length; a++) {
			xml.childNodes[0].childNodes[a].childNodes[0].childNodes[0].nodeValue = pref.myPath+xml.childNodes[0].childNodes[a].childNodes[0].childNodes[0].toString();
			xml.childNodes[0].childNodes[a].childNodes[2].childNodes[0].nodeValue = pref.myPath+xml.childNodes[0].childNodes[a].childNodes[2].childNodes[0].toString();
		}
		_root["myFlxerGallery"].avvia(xml);
		delete this["home"];
	}
	function myReplace(str, search, replace) {
		var temparray = str.split(search);
		str = temparray.join(replace);
		return str;
	}
}