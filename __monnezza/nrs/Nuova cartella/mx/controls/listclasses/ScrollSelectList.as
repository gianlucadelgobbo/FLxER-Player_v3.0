class mx.controls.listclasses.ScrollSelectList extends mx.core.ScrollView
{
    var rows, topRowZ, listContent, __vPosition, __dataProvider, tW, layoutX, layoutY, tH, invRowHeight, __height, invUpdateControl, __cellRenderer, __labelFunction, __iconField, __iconFunction, baseRowZ, lastPosition, propertyTable, wasKeySelected, changeFlag, lastSelected, dragScrolling, _ymouse, scrollInterval, enabled, isPressed, onMouseUp, tabEnabled, tabChildren, invLayoutContent, border_mc;
    function ScrollSelectList()
    {
        super();
    } // End of the function
    function layoutContent(x, y, w, h)
    {
        delete this.invLayoutContent;
        var _l4 = Math.ceil(h / __rowHeight);
        roundUp = h % __rowHeight != 0;
        var _l12 = _l4 - __rowCount;
        if (_l12 < 0)
        {
            var _l3 = _l4;
            while (_l3 < __rowCount)
            {
                rows[_l3].removeMovieClip();
                delete rows[_l3];
                ++_l3;
            } // end while
            topRowZ = topRowZ + _l12;
        }
        else if (_l12 > 0)
        {
            if (rows == undefined)
            {
                rows = new Array();
            } // end if
            _l3 = __rowCount;
            while (_l3 < _l4)
            {
                var _l2 = rows[_l3] = listContent.createObject(__rowRenderer, "listRow" + topRowZ++, topRowZ, {owner: this, styleName: this, rowIndex: _l3});
                _l2._x = x;
                _l2._y = Math.round(_l3 * __rowHeight + y);
                _l2.setSize(w, __rowHeight);
                _l2.drawRow(__dataProvider.getItemAt(__vPosition + _l3), this.getStateAt(__vPosition + _l3));
                _l2.lastY = _l2._y;
                ++_l3;
            } // end while
        } // end if
        if (tW != w)
        {
            var _l11 = _l12 > 0 ? (__rowCount) : (_l4);
            _l3 = 0;
            while (_l3 < _l11)
            {
                rows[_l3].setSize(w, __rowHeight);
                ++_l3;
            } // end while
        } // end if
        if (layoutX != x || layoutY != y)
        {
            _l3 = 0;
            while (_l3 < _l4)
            {
                rows[_l3]._x = x;
                rows[_l3]._y = Math.round(_l3 * __rowHeight + y);
                ++_l3;
            } // end while
        } // end if
        __rowCount = _l4;
        layoutX = x;
        layoutY = y;
        tW = w;
        tH = h;
    } // End of the function
    function getRowHeight(Void)
    {
        return (__rowHeight);
    } // End of the function
    function setRowHeight(v)
    {
        __rowHeight = v;
        invRowHeight = true;
        this.invalidate();
    } // End of the function
    function __get__rowHeight()
    {
        return (this.getRowHeight());
    } // End of the function
    function __set__rowHeight(w)
    {
        this.setRowHeight(w);
        return (this.__get__rowHeight());
        null;
    } // End of the function
    function setRowCount(v)
    {
        __rowCount = v;
    } // End of the function
    function getRowCount(Void)
    {
        var _l2 = __rowCount == 0 ? (Math.ceil(__height / __rowHeight)) : (__rowCount);
        return (_l2);
    } // End of the function
    function __get__rowCount()
    {
        return (this.getRowCount());
    } // End of the function
    function __set__rowCount(w)
    {
        this.setRowCount(w);
        return (this.__get__rowCount());
        null;
    } // End of the function
    function setEnabled(v)
    {
        super.setEnabled(v);
        invUpdateControl = true;
        this.invalidate();
    } // End of the function
    function setCellRenderer(cR)
    {
        __cellRenderer = cR;
        var _l2 = 0;
        while (_l2 < rows.length)
        {
            rows[_l2].setCellRenderer(true);
            ++_l2;
        } // end while
        invUpdateControl = true;
        this.invalidate();
    } // End of the function
    function __set__cellRenderer(cR)
    {
        this.setCellRenderer(cR);
        return (this.__get__cellRenderer());
        null;
    } // End of the function
    function __get__cellRenderer()
    {
        return (__cellRenderer);
    } // End of the function
    function __set__labelField(field)
    {
        this.setLabelField(field);
        return (this.__get__labelField());
        null;
    } // End of the function
    function setLabelField(field)
    {
        __labelField = field;
        invUpdateControl = true;
        this.invalidate();
    } // End of the function
    function __get__labelField()
    {
        return (__labelField);
    } // End of the function
    function __set__labelFunction(func)
    {
        this.setLabelFunction(func);
        return (this.__get__labelFunction());
        null;
    } // End of the function
    function setLabelFunction(func)
    {
        __labelFunction = func;
        invUpdateControl = true;
        this.invalidate();
    } // End of the function
    function __get__labelFunction()
    {
        return (__labelFunction);
    } // End of the function
    function __set__iconField(field)
    {
        this.setIconField(field);
        return (this.__get__iconField());
        null;
    } // End of the function
    function setIconField(field)
    {
        __iconField = field;
        invUpdateControl = true;
        this.invalidate();
    } // End of the function
    function __get__iconField()
    {
        return (__iconField);
    } // End of the function
    function __set__iconFunction(func)
    {
        this.setIconFunction(func);
        return (this.__get__iconFunction());
        null;
    } // End of the function
    function setIconFunction(func)
    {
        __iconFunction = func;
        invUpdateControl = true;
        this.invalidate();
    } // End of the function
    function __get__iconFunction()
    {
        return (__iconFunction);
    } // End of the function
    function setVPosition(pos)
    {
        if (pos < 0)
        {
            return (undefined);
        } // end if
        if (pos > 0 && this.getLength() - __rowCount + roundUp < pos)
        {
            return (undefined);
        } // end if
        var _l8 = pos - __vPosition;
        if (_l8 == 0)
        {
            return (undefined);
        } // end if
        __vPosition = pos;
        var _l10 = _l8 > 0;
        _l8 = Math.abs(_l8);
        if (_l8 >= __rowCount)
        {
            this.updateControl();
        }
        else
        {
            var _l4 = new Array();
            var _l9 = __rowCount - _l8;
            var _l12 = _l8 * __rowHeight;
            var _l11 = _l9 * __rowHeight;
            var _l6 = _l10 ? (1) : (-1);
            var _l3 = 0;
            while (_l3 < __rowCount)
            {
                if (_l3 < _l8 && _l10 || _l3 >= _l9 && !_l10)
                {
                    rows[_l3]._y = rows[_l3]._y + Math.round(_l6 * _l11);
                    var _l5 = _l3 + _l6 * _l9;
                    var _l7 = __vPosition + _l5;
                    _l4[_l5] = rows[_l3];
                    _l4[_l5].rowIndex = _l5;
                    _l4[_l5].drawRow(__dataProvider.getItemAt(_l7), this.getStateAt(_l7), false);
                }
                else
                {
                    rows[_l3]._y = rows[_l3]._y - Math.round(_l6 * _l12);
                    _l5 = _l3 - _l6 * _l8;
                    _l4[_l5] = rows[_l3];
                    _l4[_l5].rowIndex = _l5;
                } // end if
                ++_l3;
            } // end while
            rows = _l4;
            _l3 = 0;
            while (_l3 < __rowCount)
            {
                rows[_l3].swapDepths(baseRowZ + _l3);
                ++_l3;
            } // end while
        } // end if
        lastPosition = pos;
        super.setVPosition(pos);
    } // End of the function
    function setPropertiesAt(index, obj)
    {
        var _l2 = __dataProvider.getItemID(index);
        if (_l2 == undefined)
        {
            return (undefined);
        } // end if
        if (propertyTable == undefined)
        {
            propertyTable = new Object();
        } // end if
        propertyTable[_l2] = obj;
        rows[index - __vPosition].drawRow(__dataProvider.getItemAt(index), this.getStateAt(index));
    } // End of the function
    function getPropertiesAt(index)
    {
        var _l2 = __dataProvider.getItemID(index);
        if (_l2 == undefined)
        {
            return (undefined);
        } // end if
        return (propertyTable[_l2]);
    } // End of the function
    function getPropertiesOf(obj)
    {
        var _l2 = obj.getID();
        if (_l2 == undefined)
        {
            return (undefined);
        } // end if
        return (propertyTable[_l2]);
    } // End of the function
    function getStyle(styleProp)
    {
        var _l2 = super.getStyle(styleProp);
        var _l3 = mx.styles.StyleManager.colorNames[_l2];
        if (_l3 != undefined)
        {
            _l2 = _l3;
        } // end if
        return (_l2);
    } // End of the function
    function updateControl(Void)
    {
        var _l2 = 0;
        while (_l2 < __rowCount)
        {
            rows[_l2].drawRow(__dataProvider.getItemAt(_l2 + __vPosition), this.getStateAt(_l2 + __vPosition));
            ++_l2;
        } // end while
        delete this.invUpdateControl;
    } // End of the function
    function getStateAt(index)
    {
        return (this.isSelected(index) ? ("selected") : ("normal"));
    } // End of the function
    function selectRow(rowIndex, transition, allowChangeEvent)
    {
        if (!selectable)
        {
            return (undefined);
        } // end if
        var _l3 = __vPosition + rowIndex;
        var _l8 = __dataProvider.getItemAt(_l3);
        var _l5 = rows[rowIndex];
        if (_l8 == undefined)
        {
            return (undefined);
        } // end if
        if (transition == undefined)
        {
            var _l6 = true;
        } // end if
        if (allowChangeEvent == undefined)
        {
            var _l10 = wasKeySelected;
        } // end if
        changeFlag = true;
        if (!multipleSelection && !Key.isDown(17) || !Key.isDown(16) && !Key.isDown(17))
        {
            this.clearSelected(_l6);
            this.selectItem(_l3, true);
            lastSelected = _l3;
            _l5.drawRow(_l5.item, this.getStateAt(_l3), _l6);
        }
        else if (Key.isDown(16) && multipleSelection)
        {
            if (lastSelected == undefined)
            {
                lastSelected = _l3;
            } // end if
            var _l4 = lastSelected < _l3 ? (1) : (-1);
            this.clearSelected(false);
            var _l2 = lastSelected;
            while (_l2 != _l3)
            {
                this.selectItem(_l2, true);
                if (_l2 >= __vPosition && _l2 < __vPosition + __rowCount)
                {
                    rows[_l2 - __vPosition].drawRow(rows[_l2 - __vPosition].item, "selected", false);
                } // end if
                _l2 = _l2 + _l4;
            } // end while
            this.selectItem(_l3, true);
            _l5.drawRow(_l5.item, "selected", _l6);
        }
        else if (Key.isDown(17))
        {
            var _l7 = this.isSelected(_l3);
            if (!multipleSelection || wasKeySelected)
            {
                this.clearSelected(_l6);
            } // end if
            if (!(!multipleSelection && _l7))
            {
                this.selectItem(_l3, !_l7);
                var _l9 = !_l7 ? ("selected") : ("normal");
                _l5.drawRow(_l5.item, _l9, _l6);
            } // end if
            lastSelected = _l3;
        } // end if
        if (_l10)
        {
            this.dispatchEvent({type: "change"});
        } // end if
        delete this.wasKeySelected;
    } // End of the function
    function dragScroll(Void)
    {
        clearInterval(dragScrolling);
        if (_ymouse < 0)
        {
            this.setVPosition(__vPosition - 1);
            this.selectRow(0, false);
            var _l2 = Math.min(-_ymouse - 30, 0);
            scrollInterval = 0.593000 * _l2 * _l2 + 1 + minScrollInterval;
            dragScrolling = setInterval(this, "dragScroll", scrollInterval);
            this.dispatchEvent({type: "scroll", direction: "vertical", position: __vPosition});
        }
        else if (_ymouse > __height)
        {
            var _l3 = __vPosition;
            this.setVPosition(__vPosition + 1);
            if (_l3 != __vPosition)
            {
                this.selectRow(__rowCount - 1 - roundUp, false);
            } // end if
            _l2 = Math.min(_ymouse - __height - 30, 0);
            scrollInterval = 0.593000 * _l2 * _l2 + 1 + minScrollInterval;
            dragScrolling = setInterval(this, "dragScroll", scrollInterval);
            this.dispatchEvent({type: "scroll", direction: "vertical", position: __vPosition});
        }
        else
        {
            dragScrolling = setInterval(this, "dragScroll", 15);
        } // end if
        updateAfterEvent();
    } // End of the function
    function __onMouseUp(Void)
    {
        clearInterval(dragScrolling);
        delete this.dragScrolling;
        delete this.dragScrolling;
        delete this.isPressed;
        delete this.onMouseUp;
        if (!selectable)
        {
            return (undefined);
        } // end if
        if (changeFlag)
        {
            this.dispatchEvent({type: "change"});
        } // end if
        delete this.changeFlag;
    } // End of the function
    function moveSelBy(incr)
    {
        if (!selectable)
        {
            this.setVPosition(__vPosition + incr);
            return (undefined);
        } // end if
        var _l3 = this.getSelectedIndex();
        if (_l3 == undefined)
        {
            _l3 = -1;
        } // end if
        var _l2 = _l3 + incr;
        _l2 = Math.max(0, _l2);
        _l2 = Math.min(this.getLength() - 1, _l2);
        if (_l2 == _l3)
        {
            return (undefined);
        } // end if
        if (_l3 < __vPosition || _l3 >= __vPosition + __rowCount)
        {
            this.setVPosition(_l3);
        } // end if
        if (_l2 >= __vPosition + __rowCount - roundUp || _l2 < __vPosition)
        {
            this.setVPosition(__vPosition + incr);
        } // end if
        wasKeySelected = true;
        this.selectRow(_l2 - __vPosition, false);
    } // End of the function
    function keyDown(e)
    {
        if (selectable)
        {
            if (this.findInputText())
            {
                return (undefined);
            } // end if
        } // end if
        if (e.code == 40)
        {
            this.moveSelBy(1);
        }
        else if (e.code == 38)
        {
            this.moveSelBy(-1);
        }
        else if (e.code == 34)
        {
            if (selectable)
            {
                var _l3 = this.getSelectedIndex();
                if (_l3 == undefined)
                {
                    _l3 = 0;
                } // end if
                this.setVPosition(_l3);
            } // end if
            this.moveSelBy(__rowCount - 1 - roundUp);
        }
        else if (e.code == 33)
        {
            if (selectable)
            {
                _l3 = this.getSelectedIndex();
                if (_l3 == undefined)
                {
                    _l3 = 0;
                } // end if
                this.setVPosition(_l3);
            } // end if
            this.moveSelBy(1 - __rowCount + roundUp);
        }
        else if (e.code == 36)
        {
            this.moveSelBy(-__dataProvider.length);
        }
        else if (e.code == 35)
        {
            this.moveSelBy(__dataProvider.length);
        } // end if
    } // End of the function
    function findInputText(Void)
    {
        var _l2 = Key.getAscii();
        if (_l2 >= 33 && _l2 <= 126)
        {
            this.findString(String.fromCharCode(_l2));
            return (true);
        } // end if
    } // End of the function
    function findString(str)
    {
        if (__dataProvider.length == 0)
        {
            return (undefined);
        } // end if
        var _l4 = this.getSelectedIndex();
        if (_l4 == undefined)
        {
            _l4 = 0;
        } // end if
        var _l6 = 0;
        var _l3 = _l4 + 1;
        while (_l3 != _l4)
        {
            var _l2 = __dataProvider.getItemAt(_l3);
            if (_l2 instanceof XMLNode)
            {
                _l2 = _l2.attributes[__labelField];
            }
            else if (typeof(_l2) != "string")
            {
                _l2 = String(_l2[__labelField]);
            } // end if
            _l2 = _l2.substring(0, str.length);
            if (_l2 == str || str.toUpperCase() == _l2.toUpperCase())
            {
                _l6 = _l3 - _l4;
                break;
            } // end if
            if (_l3 >= this.getLength() - 1)
            {
                _l3 = -1;
            } // end if
            ++_l3;
        } // end while
        if (_l6 != 0)
        {
            this.moveSelBy(_l6);
        } // end if
    } // End of the function
    function onRowPress(rowIndex)
    {
        if (!enabled)
        {
            return (undefined);
        } // end if
        isPressed = true;
        dragScrolling = setInterval(this, "dragScroll", 15);
        onMouseUp = __onMouseUp;
        if (!selectable)
        {
            return (undefined);
        } // end if
        this.selectRow(rowIndex);
    } // End of the function
    function onRowRelease(rowIndex)
    {
    } // End of the function
    function onRowRollOver(rowIndex)
    {
        if (!enabled)
        {
            return (undefined);
        } // end if
        var _l2 = rows[rowIndex].item;
        if (this.getStyle("useRollOver") && _l2 != undefined)
        {
            rows[rowIndex].drawRow(_l2, "highlighted", false);
        } // end if
        this.dispatchEvent({type: "itemRollOver", index: rowIndex + __vPosition});
    } // End of the function
    function onRowRollOut(rowIndex)
    {
        if (!enabled)
        {
            return (undefined);
        } // end if
        if (this.getStyle("useRollOver"))
        {
            rows[rowIndex].drawRow(rows[rowIndex].item, this.getStateAt(rowIndex + __vPosition), false);
        } // end if
        this.dispatchEvent({type: "itemRollOut", index: rowIndex + __vPosition});
    } // End of the function
    function onRowDragOver(rowIndex)
    {
        if (!enabled || isPressed != true || !selectable)
        {
            return (undefined);
        } // end if
        if (dropEnabled)
        {
        }
        else if (dragScrolling)
        {
            this.selectRow(rowIndex, false);
        }
        else
        {
            onMouseUp = __onMouseUp;
            this.onRowPress(rowIndex);
        } // end if
    } // End of the function
    function onRowDragOut(rowIndex)
    {
        if (!enabled)
        {
            return (undefined);
        } // end if
        if (dragEnabled)
        {
        }
        else
        {
            this.onRowRollOut(rowIndex);
        } // end if
    } // End of the function
    function init(Void)
    {
        super.init();
        tabEnabled = true;
        tabChildren = false;
        if (__dataProvider == undefined)
        {
            __dataProvider = new Array();
            __dataProvider.addEventListener("modelChanged", this);
        } // end if
        baseRowZ = topRowZ = 10;
    } // End of the function
    function createChildren(Void)
    {
        super.createChildren();
        listContent = this.createEmptyMovieClip("content_mc", CONTENTDEPTH);
        invLayoutContent = true;
        this.invalidate();
    } // End of the function
    function draw(Void)
    {
        if (invRowHeight)
        {
            delete this.invRowHeight;
            __rowCount = 0;
            listContent.removeMovieClip();
            listContent = this.createEmptyMovieClip("content_mc", CONTENTDEPTH);
        } // end if
        if (invUpdateControl)
        {
            this.updateControl();
        } // end if
        border_mc.draw();
    } // End of the function
    function invalidateStyle(propName)
    {
        if (isRowStyle[propName])
        {
            invUpdateControl = true;
            this.invalidate();
        }
        else
        {
            var _l3 = 0;
            while (_l3 < __rowCount)
            {
                rows[_l3].invalidateStyle(propName);
                ++_l3;
            } // end while
        } // end if
        super.invalidateStyle(propName);
    } // End of the function
    static var mixIt1 = mx.controls.listclasses.DataSelector.Initialize(mx.controls.listclasses.ScrollSelectList);
    static var mixIt2 = mx.controls.listclasses.DataProvider.Initialize(Array);
    var CONTENTDEPTH = 100;
    var __hPosition = 0;
    var __rowRenderer = "SelectableRow";
    var __rowHeight = 22;
    var __rowCount = 0;
    var __labelField = "label";
    var minScrollInterval = 30;
    var dropEnabled = false;
    var dragEnabled = false;
    var className = "ScrollSelectList";
    var isRowStyle = {styleName: true, backgroundColor: true, selectionColor: true, rollOverColor: true, selectionDisabledColor: true, backgroundDisabledColor: true, textColor: true, textSelectedColor: true, textRollOverColor: true, textDisabledColor: true, alternatingRowColors: true, defaultIcon: true};
    var roundUp = 0;
    var selectable = true;
    var multipleSelection = false;
} // End of Class
