class mx.controls.List extends mx.controls.listclasses.ScrollSelectList
{
    var border_mc, __labels, __dataProvider, roundUp, __maxHPosition, invScrollProps, __vPosition, __rowHeight, __width, totalWidth, totalHeight, displayWidth, __hScrollPolicy, vScroller, __hPosition, listContent, labels, data, mask_mc, __height, __rowCount, invRowHeight, invLayoutContent, oldVWidth;
    function List()
    {
        super();
    } // End of the function
    function setEnabled(v)
    {
        super.setEnabled(v);
        border_mc.backgroundColorName = v ? ("backgroundColor") : ("backgroundDisabledColor");
        border_mc.invalidate();
    } // End of the function
    function __get__labels()
    {
        return (__labels);
    } // End of the function
    function __set__labels(lbls)
    {
        __labels = lbls;
        this.setDataProvider(lbls);
        return (this.__get__labels());
        null;
    } // End of the function
    function setVPosition(pos)
    {
        var _l3 = Math.min(__dataProvider.length - this.__get__rowCount() + roundUp, pos);
        _l3 = Math.max(0, _l3);
        super.setVPosition(_l3);
    } // End of the function
    function setHPosition(pos)
    {
        var _l3 = Math.max(Math.min(__maxHPosition, pos), 0);
        super.setHPosition(_l3);
        this.hScroll(_l3);
    } // End of the function
    function setMaxHPosition(pos)
    {
        __maxHPosition = pos;
        invScrollProps = true;
        this.invalidate();
    } // End of the function
    function setHScrollPolicy(policy)
    {
        if (policy.toLowerCase() == "auto" && !autoHScrollAble)
        {
            return (undefined);
        } // end if
        super.setHScrollPolicy(policy);
        if (policy == "off")
        {
            this.setHPosition(0);
            this.setVPosition(Math.min(__dataProvider.length - this.__get__rowCount() + roundUp, __vPosition));
        } // end if
    } // End of the function
    function setRowCount(rC)
    {
        if (isNaN(rC))
        {
            return (undefined);
        } // end if
        var _l2 = this.getViewMetrics();
        this.setSize(__width, __rowHeight * rC + _l2.top + _l2.bottom);
    } // End of the function
    function layoutContent(x, y, tW, tH, dW, dH)
    {
        totalWidth = tW;
        totalHeight = tH;
        displayWidth = dW;
        var _l4 = __hScrollPolicy == "on" || __hScrollPolicy == "auto" ? (Math.max(tW, dW)) : (dW);
        super.layoutContent(x, y, _l4, dH);
    } // End of the function
    function modelChanged(eventObj)
    {
        super.modelChanged(eventObj);
        var _l3 = eventObj.eventName;
        if (_l3 == "addItems" || _l3 == "removeItems" || _l3 == "updateAll" || _l3 == "filterModel")
        {
            invScrollProps = true;
            this.invalidate("invScrollProps");
        } // end if
    } // End of the function
    function onScroll(eventObj)
    {
        var _l3 = eventObj.target;
        if (_l3 == vScroller)
        {
            this.setVPosition(_l3.scrollPosition);
        }
        else
        {
            this.hScroll(_l3.scrollPosition);
        } // end if
        super.onScroll(eventObj);
    } // End of the function
    function hScroll(pos)
    {
        __hPosition = pos;
        listContent._x = -pos;
    } // End of the function
    function init(Void)
    {
        super.init();
        if (labels.length > 0)
        {
            var _l6 = new Array();
            var _l3 = 0;
            while (_l3 < labels.length)
            {
                _l6.addItem({label: labels[_l3], data: data[_l3]});
                ++_l3;
            } // end while
            this.setDataProvider(_l6);
        } // end if
        __maxHPosition = 0;
    } // End of the function
    function createChildren(Void)
    {
        super.createChildren();
        listContent.setMask(mask_mc);
        border_mc.move(0, 0);
        border_mc.setSize(__width, __height);
    } // End of the function
    function getRowCount(Void)
    {
        var _l2 = this.getViewMetrics();
        return (__rowCount == 0 ? (Math.ceil((__height - _l2.top - _l2.bottom) / __rowHeight)) : (__rowCount));
    } // End of the function
    function size(Void)
    {
        super.size();
        this.configureScrolling();
        var _l3 = this.getViewMetrics();
        this.layoutContent(_l3.left, _l3.top, __width + __maxHPosition, totalHeight, __width - _l3.left - _l3.right, __height - _l3.top - _l3.bottom);
    } // End of the function
    function draw(Void)
    {
        if (invRowHeight)
        {
            invScrollProps = true;
            super.draw();
            listContent.setMask(mask_mc);
            invLayoutContent = true;
        } // end if
        if (invScrollProps)
        {
            this.configureScrolling();
            delete this.invScrollProps;
        } // end if
        if (invLayoutContent)
        {
            var _l3 = this.getViewMetrics();
            this.layoutContent(_l3.left, _l3.top, __width + __maxHPosition, totalHeight, __width - _l3.left - _l3.right, __height - _l3.top - _l3.bottom);
        } // end if
        super.draw();
    } // End of the function
    function configureScrolling(Void)
    {
        var _l2 = __dataProvider.length;
        if (__vPosition > Math.max(0, _l2 - this.getRowCount() + roundUp))
        {
            this.setVPosition(Math.max(0, Math.min(_l2 - this.getRowCount() + roundUp, __vPosition)));
        } // end if
        var _l3 = this.getViewMetrics();
        var _l4 = __hScrollPolicy != "off" ? (__maxHPosition + __width - _l3.left - _l3.right) : (__width - _l3.left - _l3.right);
        if (_l2 == undefined)
        {
            _l2 = 0;
        } // end if
        this.setScrollProperties(_l4, 1, _l2, __rowHeight);
        if (oldVWidth != _l4)
        {
            invLayoutContent = true;
        } // end if
        oldVWidth = _l4;
    } // End of the function
    static var symbolOwner = mx.controls.List;
    static var symbolName = "List";
    var className = "List";
    static var version = "2.0.1.78";
    var clipParameters = {rowHeight: 1, enabled: 1, visible: 1, labels: 1};
    var scrollDepth = 1;
    var __vScrollPolicy = "on";
    var autoHScrollAble = false;
} // End of Class
