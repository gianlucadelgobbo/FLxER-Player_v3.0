class mx.skins.ColoredSkinElement
{
    var _color, onEnterFrame;
    function ColoredSkinElement()
    {
    } // End of the function
    function setColor(c)
    {
        if (c != undefined)
        {
            var _l2 = new Color(this);
            _l2.setRGB(c);
        } // end if
    } // End of the function
    function draw(Void)
    {
        this.setColor(this.getStyle(_color));
        onEnterFrame = undefined;
    } // End of the function
    function invalidateStyle(Void)
    {
        onEnterFrame = draw;
    } // End of the function
    static function setColorStyle(p, colorStyle)
    {
        if (p._color == undefined)
        {
            p._color = colorStyle;
        } // end if
        p.setColor = mx.skins.ColoredSkinElement.mixins.setColor;
        p.invalidateStyle = mx.skins.ColoredSkinElement.mixins.invalidateStyle;
        p.draw = mx.skins.ColoredSkinElement.mixins.draw;
        p.setColor(p.getStyle(colorStyle));
    } // End of the function
    static var mixins = new mx.skins.ColoredSkinElement();
} // End of Class
