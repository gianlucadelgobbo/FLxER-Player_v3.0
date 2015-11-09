class mx.managers.SystemManager
{
    function SystemManager()
    {
    } // End of the function
    static function init(Void)
    {
        if (mx.managers.SystemManager._initialized == false)
        {
            mx.managers.SystemManager._initialized = true;
            mx.events.EventDispatcher.initialize(mx.managers.SystemManager);
            Mouse.addListener(mx.managers.SystemManager);
            Stage.addListener(mx.managers.SystemManager);
            mx.managers.SystemManager._xAddEventListener = mx.managers.SystemManager.addEventListener;
            mx.managers.SystemManager.addEventListener = mx.managers.SystemManager.__addEventListener;
            mx.managers.SystemManager._xRemoveEventListener = mx.managers.SystemManager.removeEventListener;
            mx.managers.SystemManager.removeEventListener = mx.managers.SystemManager.__removeEventListener;
        } // end if
    } // End of the function
    static function addFocusManager(f)
    {
        mx.managers.SystemManager.form = f;
        f.focusManager.activate();
    } // End of the function
    static function removeFocusManager(f)
    {
    } // End of the function
    static function onMouseDown(Void)
    {
        var _l1 = mx.managers.SystemManager.form;
        _l1.focusManager._onMouseDown();
    } // End of the function
    static function onResize(Void)
    {
        var _l7 = Stage.width;
        var _l6 = Stage.height;
        var _l9 = _global.origWidth;
        var _l8 = _global.origHeight;
        var _l3 = Stage.align;
        var _l5 = (_l9 - _l7) / 2;
        var _l4 = (_l8 - _l6) / 2;
        if (_l3 == "T")
        {
            _l4 = 0;
        }
        else if (_l3 == "B")
        {
            _l4 = _l8 - _l6;
        }
        else if (_l3 == "L")
        {
            _l5 = 0;
        }
        else if (_l3 == "R")
        {
            _l5 = _l9 - _l7;
        }
        else if (_l3 == "LT")
        {
            _l4 = 0;
            _l5 = 0;
        }
        else if (_l3 == "TR")
        {
            _l4 = 0;
            _l5 = _l9 - _l7;
        }
        else if (_l3 == "LB")
        {
            _l4 = _l8 - _l6;
            _l5 = 0;
        }
        else if (_l3 == "RB")
        {
            _l4 = _l8 - _l6;
            _l5 = _l9 - _l7;
        } // end if
        if (mx.managers.SystemManager.__screen == undefined)
        {
            mx.managers.SystemManager.__screen = new Object();
        } // end if
        mx.managers.SystemManager.__screen.x = _l5;
        mx.managers.SystemManager.__screen.y = _l4;
        mx.managers.SystemManager.__screen.width = _l7;
        mx.managers.SystemManager.__screen.height = _l6;
        _root.focusManager.relocate();
        mx.managers.SystemManager.dispatchEvent({type: "resize"});
    } // End of the function
    static function __get__screen()
    {
        mx.managers.SystemManager.init();
        if (mx.managers.SystemManager.__screen == undefined)
        {
            mx.managers.SystemManager.onResize();
        } // end if
        return (mx.managers.SystemManager.__screen);
    } // End of the function
    static var _initialized = false;
    static var idleFrames = 0;
    static var isMouseDown = false;
    static var forms = new Array();
} // End of Class
