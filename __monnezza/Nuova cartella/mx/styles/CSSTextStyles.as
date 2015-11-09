class mx.styles.CSSTextStyles
{
    var _tf;
    function CSSTextStyles()
    {
    } // End of the function
    static function addTextStyles(o, bColor)
    {
        x.addProperty("textAlign", function ()
        {
            return (_tf.align);
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.align = x;
        });
        x.addProperty("fontWeight", function ()
        {
            return (_tf.bold != undefined ? (_tf.bold ? ("bold") : ("none")) : (undefined));
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.bold = x == "bold";
        });
        if (bColor)
        {
            x.addProperty("color", function ()
            {
                return (_tf.color);
            }, function (x)
            {
                if (_tf == undefined)
                {
                    _tf = new TextFormat();
                } // end if
                _tf.color = x;
            });
        } // end if
        x.addProperty("fontFamily", function ()
        {
            return (_tf.font);
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.font = x;
        });
        x.addProperty("textIndent", function ()
        {
            return (_tf.indent);
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.indent = x;
        });
        x.addProperty("fontStyle", function ()
        {
            return (_tf.italic != undefined ? (_tf.italic ? ("italic") : ("none")) : (undefined));
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.italic = x == "italic";
        });
        x.addProperty("marginLeft", function ()
        {
            return (_tf.leftMargin);
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.leftMargin = x;
        });
        x.addProperty("marginRight", function ()
        {
            return (_tf.rightMargin);
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.rightMargin = x;
        });
        x.addProperty("fontSize", function ()
        {
            return (_tf.size);
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.size = x;
        });
        x.addProperty("textDecoration", function ()
        {
            return (_tf.underline != undefined ? (_tf.underline ? ("underline") : ("none")) : (undefined));
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.underline = x == "underline";
        });
        x.addProperty("embedFonts", function ()
        {
            return (_tf.embedFonts);
        }, function (x)
        {
            if (_tf == undefined)
            {
                _tf = new TextFormat();
            } // end if
            _tf.embedFonts = x;
        });
    } // End of the function
} // End of Class
