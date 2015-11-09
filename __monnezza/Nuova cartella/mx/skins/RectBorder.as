class mx.skins.RectBorder extends mx.skins.Border
{
    var __width, __height, offset, __borderMetrics;
    function RectBorder()
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
    function init(Void)
    {
        super.init();
    } // End of the function
    function draw(Void)
    {
        this.size();
    } // End of the function
    function getBorderMetrics(Void)
    {
        var _l2 = offset;
        if (__borderMetrics == undefined)
        {
            __borderMetrics = {left: _l2, top: _l2, right: _l2, bottom: _l2};
        }
        else
        {
            __borderMetrics.left = _l2;
            __borderMetrics.top = _l2;
            __borderMetrics.right = _l2;
            __borderMetrics.bottom = _l2;
        } // end if
        return (__borderMetrics);
    } // End of the function
    function __get__borderMetrics()
    {
        return (this.getBorderMetrics());
    } // End of the function
    function drawBorder(Void)
    {
    } // End of the function
    function size(Void)
    {
        this.drawBorder();
    } // End of the function
    function setColor(Void)
    {
        this.drawBorder();
    } // End of the function
    static var symbolName = "RectBorder";
    static var symbolOwner = mx.skins.RectBorder;
    static var version = "2.0.1.78";
    var className = "RectBorder";
    var borderStyleName = "borderStyle";
    var borderColorName = "borderColor";
    var shadowColorName = "shadowColor";
    var highlightColorName = "highlightColor";
    var buttonColorName = "buttonColor";
    var backgroundColorName = "backgroundColor";
} // End of Class
