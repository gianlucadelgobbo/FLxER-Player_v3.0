class mx.controls.listclasses.DataProvider extends Object
{
    var _l4[_l3], __ID__, length, index, splice;
    function DataProvider(obj)
    {
        super();
    } // End of the function
    static function Initialize(obj)
    {
        var _l4 = mx.controls.listclasses.DataProvider.mixinProps;
        var _l6 = _l4.length;
        var _l3 = 0;
        while (_l3 < _l6)
        {
            _l4[_l3] = mx.controls.listclasses.DataProvider.mixins[_l4[_l3]];
            _global.ASSetPropFlags(obj, _l4[_l3], 1);
            ++_l3;
        } // end while
        mx.events.EventDispatcher.initialize(obj);
        _global.ASSetPropFlags(obj, "addEventListener", 1);
        _global.ASSetPropFlags(obj, "removeEventListener", 1);
        _global.ASSetPropFlags(obj, "dispatchEvent", 1);
        _global.ASSetPropFlags(obj, "dispatchQueue", 1);
        Object.prototype.LargestID = 0;
        Object.prototype.getID = function ()
        {
            if (__ID__ == undefined)
            {
                __ID__ = Object.prototype.LargestID++;
                _global.ASSetPropFlags(this, "__ID__", 1);
            } // end if
            return (__ID__);
        };
        _global.ASSetPropFlags(Object.prototype, "LargestID", 1);
        _global.ASSetPropFlags(Object.prototype, "getID", 1);
        return (true);
    } // End of the function
    function addItemAt(index, value)
    {
        if (length > index)
        {
            this.splice(index, 0, value);
        }
        else if (length < index)
        {
            trace ("Cannot add an item past the end of the DataProvider");
            return (undefined);
        } // end if
        index = value;
        this.updateViews("addItems", index, index);
    } // End of the function
    function addItem(value)
    {
        this.addItemAt(length, value);
    } // End of the function
    function addItemsAt(index, newItems)
    {
        var _l2 = Math.min(length, index);
        newItems.unshift(_l2, 0);
        splice.apply(this, newItems);
        newItems.splice(0, 2);
        this.updateViews("addItems", _l2, _l2 + newItems.length - 1);
    } // End of the function
    function removeItemsAt(index, len)
    {
        var _l3 = new Array();
        var _l2 = 0;
        while (_l2 < len)
        {
            _l3.push(this.getItemID(index + _l2));
            ++_l2;
        } // end while
        var _l6 = this.splice(index, len);
        this.dispatchEvent({type: "modelChanged", eventName: "removeItems", firstItem: index, lastItem: index + len - 1, removedItems: _l6, removedIDs: _l3});
    } // End of the function
    function removeItemAt(index)
    {
        var _l2 = this[index];
        this.removeItemsAt(index, 1);
        return (_l2);
    } // End of the function
    function removeAll(Void)
    {
        this.splice(0);
        this.updateViews("removeItems", 0, length - 1);
    } // End of the function
    function replaceItemAt(index, itemObj)
    {
        if (index < 0 || length <= index)
        {
            return (undefined);
        } // end if
        var _l3 = this.getItemID(index);
        index = itemObj;
        this[index].__ID__ = _l3;
        this.updateViews("updateItems", index, index);
    } // End of the function
    function getItemAt(index)
    {
        return (this[index]);
    } // End of the function
    function getItemID(index)
    {
        var _l2 = this[index];
        if (typeof(_l2) != "object" && _l2 != undefined)
        {
            return (index);
        }
        else
        {
            return (_l2.getID());
        } // end if
    } // End of the function
    function sortItemsBy(fieldName, order)
    {
        if (typeof(order) == "string")
        {
            this.sortOn(fieldName);
            if (order.toUpperCase() == "DESC")
            {
                this.reverse();
            } // end if
        }
        else
        {
            this.sortOn(fieldName, order);
        } // end if
        this.updateViews("sort");
    } // End of the function
    function sortItems(compareFunc, optionFlags)
    {
        this.sort(compareFunc, optionFlags);
        this.updateViews("sort");
    } // End of the function
    function editField(index, fieldName, newData)
    {
        this[index][fieldName] = newData;
        this.dispatchEvent({type: "modelChanged", eventName: "updateField", firstItem: index, lastItem: index, fieldName: fieldName});
    } // End of the function
    function getEditingData(index, fieldName)
    {
        return (this[index][fieldName]);
    } // End of the function
    function updateViews(event, first, last)
    {
        this.dispatchEvent({type: "modelChanged", eventName: event, firstItem: first, lastItem: last});
    } // End of the function
    static var mixinProps = ["addView", "addItem", "addItemAt", "removeAll", "removeItemAt", "replaceItemAt", "getItemAt", "getItemID", "sortItemsBy", "sortItems", "updateViews", "addItemsAt", "removeItemsAt", "getEditingData", "editField"];
    static var evtDipatcher = mx.events.EventDispatcher;
    static var mixins = new mx.controls.listclasses.DataProvider();
} // End of Class
