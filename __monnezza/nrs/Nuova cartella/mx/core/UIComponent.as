class mx.core.UIComponent extends mx.core.UIObject
{
    var __width, __height, stylecache, _xscale, _yscale, _focusrect, enabled;
    function UIComponent()
    {
        super();
    } // End of the function
    function __get__width()
    {
        return (__width);
    } // End of the function
    function __get__height()
    {
        return (__height);
    } // End of the function
    function setVisible(x, noEvent)
    {
        super.setVisible(x, noEvent);
    } // End of the function
    function enabledChanged(id, oldValue, newValue)
    {
        this.setEnabled(newValue);
        this.invalidate();
        delete stylecache.tf;
        return (newValue);
    } // End of the function
    function setEnabled(enabled)
    {
        this.invalidate();
    } // End of the function
    function getFocus()
    {
        var selFocus = Selection.getFocus();
        return (selFocus === null ? (null) : (selFocus));
    } // End of the function
    function setFocus()
    {
        Selection.setFocus(this);
    } // End of the function
    function getFocusManager()
    {
        var _l2 = this;
        while (_l2 != undefined)
        {
            if (_l2.focusManager != undefined)
            {
                return (_l2.focusManager);
            } // end if
            _l2 = _l2._parent;
        } // end while
        return (undefined);
    } // End of the function
    function onKillFocus(newFocus)
    {
        this.removeEventListener("keyDown", this);
        this.removeEventListener("keyUp", this);
        this.dispatchEvent({type: "focusOut"});
        this.drawFocus(false);
    } // End of the function
    function onSetFocus(oldFocus)
    {
        this.addEventListener("keyDown", this);
        this.addEventListener("keyUp", this);
        this.dispatchEvent({type: "focusIn"});
        if (this.getFocusManager().bDrawFocus != false)
        {
            this.drawFocus(true);
        } // end if
    } // End of the function
    function findFocusInChildren(o)
    {
        if (o.focusTextField != undefined)
        {
            return (o.focusTextField);
        } // end if
        if (o.tabEnabled == true)
        {
            return (o);
        } // end if
        return (undefined);
    } // End of the function
    function findFocusFromObject(o)
    {
        if (o.tabEnabled != true)
        {
            if (o._parent == undefined)
            {
                return (undefined);
            } // end if
            if (o._parent.tabEnabled == true)
            {
                var _l2 = o._parent;
            }
            else if (_l2._parent.tabChildren)
            {
                _l2 = this.findFocusInChildren(_l2._parent);
            }
            else
            {
                _l2 = this.findFocusFromObject(_l2._parent);
            } // end if
        } // end if
        return (_l2);
    } // End of the function
    function pressFocus()
    {
        var _l3 = this.findFocusFromObject(this);
        var _l2 = this.getFocus();
        if (_l3 != _l2)
        {
            _l2.drawFocus(false);
            if (this.getFocusManager().bDrawFocus != false)
            {
                _l3.drawFocus(true);
            } // end if
        } // end if
    } // End of the function
    function releaseFocus()
    {
        var _l2 = this.findFocusFromObject(this);
        if (_l2 != this.getFocus())
        {
            _l2.setFocus();
        } // end if
    } // End of the function
    function isParent(o)
    {
        while (o != undefined)
        {
            if (o == this)
            {
                return (true);
            } // end if
            var _l2 = o._parent;
        } // end while
        return (false);
    } // End of the function
    function size()
    {
    } // End of the function
    function init()
    {
        super.init();
        _xscale = 100;
        _yscale = 100;
        _focusrect = _global.useFocusRect == false;
        this.watch("enabled", enabledChanged);
        if (enabled == false)
        {
            this.setEnabled(false);
        } // end if
    } // End of the function
    function dispatchValueChangedEvent(value)
    {
        this.dispatchEvent({type: "valueChanged", value: value});
    } // End of the function
    static var symbolName = "UIComponent";
    static var symbolOwner = mx.core.UIComponent;
    static var version = "2.0.1.78";
    static var kStretch = 5000;
    var focusEnabled = true;
    var tabEnabled = true;
    var origBorderStyles = {themeColor: 16711680};
    var clipParameters = {};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.core.UIComponent.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
} // End of Class
