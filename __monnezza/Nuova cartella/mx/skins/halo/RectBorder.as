class mx.skins.halo.RectBorder extends mx.skins.RectBorder
{
    var offset, borderStyleName, __borderMetrics, className, borderColorName, backgroundColorName, shadowColorName, highlightColorName, buttonColorName, _color;
    function RectBorder()
    {
        super();
    } // End of the function
    function init(Void)
    {
        borderWidths.default = 3;
        super.init();
    } // End of the function
    function getBorderMetrics(Void)
    {
        if (offset == undefined)
        {
            var _l3 = this.getStyle(borderStyleName);
            offset = borderWidths[_l3];
        } // end if
        if (this.getStyle(borderStyleName) == "default" || this.getStyle(borderStyleName) == "alert")
        {
            __borderMetrics = {left: 3, top: 1, right: 3, bottom: 3};
            return (__borderMetrics);
        } // end if
        return (super.getBorderMetrics());
    } // End of the function
    function drawBorder(Void)
    {
        var _l6 = _global.styles[className];
        if (_l6 == undefined)
        {
            _l6 = _global.styles.RectBorder;
        } // end if
        var _l5 = this.getStyle(borderStyleName);
        var _l7 = this.getStyle(borderColorName);
        if (_l7 == undefined)
        {
            _l7 = _l6[borderColorName];
        } // end if
        var _l8 = this.getStyle(backgroundColorName);
        if (_l8 == undefined)
        {
            _l8 = _l6[backgroundColorName];
        } // end if
        var _l16 = this.getStyle("backgroundImage");
        if (_l5 != "none")
        {
            var _l14 = this.getStyle(shadowColorName);
            if (_l14 == undefined)
            {
                _l14 = _l6[shadowColorName];
            } // end if
            var _l13 = this.getStyle(highlightColorName);
            if (_l13 == undefined)
            {
                _l13 = _l6[highlightColorName];
            } // end if
            var _l12 = this.getStyle(buttonColorName);
            if (_l12 == undefined)
            {
                _l12 = _l6[buttonColorName];
            } // end if
            var _l11 = this.getStyle(borderCapColorName);
            if (_l11 == undefined)
            {
                _l11 = _l6[borderCapColorName];
            } // end if
            var _l10 = this.getStyle(shadowCapColorName);
            if (_l10 == undefined)
            {
                _l10 = _l6[shadowCapColorName];
            } // end if
        } // end if
        offset = borderWidths[_l5];
        var _l9 = offset;
        var _l3 = this.__get__width();
        var _l4 = this.__get__height();
        this.clear();
        _color = undefined;
        if (_l5 == "none")
        {
        }
        else if (_l5 == "inset")
        {
            _color = colorList;
            this.draw3dBorder(_l11, _l12, _l7, _l13, _l14, _l10);
        }
        else if (_l5 == "outset")
        {
            _color = colorList;
            this.draw3dBorder(_l11, _l7, _l12, _l14, _l13, _l10);
        }
        else if (_l5 == "alert")
        {
            var _l15 = this.getStyle("themeColor");
            this.drawRoundRect(0, 5, _l3, _l4 - 5, 5, 6184542, 10);
            this.drawRoundRect(1, 4, _l3 - 2, _l4 - 5, 4, [6184542, 6184542], 10, 0, "radial");
            this.drawRoundRect(2, 0, _l3 - 4, _l4 - 2, 3, [0, 14342874], 100, 0, "radial");
            this.drawRoundRect(2, 0, _l3 - 4, _l4 - 2, 3, _l15, 50);
            this.drawRoundRect(3, 1, _l3 - 6, _l4 - 4, 2, 16777215, 100);
        }
        else if (_l5 == "default")
        {
            this.drawRoundRect(0, 5, _l3, _l4 - 5, {tl: 5, tr: 5, br: 0, bl: 0}, 6184542, 10);
            this.drawRoundRect(1, 4, _l3 - 2, _l4 - 5, {tl: 4, tr: 4, br: 0, bl: 0}, [6184542, 6184542], 10, 0, "radial");
            this.drawRoundRect(2, 0, _l3 - 4, _l4 - 2, {tl: 3, tr: 3, br: 0, bl: 0}, [12897484, 11844796], 100, 0, "radial");
            this.drawRoundRect(3, 1, _l3 - 6, _l4 - 4, {tl: 2, tr: 2, br: 0, bl: 0}, 16777215, 100);
        }
        else if (_l5 == "dropDown")
        {
            this.drawRoundRect(0, 0, _l3 + 1, _l4, {tl: 4, tr: 0, br: 0, bl: 4}, [13290186, 7895160], 100, -10, "linear");
            this.drawRoundRect(1, 1, _l3 - 1, _l4 - 2, {tl: 3, tr: 0, br: 0, bl: 3}, 16777215, 100);
        }
        else if (_l5 == "menuBorder")
        {
            _l15 = this.getStyle("themeColor");
            this.drawRoundRect(4, 4, _l3 - 2, _l4 - 3, 0, [6184542, 6184542], 10, 0, "radial");
            this.drawRoundRect(4, 4, _l3 - 1, _l4 - 2, 0, 6184542, 10);
            this.drawRoundRect(0, 0, _l3 + 1, _l4, 0, [0, 14342874], 100, 250, "linear");
            this.drawRoundRect(0, 0, _l3 + 1, _l4, 0, _l15, 50);
            this.drawRoundRect(2, 2, _l3 - 3, _l4 - 4, 0, 16777215, 100);
        }
        else if (_l5 == "comboNonEdit")
        {
        }
        else
        {
            this.beginFill(_l7);
            this.drawRect(0, 0, _l3, _l4);
            this.drawRect(1, 1, _l3 - 1, _l4 - 1);
            this.endFill();
            _color = borderColorName;
        } // end if
        if (_l8 != undefined)
        {
            this.beginFill(_l8);
            this.drawRect(_l9, _l9, this.__get__width() - _l9, this.__get__height() - _l9);
            this.endFill();
        } // end if
    } // End of the function
    function draw3dBorder(c1, c2, c3, c4, c5, c6)
    {
        var _l3 = this.__get__width();
        var _l2 = this.__get__height();
        this.beginFill(c1);
        this.drawRect(0, 0, _l3, _l2);
        this.drawRect(1, 0, _l3 - 1, _l2);
        this.endFill();
        this.beginFill(c2);
        this.drawRect(1, 0, _l3 - 1, 1);
        this.endFill();
        this.beginFill(c3);
        this.drawRect(1, _l2 - 1, _l3 - 1, _l2);
        this.endFill();
        this.beginFill(c4);
        this.drawRect(1, 1, _l3 - 1, 2);
        this.endFill();
        this.beginFill(c5);
        this.drawRect(1, _l2 - 2, _l3 - 1, _l2 - 1);
        this.endFill();
        this.beginFill(c6);
        this.drawRect(1, 2, _l3 - 1, _l2 - 2);
        this.drawRect(2, 2, _l3 - 2, _l2 - 2);
        this.endFill();
    } // End of the function
    static function classConstruct()
    {
        mx.core.ext.UIObjectExtensions.Extensions();
        _global.styles.rectBorderClass = mx.skins.halo.RectBorder;
        _global.skinRegistry.RectBorder = true;
        return (true);
    } // End of the function
    static var symbolName = "RectBorder";
    static var symbolOwner = mx.skins.halo.RectBorder;
    static var version = "2.0.1.78";
    var borderCapColorName = "borderCapColor";
    var shadowCapColorName = "shadowCapColor";
    var colorList = {highlightColor: 0, borderColor: 0, buttonColor: 0, shadowColor: 0, borderCapColor: 0, shadowCapColor: 0};
    var borderWidths = {none: 0, solid: 1, inset: 2, outset: 2, alert: 3, dropDown: 2, menuBorder: 2, comboNonEdit: 2};
    static var classConstructed = mx.skins.halo.RectBorder.classConstruct();
    static var UIObjectExtensionsDependency = mx.core.ext.UIObjectExtensions;
} // End of Class
