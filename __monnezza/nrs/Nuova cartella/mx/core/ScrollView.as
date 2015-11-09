class mx.core.ScrollView extends mx.core.View
{
    var __width, hScroller, vScroller, __maxHPosition, propsInited, specialHScrollCase, scrollAreaChanged, viewableColumns, __height, viewableRows, oldRndUp, __viewMetrics, owner, enabled, border_mc, mask_mc, _parent, _l5;
    function ScrollView()
    {
        super();
    } // End of the function
    function getHScrollPolicy(Void)
    {
        return (__hScrollPolicy);
    } // End of the function
    function setHScrollPolicy(policy)
    {
        __hScrollPolicy = policy.toLowerCase();
        if (__width == undefined)
        {
            return (undefined);
        } // end if
        this.setScrollProperties(numberOfCols, columnWidth, rowC, rowH, heightPadding, widthPadding);
    } // End of the function
    function __get__hScrollPolicy()
    {
        return (this.getHScrollPolicy());
    } // End of the function
    function __set__hScrollPolicy(policy)
    {
        this.setHScrollPolicy(policy);
        return (this.__get__hScrollPolicy());
        null;
    } // End of the function
    function getVScrollPolicy(Void)
    {
        return (__vScrollPolicy);
    } // End of the function
    function setVScrollPolicy(policy)
    {
        __vScrollPolicy = policy.toLowerCase();
        if (__width == undefined)
        {
            return (undefined);
        } // end if
        this.setScrollProperties(numberOfCols, columnWidth, rowC, rowH, heightPadding, widthPadding);
    } // End of the function
    function __get__vScrollPolicy()
    {
        return (this.getVScrollPolicy());
    } // End of the function
    function __set__vScrollPolicy(policy)
    {
        this.setVScrollPolicy(policy);
        return (this.__get__vScrollPolicy());
        null;
    } // End of the function
    function __get__hPosition()
    {
        return (this.getHPosition());
    } // End of the function
    function __set__hPosition(pos)
    {
        this.setHPosition(pos);
        return (this.__get__hPosition());
        null;
    } // End of the function
    function getHPosition(Void)
    {
        return (__hPosition);
    } // End of the function
    function setHPosition(pos)
    {
        hScroller.__set__scrollPosition(pos);
        __hPosition = pos;
    } // End of the function
    function __get__vPosition()
    {
        return (this.getVPosition());
    } // End of the function
    function __set__vPosition(pos)
    {
        this.setVPosition(pos);
        return (this.__get__vPosition());
        null;
    } // End of the function
    function getVPosition(Void)
    {
        return (__vPosition);
    } // End of the function
    function setVPosition(pos)
    {
        vScroller.__set__scrollPosition(pos);
        __vPosition = pos;
    } // End of the function
    function __get__maxVPosition()
    {
        var _l2 = vScroller.maxPos;
        return (_l2 == undefined ? (0) : (_l2));
    } // End of the function
    function __get__maxHPosition()
    {
        return (this.getMaxHPosition());
    } // End of the function
    function __set__maxHPosition(pos)
    {
        this.setMaxHPosition(pos);
        return (this.__get__maxHPosition());
        null;
    } // End of the function
    function getMaxHPosition(Void)
    {
        if (__maxHPosition != undefined)
        {
            return (__maxHPosition);
        } // end if
        var _l2 = hScroller.maxPos;
        return (_l2 == undefined ? (0) : (_l2));
    } // End of the function
    function setMaxHPosition(pos)
    {
        __maxHPosition = pos;
    } // End of the function
    function setScrollProperties(colCount, colWidth, rwCount, rwHeight, hPadding, wPadding)
    {
        var _l3 = this.getViewMetrics();
        if (hPadding == undefined)
        {
            var _l11 = 0;
        } // end if
        if (wPadding == undefined)
        {
            var _l13 = 0;
        } // end if
        propsInited = true;
        delete this.scrollAreaChanged;
        heightPadding = _l11;
        widthPadding = _l13;
        if (colWidth == 0)
        {
            var _l6 = 1;
        } // end if
        if (rwHeight == 0)
        {
            var _l7 = 1;
        } // end if
        var _l4 = Math.ceil((__width - _l3.left - _l3.right - widthPadding) / _l6);
        if (hScroller == undefined || specialHScrollCase)
        {
            delete this.specialHScrollCase;
            hScroller[mx.controls.scrollClasses.ScrollBar] = this.createObject("HScrollBar", "hSB", 1001);
            hScroller.__set__lineScrollSize(20);
            hScroller.scrollHandler = scrollProxy;
            hScroller.__set__scrollPosition(__hPosition);
            scrollAreaChanged = true;
        } // end if
        if (numberOfCols != colCount || columnWidth != _l6 || viewableColumns != _l4 || scrollAreaChanged)
        {
            hScroller.setScrollProperties(_l4, 0, colCount - _l4);
            viewableColumns = _l4;
            numberOfCols = colCount;
            columnWidth = _l6;
        } // end if
        if ((__hScrollPolicy == "auto" || __hScrollPolicy == "off") && hScroller != undefined)
        {
            hScroller.removeMovieClip();
            delete this.hScroller;
            scrollAreaChanged = true;
        } // end if
        if (heightPadding == undefined)
        {
            heightPadding = 0;
        } // end if
        var _l5 = Math.ceil((__height - _l3.top - _l3.bottom - heightPadding) / _l7);
        var _l8 = (__height - _l3.top - _l3.bottom) % _l7 != 0;
        if (vScroller == undefined)
        {
            vScroller[mx.controls.scrollClasses.ScrollBar] = this.createObject("VScrollBar", "vSB", 1002);
            vScroller.scrollHandler = scrollProxy;
            vScroller.__set__scrollPosition(__vPosition);
            scrollAreaChanged = true;
            rowH = 0;
        } // end if
        if (rowC != rwCount || rowH != _l7 || viewableRows + _l8 != _l5 + oldRndUp || scrollAreaChanged)
        {
            vScroller.setScrollProperties(_l5, 0, rwCount - _l5 + _l8);
            viewableRows = _l5;
            rowC = rwCount;
            rowH = _l7;
            oldRndUp = _l8;
        } // end if
        if ((__vScrollPolicy == "auto" || __vScrollPolicy == "off") && vScroller != undefined)
        {
            vScroller.removeMovieClip();
            delete this.vScroller;
            scrollAreaChanged = true;
        } // end if
        numberOfCols = colCount;
        columnWidth = _l6;
        if (scrollAreaChanged)
        {
            this.doLayout();
            var _l2 = __viewMetrics;
            var _l12 = owner != undefined ? (owner) : (this);
            _l12.layoutContent(_l2.left, _l2.top, columnWidth * numberOfCols - _l2.left - _l2.right, rowC * rowH, __width - _l2.left - _l2.right, __height - _l2.top - _l2.bottom);
        } // end if
        if (!enabled)
        {
            this.setEnabled(false);
        } // end if
    } // End of the function
    function getViewMetrics(Void)
    {
        var _l2 = __viewMetrics;
        var _l3 = border_mc.__get__borderMetrics();
        _l2.left = _l3.left;
        _l2.right = _l3.right;
        if (vScroller != undefined)
        {
            _l2.right = _l2.right + vScroller.minWidth;
        } // end if
        _l2.top = _l3.top;
        if (hScroller == undefined && (__hScrollPolicy == "on" || __hScrollPolicy == true))
        {
            hScroller[mx.controls.scrollClasses.ScrollBar] = this.createObject("FHScrollBar", "hSB", 1001);
            specialHScrollCase = true;
        } // end if
        _l2.bottom = _l3.bottom;
        if (hScroller != undefined)
        {
            _l2.bottom = _l2.bottom + hScroller.minHeight;
        } // end if
        return (_l2);
    } // End of the function
    function doLayout(Void)
    {
        var _l10 = this.__get__width();
        var _l8 = this.__get__height();
        delete this.invLayout;
        var _l3 = __viewMetrics = this.getViewMetrics();
        var _l2 = _l3.left;
        var _l9 = _l3.right;
        var _l5 = _l3.top;
        var _l11 = _l3.bottom;
        var _l7 = hScroller;
        var _l6 = vScroller;
        _l7.setSize(_l10 - _l2 - _l9, _l7.minHeight + 0);
        _l7.move(_l2, _l8 - _l11);
        _l6.setSize(_l6.minWidth + 0, _l8 - _l5 - _l11);
        _l6.move(_l10 - _l9, _l5);
        var _l4 = mask_mc;
        _l4._width = _l10 - _l2 - _l9;
        _l4._height = _l8 - _l5 - _l11;
        _l4._x = _l2;
        _l4._y = _l5;
    } // End of the function
    function createChild(id, name, props)
    {
        var _l2 = super.createChild(id, name, props);
        return (_l2);
    } // End of the function
    function init(Void)
    {
        super.init();
        __viewMetrics = new Object();
        if (_global.__SVMouseWheelManager == undefined)
        {
            var _l4 = _global.__SVMouseWheelManager = new Object();
            _l4.onMouseWheel = __onMouseWheel;
            Mouse.addListener(_l4);
        } // end if
    } // End of the function
    function __onMouseWheel(delta, scrollTarget)
    {
        var _l4 = scrollTarget;
        var _l1;
        while (_l4 != undefined)
        {
            if (_l4 instanceof mx.core.ScrollView)
            {
                _l1 = _l4;
                false;
            } // end if
            _l4 = _l4._parent;
        } // end while
        if (_l1 != undefined)
        {
            _l4 = delta <= 0 ? (1) : (-1);
            var _l2 = _l1.vScroller.lineScrollSize;
            if (_l2 == undefined)
            {
                _l2 = 0;
            } // end if
            _l2 = Math.max(Math.abs(delta), _l2);
            var _l3 = _l1.vPosition + _l2 * _l4;
            _l1.vPosition = Math.max(0, Math.min(_l3, _l1.maxVPosition));
            _l1.dispatchEvent({type: "scroll", direction: "vertical", position: _l1.vPosition});
        } // end if
    } // End of the function
    function createChildren(Void)
    {
        super.createChildren();
        if (mask_mc == undefined)
        {
            mask_mc = this.createObject("BoundingBox", "mask_mc", MASK_DEPTH);
        } // end if
        mask_mc._visible = false;
    } // End of the function
    function invalidate(Void)
    {
        super.invalidate();
    } // End of the function
    function draw(Void)
    {
        this.size();
    } // End of the function
    function size(Void)
    {
        super.size();
    } // End of the function
    function scrollProxy(docObj)
    {
        _parent.onScroll(docObj);
    } // End of the function
    function onScroll(docObj)
    {
        var _l3 = docObj.target;
        var _l2 = _l3.scrollPosition;
        if (_l3 == vScroller)
        {
            var _l4 = "vertical";
            var _l5 = "__vPosition";
        }
        else
        {
            _l4 = "horizontal";
            _l5 = "__hPosition";
        } // end if
        this.dispatchEvent({type: "scroll", direction: _l4, position: _l2});
        _l5 = _l2;
    } // End of the function
    function setEnabled(v)
    {
        vScroller.enabled = hScroller.enabled = v;
    } // End of the function
    function childLoaded(obj)
    {
        super.childLoaded(obj);
        obj.setMask(mask_mc);
    } // End of the function
    static var symbolName = "ScrollView";
    static var symbolOwner = mx.core.ScrollView;
    static var version = "2.0.1.78";
    var className = "ScrollView";
    var __vScrollPolicy = "auto";
    var __hScrollPolicy = "off";
    var __vPosition = 0;
    var __hPosition = 0;
    var numberOfCols = 0;
    var rowC = 0;
    var columnWidth = 1;
    var rowH = 0;
    var heightPadding = 0;
    var widthPadding = 0;
    var MASK_DEPTH = 10000;
} // End of Class
