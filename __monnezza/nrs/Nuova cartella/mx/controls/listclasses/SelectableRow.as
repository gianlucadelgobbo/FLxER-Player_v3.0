class mx.controls.listclasses.SelectableRow extends mx.core.UIComponent
{
    var __height, cell, owner, rowIndex, icon_mc, __width, backGround, highlightColor, highlight, listOwner, tabEnabled, item, drawRect, isChangedToSelected, bGTween, grandOwner;
    function SelectableRow()
    {
        super();
    } // End of the function
    function setValue(itmObj, state)
    {
        var _l7 = __height;
        var _l2 = cell;
        var _l5 = owner;
        var _l8 = this.itemToString(itmObj);
        if (_l2.getValue() != _l8)
        {
            _l2.setValue(_l8, itmObj, state);
        } // end if
        var _l4 = _l5.getPropertiesAt(rowIndex + _l5.__vPosition).icon;
        if (_l4 == undefined)
        {
            _l4 = _l5.__iconFunction(itmObj);
            if (_l4 == undefined)
            {
                _l4 = itmObj[_l5.__iconField];
                if (_l4 == undefined)
                {
                    _l4 = _l5.getStyle("defaultIcon");
                } // end if
            } // end if
        } // end if
        var _l3 = icon_mc;
        if (_l4 != undefined && itmObj != undefined)
        {
            _l3 = this.createObject(_l4, "icon_mc", 20);
            _l3._x = 2;
            _l3._y = (_l7 - _l3._height) / 2;
            _l2._x = 4 + _l3._width;
        }
        else
        {
            _l3.removeMovieClip();
            _l2._x = 2;
        } // end if
        var _l9 = _l3 == undefined ? (0) : (_l3._width);
        _l2.setSize(__width - _l9, Math.min(_l7, _l2.getPreferredHeight()));
        _l2._y = (_l7 - _l2._height) / 2;
    } // End of the function
    function size(Void)
    {
        var _l3 = backGround;
        var _l2 = cell;
        var _l4 = __height;
        var _l5 = __width;
        var _l6 = icon_mc == undefined ? (0) : (icon_mc._width);
        _l2.setSize(_l5 - _l6, Math.min(_l4, _l2.getPreferredHeight()));
        _l2._y = (_l4 - _l2._height) / 2;
        icon_mc._y = (_l4 - icon_mc._height) / 2;
        _l3._x = 0;
        _l3._width = _l5;
        _l3._height = _l4;
        this.drawRowFill(_l3, normalColor);
        this.drawRowFill(highlight, highlightColor);
    } // End of the function
    function setCellRenderer(forceSizing)
    {
        var _l3 = owner.__cellRenderer;
        var _l4;
        if (cell != undefined)
        {
            _l4 = cell._x;
            cell.removeMovieClip();
            cell.removeTextField();
        } // end if
        var _l2;
        if (_l3 == undefined)
        {
            _l2 = cell = this.createLabel("cll", 0, {styleName: this});
            _l2.styleName = owner;
            _l2.selectable = false;
            _l2.tabEnabled = false;
            _l2.background = false;
            _l2.border = false;
        }
        else if (typeof(_l3) == "string")
        {
            _l2 = cell = this.createObject(_l3, "cll", 0, {styleName: this});
        }
        else
        {
            _l2 = cell = this.createClassObject(_l3, "cll", 0, {styleName: this});
        } // end if
        _l2.owner = this;
        _l2.listOwner = owner;
        _l2.getCellIndex = getCellIndex;
        _l2.getDataLabel = getDataLabel;
        if (_l4 != undefined)
        {
            _l2._x = _l4;
        } // end if
        if (forceSizing)
        {
            this.size();
        } // end if
    } // End of the function
    function getCellIndex(Void)
    {
        return ({columnIndex: 0, itemIndex: owner.rowIndex + listOwner.__vPosition});
    } // End of the function
    function getDataLabel()
    {
        return (listOwner.labelField);
    } // End of the function
    function init(Void)
    {
        super.init();
        tabEnabled = false;
    } // End of the function
    function createChildren(Void)
    {
        this.setCellRenderer(false);
        this.setupBG();
        this.setState(state, false);
    } // End of the function
    function drawRow(itmObj, state, transition)
    {
        item = itmObj;
        this.setState(state, transition);
        this.setValue(itmObj, state, transition);
    } // End of the function
    function itemToString(itmObj)
    {
        if (itmObj == undefined)
        {
            return (" ");
        } // end if
        var _l2 = owner.__labelFunction(itmObj);
        if (_l2 == undefined)
        {
            _l2 = itmObj instanceof XMLNode ? (itmObj.attributes[owner.__labelField]) : (itmObj[owner.__labelField]);
            if (_l2 == undefined)
            {
                _l2 = " ";
                if (typeof(itmObj) == "object")
                {
                    for (var _l4 in itmObj)
                    {
                        if (_l4 != "__ID__")
                        {
                            _l2 = itmObj[_l4] + ", " + _l2;
                        } // end if
                    } // end of for...in
                    _l2 = _l2.substring(0, _l2.length - 2);
                }
                else
                {
                    _l2 = itmObj;
                } // end if
            } // end if
        } // end if
        return (_l2);
    } // End of the function
    function setupBG(Void)
    {
        var _l2 = backGround = this.createEmptyMovieClip("bG_mc", mx.controls.listclasses.SelectableRow.LOWEST_DEPTH);
        this.drawRowFill(_l2, normalColor);
        highlight = this.createEmptyMovieClip("tran_mc", mx.controls.listclasses.SelectableRow.LOWEST_DEPTH + 10);
        _l2.owner = this;
        _l2.grandOwner = owner;
        _l2.onPress = bGOnPress;
        _l2.onRelease = bGOnRelease;
        _l2.onRollOver = bGOnRollOver;
        _l2.onRollOut = bGOnRollOut;
        _l2.onDragOver = bGOnDragOver;
        _l2.onDragOut = bGOnDragOut;
        _l2.useHandCursor = false;
        _l2.trackAsMenu = true;
        _l2.drawRect = drawRect;
        highlight.drawRect = drawRect;
    } // End of the function
    function drawRowFill(mc, newClr)
    {
        mc.clear();
        mc.beginFill(newClr);
        mc.drawRect(1, 0, __width, __height);
        mc.endFill();
        mc._width = __width;
        mc._height = __height;
    } // End of the function
    function setState(newState, transition)
    {
        var _l2 = highlight;
        var _l8 = backGround;
        var _l4 = __height;
        var _l3 = owner;
        if (!_l3.enabled)
        {
            if (newState == "selected" || state == "selected")
            {
                highlightColor = _l3.getStyle("selectionDisabledColor");
                this.drawRowFill(_l2, highlightColor);
                _l2._visible = true;
                _l2._y = 0;
                _l2._height = _l4;
            }
            else
            {
                _l2._visible = false;
                normalColor = _l3.getStyle("backgroundDisabledColor");
                this.drawRowFill(_l8, normalColor);
            } // end if
            cell.__enabled = false;
            cell.setColor(_l3.getStyle("disabledColor"));
        }
        else
        {
            cell.__enabled = true;
            if (transition && (state == newState || newState == "highlighted" && state == "selected"))
            {
                isChangedToSelected = true;
                return (undefined);
            } // end if
            var _l6 = _l3.getStyle("selectionDuration");
            var _l7 = 0;
            if (isChangedToSelected && newState == "selected")
            {
                var _l11 = false;
            } // end if
            var _l10 = _l11 && _l6 != 0;
            if (newState == "normal")
            {
                _l7 = _l3.getStyle("color");
                normalColor = this.getNormalColor();
                this.drawRowFill(_l8, normalColor);
                if (_l10)
                {
                    _l6 = _l6 / 2;
                    _l2._height = _l4;
                    _l2._width = __width;
                    _l2._y = 0;
                    bGTween = new mx.effects.Tween(this, _l4 + 2, _l4 * 0.200000, _l6, 5);
                }
                else
                {
                    _l2._visible = false;
                } // end if
                delete this.isChangedToSelected;
            }
            else
            {
                highlightColor = _l3.getStyle(newState == "highlighted" ? ("rollOverColor") : ("selectionColor"));
                this.drawRowFill(_l2, highlightColor);
                _l2._visible = true;
                _l7 = _l3.getStyle(newState == "highlighted" ? ("textRollOverColor") : ("textSelectedColor"));
                if (_l10)
                {
                    _l2._height = _l4 * 0.500000;
                    _l2._y = (_l4 - _l2._height) / 2;
                    bGTween = new mx.effects.Tween(this, _l2._height, _l4 + 2, _l6, 5);
                    var _l9 = _l3.getStyle("selectionEasing");
                    if (_l9 != undefined)
                    {
                        bGTween.easingEquation = _l9;
                    } // end if
                }
                else
                {
                    _l2._y = 0;
                    _l2._height = _l4;
                } // end if
            } // end if
            cell.setColor(_l7);
        } // end if
        state = newState;
    } // End of the function
    function onTweenUpdate(val)
    {
        highlight._height = val;
        highlight._y = (__height - val) / 2;
    } // End of the function
    function onTweenEnd(val)
    {
        this.onTweenUpdate(val);
        highlight._visible = state != "normal";
    } // End of the function
    function getNormalColor(Void)
    {
        var _l3;
        var _l2 = owner;
        if (!owner.enabled)
        {
            _l3 = _l2.getStyle("backgroundDisabledColor");
        }
        else
        {
            var _l5 = rowIndex + _l2.__vPosition;
            if (rowIndex == undefined)
            {
                _l3 = _l2.getPropertiesOf(item).backgroundColor;
            }
            else
            {
                _l3 = _l2.getPropertiesAt(_l5).backgroundColor;
            } // end if
            if (_l3 == undefined)
            {
                var _l4 = _l2.getStyle("alternatingRowColors");
                if (_l4 == undefined)
                {
                    _l3 = _l2.getStyle("backgroundColor");
                }
                else
                {
                    _l3 = _l4[_l5 % _l4.length];
                } // end if
            } // end if
        } // end if
        return (_l3);
    } // End of the function
    function invalidateStyle(propName)
    {
        cell.invalidateStyle(propName);
        super.invalidateStyle(propName);
    } // End of the function
    function bGOnPress(Void)
    {
        grandOwner.pressFocus();
        grandOwner.onRowPress(owner.rowIndex);
    } // End of the function
    function bGOnRelease(Void)
    {
        grandOwner.releaseFocus();
        grandOwner.onRowRelease(owner.rowIndex);
    } // End of the function
    function bGOnRollOver(Void)
    {
        grandOwner.onRowRollOver(owner.rowIndex);
    } // End of the function
    function bGOnRollOut(Void)
    {
        grandOwner.onRowRollOut(owner.rowIndex);
    } // End of the function
    function bGOnDragOver(Void)
    {
        grandOwner.onRowDragOver(owner.rowIndex);
    } // End of the function
    function bGOnDragOut(Void)
    {
        grandOwner.onRowDragOut(owner.rowIndex);
    } // End of the function
    static var LOWEST_DEPTH = -16384;
    var state = "normal";
    var disabledColor = 15263976;
    var normalColor = 16777215;
} // End of Class
