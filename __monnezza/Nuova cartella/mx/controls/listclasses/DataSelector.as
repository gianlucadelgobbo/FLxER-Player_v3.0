class mx.controls.listclasses.DataSelector extends Object
{
    var _l3[_l1], __vPosition, __dataProvider, enabled, lastSelected, lastSelID, selected, invUpdateControl, multipleSelection, __rowCount, rows;
    function DataSelector()
    {
        super();
    } // End of the function
    static function Initialize(obj)
    {
        var _l3 = mx.controls.listclasses.DataSelector.mixinProps;
        var _l4 = _l3.length;
        var _l1 = 0;
        while (_l1 < _l4)
        {
            _l3[_l1] = mx.controls.listclasses.DataSelector.mixins[_l3[_l1]];
            ++_l1;
        } // end while
        mx.controls.listclasses.DataSelector.mixins.createProp(obj, "dataProvider", true);
        mx.controls.listclasses.DataSelector.mixins.createProp(obj, "length", false);
        mx.controls.listclasses.DataSelector.mixins.createProp(obj, "value", false);
        mx.controls.listclasses.DataSelector.mixins.createProp(obj, "selectedIndex", true);
        mx.controls.listclasses.DataSelector.mixins.createProp(obj, "selectedIndices", true);
        mx.controls.listclasses.DataSelector.mixins.createProp(obj, "selectedItems", false);
        mx.controls.listclasses.DataSelector.mixins.createProp(obj, "selectedItem", true);
        return (true);
    } // End of the function
    function createProp(obj, propName, setter)
    {
        var p = propName.charAt(0).toUpperCase() + propName.substr(1);
        var _l2 = null;
        var _l3 = function (Void)
        {
            return (this());
        };
        if (setter)
        {
            var _l2 = function (val)
            {
                this(val);
            };
        } // end if
        obj.addProperty(propName, _l3, _l2);
    } // End of the function
    function setDataProvider(dP)
    {
        if (__vPosition != 0)
        {
            this.setVPosition(0);
        } // end if
        this.clearSelected();
        __dataProvider.removeEventListener(this);
        __dataProvider = dP;
        dP.addEventListener("modelChanged", this);
        dP.addView(this);
        this.modelChanged({eventName: "updateAll"});
    } // End of the function
    function getDataProvider(Void)
    {
        return (__dataProvider);
    } // End of the function
    function addItemAt(index, label, data)
    {
        if (index < 0 || !enabled)
        {
            return (undefined);
        } // end if
        var _l2 = __dataProvider;
        if (_l2 == undefined)
        {
            _l2 = __dataProvider = new Array();
            _l2.addEventListener("modelChanged", this);
            var _l3 = 0;
        } // end if
        if (typeof(label) == "object" || typeof(_l2.getItemAt(0)) == "string")
        {
            _l2.addItemAt(_l3, label);
        }
        else
        {
            _l2.addItemAt(_l3, {label: label, data: data});
        } // end if
    } // End of the function
    function addItem(label, data)
    {
        this.addItemAt(__dataProvider.length, label, data);
    } // End of the function
    function removeItemAt(index)
    {
        return (__dataProvider.removeItemAt(index));
    } // End of the function
    function removeAll(Void)
    {
        __dataProvider.removeAll();
    } // End of the function
    function replaceItemAt(index, newLabel, newData)
    {
        if (typeof(newLabel) == "object")
        {
            __dataProvider.replaceItemAt(index, newLabel);
        }
        else
        {
            __dataProvider.replaceItemAt(index, {label: newLabel, data: newData});
        } // end if
    } // End of the function
    function sortItemsBy(fieldName, order)
    {
        lastSelID = __dataProvider.getItemID(lastSelected);
        __dataProvider.sortItemsBy(fieldName, order);
    } // End of the function
    function sortItems(compareFunc, order)
    {
        lastSelID = __dataProvider.getItemID(lastSelected);
        __dataProvider.sortItems(compareFunc, order);
    } // End of the function
    function getLength(Void)
    {
        return (__dataProvider.length);
    } // End of the function
    function getItemAt(index)
    {
        return (__dataProvider.getItemAt(index));
    } // End of the function
    function modelChanged(eventObj)
    {
        var _l3 = eventObj.firstItem;
        var _l6 = eventObj.lastItem;
        var _l7 = eventObj.eventName;
        if (_l7 == undefined)
        {
            _l7 = eventObj.event;
            _l3 = eventObj.firstRow;
            _l6 = eventObj.lastRow;
            if (_l7 == "addRows")
            {
                _l7 = eventObj.eventName = "addItems";
            }
            else if (_l7 == "deleteRows")
            {
                _l7 = eventObj.eventName = "removeItems";
            }
            else if (_l7 == "updateRows")
            {
                _l7 = eventObj.eventName = "updateItems";
            } // end if
        } // end if
        if (_l7 == "addItems")
        {
            for (var _l2 in selected)
            {
                var _l5 = selected[_l2];
                if (_l5 != undefined && _l5 >= _l3)
                {
                    selected[_l2] = selected[_l2] + (_l6 - _l3 + 1);
                } // end if
            } // end of for...in
        }
        else if (_l7 == "removeItems")
        {
            if (__dataProvider.length == 0)
            {
                delete this.selected;
            }
            else
            {
                var _l9 = eventObj.removedIDs;
                var _l10 = _l9.length;
                _l2 = 0;
                while (_l2 < _l10)
                {
                    var _l4 = _l9[_l2];
                    if (selected[_l4] != undefined)
                    {
                        delete selected[_l4];
                    } // end if
                    ++_l2;
                } // end while
                for (var _l2 in selected)
                {
                    if (selected[_l2] >= _l3)
                    {
                        selected[_l2] = selected[_l2] - (_l6 - _l3 + 1);
                    } // end if
                } // end of for...in
            } // end if
        }
        else if (_l7 == "sort")
        {
            if (typeof(__dataProvider.getItemAt(0)) != "object")
            {
                delete this.selected;
            }
            else
            {
                _l10 = __dataProvider.length;
                _l2 = 0;
                while (_l2 < _l10)
                {
                    if (this.isSelected(_l2))
                    {
                        _l4 = __dataProvider.getItemID(_l2);
                        if (_l4 == lastSelID)
                        {
                            lastSelected = _l2;
                        } // end if
                        selected[_l4] = _l2;
                    } // end if
                    ++_l2;
                } // end while
            } // end if
        }
        else if (_l7 == "filterModel")
        {
            this.setVPosition(0);
        } // end if
        invUpdateControl = true;
        this.invalidate();
    } // End of the function
    function getValue(Void)
    {
        var _l2 = this.getSelectedItem();
        if (typeof(_l2) != "object")
        {
            return (_l2);
        } // end if
        return (_l2.data == undefined ? (_l2.label) : (_l2.data));
    } // End of the function
    function getSelectedIndex(Void)
    {
        for (var _l3 in selected)
        {
            var _l2 = selected[_l3];
            if (_l2 != undefined)
            {
                return (_l2);
            } // end if
        } // end of for...in
    } // End of the function
    function setSelectedIndex(index)
    {
        if (index >= 0 && __dataProvider.length > index && enabled)
        {
            delete this.selected;
            this.selectItem(index, true);
            lastSelected = index;
            invUpdateControl = true;
            this.invalidate();
        }
        else if (index == undefined)
        {
            this.clearSelected();
        } // end if
    } // End of the function
    function getSelectedIndices(Void)
    {
        var _l2 = new Array();
        for (var _l3 in selected)
        {
            _l2.push(selected[_l3]);
        } // end of for...in
        _l2.reverse();
        return (_l2.length > 0 ? (_l2) : (undefined));
    } // End of the function
    function setSelectedIndices(indexArray)
    {
        if (multipleSelection != true)
        {
            return (undefined);
        } // end if
        delete this.selected;
        var _l3 = 0;
        while (_l3 < indexArray.length)
        {
            var _l2 = indexArray[_l3];
            if (_l2 >= 0 && _l2 < __dataProvider.length)
            {
                this.selectItem(_l2, true);
            } // end if
            ++_l3;
        } // end while
        invUpdateControl = true;
        this.updateControl();
    } // End of the function
    function getSelectedItems(Void)
    {
        var _l3 = this.getSelectedIndices();
        var _l4 = new Array();
        var _l2 = 0;
        while (_l2 < _l3.length)
        {
            _l4.push(this.getItemAt(_l3[_l2]));
            ++_l2;
        } // end while
        return (_l4.length > 0 ? (_l4) : (undefined));
    } // End of the function
    function getSelectedItem(Void)
    {
        return (__dataProvider.getItemAt(this.getSelectedIndex()));
    } // End of the function
    function selectItem(index, selectedFlag)
    {
        if (selected == undefined)
        {
            selected = new Object();
        } // end if
        var _l2 = __dataProvider.getItemID(index);
        if (_l2 == undefined)
        {
            return (undefined);
        } // end if
        if (selectedFlag && !this.isSelected(index))
        {
            selected[_l2] = index;
        }
        else if (!selectedFlag)
        {
            delete selected[_l2];
        } // end if
    } // End of the function
    function isSelected(index)
    {
        var _l2 = __dataProvider.getItemID(index);
        if (_l2 == undefined)
        {
            return (false);
        } // end if
        return (selected[_l2] != undefined);
    } // End of the function
    function clearSelected(transition)
    {
        var _l3 = 0;
        for (var _l4 in selected)
        {
            var _l2 = selected[_l4];
            if (_l2 != undefined && __vPosition <= _l2 && _l2 < __vPosition + __rowCount)
            {
                rows[_l2 - __vPosition].drawRow(rows[_l2 - __vPosition].item, "normal", transition && _l3 % 3 == 0);
            } // end if
            ++_l3;
        } // end of for...in
        delete this.selected;
    } // End of the function
    static var mixins = new mx.controls.listclasses.DataSelector();
    static var mixinProps = ["setDataProvider", "getDataProvider", "addItem", "addItemAt", "removeAll", "removeItemAt", "replaceItemAt", "sortItemsBy", "sortItems", "getLength", "getItemAt", "modelChanged", "calcPreferredWidthFromData", "calcPreferredHeightFromData", "getValue", "getSelectedIndex", "getSelectedItem", "getSelectedIndices", "getSelectedItems", "selectItem", "isSelected", "clearSelected", "setSelectedIndex", "setSelectedIndices"];
} // End of Class
