class mx.core.UIObject extends MovieClip
{
    var _width, _height, _x, _y, _parent, _minHeight, _minWidth, _visible, _xscale, _yscale, methodTable, onEnterFrame, tfList, __width, __height, idNames, childrenCreated, _name, validateNow, "def_" + _l2, _l2, initProperties, stylecache, className, ignoreClassStyleDeclaration, _tf, fontFamily, fontSize, color, marginLeft, marginRight, fontStyle, fontWeight, textAlign, textIndent, textDecoration, embedFonts, styleName, enabled;
    function UIObject()
    {
        super();
        this.constructObject();
    } // End of the function
    function __get__width()
    {
        return (_width);
    } // End of the function
    function __get__height()
    {
        return (_height);
    } // End of the function
    function __get__left()
    {
        return (_x);
    } // End of the function
    function __get__x()
    {
        return (_x);
    } // End of the function
    function __get__top()
    {
        return (_y);
    } // End of the function
    function __get__y()
    {
        return (_y);
    } // End of the function
    function __get__right()
    {
        return (_parent.width - (_x + this.__get__width()));
    } // End of the function
    function __get__bottom()
    {
        return (_parent.height - (_y + this.__get__height()));
    } // End of the function
    function getMinHeight(Void)
    {
        return (_minHeight);
    } // End of the function
    function setMinHeight(h)
    {
        _minHeight = h;
    } // End of the function
    function __get__minHeight()
    {
        return (this.getMinHeight());
    } // End of the function
    function __set__minHeight(h)
    {
        this.setMinHeight(h);
        return (this.__get__minHeight());
        null;
    } // End of the function
    function getMinWidth(Void)
    {
        return (_minWidth);
    } // End of the function
    function setMinWidth(w)
    {
        _minWidth = w;
    } // End of the function
    function __get__minWidth()
    {
        return (this.getMinWidth());
    } // End of the function
    function __set__minWidth(w)
    {
        this.setMinWidth(w);
        return (this.__get__minWidth());
        null;
    } // End of the function
    function setVisible(x, noEvent)
    {
        if (_visible != x)
        {
            _visible = x;
            if (noEvent != true)
            {
                this.dispatchEvent({type: x ? ("reveal") : ("hide")});
            } // end if
        } // end if
    } // End of the function
    function __get__visible()
    {
        return (_visible);
    } // End of the function
    function __set__visible(x)
    {
        this.setVisible(x, false);
        return (this.__get__visible());
        null;
    } // End of the function
    function __get__scaleX()
    {
        return (_xscale);
    } // End of the function
    function __set__scaleX(x)
    {
        _xscale = x;
        return (this.__get__scaleX());
        null;
    } // End of the function
    function __get__scaleY()
    {
        return (_yscale);
    } // End of the function
    function __set__scaleY(y)
    {
        _yscale = y;
        return (this.__get__scaleY());
        null;
    } // End of the function
    function doLater(obj, fn)
    {
        if (methodTable == undefined)
        {
            methodTable = new Array();
        } // end if
        methodTable.push({obj: obj, fn: fn});
        onEnterFrame = doLaterDispatcher;
    } // End of the function
    function doLaterDispatcher(Void)
    {
        delete this.onEnterFrame;
        if (invalidateFlag)
        {
            this.redraw();
        } // end if
        var _l3 = methodTable;
        methodTable = new Array();
        if (_l3.length > 0)
        {
            var _l2;
            _l2 = _l3.shift();
            if (_l3.shift() != undefined)
            {
                _l2.obj[_l2.fn]();
                
            } // end if
        } // end if
    } // End of the function
    function cancelAllDoLaters(Void)
    {
        delete this.onEnterFrame;
        methodTable = new Array();
    } // End of the function
    function invalidate(Void)
    {
        invalidateFlag = true;
        onEnterFrame = doLaterDispatcher;
    } // End of the function
    function invalidateStyle(Void)
    {
        this.invalidate();
    } // End of the function
    function redraw(bAlways)
    {
        if (invalidateFlag || bAlways)
        {
            invalidateFlag = false;
            var _l2;
            for (var _l2 in tfList)
            {
                tfList[_l2].draw();
            } // end of for...in
            this.draw();
            this.dispatchEvent({type: "draw"});
        } // end if
    } // End of the function
    function draw(Void)
    {
    } // End of the function
    function move(x, y, noEvent)
    {
        var _l3 = _x;
        var _l2 = _y;
        _x = x;
        _y = y;
        if (noEvent != true)
        {
            this.dispatchEvent({type: "move", oldX: _l3, oldY: _l2});
        } // end if
    } // End of the function
    function setSize(w, h, noEvent)
    {
        var _l3 = __width;
        var _l2 = __height;
        __width = w;
        __height = h;
        this.size();
        if (noEvent != true)
        {
            this.dispatchEvent({type: "resize", oldWidth: _l3, oldHeight: _l2});
        } // end if
    } // End of the function
    function size(Void)
    {
        _width = __width;
        _height = __height;
    } // End of the function
    function drawRect(x1, y1, x2, y2)
    {
        this.moveTo(x1, y1);
        this.lineTo(x2, y1);
        this.lineTo(x2, y2);
        this.lineTo(x1, y2);
        this.lineTo(x1, y1);
    } // End of the function
    function createLabel(name, depth, text)
    {
        this.createTextField(name, depth, 0, 0, 0, 0);
        var _l2 = this[name];
        _l2._color = mx.core.UIObject.textColorList;
        _l2._visible = false;
        _l2.__text = text;
        if (tfList == undefined)
        {
            tfList = new Object();
        } // end if
        tfList[name] = _l2;
        _l2.invalidateStyle();
        this.invalidate();
        _l2.styleName = this;
        return (_l2);
    } // End of the function
    function createObject(linkageName, id, depth, initobj)
    {
        return (this.attachMovie(linkageName, id, depth, initobj));
    } // End of the function
    function createClassObject(className, id, depth, initobj)
    {
        var _l3 = className.symbolName == undefined;
        if (_l3)
        {
            Object.registerClass(className.symbolOwner.symbolName, className);
        } // end if
        var _l4 = this.createObject(className.symbolOwner.symbolName, id, depth, initobj);
        if (_l3)
        {
            Object.registerClass(className.symbolOwner.symbolName, className.symbolOwner);
        } // end if
        return (_l4);
    } // End of the function
    function createEmptyObject(id, depth)
    {
        return (this.createClassObject(mx.core.UIObject, id, depth));
    } // End of the function
    function destroyObject(id)
    {
        var _l2 = this[id];
        if (_l2.getDepth() < 0)
        {
            var _l4 = this.buildDepthTable();
            var _l5 = this.findNextAvailableDepth(0, _l4, "up");
            var _l3 = _l5;
            _l2.swapDepths(_l3);
        } // end if
        _l2.removeMovieClip();
        delete this[id];
    } // End of the function
    function getSkinIDName(tag)
    {
        return (idNames[tag]);
    } // End of the function
    function setSkin(tag, linkageName, initObj)
    {
        if (_global.skinRegistry[linkageName] == undefined)
        {
            mx.skins.SkinElement.registerElement(linkageName, mx.skins.SkinElement);
        } // end if
        return (this.createObject(linkageName, this.getSkinIDName(tag), tag, initObj));
    } // End of the function
    function createSkin(tag)
    {
        var _l2 = this.getSkinIDName(tag);
        this.createEmptyObject(_l2, tag);
        return (this[_l2]);
    } // End of the function
    function createChildren(Void)
    {
    } // End of the function
    function _createChildren(Void)
    {
        this.createChildren();
        childrenCreated = true;
    } // End of the function
    function constructObject(Void)
    {
        if (_name == undefined)
        {
            return (undefined);
        } // end if
        this.init();
        this._createChildren();
        this.createAccessibilityImplementation();
        this._endInit();
        if (validateNow)
        {
            this.redraw(true);
        }
        else
        {
            this.invalidate();
        } // end if
    } // End of the function
    function initFromClipParameters(Void)
    {
        var _l4 = false;
        var _l2;
        for (var _l2 in clipParameters)
        {
            if (this.hasOwnProperty(_l2))
            {
                _l4 = true;
                set("def_" + _l2, this[_l2]);
                delete this[_l2];
            } // end if
        } // end of for...in
        if (_l4)
        {
            for (var _l2 in clipParameters)
            {
                var _l3 = this["def_" + _l2];
                if (_l3 != undefined)
                {
                    _l2 = _l3;
                } // end if
            } // end of for...in
        } // end if
    } // End of the function
    function init(Void)
    {
        __width = _width;
        __height = _height;
        if (initProperties == undefined)
        {
            this.initFromClipParameters();
        }
        else
        {
            this.initProperties();
        } // end if
        if (_global.cascadingStyles == true)
        {
            stylecache = new Object();
        } // end if
    } // End of the function
    function getClassStyleDeclaration(Void)
    {
        var _l4 = this;
        var _l3 = className;
        while (_l3 != undefined)
        {
            if (ignoreClassStyleDeclaration[_l3] == undefined)
            {
                if (_global.styles[_l3] != undefined)
                {
                    return (_global.styles[_l3]);
                } // end if
            } // end if
            _l4 = _l4.__proto__;
            _l3 = _l4.className;
        } // end while
    } // End of the function
    function setColor(color)
    {
    } // End of the function
    function __getTextFormat(tf, bAll)
    {
        var _l8 = stylecache.tf;
        if (_l8 != undefined)
        {
            var _l3;
            for (var _l3 in mx.styles.StyleManager.TextFormatStyleProps)
            {
                if (bAll || mx.styles.StyleManager.TextFormatStyleProps[_l3])
                {
                    if (tf[_l3] == undefined)
                    {
                        tf[_l3] = _l8[_l3];
                    } // end if
                } // end if
            } // end of for...in
            return (false);
        } // end if
        var _l6 = false;
        for (var _l3 in mx.styles.StyleManager.TextFormatStyleProps)
        {
            if (bAll || mx.styles.StyleManager.TextFormatStyleProps[_l3])
            {
                if (tf[_l3] == undefined)
                {
                    var _l5 = _tf[_l3];
                    if (_l5 != undefined)
                    {
                        tf[_l3] = _l5;
                    }
                    else if (_l3 == "font" && fontFamily != undefined)
                    {
                        tf[_l3] = fontFamily;
                    }
                    else if (_l3 == "size" && fontSize != undefined)
                    {
                        tf[_l3] = fontSize;
                    }
                    else if (_l3 == "color" && color != undefined)
                    {
                        tf[_l3] = color;
                    }
                    else if (_l3 == "leftMargin" && marginLeft != undefined)
                    {
                        tf[_l3] = marginLeft;
                    }
                    else if (_l3 == "rightMargin" && marginRight != undefined)
                    {
                        tf[_l3] = marginRight;
                    }
                    else if (_l3 == "italic" && fontStyle != undefined)
                    {
                        tf[_l3] = fontStyle == _l3;
                    }
                    else if (_l3 == "bold" && fontWeight != undefined)
                    {
                        tf[_l3] = fontWeight == _l3;
                    }
                    else if (_l3 == "align" && textAlign != undefined)
                    {
                        tf[_l3] = textAlign;
                    }
                    else if (_l3 == "indent" && textIndent != undefined)
                    {
                        tf[_l3] = textIndent;
                    }
                    else if (_l3 == "underline" && textDecoration != undefined)
                    {
                        tf[_l3] = textDecoration == _l3;
                    }
                    else if (_l3 == "embedFonts" && embedFonts != undefined)
                    {
                        tf[_l3] = embedFonts;
                    }
                    else
                    {
                        _l6 = true;
                    } // end if
                } // end if
            } // end if
        } // end of for...in
        if (_l6)
        {
            var _l9 = styleName;
            if (_l9 != undefined)
            {
                if (typeof(_l9) != "string")
                {
                    _l6 = _l9.__getTextFormat(tf, true, this);
                }
                else if (_global.styles[_l9] != undefined)
                {
                    _l6 = _global.styles[_l9].__getTextFormat(tf, true, this);
                } // end if
            } // end if
        } // end if
        if (_l6)
        {
            var _l10 = this.getClassStyleDeclaration();
            if (_l10 != undefined)
            {
                _l6 = _l10.__getTextFormat(tf, true, this);
            } // end if
        } // end if
        if (_l6)
        {
            if (_global.cascadingStyles)
            {
                if (_parent != undefined)
                {
                    _l6 = _parent.__getTextFormat(tf, false);
                } // end if
            } // end if
        } // end if
        if (_l6)
        {
            _l6 = _global.style.__getTextFormat(tf, true, this);
        } // end if
        return (_l6);
    } // End of the function
    function _getTextFormat(Void)
    {
        var _l2 = stylecache.tf;
        if (_l2 != undefined)
        {
            return (_l2);
        } // end if
        _l2 = new TextFormat();
        this.__getTextFormat(_l2, true);
        stylecache.tf = _l2;
        if (enabled == false)
        {
            var _l3 = this.getStyle("disabledColor");
            _l2.color = _l3;
        } // end if
        return (_l2);
    } // End of the function
    function getStyleName(Void)
    {
        var _l2 = styleName;
        if (_l2 != undefined)
        {
            if (typeof(_l2) != "string")
            {
                return (_l2.getStyleName());
            }
            else
            {
                return (_l2);
            } // end if
        } // end if
        if (_parent != undefined)
        {
            return (_parent.getStyleName());
        }
        else
        {
            return (undefined);
        } // end if
    } // End of the function
    function getStyle(styleProp)
    {
        var _l3;
        ++_global.getStyleCounter;
        if (this[styleProp] != undefined)
        {
            return (this[styleProp]);
        } // end if
        var _l6 = styleName;
        if (_l6 != undefined)
        {
            if (typeof(_l6) != "string")
            {
                _l3 = _l6.getStyle(styleProp);
            }
            else
            {
                var _l7 = _global.styles[_l6];
                _l3 = _l7.getStyle(styleProp);
            } // end if
        } // end if
        if (_l3 != undefined)
        {
            return (_l3);
        } // end if
        _l7 = this.getClassStyleDeclaration();
        if (_l7 != undefined)
        {
            _l3 = _l7[styleProp];
        } // end if
        if (_l3 != undefined)
        {
            return (_l3);
        } // end if
        if (_global.cascadingStyles)
        {
            if (mx.styles.StyleManager.isInheritingStyle(styleProp) || mx.styles.StyleManager.isColorStyle(styleProp))
            {
                var _l5 = stylecache;
                if (_l5 != undefined)
                {
                    if (_l5[styleProp] != undefined)
                    {
                        return (_l5[styleProp]);
                    } // end if
                } // end if
                if (_parent != undefined)
                {
                    _l3 = _parent.getStyle(styleProp);
                }
                else
                {
                    _l3 = _global.style[styleProp];
                } // end if
                if (_l5 != undefined)
                {
                    _l5[styleProp] = _l3;
                } // end if
                return (_l3);
            } // end if
        } // end if
        if (_l3 == undefined)
        {
            _l3 = _global.style[styleProp];
        } // end if
        return (_l3);
    } // End of the function
    static function mergeClipParameters(o, p)
    {
        for (var _l3 in p)
        {
            o[_l3] = p[_l3];
        } // end of for...in
        return (true);
    } // End of the function
    static var symbolName = "UIObject";
    static var symbolOwner = mx.core.UIObject;
    static var version = "2.0.1.78";
    static var textColorList = {color: 1, disabledColor: 1};
    var invalidateFlag = false;
    var lineWidth = 1;
    var lineColor = 0;
    var tabEnabled = false;
    var clipParameters = {visible: 1, minHeight: 1, minWidth: 1, maxHeight: 1, maxWidth: 1, preferredHeight: 1, preferredWidth: 1};
} // End of Class
