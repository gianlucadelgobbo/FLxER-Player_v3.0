class JukeboxDisplay extends MovieClip
{
    var _xmlFile, _singleFLV, _vSize, _continuousLoop, _enableMediaLink, _fileLoop, _enableAutoPlay, _enableRandomPlay, _bufferFont, _bufferFontSize, _bgColor, _bufferFontColor, _bufferString, _bufferTime, _timeText, _currentVideoPosition, _videos, _pctLoaded, _bytesTotal, audio_sound, netStream, _videoCount, __height, __width, _xscale, _yscale, _width, _height, boundingBox_mc, container, _error, videoLink_mc, myVideo_mc, loading_mc;
    function JukeboxDisplay(xmlFile)
    {
        super();
        this.init();
        this.createChildren();
        this.arrange();
    } // End of the function
    function __set__xmlLocation(xmlFile)
    {
        _xmlFile = xmlFile;
        return (this.__get__xmlLocation());
        null;
    } // End of the function
    function __set__singleFLV(singleFLV)
    {
        _singleFLV = singleFLV;
        return (this.__get__singleFLV());
        null;
    } // End of the function
    function __set__vSize(vSize)
    {
        _vSize = vSize;
        return (this.__get__vSize());
        null;
    } // End of the function
    function __get__vSize()
    {
        return (_vSize);
    } // End of the function
    function __set__continuousLoop(continuousLoop)
    {
        _continuousLoop = continuousLoop;
        return (this.__get__continuousLoop());
        null;
    } // End of the function
    function __get__continuousLoop()
    {
        return (_continuousLoop);
    } // End of the function
    function __set__enableMediaLink(enableMediaLink)
    {
        _enableMediaLink = enableMediaLink;
        return (this.__get__enableMediaLink());
        null;
    } // End of the function
    function __get__enableMediaLink()
    {
        return (_enableMediaLink);
    } // End of the function
    function __set__fileLoop(fileLoop)
    {
        _fileLoop = fileLoop;
        return (this.__get__fileLoop());
        null;
    } // End of the function
    function __get__fileLoop()
    {
        return (_fileLoop);
    } // End of the function
    function __set__enableAutoPlay(enableAutoPlay)
    {
        _enableAutoPlay = enableAutoPlay;
        return (this.__get__enableAutoPlay());
        null;
    } // End of the function
    function __get__enableAutoPlay()
    {
        return (_enableAutoPlay);
    } // End of the function
    function __set__enableRandomPlay(enableRandomPlay)
    {
        _enableRandomPlay = enableRandomPlay;
        return (this.__get__enableRandomPlay());
        null;
    } // End of the function
    function __get__enableRandomPlay()
    {
        return (_enableRandomPlay);
    } // End of the function
    function __set__bufferFont(bufferFont)
    {
        _bufferFont = bufferFont;
        return (this.__get__bufferFont());
        null;
    } // End of the function
    function __get__bufferFont()
    {
        return (_bufferFont);
    } // End of the function
    function __set__bufferFontSize(bufferFontSize)
    {
        _bufferFontSize = bufferFontSize;
        return (this.__get__bufferFontSize());
        null;
    } // End of the function
    function __get__bufferFontSize()
    {
        return (_bufferFontSize);
    } // End of the function
    function __set__bgColor(bgColor)
    {
        _bgColor = bgColor;
        return (this.__get__bgColor());
        null;
    } // End of the function
    function __set__bufferFontColor(bufferFontColor)
    {
        _bufferFontColor = bufferFontColor;
        return (this.__get__bufferFontColor());
        null;
    } // End of the function
    function __set__bufferString(bufferString)
    {
        _bufferString = bufferString;
        return (this.__get__bufferString());
        null;
    } // End of the function
    function __set__bufferTime(bufferTime)
    {
        _bufferTime = bufferTime;
        return (this.__get__bufferTime());
        null;
    } // End of the function
    function __get__bufferTime()
    {
        return (_bufferTime);
    } // End of the function
    function __get__timeText()
    {
        return (_timeText);
    } // End of the function
    function __get__paused()
    {
        return (_pausedFlag);
    } // End of the function
    function __get__currentVideo()
    {
        return (_currentVideo);
    } // End of the function
    function __get__currentVideoPosition()
    {
        return (_currentVideoPosition);
    } // End of the function
    function __get__mediaLength()
    {
        return (_mediaLength);
    } // End of the function
    function __get__videosArray()
    {
        return (_videos);
    } // End of the function
    function __get__pctLoaded()
    {
        return (_pctLoaded);
    } // End of the function
    function __get__mediaBytesTotal()
    {
        return (_bytesTotal);
    } // End of the function
    function __set__audioVolume(new_vol)
    {
        audio_sound.setVolume(new_vol);
        return (this.__get__audioVolume());
        null;
    } // End of the function
    function __get__audioVolume()
    {
        return (audio_sound.getVolume());
    } // End of the function
    function __set__buffering(setBuffering)
    {
        if (setBuffering == true && _buffering == false)
        {
            this.loading(1);
        } // end if
        if (setBuffering == true && _buffering == true)
        {
            this.loading(0);
        } // end if
        return (this.__get__buffering());
        null;
    } // End of the function
    function __get__buffering()
    {
        return (_buffering);
    } // End of the function
    function play()
    {
        var _l2 = this;
        if (_l2._pausedFlag == true)
        {
            _l2.netStream.pause();
            _l2._pausedFlag = false;
        } // end if
        _l2.dispatchEvent({target: this, type: "play"});
    } // End of the function
    function pause()
    {
        var _l2 = this;
        if (_l2._pausedFlag == false)
        {
            _l2.netStream.pause();
            _l2._pausedFlag = true;
        } // end if
        _l2.dispatchEvent({target: this, type: "pause"});
    } // End of the function
    function restart()
    {
        netStream.seek(0);
    } // End of the function
    function fastForward(n)
    {
        netStream.seek(n);
    } // End of the function
    function jumpToVideoPosition(n)
    {
        netStream.seek(n);
    } // End of the function
    function seek(n)
    {
        netStream.seek(n);
    } // End of the function
    function jumpToVideo(n)
    {
        if (_videoCount > n && n >= 0)
        {
            _currentVideo = n;
            this.videoJukebox();
        } // end if
    } // End of the function
    function nextVideo()
    {
        var _l2 = _currentVideo + 1;
        if (_fileLoop == "true")
        {
            _l2 = _currentVideo;
        } // end if
        if (_l2 > _videoCount - 1)
        {
            _l2 = 0;
            _currentVideo = _l2;
            _videoLoops = _videoLoops + 1;
            this.videoJukebox();
        }
        else
        {
            if (_singleFLV !== "")
            {
                _videoLoops = _videoLoops + 1;
            } // end if
            _currentVideo = _l2;
            this.videoJukebox();
        } // end if
    } // End of the function
    function prevVideo()
    {
        var _l2 = _currentVideo - 1;
        if (_l2 < 0)
        {
            _l2 = _videoCount - 1;
        } // end if
        _currentVideo = _l2;
        this.videoJukebox();
    } // End of the function
    function setColorScheme()
    {
        var _l2 = this;
        MovieClip.prototype.setRGB = function (colorValue)
        {
            new Color(this).setRGB(colorValue);
        };
        colorValue.myVideo_mc.bg_mc.setRGB(Number(colorValue._bgColor));
    } // End of the function
    function __set__height(nHeight)
    {
        this.setSize(null, nHeight);
        return (this.__get__height());
        null;
    } // End of the function
    function __get__height()
    {
        return (__height);
    } // End of the function
    function __set__width(nWidth)
    {
        this.setSize(nWidth, null);
        return (this.__get__width());
        null;
    } // End of the function
    function __get__width()
    {
        return (__width);
    } // End of the function
    function setSize(nW, nH)
    {
        _xscale = 100;
        _yscale = 100;
        __width = nW;
        __height = nH;
        this.arrange();
    } // End of the function
    function init()
    {
        __width = _width;
        __height = _height;
        _xscale = 100;
        _yscale = 100;
        mx.events.EventDispatcher.initialize(this);
        boundingBox_mc._visible = false;
        boundingBox_mc._width = 0;
        boundingBox_mc._height = 0;
        if (_singleFLV == "")
        {
            var _l2 = new XML();
            _l2.ignoreWhite = true;
            _l2.container = this;
            _l2.onLoad = function (success)
            {
                if (success)
                {
                    container.onXMLLoaded(this);
                }
                else
                {
                    _error = "Cannot load XML";
                } // end if
            };
            if (_xmlFile !== "")
            {
                success.load(_xmlFile);
            } // end if
        } // end if
    } // End of the function
    function createChildren()
    {
        this.attachMovie("myVideo_mc", "myVideo_mc", this.getNextHighestDepth());
        this.attachMovie("videoLink_mc", "videoLink_mc", this.getNextHighestDepth());
        this.attachMovie("loading_mc", "loading_mc", this.getNextHighestDepth());
        videoLink_mc._alpha = 0;
        this.setColorScheme();
        if (_singleFLV != "")
        {
            this.initNetStream();
            this.initAudioSound();
            this.initCheckVideo();
        } // end if
    } // End of the function
    function arrange()
    {
        videoLink_mc._alpha = 0;
        videoLink_mc._width = __width;
        videoLink_mc._height = __height;
        myVideo_mc.myVideo._width = __width;
        myVideo_mc.myVideo._height = __height;
        myVideo_mc.bg_mc._width = __width;
        myVideo_mc.bg_mc._height = __height;
        loading_mc._x = 5;
        loading_mc._y = __height - (10 + _bufferFontSize);
        var _l2 = new TextField.StyleSheet();
        _l2.setStyle(".one", {fontFamily: _bufferFont, fontSize: _bufferFontSize + "px", fontWeight: "normal"});
        loading_mc.buffering_txt.styleSheet = _l2;
        loading_mc.buffering_txt.text = "<span class=\'one\'>" + _bufferString + "</span>";
        loading_mc.buffering_txt.textColor = _bufferFontColor;
        if (_xmlFile == "" && _singleFLV == "")
        {
            this.loading(0);
        } // end if
    } // End of the function
    function onXMLLoaded(videosXML)
    {
        var _l2 = this;
        var _l3 = videosXML.firstChild.firstChild;
        _videos = this.xmlVideoNodesToArray(_l3);
        _l3 = _l3.nextSibling;
        _videoCount = _videos.length;
        _l2.dispatchEvent({target: this, type: "xmlLoaded"});
        _l2.initNetStream();
        _l2.initAudioSound();
        _l2.initCheckVideo();
    } // End of the function
    function xmlVideoNodesToArray(node)
    {
        var _l5 = new Array();
        var _l4;
        var _l2;
        var _l3 = node;
        while (_l3 != null)
        {
            _l4 = this.xmlAttributesToObject(new Object(), _l3);
            _l2 = _l3.firstChild;
            while (_l2 != null)
            {
                _l4[_l2.nodeName] = _l2.firstChild.nodeValue;
                _l2 = _l2.nextSibling;
            } // end while
            _l5.push(_l4);
            _l3 = _l3.nextSibling;
        } // end while
        return (_l5);
    } // End of the function
    function xmlAttributesToObject(o, node)
    {
        var _l1 = node.attributes;
        for (var _l3 in _l1)
        {
            o[_l3] = _l1[_l3];
        } // end of for...in
        return (_l1);
    } // End of the function
    function loading(n)
    {
        var _l2 = this;
        if (n == 0)
        {
            _l2.loading_mc._visible = false;
            _l2._buffering = false;
        }
        else if (n == 1)
        {
            _l2.loading_mc._visible = true;
            _l2._buffering = true;
        } // end if
    } // End of the function
    function initNetStream()
    {
        function onVideoResize()
        {
            var _l3 = tC.myVideo_mc.myVideo.width / tC.myVideo_mc.myVideo.height;
            if (tC.myVideo_mc._width > tC.myVideo_mc._height)
            {
                var _l1 = tC.myVideo_mc._width;
                var _l2 = tC.myVideo_mc._width / _l3;
            }
            else
            {
                _l2 = tC.myVideo_mc._height;
                _l1 = tC.myVideo_mc._height * _l3;
            } // end if
            while (_l2 > tC.myVideo_mc.myVideo._height || _l1 > tC.myVideo_mc.myVideo._width)
            {
                _l1 = _l1 - 1;
                _l2 = _l1 / _l3;
            } // end while
            if (_l1 > 1 && _l2 > 1)
            {
                tC.myVideo_mc.myVideo._width = Math.round(_l1);
                tC.myVideo_mc.myVideo._height = Math.round(_l2);
            } // end if
            var _l5 = (tC.myVideo_mc._width - tC.myVideo_mc.myVideo._width) / 2;
            tC.myVideo_mc.myVideo._x = _l5;
            var _l4 = (tC.myVideo_mc._height - tC.myVideo_mc.myVideo._height) / 2;
            tC.myVideo_mc.myVideo._y = _l4;
        } // End of the function
        var tC = _l1;
        tC.netConn = new NetConnection();
        tC.netConn.connect(null);
        tC.netStream = new NetStream(tC.netConn);
        tC.netStream.setBufferTime(tC._bufferTime);
        tC.myVideo_mc.myVideo.attachVideo(tC.netStream);
        tC.myVideo_mc.myVideo.smoothing = true;
        if (_vSize == "constrain_to_display")
        {
            setInterval(onVideoResize, 200);
        } // end if
        tC.netStream.onStatus = function (infoObject)
        {
            if (infoObject.code == "NetStream.Play.Start")
            {
                tC.myVideo_mc.myVideo._x = 0;
                tC.myVideo_mc.myVideo._y = 0;
                tC.myVideo_mc.myVideo._width = tC.myVideo_mc._width;
                tC.myVideo_mc.myVideo._height = tC.myVideo_mc._height;
                tC._bytesTotal = tC.netStream.bytesTotal;
                tC.dispatchEvent({target: this, type: "start"});
            }
            else if (infoObject.code == "NetStream.Play.Stop")
            {
            }
            else if (infoObject.code == "NetStream.Buffer.Full")
            {
                tC.loading(0);
                tC.dispatchEvent({target: this, type: "buffer_full"});
            }
            else if (infoObject.code == "NetStream.Buffer.Empty")
            {
                tC.dispatchEvent({target: this, type: "buffer_empty"});
            } // end if
        };
        tC.netStream.onMetaData = function (info)
        {
            tC._mediaLength = info.duration;
            tC.dispatchEvent({target: this, type: "mediaLength"});
        };
    } // End of the function
    function initAudioSound()
    {
        var _l2 = this;
        _l2.createEmptyMovieClip("audio_mc", this.getNextHighestDepth());
        _l2.audio_mc.attachAudio(_l2.netStream);
        _l2.audio_sound = new Sound(_l2.audio_mc);
    } // End of the function
    function initCheckVideo()
    {
        function endCheck()
        {
            if (tC.__get__mediaLength() - tC.netStream.time < 0.250000 && tC.netStream.time > 0 && tC.__get__mediaLength() > 0 && tC.__get__mediaLength() != undefined)
            {
                tC.dispatchEvent({target: this, type: "stop"});
                tC.dispatchEvent({target: this, type: "end"});
                tC._mediaLength = 0;
                tC._pctLoaded = 0;
                tC.nextVideo();
            } // end if
            if (tC.__get__mediaLength() > 0 && Math.round(tC.netStream.time) == Math.floor(tC.__get__mediaLength()) && tC._isPlaying == false && tC._pausedFlag == false)
            {
                tC.dispatchEvent({target: this, type: "stop"});
                tC.dispatchEvent({target: this, type: "end"});
                tC._mediaLength = 0;
                tC._pctLoaded = 0;
                tC.nextVideo();
            } // end if
        } // End of the function
        function isPlaying()
        {
            if (tC.netStream.time != undefined && tC.netStream.time > 0)
            {
                tC._isPlaying = tC.netStream.time - prev_time != 0;
            } // end if
            if (tC._pausedFlag == true)
            {
                tC._isPlaying = true;
                tC.dispatchEvent({target: this, type: "pause"});
            }
            else
            {
                tC.dispatchEvent({target: this, type: "play"});
            } // end if
            if (tC._enableAutoPlay == "false" && Math.floor(tC.netStream.time) == 0)
            {
                tC._isPlaying = true;
            } // end if
            if (tC._isPlaying)
            {
                tC.loading(0);
            }
            else
            {
                tC.loading(1);
            } // end if
            prev_time = tC.netStream.time;
        } // End of the function
        function curTime()
        {
            tC._currentVideoPosition = tC.netStream.time;
            tC._minutes = Math.floor(tC.netStream.time / 60);
            tC._seconds = Math.floor(tC.netStream.time % 60);
            if (tC._minutes < 10)
            {
                tC._timeText = "0" + tC._minutes;
            }
            else
            {
                tC._timeText = "" + tC._minutes;
            } // end if
            if (tC._seconds < 10)
            {
                tC._timeText = tC._timeText + (":0" + tC._seconds);
            }
            else
            {
                tC._timeText = tC._timeText + (":" + tC._seconds);
            } // end if
            if (tC._mediaLength > 0)
            {
                tC.dispatchEvent({target: this, type: "mediaTime"});
            } // end if
        } // End of the function
        var tC = this;
        var prev_time = 0;
        tC._videoTime_Interval = setInterval(curTime, 25);
        tC._isPlaying_Interval = setInterval(isPlaying, 250);
        tC._endCheck_Interval = setInterval(endCheck, 5);
        tC.videoJukebox();
    } // End of the function
    function initVideoInfo()
    {
        var _l2 = this;
        if (_l2._singleFLV == "")
        {
            if (_videos[_l2._currentVideo].category == "true" && _videos[_l2._currentVideo].file.length == 0)
            {
                _l2._currentVideo = _l2._currentVideo + 1;
            } // end if
            _l2._mediaTitle = _videos[_l2._currentVideo].title;
            _l2._mediaLink = _videos[_l2._currentVideo].link;
            _l2._file = _videos[_l2._currentVideo].file;
            if (_videos[_l2._currentVideo].length.length > 0)
            {
                _l2._mediaLength = _videos[_l2._currentVideo].length;
                _l2.dispatchEvent({target: this, type: "mediaLength"});
            } // end if
        }
        else
        {
            _l2._file = _l2._singleFLV;
        } // end if
    } // End of the function
    function playFLV(flvFile)
    {
        var _l2 = this;
        _l2._file = "";
        _l2._xmlFile = "";
        _l2._singleFLV = "";
        if (_l2._pausedFlag == true)
        {
            _l2.play();
        } // end if
        _l2.netStream.close();
        clearInterval(_l2._videoTime_Interval);
        clearInterval(_l2._isPlaying_Interval);
        clearInterval(_l2._endCheck_Interval);
        _l2._singleFLV = flvFile;
        _l2.initNetStream();
        _l2.initAudioSound();
        _l2.initCheckVideo();
    } // End of the function
    function loadXML(xmlFile)
    {
        var tC = this;
        tC._pausedFlag = false;
        tC.netStream.close();
        clearInterval(tC._videoTime_Interval);
        clearInterval(tC._isPlaying_Interval);
        clearInterval(tC._endCheck_Interval);
        tC._file = "";
        tC._xmlFile = "";
        tC._singleFLV = "";
        tC._currentVideo = 0;
        tC._xmlFile = xmlFile;
        var _l2 = new XML();
        _l2.ignoreWhite = true;
        _l2.container = this;
        _l2.onLoad = function (success)
        {
            if (success)
            {
                container.onXMLLoaded(this);
            }
            else
            {
                tC._error = "Cannot load XML";
            } // end if
        };
        if (tC._xmlFile)
        {
            success.load(tC._xmlFile);
        } // end if
        tC.loading(1);
    } // End of the function
    function unload()
    {
        var _l2 = this;
        clearInterval(_l2._videoTime_Interval);
        clearInterval(_l2._isPlaying_Interval);
        clearInterval(_l2._endCheck_Interval);
        _l2._pausedFlag = true;
        _l2.netStream.close();
        _l2.myVideo_mc.myVideo.clear();
        _l2.dispatchEvent({target: this, type: "unload"});
    } // End of the function
    function videoJukebox()
    {
        function checkPctLoaded()
        {
            tC._pctLoaded = Math.round(tC.netStream.bytesLoaded / tC.netStream.bytesTotal * 100);
            if (tC._pctLoaded >= 100)
            {
                clearInterval(tC._loaded_interval);
            } // end if
            tC.dispatchEvent({target: this, type: "pctLoaded"});
        } // End of the function
        var tC = this;
        if (tC._enableRandomPlay == "true" && tC._singleFLV == "")
        {
            tC._currentVideo = Math.round(Math.random() * (tC._videoCount - 1));
        } // end if
        tC.initVideoInfo();
        if (tC._mediaLink.length > 0 && tC._enableMediaLink == "true" && tC._singleFLV == "")
        {
            tC.videoLink_mc.enabled = true;
            tC.videoLink_mc.onRelease = function ()
            {
            };
        }
        else
        {
            tC.videoLink_mc.enabled = false;
        } // end if
        if (tC._pausedFlag != true)
        {
            clearInterval(tC._loaded_interval);
            tC.netStream.play(tC._file);
            tC._pausedFlag = false;
            tC.dispatchEvent({target: this, type: "play"});
        } // end if
        tC._loaded_interval = setInterval(checkPctLoaded, 10);
        if (tC._enableAutoPlay == "false" && tC._currentVideo == 0)
        {
            tC.netStream.seek(0);
            tC.pause();
        } // end if
        if (tC._videoLoops > 0 && _continuousLoop == "false")
        {
            tC.netStream.seek(0);
            tC.pause();
            tC._pausedFlag = true;
            tC._videoLoops = 0;
        } // end if
    } // End of the function
    var _singleFLVPlayed = false;
    var _isPlaying = true;
    var _buffering = true;
    var _pausedFlag = false;
    var _currentVideo = 0;
    var _videoLoops = 0;
    var _mediaLength = 0;
    var _playingFlag = false;
} // End of Class
