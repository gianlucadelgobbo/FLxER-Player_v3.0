class mx.core.View extends mx.core.UIComponent
{
    var tabChildren, tabEnabled, boundingBox_mc, border_mc, __tabIndex, depth, mx.core.View.childNameBase + this.__get__numChildren(), mx.core.View.childNameBase + _l2;
    function View()
    {
        super();
    } // End of the function
    function init()
    {
        super.init();
        tabChildren = true;
        tabEnabled = false;
        boundingBox_mc._visible = false;
        boundingBox_mc._width = boundingBox_mc._height = 0;
    } // End of the function
    function size()
    {
        border_mc.move(0, 0);
        border_mc.setSize(this.__get__width(), this.__get__height());
        this.doLayout();
    } // End of the function
    function draw()
    {
        this.size();
    } // End of the function
    function __get__numChildren()
    {
        var _l3 = mx.core.View.childNameBase;
        var _l2 = 0;
        while (true)
        {
            if (this[_l3 + _l2] == undefined)
            {
                return (_l2);
            } // end if
            ++_l2;
        } // end while
        return (-1);
    } // End of the function
    function __get__tabIndex()
    {
        return (tabEnabled ? (__tabIndex) : (undefined));
    } // End of the function
    function __set__tabIndex(n)
    {
        __tabIndex = n;
        return (this.__get__tabIndex());
        null;
    } // End of the function
    function addLayoutObject(object)
    {
    } // End of the function
    function createChild(className, instanceName, initProps)
    {
        if (depth == undefined)
        {
            depth = 1;
        } // end if
        var _l2;
        if (typeof(className) == "string")
        {
            _l2 = this.createObject(className, instanceName, depth++, initProps);
        }
        else
        {
            _l2 = this.createClassObject(className, instanceName, depth++, initProps);
        } // end if
        if (_l2 == undefined)
        {
            _l2 = this.loadExternal(className, _loadExternalClass, instanceName, depth++, initProps);
        }
        else
        {
            set(mx.core.View.childNameBase + this.__get__numChildren(), _l2);
            _l2._complete = true;
            this.childLoaded(_l2);
        } // end if
        this.addLayoutObject(_l2);
        return (_l2);
    } // End of the function
    function getChildAt(childIndex)
    {
        return (this[mx.core.View.childNameBase + childIndex]);
    } // End of the function
    function destroyChildAt(childIndex)
    {
        if (!(childIndex >= 0 && this.__get__numChildren() > childIndex))
        {
            return (undefined);
        } // end if
        var _l4 = mx.core.View.childNameBase + childIndex;
        var _l6 = this.__get__numChildren();
        var _l3;
        for (var _l3 in this)
        {
            if (_l3 == _l4)
            {
                _l4 = "";
                this.destroyObject(_l3);
            }
            else
            {
            } // end if
        } // end of for...in
        var _l2 = Number(childIndex);
        while (_l2 < _l6 - 1)
        {
            set(mx.core.View.childNameBase + _l2, this[mx.core.View.childNameBase + (_l2 + 1)]);
            ++_l2;
        } // end while
        delete this[mx.core.View.childNameBase + (_l6 - 1)];
        --depth;
    } // End of the function
    function initLayout()
    {
        if (!hasBeenLayedOut)
        {
            this.doLayout();
        } // end if
    } // End of the function
    function doLayout()
    {
        hasBeenLayedOut = true;
    } // End of the function
    function createChildren()
    {
        if (border_mc == undefined)
        {
            border_mc = this.createClassChildAtDepth(_global.styles.rectBorderClass, mx.managers.DepthManager.kBottom, {styleName: this});
        } // end if
        this.doLater(this, "initLayout");
    } // End of the function
    function convertToUIObject(obj)
    {
    } // End of the function
    function childLoaded(obj)
    {
        this.convertToUIObject(obj);
    } // End of the function
    static function extension()
    {
        mx.core.ExternalContent.enableExternalContent();
    } // End of the function
    static var symbolName = "View";
    static var symbolOwner = mx.core.View;
    static var version = "2.0.1.78";
    var className = "View";
    static var childNameBase = "_child";
    var hasBeenLayedOut = false;
    var _loadExternalClass = "UIComponent";
} // End of Class
