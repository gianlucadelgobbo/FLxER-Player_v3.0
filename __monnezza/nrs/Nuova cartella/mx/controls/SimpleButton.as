class mx.controls.SimpleButton extends mx.core.UIComponent
{
    var preset, boundingBox_mc, useHandCursor, refNames[preset], skinName, linkLength, _l2, idNames[tag + 8], idNames[tag], _l4, iconName, stateNames[_l2 - 8] + "Icon", _width, __width, _height, __height, _l3, styleName, __emphaticStyleName, enabled, autoRepeat, interval, idNames[_l2], idNames[_l2 + 8];
    function SimpleButton()
    {
        super();
    } // End of the function
    function init(Void)
    {
        super.init();
        if (preset == undefined)
        {
            boundingBox_mc._visible = false;
            boundingBox_mc._width = boundingBox_mc._height = 0;
        } // end if
        useHandCursor = false;
    } // End of the function
    function createChildren(Void)
    {
        if (preset != undefined)
        {
            var _l2 = this[idNames[preset]];
            refNames[preset] = _l2;
            skinName = _l2;
            if (falseOverSkin.length == 0)
            {
                rolloverSkin = fus;
            } // end if
            if (falseOverIcon.length == 0)
            {
                rolloverIcon = fui;
            } // end if
            initializing = false;
        }
        else if (__state == true)
        {
            this.setStateVar(true);
        }
        else
        {
            if (falseOverSkin.length == 0)
            {
                rolloverSkin = fus;
            } // end if
            if (falseOverIcon.length == 0)
            {
                rolloverIcon = fui;
            } // end if
        } // end if
    } // End of the function
    function setIcon(tag, linkageName)
    {
        return (this.setSkin(tag + 8, linkageName));
    } // End of the function
    function changeIcon(tag, linkageName)
    {
        linkLength = linkageName.length;
        var _l2 = stateNames[tag] + "Icon";
        _l2 = linkageName;
        idNames[tag + 8] = _l2;
        this.setStateVar(this.getState());
    } // End of the function
    function changeSkin(tag, linkageName)
    {
        var _l2 = stateNames[tag] + "Skin";
        _l2 = linkageName;
        idNames[tag] = _l2;
        this.setStateVar(this.getState());
    } // End of the function
    function viewIcon(varName)
    {
        var _l4 = varName + "Icon";
        var _l3 = this[_l4];
        if (typeof(_l3) == "string")
        {
            var _l5 = _l3;
            if (__emphasized)
            {
                if (this[_l3 + "Emphasized"].length > 0)
                {
                    _l3 = _l3 + "Emphasized";
                } // end if
            } // end if
            if (this[_l3].length == 0)
            {
                return (undefined);
            } // end if
            _l3 = this.setIcon(tagMap[_l5], this[_l3]);
            if (_l3 == undefined && _global.isLivePreview)
            {
                _l3 = this.setIcon(0, "ButtonIcon");
            } // end if
            _l4 = _l3;
        } // end if
        iconName._visible = false;
        iconName = _l3;
        iconName._visible = true;
    } // End of the function
    function removeIcons()
    {
        var _l3 = 0;
        while (_l3 < 2)
        {
            var _l2 = 8;
            while (_l2 < 16)
            {
                this.destroyObject(idNames[_l2]);
                set(stateNames[_l2 - 8] + "Icon", "");
                ++_l2;
            } // end while
            ++_l3;
        } // end while
        this.refresh();
    } // End of the function
    function setSkin(tag, linkageName, initobj)
    {
        var _l3 = super.setSkin(tag, linkageName, initobj != undefined ? (initobj) : ({styleName: this}));
        this.calcSize(tag, _l3);
        return (_l3);
    } // End of the function
    function calcSize(Void)
    {
        __width = _width;
        __height = _height;
    } // End of the function
    function viewSkin(varName, initObj)
    {
        var _l3 = varName + "Skin";
        var _l2 = this[_l3];
        if (typeof(_l2) == "string")
        {
            var _l4 = _l2;
            if (__emphasized)
            {
                if (this[_l2 + "Emphasized"].length > 0)
                {
                    _l2 = _l2 + "Emphasized";
                } // end if
            } // end if
            if (this[_l2].length == 0)
            {
                return (undefined);
            } // end if
            _l2 = this.setSkin(tagMap[_l4], this[_l2], initObj != undefined ? (initObj) : ({styleName: this}));
            _l3 = _l2;
        } // end if
        skinName._visible = false;
        skinName = _l2;
        skinName._visible = true;
    } // End of the function
    function showEmphasized(e)
    {
        if (e && !__emphatic)
        {
            if (mx.controls.SimpleButton.emphasizedStyleDeclaration != undefined)
            {
                __emphaticStyleName = styleName;
                styleName = mx.controls.SimpleButton.emphasizedStyleDeclaration;
            } // end if
            __emphatic = true;
        }
        else
        {
            if (__emphatic)
            {
                styleName = __emphaticStyleName;
            } // end if
            __emphatic = false;
        } // end if
    } // End of the function
    function refresh(Void)
    {
        var _l2 = this.getState();
        if (enabled == false)
        {
            this.viewIcon("disabled");
            this.viewSkin("disabled");
        }
        else
        {
            this.viewSkin(phase);
            this.viewIcon(phase);
        } // end if
        this.setView(phase == "down");
        iconName.enabled = enabled;
    } // End of the function
    function setView(offset)
    {
        if (iconName == undefined)
        {
            return (undefined);
        } // end if
        var _l2 = offset ? (btnOffset) : (0);
        iconName._x = (__width - iconName._width) / 2 + _l2;
        iconName._y = (__height - iconName._height) / 2 + _l2;
    } // End of the function
    function setStateVar(state)
    {
        if (state)
        {
            if (trueOverSkin.length == 0)
            {
                rolloverSkin = tus;
            }
            else
            {
                rolloverSkin = trs;
            } // end if
            if (trueOverIcon.length == 0)
            {
                rolloverIcon = tui;
            }
            else
            {
                rolloverIcon = tri;
            } // end if
            upSkin = tus;
            downSkin = tds;
            disabledSkin = dts;
            upIcon = tui;
            downIcon = tdi;
            disabledIcon = dti;
        }
        else
        {
            if (falseOverSkin.length == 0)
            {
                rolloverSkin = fus;
            }
            else
            {
                rolloverSkin = frs;
            } // end if
            if (falseOverIcon.length == 0)
            {
                rolloverIcon = fui;
            }
            else
            {
                rolloverIcon = fri;
            } // end if
            upSkin = fus;
            downSkin = fds;
            disabledSkin = dfs;
            upIcon = fui;
            downIcon = fdi;
            disabledIcon = dfi;
        } // end if
        __state = state;
    } // End of the function
    function setState(state)
    {
        if (__state != state)
        {
            this.setStateVar(state);
            this.invalidate();
        } // end if
    } // End of the function
    function size(Void)
    {
        this.refresh();
    } // End of the function
    function draw(Void)
    {
        if (initializing)
        {
            initializing = false;
            skinName.visible = true;
            iconName.visible = true;
        } // end if
        this.size();
    } // End of the function
    function getState(Void)
    {
        return (__state);
    } // End of the function
    function setToggle(val)
    {
        __toggle = val;
        if (__toggle == false)
        {
            this.setState(false);
        } // end if
    } // End of the function
    function getToggle(Void)
    {
        return (__toggle);
    } // End of the function
    function __set__toggle(val)
    {
        this.setToggle(val);
        return (this.__get__toggle());
        null;
    } // End of the function
    function __get__toggle()
    {
        return (this.getToggle());
    } // End of the function
    function __set__value(val)
    {
        this.setSelected(val);
        return (this.__get__value());
        null;
    } // End of the function
    function __get__value()
    {
        return (this.getSelected());
    } // End of the function
    function __set__selected(val)
    {
        this.setSelected(val);
        return (this.__get__selected());
        null;
    } // End of the function
    function __get__selected()
    {
        return (this.getSelected());
    } // End of the function
    function setSelected(val)
    {
        if (__toggle)
        {
            this.setState(val);
        }
        else
        {
            this.setState(initializing ? (val) : (__state));
        } // end if
    } // End of the function
    function getSelected()
    {
        return (__state);
    } // End of the function
    function setEnabled(val)
    {
        if (enabled != val)
        {
            super.setEnabled(val);
            this.invalidate();
        } // end if
    } // End of the function
    function onPress(Void)
    {
        this.pressFocus();
        phase = "down";
        this.refresh();
        this.dispatchEvent({type: "buttonDown"});
        if (autoRepeat)
        {
            interval = setInterval(this, "onPressDelay", this.getStyle("repeatDelay"));
        } // end if
    } // End of the function
    function onPressDelay(Void)
    {
        this.dispatchEvent({type: "buttonDown"});
        if (autoRepeat)
        {
            clearInterval(interval);
            interval = setInterval(this, "onPressRepeat", this.getStyle("repeatInterval"));
        } // end if
    } // End of the function
    function onPressRepeat(Void)
    {
        this.dispatchEvent({type: "buttonDown"});
        updateAfterEvent();
    } // End of the function
    function onRelease(Void)
    {
        this.releaseFocus();
        phase = "rollover";
        if (interval != undefined)
        {
            clearInterval(interval);
            delete this.interval;
        } // end if
        if (this.getToggle())
        {
            this.setState(!this.getState());
        }
        else
        {
            this.refresh();
        } // end if
        this.dispatchEvent({type: "click"});
    } // End of the function
    function onDragOut(Void)
    {
        phase = "up";
        this.refresh();
        this.dispatchEvent({type: "buttonDragOut"});
    } // End of the function
    function onDragOver(Void)
    {
        if (phase != "up")
        {
            this.onPress();
            return (undefined);
        }
        else
        {
            phase = "down";
            this.refresh();
        } // end if
    } // End of the function
    function onReleaseOutside(Void)
    {
        this.releaseFocus();
        phase = "up";
        if (interval != undefined)
        {
            clearInterval(interval);
            delete this.interval;
        } // end if
    } // End of the function
    function onRollOver(Void)
    {
        phase = "rollover";
        this.refresh();
    } // End of the function
    function onRollOut(Void)
    {
        phase = "up";
        this.refresh();
    } // End of the function
    function getLabel(Void)
    {
        return (fui.text);
    } // End of the function
    function setLabel(val)
    {
        if (typeof(fui) == "string")
        {
            this.createLabel("fui", 8, val);
            fui.styleName = this;
        }
        else
        {
            fui.text = val;
        } // end if
        var _l4 = fui._getTextFormat();
        var _l2 = _l4.getTextExtent2(val);
        fui._width = _l2.width + 5;
        fui._height = _l2.height + 5;
        iconName = fui;
        this.setView(__state);
    } // End of the function
    function __get__emphasized()
    {
        return (__emphasized);
    } // End of the function
    function __set__emphasized(val)
    {
        __emphasized = val;
        var _l2 = 0;
        while (_l2 < 8)
        {
            idNames[_l2] = stateNames[_l2] + "Skin";
            if (typeof(this[idNames[_l2 + 8]]) == "movieclip")
            {
                idNames[_l2 + 8] = stateNames[_l2] + "Icon";
            } // end if
            ++_l2;
        } // end while
        this.showEmphasized(__emphasized);
        this.setStateVar(__state);
        this.invalidateStyle();
        return (this.__get__emphasized());
        null;
    } // End of the function
    function keyDown(e)
    {
        if (e.code == 32)
        {
            this.onPress();
        } // end if
    } // End of the function
    function keyUp(e)
    {
        if (e.code == 32)
        {
            this.onRelease();
        } // end if
    } // End of the function
    function onKillFocus(newFocus)
    {
        super.onKillFocus();
        if (phase != "up")
        {
            phase = "up";
            this.refresh();
        } // end if
    } // End of the function
    static var symbolName = "SimpleButton";
    static var symbolOwner = mx.controls.SimpleButton;
    static var version = "2.0.1.78";
    var className = "SimpleButton";
    var style3dInset = 4;
    var btnOffset = 1;
    var __toggle = false;
    var __state = false;
    var __emphasized = false;
    var __emphatic = false;
    static var falseUp = 0;
    static var falseDown = 1;
    static var falseOver = 2;
    static var falseDisabled = 3;
    static var trueUp = 4;
    static var trueDown = 5;
    static var trueOver = 6;
    static var trueDisabled = 7;
    var falseUpSkin = "SimpleButtonUp";
    var falseDownSkin = "SimpleButtonIn";
    var falseOverSkin = "";
    var falseDisabledSkin = "SimpleButtonUp";
    var trueUpSkin = "SimpleButtonIn";
    var trueDownSkin = "";
    var trueOverSkin = "";
    var trueDisabledSkin = "SimpleButtonIn";
    var falseUpIcon = "";
    var falseDownIcon = "";
    var falseOverIcon = "";
    var falseDisabledIcon = "";
    var trueUpIcon = "";
    var trueDownIcon = "";
    var trueOverIcon = "";
    var trueDisabledIcon = "";
    var phase = "up";
    var fui = "falseUpIcon";
    var fus = "falseUpSkin";
    var fdi = "falseDownIcon";
    var fds = "falseDownSkin";
    var frs = "falseOverSkin";
    var fri = "falseOverIcon";
    var dfi = "falseDisabledIcon";
    var dfs = "falseDisabledSkin";
    var tui = "trueUpIcon";
    var tus = "trueUpSkin";
    var tdi = "trueDownIcon";
    var tds = "trueDownSkin";
    var trs = "trueOverSkin";
    var tri = "trueOverIcon";
    var dts = "trueDisabledSkin";
    var dti = "trueDisabledIcon";
    var rolloverSkin = mx.controls.SimpleButton.prototype.frs;
    var rolloverIcon = mx.controls.SimpleButton.prototype.fri;
    var upSkin = mx.controls.SimpleButton.prototype.fus;
    var downSkin = mx.controls.SimpleButton.prototype.fds;
    var disabledSkin = mx.controls.SimpleButton.prototype.dfs;
    var upIcon = mx.controls.SimpleButton.prototype.fui;
    var downIcon = mx.controls.SimpleButton.prototype.fdi;
    var disabledIcon = mx.controls.SimpleButton.prototype.dfi;
    var initializing = true;
    var idNames = ["fus", "fds", "frs", "dfs", "tus", "tds", "trs", "dts", "fui", "fdi", "fri", "dfi", "tui", "tdi", "tri", "dti"];
    var stateNames = ["falseUp", "falseDown", "falseOver", "falseDisabled", "trueUp", "trueDown", "trueOver", "trueDisabled"];
    var refNames = ["upSkin", "downSkin", "rolloverSkin", "disabledSkin"];
    var tagMap = {falseUpSkin: 0, falseDownSkin: 1, falseOverSkin: 2, falseDisabledSkin: 3, trueUpSkin: 4, trueDownSkin: 5, trueOverSkin: 6, trueDisabledSkin: 7, falseUpIcon: 0, falseDownIcon: 1, falseOverIcon: 2, falseDisabledIcon: 3, trueUpIcon: 4, trueDownIcon: 5, trueOverIcon: 6, trueDisabledIcon: 7};
} // End of Class
