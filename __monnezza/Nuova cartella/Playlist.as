class Playlist extends MovieClip
{
    var _altRowColor1, _altRowColor2, _rollOverColor, _selectionColor, _backgroundColor, _listBorderStyle, _vertScrollPolicy, _playerInstance, _cssLocation, _rowHeight, _icon, __width, __height, _xscale, _yscale, _width, _height, player_mc;
    function Playlist()
    {
        super();
        this.init();
        this.createChildren();
        this.arrange();
    } // End of the function
    function __set__altRowColor1(altRowColor1)
    {
        _altRowColor1 = altRowColor1;
        return (this.__get__altRowColor1());
        null;
    } // End of the function
    function __get__altRowColor1()
    {
        return (_altRowColor1);
    } // End of the function
    function __set__altRowColor2(altRowColor2)
    {
        _altRowColor2 = altRowColor2;
        return (this.__get__altRowColor2());
        null;
    } // End of the function
    function __get__altRowColor2()
    {
        return (_altRowColor2);
    } // End of the function
    function __set__rollOverColor(rollOverColor)
    {
        _rollOverColor = rollOverColor;
        return (this.__get__rollOverColor());
        null;
    } // End of the function
    function __get__rollOverColor()
    {
        return (_rollOverColor);
    } // End of the function
    function __set__selectionColor(selectionColor)
    {
        _selectionColor = selectionColor;
        return (this.__get__selectionColor());
        null;
    } // End of the function
    function __get__selectionColor()
    {
        return (_selectionColor);
    } // End of the function
    function __set__backgroundColor(backgroundColor)
    {
        _backgroundColor = backgroundColor;
        return (this.__get__backgroundColor());
        null;
    } // End of the function
    function __get__backgroundColor()
    {
        return (_backgroundColor);
    } // End of the function
    function __set__listBorderStyle(listBorderStyle)
    {
        _listBorderStyle = listBorderStyle;
        return (this.__get__listBorderStyle());
        null;
    } // End of the function
    function __get__listBorderStyle()
    {
        return (_listBorderStyle);
    } // End of the function
    function __set__vertScrollPolicy(vertScrollPolicy)
    {
        _vertScrollPolicy = vertScrollPolicy;
        return (this.__get__vertScrollPolicy());
        null;
    } // End of the function
    function __get__vertScrollPolicy()
    {
        return (_vertScrollPolicy);
    } // End of the function
    function __set__playerInstance(playerInstance)
    {
        _playerInstance = playerInstance;
        return (this.__get__playerInstance());
        null;
    } // End of the function
    function __get__playerInstance()
    {
        return (_playerInstance);
    } // End of the function
    function __set__cssLocation(cssLocation)
    {
        _cssLocation = cssLocation;
        return (this.__get__cssLocation());
        null;
    } // End of the function
    function __get__cssLocation()
    {
        return (_cssLocation);
    } // End of the function
    function __set__rowHeight(rowHeight)
    {
        _rowHeight = rowHeight;
        return (this.__get__rowHeight());
        null;
    } // End of the function
    function __get__rowHeight()
    {
        return (_rowHeight);
    } // End of the function
    function __set__icon(icon)
    {
        _icon = icon;
        return (this.__get__icon());
        null;
    } // End of the function
    function __get__icon()
    {
        return (_icon);
    } // End of the function
    function __set__width(nwidth)
    {
        this.setSize(nwidth, null);
        return (this.__get__width());
        null;
    } // End of the function
    function __get__width()
    {
        return (__width);
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
    function dispatchEvent()
    {
    } // End of the function
    function addEventListener()
    {
    } // End of the function
    function removeEventListener()
    {
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
        function handleEvent(evt)
        {
            if (evt.type == "start")
            {
                tL.list_mc.pl_list.vPosition = tL.player_mc.currentVideo - 1;
                tL.list_mc.pl_list.selectedIndex = tL.player_mc.currentVideo;
            }
            else if (evt.type == "xmlLoaded")
            {
                tL._videosArray = tL.player_mc.videosArray;
                tL.initList();
            } // end if
        } // End of the function
        __width = _width;
        __height = _height;
        _xscale = 100;
        _yscale = 100;
        var tL = evt;
        _global.HtmlCellRenderer.CssUrl = tL._cssLocation;
        mx.events.EventDispatcher.initialize(evt);
        tL.player_mc = tL._parent[tL._playerInstance];
        tL.boundingBox_mc._visible = false;
        tL.boundingBox_mc._width = 0;
        tL.boundingBox_mc._height = 0;
        player_mc.addEventListener("start", handleEvent);
        player_mc.addEventListener("xmlLoaded", handleEvent);
    } // End of the function
    function createChildren()
    {
        var _l2 = this;
        _l2.attachMovie("list_mc", "list_mc", 25);
    } // End of the function
    function arrange()
    {
        var _l2 = this;
        _l2.list_mc.pl_list._width = __width;
        _l2.list_mc.pl_list._height = __height;
    } // End of the function
    function initList()
    {
        var _l3 = this;
        _l3.list_mc.pl_list.rowHeight = _l3._rowHeight;
        _l3._myDP = new Array();
        _l3.list_mc.pl_list.dataProvider = _l3._myDP;
        var _l4 = 0;
        while (_l4 < _l3._videosArray.length)
        {
            _l3._myDP.addItem({label: _l3._videosArray[_l4].title, data: _l3._videosArray[_l4], icon: _l3._icon});
            ++_l4;
        } // end while
        _l3.list_mc.pl_list.vScrollPolicy = _vertScrollPolicy;
        _global.styles.ScrollSelectList.setStyle("selectionColor", _selectionColor);
        _global.styles.ScrollSelectList.setStyle("rollOverColor", _rollOverColor);
        _global.styles.ScrollSelectList.setStyle("borderStyle", _listBorderStyle);
        _global.styles.ScrollSelectList.setStyle("backgroundColor", _backgroundColor);
        if (_altRowColor1 != undefined || _altRowColor2 != undefined)
        {
            _global.styles.ScrollSelectList.setStyle("alternatingRowColors", Array(_altRowColor1, _altRowColor2));
        } // end if
        _l3.list_mc.pl_list.cellRenderer = "HtmlCellRenderer";
        _l3.list_mc.pl_list.selectable = true;
    } // End of the function
} // End of Class
