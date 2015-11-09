class mx.styles.CSSStyleDeclaration
{
    var _tf;
    function CSSStyleDeclaration()
    {
    } // End of the function
    function __getTextFormat(tf, bAll)
    {
        var _l5 = false;
        if (_tf != undefined)
        {
            var _l2;
            for (var _l2 in mx.styles.StyleManager.TextFormatStyleProps)
            {
                if (bAll || mx.styles.StyleManager.TextFormatStyleProps[_l2])
                {
                    if (tf[_l2] == undefined)
                    {
                        var _l3 = _tf[_l2];
                        if (_l3 != undefined)
                        {
                            tf[_l2] = _l3;
                        }
                        else
                        {
                            _l5 = true;
                        } // end if
                    } // end if
                } // end if
            } // end of for...in
        }
        else
        {
            _l5 = true;
        } // end if
        return (_l5);
    } // End of the function
    function getStyle(styleProp)
    {
        var _l2 = this[styleProp];
        var _l3 = mx.styles.StyleManager.getColorName(_l2);
        return (_l3 == undefined ? (_l2) : (_l3));
    } // End of the function
    static function classConstruct()
    {
        mx.styles.CSSTextStyles.addTextStyles(mx.styles.CSSStyleDeclaration.prototype, true);
        return (true);
    } // End of the function
    static var classConstructed = mx.styles.CSSStyleDeclaration.classConstruct();
    static var CSSTextStylesDependency = mx.styles.CSSTextStyles;
} // End of Class
