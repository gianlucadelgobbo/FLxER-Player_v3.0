class mx.styles.CSSSetStyle
{
    var styleProp, styleName, stylecache, _color;
    function CSSSetStyle()
    {
    } // End of the function
    function _setStyle(styleProp, newValue)
    {
        styleProp = newValue;
        if (mx.styles.StyleManager.TextStyleMap[styleProp] != undefined)
        {
            if (styleProp == "color")
            {
                if (isNaN(newValue))
                {
                    var _l2 = mx.styles.StyleManager.getColorName(newValue);
                    styleProp = _l2;
                    if (_l2 == undefined)
                    {
                        return (undefined);
                    } // end if
                } // end if
            } // end if
            _level0.changeTextStyleInChildren(styleProp);
            return (undefined);
        } // end if
        if (mx.styles.StyleManager.isColorStyle(styleProp))
        {
            if (isNaN(_l2))
            {
                _l2 = mx.styles.StyleManager.getColorName(_l2);
                styleProp = _l2;
                if (_l2 == undefined)
                {
                    return (undefined);
                } // end if
            } // end if
            if (styleProp == "themeColor")
            {
                var _l7 = mx.styles.StyleManager.colorNames.haloBlue;
                var _l6 = mx.styles.StyleManager.colorNames.haloGreen;
                var _l8 = mx.styles.StyleManager.colorNames.haloOrange;
                var _l4 = {};
                _l4[_l7] = 12188666;
                _l4[_l6] = 13500353;
                _l4[_l8] = 16766319;
                var _l5 = {};
                _l5[_l7] = 13958653;
                _l5[_l6] = 14942166;
                _l5[_l8] = 16772787;
                var _l9 = _l4[_l2];
                var _l10 = _l5[_l2];
                if (_l9 == undefined)
                {
                    _l9 = _l2;
                } // end if
                if (_l10 == undefined)
                {
                    _l10 = _l2;
                } // end if
                this.setStyle("selectionColor", _l9);
                this.setStyle("rollOverColor", _l10);
            } // end if
            _level0.changeColorStyleInChildren(styleName, styleProp, _l2);
        }
        else
        {
            if (styleProp == "backgroundColor" && isNaN(_l2))
            {
                _l2 = mx.styles.StyleManager.getColorName(_l2);
                styleProp = _l2;
                if (_l2 == undefined)
                {
                    return (undefined);
                } // end if
            } // end if
            _level0.notifyStyleChangeInChildren(styleName, styleProp, _l2);
        } // end if
    } // End of the function
    function changeTextStyleInChildren(styleProp)
    {
        var _l4 = getTimer();
        var _l5;
        for (var _l5 in this)
        {
            var _l2 = this[_l5];
            if (_l2._parent == this)
            {
                if (_l2.searchKey != _l4)
                {
                    if (_l2.stylecache != undefined)
                    {
                        delete _l2.stylecache.tf;
                        delete _l2.stylecache[styleProp];
                    } // end if
                    _l2.invalidateStyle(styleProp);
                    _l2.changeTextStyleInChildren(styleProp);
                    _l2.searchKey = _l4;
                } // end if
            } // end if
        } // end of for...in
    } // End of the function
    function changeColorStyleInChildren(sheetName, colorStyle, newValue)
    {
        var _l6 = getTimer();
        var _l7;
        for (var _l7 in this)
        {
            var _l2 = this[_l7];
            if (_l2._parent == this)
            {
                if (_l2.searchKey != _l6)
                {
                    if (_l2.getStyleName() == sheetName || sheetName == undefined || sheetName == "_global")
                    {
                        if (_l2.stylecache != undefined)
                        {
                            delete _l2.stylecache[colorStyle];
                        } // end if
                        if (typeof(_l2._color) == "string")
                        {
                            if (_l2._color == colorStyle)
                            {
                                var _l4 = _l2.getStyle(colorStyle);
                                if (colorStyle == "color")
                                {
                                    if (stylecache.tf.color != undefined)
                                    {
                                        stylecache.tf.color = _l4;
                                    } // end if
                                } // end if
                                _l2.setColor(_l4);
                            } // end if
                        }
                        else if (_l2._color[colorStyle] != undefined)
                        {
                            if (typeof(_l2) != "movieclip")
                            {
                                _l2._parent.invalidateStyle();
                            }
                            else
                            {
                                _l2.invalidateStyle(colorStyle);
                            } // end if
                        } // end if
                    } // end if
                    _l2.changeColorStyleInChildren(sheetName, colorStyle, newValue);
                    _l2.searchKey = _l6;
                } // end if
            } // end if
        } // end of for...in
    } // End of the function
    function notifyStyleChangeInChildren(sheetName, styleProp, newValue)
    {
        var _l5 = getTimer();
        var _l6;
        for (var _l6 in this)
        {
            var _l2 = this[_l6];
            if (_l2._parent == this)
            {
                if (_l2.searchKey != _l5)
                {
                    if (_l2.styleName == sheetName || _l2.styleName != undefined && typeof(_l2.styleName) == "movieclip" || sheetName == undefined)
                    {
                        if (_l2.stylecache != undefined)
                        {
                            delete _l2.stylecache[styleProp];
                            delete _l2.stylecache.tf;
                        } // end if
                        delete _l2.enabledColor;
                        _l2.invalidateStyle(styleProp);
                    } // end if
                    _l2.notifyStyleChangeInChildren(sheetName, styleProp, newValue);
                    _l2.searchKey = _l5;
                } // end if
            } // end if
        } // end of for...in
    } // End of the function
    function setStyle(styleProp, newValue)
    {
        if (stylecache != undefined)
        {
            delete stylecache[styleProp];
            delete stylecache.tf;
        } // end if
        styleProp = newValue;
        if (mx.styles.StyleManager.isColorStyle(styleProp))
        {
            if (isNaN(newValue))
            {
                var _l3 = mx.styles.StyleManager.getColorName(newValue);
                styleProp = _l3;
                if (_l3 == undefined)
                {
                    return (undefined);
                } // end if
            } // end if
            if (styleProp == "themeColor")
            {
                var _l10 = mx.styles.StyleManager.colorNames.haloBlue;
                var _l9 = mx.styles.StyleManager.colorNames.haloGreen;
                var _l11 = mx.styles.StyleManager.colorNames.haloOrange;
                var _l6 = {};
                _l6[_l10] = 12188666;
                _l6[_l9] = 13500353;
                _l6[_l11] = 16766319;
                var _l7 = {};
                _l7[_l10] = 13958653;
                _l7[_l9] = 14942166;
                _l7[_l11] = 16772787;
                var _l12 = _l6[_l3];
                var _l13 = _l7[_l3];
                if (_l12 == undefined)
                {
                    _l12 = _l3;
                } // end if
                if (_l13 == undefined)
                {
                    _l13 = _l3;
                } // end if
                this.setStyle("selectionColor", _l12);
                this.setStyle("rollOverColor", _l13);
            } // end if
            if (typeof(_color) == "string")
            {
                if (_color == styleProp)
                {
                    if (styleProp == "color")
                    {
                        if (stylecache.tf.color != undefined)
                        {
                            stylecache.tf.color = _l3;
                        } // end if
                    } // end if
                    this.setColor(_l3);
                } // end if
            }
            else if (_color[styleProp] != undefined)
            {
                this.invalidateStyle(styleProp);
            } // end if
            this.changeColorStyleInChildren(undefined, styleProp, _l3);
        }
        else
        {
            if (styleProp == "backgroundColor" && isNaN(_l3))
            {
                _l3 = mx.styles.StyleManager.getColorName(_l3);
                styleProp = _l3;
                if (_l3 == undefined)
                {
                    return (undefined);
                } // end if
            } // end if
            this.invalidateStyle(styleProp);
        } // end if
        if (mx.styles.StyleManager.isInheritingStyle(styleProp) || styleProp == "styleName")
        {
            var _l8;
            var _l5 = _l3;
            if (styleProp == "styleName")
            {
                _l8 = typeof(_l3) == "string" ? (_global.styles[_l3]) : (_l5);
                _l5 = _l8.themeColor;
                if (_l5 != undefined)
                {
                    _l8.rollOverColor = _l8.selectionColor = _l5;
                } // end if
            } // end if
            this.notifyStyleChangeInChildren(undefined, styleProp, _l3);
        } // end if
    } // End of the function
    static function enableRunTimeCSS()
    {
    } // End of the function
    static function classConstruct()
    {
        mx.styles.CSSStyleDeclaration.prototype.setStyle = _setStyle;
        _global.changeTextStyleInChildren = changeTextStyleInChildren;
        _global.changeColorStyleInChildren = changeColorStyleInChildren;
        _global.notifyStyleChangeInChildren = notifyStyleChangeInChildren;
        _global.setStyle = setStyle;
        _global.ASSetPropFlags(_global, "changeTextStyleInChildren", 1);
        _global.ASSetPropFlags(_global, "changeColorStyleInChildren", 1);
        _global.ASSetPropFlags(_global, "notifyStyleChangeInChildren", 1);
        _global.ASSetPropFlags(_global, "setStyle", 1);
        setStyle = _global.setStyle;
        changeTextStyleInChildren = _l3.changeTextStyleInChildren;
        return (true);
    } // End of the function
    static var classConstructed = mx.styles.CSSSetStyle.classConstruct();
    static var CSSStyleDeclarationDependency = mx.styles.CSSStyleDeclaration;
} // End of Class
