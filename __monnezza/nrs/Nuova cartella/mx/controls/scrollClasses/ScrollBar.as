class mx.controls.scrollClasses.ScrollBar extends mx.core.UIComponent
{
    var isScrolling, scrollTrack_mc, scrollThumb_mc, __height, tabEnabled, focusEnabled, boundingBox_mc, upArrow_mc, _minHeight, _minWidth, downArrow_mc, enabled, _height, minMode, maxMode, plusMode, minusMode, _parent, scrolling, _ymouse;
    function ScrollBar()
    {
        super();
    } // End of the function
    function __get__scrollPosition()
    {
        return (_scrollPosition);
    } // End of the function
    function __set__scrollPosition(pos)
    {
        _scrollPosition = pos;
        if (isScrolling != true)
        {
            var _l2 = Math.min(pos, maxPos);
            _l2 = Math.max(_l2, minPos);
            var _l3 = (_l2 - minPos) * (scrollTrack_mc.height - scrollThumb_mc._height) / (maxPos - minPos) + scrollTrack_mc.top;
            scrollThumb_mc.move(0, _l3);
        } // end if
        return (this.__get__scrollPosition());
        null;
    } // End of the function
    function __get__pageScrollSize()
    {
        return (largeScroll);
    } // End of the function
    function __set__pageScrollSize(lScroll)
    {
        largeScroll = lScroll;
        return (this.__get__pageScrollSize());
        null;
    } // End of the function
    function __set__lineScrollSize(sScroll)
    {
        smallScroll = sScroll;
        return (this.__get__lineScrollSize());
        null;
    } // End of the function
    function __get__lineScrollSize()
    {
        return (smallScroll);
    } // End of the function
    function __get__virtualHeight()
    {
        return (__height);
    } // End of the function
    function init(Void)
    {
        super.init();
        _scrollPosition = 0;
        tabEnabled = false;
        focusEnabled = false;
        boundingBox_mc._visible = false;
        boundingBox_mc._width = boundingBox_mc._height = 0;
    } // End of the function
    function createChildren(Void)
    {
        if (scrollTrack_mc == undefined)
        {
            this.setSkin(mx.controls.scrollClasses.ScrollBar.skinIDTrack, scrollTrackName);
        } // end if
        scrollTrack_mc.visible = false;
        var _l3 = new Object();
        _l3.enabled = false;
        _l3.preset = mx.controls.SimpleButton.falseDisabled;
        _l3.initProperties = 0;
        _l3.autoRepeat = true;
        _l3.tabEnabled = false;
        var _l2;
        if (upArrow_mc == undefined)
        {
            _l2 = this.createButton(upArrowName, "upArrow_mc", mx.controls.scrollClasses.ScrollBar.skinIDUpArrow, _l3);
        } // end if
        _l2.buttonDownHandler = onUpArrow;
        _l2.clickHandler = onScrollChanged;
        _minHeight = _l2.height;
        _minWidth = _l2.width;
        if (downArrow_mc == undefined)
        {
            _l2 = this.createButton(downArrowName, "downArrow_mc", mx.controls.scrollClasses.ScrollBar.skinIDDownArrow, _l3);
        } // end if
        _l2.buttonDownHandler = onDownArrow;
        _l2.clickHandler = onScrollChanged;
        _minHeight = _minHeight + _l2.height;
    } // End of the function
    function createButton(linkageName, id, skinID, o)
    {
        if (mx.controls.scrollClasses.ScrollBar.skinIDUpArrow == skinID)
        {
            o.falseUpSkin = upArrowUpName;
            o.falseDownSkin = upArrowDownName;
            o.falseOverSkin = upArrowOverName;
        }
        else
        {
            o.falseUpSkin = downArrowUpName;
            o.falseDownSkin = downArrowDownName;
            o.falseOverSkin = downArrowOverName;
        } // end if
        var _l3 = this.createObject(linkageName, id, skinID, o);
        this[id].visible = false;
        this[id].useHandCursor = false;
        return (_l3);
    } // End of the function
    function createThumb(Void)
    {
        var _l2 = new Object();
        _l2.validateNow = true;
        _l2.tabEnabled = false;
        _l2.leftSkin = thumbTopName;
        _l2.middleSkin = thumbMiddleName;
        _l2.rightSkin = thumbBottomName;
        _l2.gripSkin = thumbGripName;
        this.createClassObject(mx.controls.scrollClasses.ScrollThumb, "scrollThumb_mc", mx.controls.scrollClasses.ScrollBar.skinIDThumb, _l2);
    } // End of the function
    function setScrollProperties(pSize, mnPos, mxPos, ls)
    {
        var _l4;
        var _l2 = scrollTrack_mc;
        pageSize = pSize;
        largeScroll = ls != undefined && ls > 0 ? (ls) : (pSize);
        minPos = Math.max(mnPos, 0);
        maxPos = Math.max(mxPos, 0);
        _scrollPosition = Math.max(minPos, _scrollPosition);
        _scrollPosition = Math.min(maxPos, _scrollPosition);
        if (maxPos - minPos > 0 && enabled)
        {
            var _l5 = _scrollPosition;
            if (!initializing)
            {
                upArrow_mc.enabled = true;
                downArrow_mc.enabled = true;
            } // end if
            _l2.onPress = _l2.onDragOver = startTrackScroller;
            _l2.onRelease = releaseScrolling;
            _l2.onDragOut = _l2.stopScrolling = stopScrolling;
            _l2.onReleaseOutside = releaseScrolling;
            _l2.useHandCursor = false;
            if (scrollThumb_mc == undefined)
            {
                this.createThumb();
            } // end if
            var _l3 = scrollThumb_mc;
            if (scrollTrackOverName.length > 0)
            {
                _l2.onRollOver = trackOver;
                _l2.onRollOut = trackOut;
            } // end if
            _l4 = pageSize / (maxPos - minPos + pageSize) * _l2.height;
            if (_l4 < _l3.minHeight)
            {
                if (_l2.height < _l3.minHeight)
                {
                    _l3.__set__visible(false);
                }
                else
                {
                    _l4 = _l3.minHeight;
                    _l3.__set__visible(true);
                    _l3.setSize(_minWidth, _l3.minHeight + 0);
                } // end if
            }
            else
            {
                _l3.__set__visible(true);
                _l3.setSize(_minWidth, _l4);
            } // end if
            _l3.setRange(upArrow_mc.__get__height() + 0, this.__get__virtualHeight() - downArrow_mc.__get__height() - _l3.__get__height(), minPos, maxPos);
            _l5 = Math.min(_l5, maxPos);
            this.__set__scrollPosition(Math.max(_l5, minPos));
        }
        else
        {
            scrollThumb_mc.__set__visible(false);
            if (!initializing)
            {
                upArrow_mc.enabled = false;
                downArrow_mc.enabled = false;
            } // end if
            delete _l2.onPress;
            delete _l2.onDragOver;
            delete _l2.onRelease;
            delete _l2.onDragOut;
            delete _l2.onRollOver;
            delete _l2.onRollOut;
            delete _l2.onReleaseOutside;
        } // end if
        if (initializing)
        {
            scrollThumb_mc.__set__visible(false);
        } // end if
    } // End of the function
    function setEnabled(enabledFlag)
    {
        super.setEnabled(enabledFlag);
        this.setScrollProperties(pageSize, minPos, maxPos, largeScroll);
    } // End of the function
    function draw(Void)
    {
        if (initializing)
        {
            initializing = false;
            scrollTrack_mc.visible = true;
            upArrow_mc.__set__visible(true);
            downArrow_mc.__set__visible(true);
        } // end if
        this.size();
    } // End of the function
    function size(Void)
    {
        if (_height == 1)
        {
            return (undefined);
        } // end if
        if (upArrow_mc == undefined)
        {
            return (undefined);
        } // end if
        var _l3 = upArrow_mc.__get__height();
        var _l2 = downArrow_mc.__get__height();
        upArrow_mc.move(0, 0);
        var _l4 = scrollTrack_mc;
        _l4._y = _l3;
        _l4._height = this.__get__virtualHeight() - _l3 - _l2;
        downArrow_mc.move(0, this.__get__virtualHeight() - _l2);
        this.setScrollProperties(pageSize, minPos, maxPos, largeScroll);
    } // End of the function
    function dispatchScrollEvent(detail)
    {
        this.dispatchEvent({type: "scroll", detail: detail});
    } // End of the function
    function isScrollBarKey(k)
    {
        if (k == 36)
        {
            if (this.__get__scrollPosition() != 0)
            {
                this.__set__scrollPosition(0);
                this.dispatchScrollEvent(minMode);
            } // end if
            return (true);
        }
        else if (k == 35)
        {
            if (this.__get__scrollPosition() < maxPos)
            {
                this.__set__scrollPosition(maxPos);
                this.dispatchScrollEvent(maxMode);
            } // end if
            return (true);
        } // end if
        return (false);
    } // End of the function
    function scrollIt(inc, mode)
    {
        var _l3 = smallScroll;
        if (inc != "Line")
        {
            _l3 = largeScroll == 0 ? (pageSize) : (largeScroll);
        } // end if
        var _l2 = _scrollPosition + mode * _l3;
        if (_l2 > maxPos)
        {
            _l2 = maxPos;
        }
        else if (_l2 < minPos)
        {
            _l2 = minPos;
        } // end if
        if (this.__get__scrollPosition() != _l2)
        {
            this.__set__scrollPosition(_l2);
            var _l4 = mode < 0 ? (minusMode) : (plusMode);
            this.dispatchScrollEvent(inc + _l4);
        } // end if
    } // End of the function
    function startTrackScroller(Void)
    {
        _parent.pressFocus();
        if (_parent.scrollTrackDownName.length > 0)
        {
            if (_parent.scrollTrackDown_mc == undefined)
            {
                _parent.setSkin(mx.controls.scrollClasses.ScrollBar.skinIDTrackDown, scrollTrackDownName);
            }
            else
            {
                _parent.scrollTrackDown_mc.visible = true;
            } // end if
        } // end if
        _parent.trackScroller();
        _parent.scrolling = setInterval(_parent, "scrollInterval", this.getStyle("repeatDelay"), "Page", -1);
    } // End of the function
    function scrollInterval(inc, mode)
    {
        clearInterval(scrolling);
        if (inc == "Page")
        {
            this.trackScroller();
        }
        else
        {
            this.scrollIt(inc, mode);
        } // end if
        scrolling = setInterval(this, "scrollInterval", this.getStyle("repeatInterval"), inc, mode);
    } // End of the function
    function trackScroller(Void)
    {
        if (scrollThumb_mc._y + scrollThumb_mc.__get__height() < _ymouse)
        {
            this.scrollIt("Page", 1);
        }
        else if (scrollThumb_mc._y > _ymouse)
        {
            this.scrollIt("Page", -1);
        } // end if
    } // End of the function
    function dispatchScrollChangedEvent(Void)
    {
        this.dispatchEvent({type: "scrollChanged"});
    } // End of the function
    function stopScrolling(Void)
    {
        clearInterval(_parent.scrolling);
        _parent.scrollTrackDown_mc.visible = false;
    } // End of the function
    function releaseScrolling(Void)
    {
        _parent.releaseFocus();
        this.stopScrolling();
        _parent.dispatchScrollChangedEvent();
    } // End of the function
    function trackOver(Void)
    {
        if (_parent.scrollTrackOverName.length > 0)
        {
            if (_parent.scrollTrackOver_mc == undefined)
            {
                _parent.setSkin(mx.controls.scrollClasses.ScrollBar.skinIDTrackOver, scrollTrackOverName);
            }
            else
            {
                _parent.scrollTrackOver_mc.visible = true;
            } // end if
        } // end if
    } // End of the function
    function trackOut(Void)
    {
        _parent.scrollTrackOver_mc.visible = false;
    } // End of the function
    function onUpArrow(Void)
    {
        _parent.scrollIt("Line", -1);
    } // End of the function
    function onDownArrow(Void)
    {
        _parent.scrollIt("Line", 1);
    } // End of the function
    function onScrollChanged(Void)
    {
        _parent.dispatchScrollChangedEvent();
    } // End of the function
    static var symbolOwner = mx.core.UIComponent;
    var className = "ScrollBar";
    var minPos = 0;
    var maxPos = 0;
    var pageSize = 0;
    var largeScroll = 0;
    var smallScroll = 1;
    var _scrollPosition = 0;
    var scrollTrackName = "ScrollTrack";
    var scrollTrackOverName = "";
    var scrollTrackDownName = "";
    var upArrowName = "BtnUpArrow";
    var upArrowUpName = "ScrollUpArrowUp";
    var upArrowOverName = "ScrollUpArrowOver";
    var upArrowDownName = "ScrollUpArrowDown";
    var downArrowName = "BtnDownArrow";
    var downArrowUpName = "ScrollDownArrowUp";
    var downArrowOverName = "ScrollDownArrowOver";
    var downArrowDownName = "ScrollDownArrowDown";
    var thumbTopName = "ScrollThumbTopUp";
    var thumbMiddleName = "ScrollThumbMiddleUp";
    var thumbBottomName = "ScrollThumbBottomUp";
    var thumbGripName = "ScrollThumbGripUp";
    static var skinIDTrack = 0;
    static var skinIDTrackOver = 1;
    static var skinIDTrackDown = 2;
    static var skinIDUpArrow = 3;
    static var skinIDDownArrow = 4;
    static var skinIDThumb = 5;
    var idNames = new Array("scrollTrack_mc", "scrollTrackOver_mc", "scrollTrackDown_mc", "upArrow_mc", "downArrow_mc");
    var clipParameters = {minPos: 1, maxPos: 1, pageSize: 1, scrollPosition: 1, lineScrollSize: 1, pageScrollSize: 1, visible: 1, enabled: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.controls.scrollClasses.ScrollBar.prototype.clipParameters, mx.core.UIComponent.prototype.clipParameters);
    var initializing = true;
} // End of Class
