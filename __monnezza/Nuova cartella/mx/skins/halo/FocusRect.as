class mx.skins.halo.FocusRect extends mx.skins.SkinElement
{
    var boundingBox_mc, _yscale, _xscale, _visible, _parent, height, width, y, x;
    function FocusRect()
    {
        super();
        boundingBox_mc._visible = false;
        boundingBox_mc._width = boundingBox_mc._height = 0;
    } // End of the function
    function draw(o)
    {
        o.adjustFocusRect();
    } // End of the function
    function setSize(w, h, r, a, rectCol)
    {
        _xscale = _yscale = 100;
        this.clear();
        if (typeof(r) == "object")
        {
            r.br = r.br > 2 ? (r.br - 2) : (0);
            r.bl = r.bl > 2 ? (r.bl - 2) : (0);
            r.tr = r.tr > 2 ? (r.tr - 2) : (0);
            r.tl = r.tl > 2 ? (r.tl - 2) : (0);
            this.beginFill(rectCol, a * 0.300000);
            this.drawRoundRect(0, 0, w, h, r);
            this.drawRoundRect(2, 2, w - 4, h - 4, r);
            this.endFill();
            r.br = r.br > 1 ? (r.br + 1) : (0);
            r.bl = r.bl > 1 ? (r.bl + 1) : (0);
            r.tr = r.tr > 1 ? (r.tr + 1) : (0);
            r.tl = r.tl > 1 ? (r.tl + 1) : (0);
            this.beginFill(rectCol, a * 0.300000);
            this.drawRoundRect(1, 1, w - 2, h - 2, r);
            r.br = r.br > 1 ? (r.br - 1) : (0);
            r.bl = r.bl > 1 ? (r.bl - 1) : (0);
            r.tr = r.tr > 1 ? (r.tr - 1) : (0);
            r.tl = r.tl > 1 ? (r.tl - 1) : (0);
            this.drawRoundRect(2, 2, w - 4, h - 4, r);
            this.endFill();
        }
        else
        {
            var _l5;
            if (r != 0)
            {
                _l5 = r - 2;
            }
            else
            {
                _l5 = 0;
            } // end if
            this.beginFill(rectCol, a * 0.300000);
            this.drawRoundRect(0, 0, w, h, r);
            this.drawRoundRect(2, 2, w - 4, h - 4, _l5);
            this.endFill();
            this.beginFill(rectCol, a * 0.300000);
            if (r != 0)
            {
                _l5 = r - 2;
                var _l2 = r - 1;
            }
            else
            {
                _l5 = 0;
                _l2 = 0;
            } // end if
            this.drawRoundRect(1, 1, w - 2, h - 2, _l2);
            this.drawRoundRect(2, 2, w - 4, h - 4, _l5);
            this.endFill();
        } // end if
    } // End of the function
    function handleEvent(e)
    {
        if (e.type == "unload")
        {
            _visible = true;
        }
        else if (e.type == "resize")
        {
            e.target.adjustFocusRect();
        }
        else if (e.type == "move")
        {
            e.target.adjustFocusRect();
        } // end if
    } // End of the function
    static function classConstruct()
    {
        mx.core.UIComponent.prototype.drawFocus = function (focused)
        {
            var _l2 = _parent.focus_mc;
            if (!focused)
            {
                _l2._visible = false;
                this.removeEventListener("unload", _l2);
                this.removeEventListener("move", _l2);
                this.removeEventListener("resize", _l2);
            }
            else
            {
                if (_l2 == undefined)
                {
                    _l2 = _parent.createChildAtDepth("FocusRect", mx.managers.DepthManager.kTop);
                    _l2.tabEnabled = false;
                    _parent.focus_mc = _l2;
                }
                else
                {
                    _l2._visible = true;
                } // end if
                _l2.draw(this);
                if (_l2.getDepth() < this.getDepth())
                {
                    _l2.setDepthAbove(this);
                } // end if
                this.addEventListener("unload", _l2);
                this.addEventListener("move", _l2);
                this.addEventListener("resize", _l2);
            } // end if
        };
        mx.core.UIComponent.prototype.adjustFocusRect = function ()
        {
            var _l2 = this.getStyle("themeColor");
            if (_l2 == undefined)
            {
                _l2 = 8453965;
            } // end if
            var _l3 = _parent.focus_mc;
            _l3.setSize(width + 4, height + 4, 0, 100, _l2);
            _l3.move(x - 2, y - 2);
        };
        TextField.prototype.drawFocus = mx.core.UIComponent.prototype.drawFocus;
        TextField.prototype.adjustFocusRect = mx.core.UIComponent.prototype.adjustFocusRect;
        mx.skins.halo.FocusRect.prototype.drawRoundRect = mx.skins.halo.Defaults.prototype.drawRoundRect;
        return (true);
    } // End of the function
    static var classConstructed = mx.skins.halo.FocusRect.classConstruct();
    static var DefaultsDependency = mx.skins.halo.Defaults;
    static var UIComponentDependency = mx.core.UIComponent;
} // End of Class
