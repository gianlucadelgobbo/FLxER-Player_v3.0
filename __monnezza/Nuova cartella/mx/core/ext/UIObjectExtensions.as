class mx.core.ext.UIObjectExtensions
{
    var getTopLevel, createLabel, createObject, createClassObject, createEmptyObject, destroyObject, __getTextFormat, getStyleName, getStyle, __enabled, move, setSize, invalidateFlag, embedFonts, __text, text, _visible, textColor, stylecache, enabledColor, textWidth, textHeight, align;
    function UIObjectExtensions()
    {
    } // End of the function
    static function addGeometry(tf, ui)
    {
        tf.addProperty("width", ui.__get__width, null);
        tf.addProperty("height", ui.__get__height, null);
        tf.addProperty("left", ui.__get__left, null);
        tf.addProperty("x", ui.__get__x, null);
        tf.addProperty("top", ui.__get__top, null);
        tf.addProperty("y", ui.__get__y, null);
        tf.addProperty("right", ui.__get__right, null);
        tf.addProperty("bottom", ui.__get__bottom, null);
        tf.addProperty("visible", ui.__get__visible, ui.__set__visible);
    } // End of the function
    static function Extensions()
    {
        if (mx.core.ext.UIObjectExtensions.bExtended == true)
        {
            return (true);
        } // end if
        mx.core.ext.UIObjectExtensions.bExtended = true;
        mx.core.ext.UIObjectExtensions.addGeometry(, );
        mx.events.UIEventDispatcher.initialize();
        var _l13 = mx.skins.ColoredSkinElement;
        mx.styles.CSSTextStyles.addTextStyles();
        getTopLevel = .getTopLevel;
        createLabel = .createLabel;
        createObject = .createObject;
        createClassObject = .createClassObject;
        createEmptyObject = .createEmptyObject;
        destroyObject = .destroyObject;
        _global.ASSetPropFlags(, "getTopLevel", 1);
        _global.ASSetPropFlags(, "createLabel", 1);
        _global.ASSetPropFlags(, "createObject", 1);
        _global.ASSetPropFlags(, "createClassObject", 1);
        _global.ASSetPropFlags(, "createEmptyObject", 1);
        _global.ASSetPropFlags(, "destroyObject", 1);
        __getTextFormat = .__getTextFormat;
        _getTextFormat = ._getTextFormat;
        getStyleName = .getStyleName;
        getStyle = .getStyle;
        _global.ASSetPropFlags(, "__getTextFormat", 1);
        _global.ASSetPropFlags(, "_getTextFormat", 1);
        _global.ASSetPropFlags(, "getStyleName", 1);
        _global.ASSetPropFlags(, "getStyle", 1);
        mx.core.ext.UIObjectExtensions.addGeometry(, );
        .addProperty("enabled", function ()
        {
            return (__enabled);
        }, function (x)
        {
            __enabled = x;
            this.invalidateStyle();
        });
        move = .move;
        setSize = .setSize;
        function invalidateStyle()
        {
            invalidateFlag = true;
        } // End of the function
        function draw()
        {
            if (invalidateFlag)
            {
                invalidateFlag = false;
                var _l2 = this._getTextFormat();
                this.setTextFormat(_l2);
                this.setNewTextFormat(_l2);
                embedFonts = _l2.embedFonts == true;
                if (__text != undefined)
                {
                    if (text == "")
                    {
                        text = __text;
                    } // end if
                    delete this.__text;
                } // end if
                _visible = true;
            } // end if
        } // End of the function
        function setColor(color)
        {
            textColor = color;
        } // End of the function
        getStyle = .getStyle;
        __getTextFormat = .__getTextFormat;
        function setValue(v)
        {
            text = v;
        } // End of the function
        function getValue()
        {
            return (text);
        } // End of the function
        .addProperty("value", function ()
        {
            return (this.getValue());
        }, function (v)
        {
            this.setValue(v);
        });
        function _getTextFormat()
        {
            var _l2 = stylecache.tf;
            if (_l2 != undefined)
            {
                return (_l2);
            } // end if
            _l2 = new TextFormat();
            this.__getTextFormat(_l2);
            stylecache.tf = _l2;
            if (__enabled == false)
            {
                if (enabledColor == undefined)
                {
                    var _l4 = this.getTextFormat();
                    enabledColor = _l4.color;
                } // end if
                var _l3 = this.getStyle("disabledColor");
                _l2.color = _l3;
            }
            else if (enabledColor != undefined)
            {
                if (_l2.color == undefined)
                {
                    _l2.color = enabledColor;
                } // end if
            } // end if
            return (_l2);
        } // End of the function
        function getPreferredWidth()
        {
            this.draw();
            return (textWidth + 4);
        } // End of the function
        function getPreferredHeight()
        {
            this.draw();
            return (textHeight + 4);
        } // End of the function
        TextFormat.prototype.getTextExtent2 = function (s)
        {
            var _l3 = _root._getTextExtent;
            if (_l3 == undefined)
            {
                _root.createTextField("_getTextExtent", -2, 0, 0, 1000, 100);
                _l3 = _root._getTextExtent;
                _l3._visible = false;
            } // end if
            _root._getTextExtent.text = s;
            var _l4 = align;
            align = "left";
            _root._getTextExtent.setTextFormat(this);
            align = _l4;
            return ({width: _l3.textWidth, height: _l3.textHeight});
        };
        if (_l3.style == undefined)
        {
            _l3.style = new mx.styles.CSSStyleDeclaration();
            _l3.cascadingStyles = true;
            _l3.styles = new Object();
            _l3.skinRegistry = new Object();
            if (_l3._origWidth == undefined)
            {
                _l3.origWidth = Stage.width;
                _l3.origHeight = Stage.height;
            } // end if
        } // end if
        _l4 = _root;
        while (_l4._parent != undefined)
        {
            _l4 = _l4._parent;
        } // end while
        _l4.addProperty("width", function ()
        {
            return (Stage.width);
        }, null);
        _l4.addProperty("height", function ()
        {
            return (Stage.height);
        }, null);
        _l3.ASSetPropFlags(_l4, "width", 1);
        _l3.ASSetPropFlags(_l4, "height", 1);
        return (true);
    } // End of the function
    static var bExtended = false;
    static var UIObjectExtended = mx.core.ext.UIObjectExtensions.Extensions();
    static var UIObjectDependency = mx.core.UIObject;
    static var SkinElementDependency = mx.skins.SkinElement;
    static var CSSTextStylesDependency = mx.styles.CSSTextStyles;
    static var UIEventDispatcherDependency = mx.events.UIEventDispatcher;
} // End of Class
