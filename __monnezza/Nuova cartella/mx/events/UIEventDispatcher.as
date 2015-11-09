class mx.events.UIEventDispatcher extends mx.events.EventDispatcher
{
    var owner, __sentLoadEvent;
    function UIEventDispatcher()
    {
        super();
    } // End of the function
    static function addKeyEvents(obj)
    {
        if (obj.keyHandler == undefined)
        {
            var _l1 = obj.keyHandler = new Object();
            _l1.owner = obj;
            _l1.onKeyDown = mx.events.UIEventDispatcher._fEventDispatcher.onKeyDown;
            _l1.onKeyUp = mx.events.UIEventDispatcher._fEventDispatcher.onKeyUp;
        } // end if
        Key.addListener(obj.keyHandler);
    } // End of the function
    static function removeKeyEvents(obj)
    {
        Key.removeListener(obj.keyHandler);
    } // End of the function
    static function addLoadEvents(obj)
    {
        if (obj.onLoad == undefined)
        {
            obj.onLoad = mx.events.UIEventDispatcher._fEventDispatcher.onLoad;
            obj.onUnload = mx.events.UIEventDispatcher._fEventDispatcher.onUnload;
            if (obj.getBytesTotal() == obj.getBytesLoaded())
            {
                obj.doLater(obj, "onLoad");
            } // end if
        } // end if
    } // End of the function
    static function removeLoadEvents(obj)
    {
        delete obj.onLoad;
        delete obj.onUnload;
    } // End of the function
    static function initialize(obj)
    {
        if (mx.events.UIEventDispatcher._fEventDispatcher == undefined)
        {
            mx.events.UIEventDispatcher._fEventDispatcher = new mx.events.UIEventDispatcher();
        } // end if
        obj.addEventListener = mx.events.UIEventDispatcher._fEventDispatcher.__addEventListener;
        obj.__origAddEventListener = mx.events.UIEventDispatcher._fEventDispatcher.addEventListener;
        obj.removeEventListener = mx.events.UIEventDispatcher._fEventDispatcher.removeEventListener;
        obj.dispatchEvent = mx.events.UIEventDispatcher._fEventDispatcher.dispatchEvent;
        obj.dispatchQueue = mx.events.UIEventDispatcher._fEventDispatcher.dispatchQueue;
    } // End of the function
    function dispatchEvent(eventObj)
    {
        if (eventObj.target == undefined)
        {
            eventObj.target = this;
        } // end if
        this(eventObj);
        this.dispatchQueue(mx.events.EventDispatcher, eventObj);
        this.dispatchQueue(this, eventObj);
    } // End of the function
    function onKeyDown(Void)
    {
        owner.dispatchEvent({type: "keyDown", code: Key.getCode(), ascii: Key.getAscii(), shiftKey: Key.isDown(16), ctrlKey: Key.isDown(17)});
    } // End of the function
    function onKeyUp(Void)
    {
        owner.dispatchEvent({type: "keyUp", code: Key.getCode(), ascii: Key.getAscii(), shiftKey: Key.isDown(16), ctrlKey: Key.isDown(17)});
    } // End of the function
    function onLoad(Void)
    {
        if (__sentLoadEvent != true)
        {
            this.dispatchEvent({type: "load"});
        } // end if
        __sentLoadEvent = true;
    } // End of the function
    function onUnload(Void)
    {
        this.dispatchEvent({type: "unload"});
    } // End of the function
    function __addEventListener(event, handler)
    {
        this.__origAddEventListener(event, handler);
        var _l3 = mx.events.UIEventDispatcher.lowLevelEvents;
        for (var _l5 in _l3)
        {
            if (mx.events.UIEventDispatcher[_l5][event] != undefined)
            {
                var _l2 = _l3[_l5][0];
                mx.events.UIEventDispatcher._l2(this);
            } // end if
        } // end of for...in
    } // End of the function
    function removeEventListener(event, handler)
    {
        var _l6 = "__q_" + event;
        mx.events.EventDispatcher._removeEventListener(this[_l6], event, handler);
        if (this[_l6].length == 0)
        {
            var _l2 = mx.events.UIEventDispatcher.lowLevelEvents;
            for (var _l5 in _l2)
            {
                if (mx.events.UIEventDispatcher[_l5][event] != undefined)
                {
                    var _l3 = _l2[_l5][1];
                    mx.events.UIEventDispatcher[_l2[_l5][1]](this);
                } // end if
            } // end of for...in
        } // end if
    } // End of the function
    static var keyEvents = {keyDown: 1, keyUp: 1};
    static var loadEvents = {load: 1, unload: 1};
    static var lowLevelEvents = {keyEvents: ["addKeyEvents", "removeKeyEvents"], loadEvents: ["addLoadEvents", "removeLoadEvents"]};
    static var _fEventDispatcher = undefined;
} // End of Class
