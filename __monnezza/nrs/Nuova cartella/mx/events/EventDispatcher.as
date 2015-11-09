class mx.events.EventDispatcher
{
    var _l3;
    function EventDispatcher()
    {
    } // End of the function
    static function _removeEventListener(queue, event, handler)
    {
        if (queue != undefined)
        {
            var _l4 = queue.length;
            var _l1;
            _l1 = 0;
            while (_l1 < _l4)
            {
                var _l2 = queue[_l1];
                if (_l2 == handler)
                {
                    queue.splice(_l1, 1);
                    return (undefined);
                } // end if
                ++_l1;
            } // end while
        } // end if
    } // End of the function
    static function initialize(object)
    {
        if (mx.events.EventDispatcher._fEventDispatcher == undefined)
        {
            mx.events.EventDispatcher._fEventDispatcher = new mx.events.EventDispatcher();
        } // end if
        object.addEventListener = mx.events.EventDispatcher._fEventDispatcher.addEventListener;
        object.removeEventListener = mx.events.EventDispatcher._fEventDispatcher.removeEventListener;
        object.dispatchEvent = mx.events.EventDispatcher._fEventDispatcher.dispatchEvent;
        object.dispatchQueue = mx.events.EventDispatcher._fEventDispatcher.dispatchQueue;
    } // End of the function
    function dispatchQueue(queueObj, eventObj)
    {
        var _l7 = "__q_" + eventObj.type;
        var _l4 = queueObj[_l7];
        if (_l4 != undefined)
        {
            var _l5;
            for (var _l5 in _l4)
            {
                var _l1 = _l4[_l5];
                var _l3 = typeof(_l1);
                if (_l3 == "object" || _l3 == "movieclip")
                {
                    if (_l1.handleEvent != undefined)
                    {
                        _l1.handleEvent(eventObj);
                    } // end if
                    if (_l1[eventObj.type] != undefined)
                    {
                        if (mx.events.EventDispatcher.exceptions[eventObj.type] == undefined)
                        {
                            _l1[eventObj.type](eventObj);
                        } // end if
                    } // end if
                }
                else
                {
                    _l1.apply(queueObj, [eventObj]);
                } // end if
            } // end of for...in
        } // end if
    } // End of the function
    function dispatchEvent(eventObj)
    {
        if (eventObj.target == undefined)
        {
            eventObj.target = this;
        } // end if
        this(eventObj);
        this.dispatchQueue(this, eventObj);
    } // End of the function
    function addEventListener(event, handler)
    {
        var _l3 = "__q_" + event;
        if (this[_l3] == undefined)
        {
            _l3 = new Array();
        } // end if
        _global.ASSetPropFlags(this, _l3, 1);
        mx.events.EventDispatcher._removeEventListener(this[_l3], event, handler);
        this[_l3].push(handler);
    } // End of the function
    function removeEventListener(event, handler)
    {
        var _l2 = "__q_" + event;
        mx.events.EventDispatcher._removeEventListener(this[_l2], event, handler);
    } // End of the function
    static var _fEventDispatcher = undefined;
    static var exceptions = {move: 1, draw: 1};
} // End of Class
