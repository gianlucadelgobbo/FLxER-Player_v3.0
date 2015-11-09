class mx.controls.Button extends mx.controls.SimpleButton
{
    var initializing, labelPath, initIcon, enabled, phase, idNames, __width, __height, iconName, _iconLinkageName, hitArea_mc;
    function Button()
    {
        super();
    } // End of the function
    function init(Void)
    {
        super.init();
    } // End of the function
    function draw()
    {
        if (initializing)
        {
            labelPath.visible = true;
        } // end if
        super.draw();
        if (initIcon != undefined)
        {
            this._setIcon(initIcon);
        } // end if
        delete this.initIcon;
    } // End of the function
    function onRelease(Void)
    {
        super.onRelease();
    } // End of the function
    function createChildren(Void)
    {
        super.createChildren();
    } // End of the function
    function setSkin(tag, linkageName, initobj)
    {
        return (super.setSkin(tag, linkageName, initobj));
    } // End of the function
    function viewSkin(varName)
    {
        var _l3 = this.getState() ? ("true") : ("false");
        _l3 = _l3 + (enabled ? (phase) : ("disabled"));
        super.viewSkin(varName, {styleName: this, borderStyle: _l3});
    } // End of the function
    function invalidateStyle(c)
    {
        labelPath.invalidateStyle(c);
        super.invalidateStyle(c);
    } // End of the function
    function setColor(c)
    {
        var _l2 = 0;
        while (_l2 < 8)
        {
            this[idNames[_l2]].redraw(true);
            ++_l2;
        } // end while
    } // End of the function
    function setEnabled(enable)
    {
        labelPath.enabled = enable;
        super.setEnabled(enable);
    } // End of the function
    function calcSize(tag, ref)
    {
        if (__width == undefined || __height == undefined)
        {
            return (undefined);
        } // end if
        if (tag < 7)
        {
            ref.setSize(__width, __height, true);
        } // end if
    } // End of the function
    function size(Void)
    {
        this.setState(this.getState());
        this.setHitArea(__width, __height);
        var _l3 = 0;
        while (_l3 < 8)
        {
            var _l4 = idNames[_l3];
            if (typeof(this[_l4]) == "movieclip")
            {
                this[_l4].setSize(__width, __height, true);
            } // end if
            ++_l3;
        } // end while
        super.size();
    } // End of the function
    function __set__labelPlacement(val)
    {
        __labelPlacement = val;
        this.invalidate();
        return (this.__get__labelPlacement());
        null;
    } // End of the function
    function __get__labelPlacement()
    {
        return (__labelPlacement);
    } // End of the function
    function getLabelPlacement(Void)
    {
        return (__labelPlacement);
    } // End of the function
    function setLabelPlacement(val)
    {
        __labelPlacement = val;
        this.invalidate();
    } // End of the function
    function getBtnOffset(Void)
    {
        if (this.getState())
        {
            var _l2 = btnOffset;
        }
        else if (phase == "down")
        {
            _l2 = btnOffset;
        }
        else
        {
            _l2 = 0;
        } // end if
        return (_l2);
    } // End of the function
    function setView(offset)
    {
        var _l16 = offset ? (btnOffset) : (0);
        var _l12 = this.getLabelPlacement();
        var _l7 = 0;
        var _l6 = 0;
        var _l9 = 0;
        var _l8 = 0;
        var _l5 = 0;
        var _l4 = 0;
        var _l3 = labelPath;
        var _l2 = iconName;
        var _l15 = _l3.textWidth;
        var _l14 = _l3.textHeight;
        var _l10 = __width - borderW - borderW;
        var _l11 = __height - borderW - borderW;
        if (_l2 != undefined)
        {
            _l7 = _l2._width;
            _l6 = _l2._height;
        } // end if
        if (_l12 == "left" || _l12 == "right")
        {
            if (_l3 != undefined)
            {
                _l9 = Math.min(_l10 - _l7, _l15 + 5);
                _l3._width = Math.min(_l10 - _l7, _l15 + 5);
                _l8 = Math.min(_l11, _l14 + 5);
                _l3._height = Math.min(_l11, _l14 + 5);
            } // end if
            if (_l12 == "right")
            {
                _l5 = _l7;
                if (centerContent)
                {
                    _l5 = _l5 + (_l10 - _l9 - _l7) / 2;
                } // end if
                _l2._x = _l5 - _l7;
            }
            else
            {
                _l5 = _l10 - _l9 - _l7;
                if (centerContent)
                {
                    _l5 = _l5 / 2;
                } // end if
                _l2._x = _l5 + _l9;
            } // end if
            _l4 = 0;
            _l2._y = 0;
            if (centerContent)
            {
                _l2._y = (_l11 - _l6) / 2;
                _l4 = (_l11 - _l8) / 2;
            } // end if
            if (!centerContent)
            {
                _l2._y = _l2._y + Math.max(0, (_l8 - _l6) / 2);
            } // end if
        }
        else
        {
            if (_l3 != undefined)
            {
                _l9 = Math.min(_l10, _l15 + 5);
                _l3._width = Math.min(_l10, _l15 + 5);
                _l8 = Math.min(_l11 - _l6, _l14 + 5);
                _l3._height = Math.min(_l11 - _l6, _l14 + 5);
            } // end if
            _l5 = (_l10 - _l9) / 2;
            _l2._x = (_l10 - _l7) / 2;
            if (_l12 == "top")
            {
                _l4 = _l11 - _l8 - _l6;
                if (centerContent)
                {
                    _l4 = _l4 / 2;
                } // end if
                _l2._y = _l4 + _l8;
            }
            else
            {
                _l4 = _l6;
                if (centerContent)
                {
                    _l4 = _l4 + (_l11 - _l8 - _l6) / 2;
                } // end if
                _l2._y = _l4 - _l6;
            } // end if
        } // end if
        var _l13 = borderW + _l16;
        _l3._x = _l5 + _l13;
        _l3._y = _l4 + _l13;
        _l2._x = _l2._x + _l13;
        _l2._y = _l2._y + _l13;
    } // End of the function
    function __set__label(lbl)
    {
        this.setLabel(lbl);
        return (this.__get__label());
        null;
    } // End of the function
    function setLabel(label)
    {
        if (label == "")
        {
            labelPath.removeTextField();
            this.refresh();
            return (undefined);
        } // end if
        if (labelPath == undefined)
        {
            var _l2 = this.createLabel("labelPath", 200, label);
            _l2._width = _l2.textWidth + 5;
            _l2._height = _l2.textHeight + 5;
            if (initializing)
            {
                _l2.visible = false;
            } // end if
        }
        else
        {
            delete labelPath.__text;
            labelPath.text = label;
            this.refresh();
        } // end if
    } // End of the function
    function getLabel(Void)
    {
        return (labelPath.__text != undefined ? (labelPath.__text) : (labelPath.text));
    } // End of the function
    function __get__label()
    {
        return (this.getLabel());
    } // End of the function
    function _getIcon(Void)
    {
        return (_iconLinkageName);
    } // End of the function
    function __get__icon()
    {
        if (initializing)
        {
            return (initIcon);
        } // end if
        return (_iconLinkageName);
    } // End of the function
    function _setIcon(linkage)
    {
        if (initializing)
        {
            if (linkage == "")
            {
                return (undefined);
            } // end if
            initIcon = linkage;
        }
        else
        {
            if (linkage == "")
            {
                this.removeIcons();
                return (undefined);
            } // end if
            super.changeIcon(0, linkage);
            super.changeIcon(1, linkage);
            super.changeIcon(3, linkage);
            super.changeIcon(4, linkage);
            super.changeIcon(5, linkage);
            _iconLinkageName = linkage;
            this.refresh();
        } // end if
    } // End of the function
    function __set__icon(linkage)
    {
        this._setIcon(linkage);
        return (this.__get__icon());
        null;
    } // End of the function
    function setHitArea(w, h)
    {
        if (hitArea_mc == undefined)
        {
            this.createEmptyObject("hitArea_mc", 100);
        } // end if
        var _l2 = hitArea_mc;
        _l2.clear();
        _l2.beginFill(16711680);
        _l2.drawRect(0, 0, w, h);
        _l2.endFill();
        _l2.setVisible(false);
    } // End of the function
    static var symbolName = "Button";
    static var symbolOwner = mx.controls.Button;
    var className = "Button";
    static var version = "2.0.1.78";
    var btnOffset = 0;
    var _color = "buttonColor";
    var __label = "default value";
    var __labelPlacement = "right";
    var falseUpSkin = "ButtonSkin";
    var falseDownSkin = "ButtonSkin";
    var falseOverSkin = "ButtonSkin";
    var falseDisabledSkin = "ButtonSkin";
    var trueUpSkin = "ButtonSkin";
    var trueDownSkin = "ButtonSkin";
    var trueOverSkin = "ButtonSkin";
    var trueDisabledSkin = "ButtonSkin";
    var falseUpIcon = "";
    var falseDownIcon = "";
    var falseOverIcon = "";
    var falseDisabledIcon = "";
    var trueUpIcon = "";
    var trueDownIcon = "";
    var trueOverIcon = "";
    var trueDisabledIcon = "";
    var clipParameters = {labelPlacement: 1, icon: 1, toggle: 1, selected: 1, label: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.controls.Button.prototype.clipParameters, mx.controls.SimpleButton.prototype.clipParameters);
    var centerContent = true;
    var borderW = 1;
} // End of Class
