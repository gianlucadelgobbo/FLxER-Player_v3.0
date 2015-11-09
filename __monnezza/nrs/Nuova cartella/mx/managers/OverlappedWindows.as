class mx.managers.OverlappedWindows
{
    function OverlappedWindows()
    {
    } // End of the function
    static function checkIdle(Void)
    {
        if (mx.managers.SystemManager.idleFrames > 10)
        {
            mx.managers.SystemManager.dispatchEvent({type: "idle"});
        }
        else
        {
            ++mx.managers.SystemManager.idleFrames;
        } // end if
    } // End of the function
    static function __addEventListener(e, o, l)
    {
        if (e == "idle")
        {
            if (mx.managers.SystemManager.interval == undefined)
            {
                mx.managers.SystemManager.interval = setInterval(mx.managers.SystemManager.checkIdle, 100);
            } // end if
        } // end if
        mx.managers.SystemManager._xAddEventListener(e, o, l);
    } // End of the function
    static function __removeEventListener(e, o, l)
    {
        if (e == "idle")
        {
            if (mx.managers.SystemManager._xRemoveEventListener(e, o, l) == 0)
            {
                clearInterval(mx.managers.SystemManager.interval);
            } // end if
        }
        else
        {
            mx.managers.SystemManager._xRemoveEventListener(e, o, l);
        } // end if
    } // End of the function
    static function onMouseDown(Void)
    {
        mx.managers.SystemManager.idleFrames = 0;
        mx.managers.SystemManager.isMouseDown = true;
        var _l5 = _root;
        var _l3;
        var _l8 = _root._xmouse;
        var _l7 = _root._ymouse;
        if (mx.managers.SystemManager.form.modalWindow == undefined)
        {
            if (mx.managers.SystemManager.forms.length > 1)
            {
                var _l6 = mx.managers.SystemManager.forms.length;
                var _l4;
                _l4 = 0;
                while (_l4 < _l6)
                {
                    var _l2 = mx.managers.SystemManager.forms[_l4];
                    if (_l2._visible)
                    {
                        if (_l2.hitTest(_l8, _l7))
                        {
                            if (_l3 == undefined)
                            {
                                _l3 = _l2.getDepth();
                                _l5 = _l2;
                            }
                            else if (_l3 < _l2.getDepth())
                            {
                                _l3 = _l2.getDepth();
                                _l5 = _l2;
                            } // end if
                        } // end if
                    } // end if
                    ++_l4;
                } // end while
                if (_l5 != mx.managers.SystemManager.form)
                {
                    mx.managers.SystemManager.activate(_l5);
                } // end if
            } // end if
        } // end if
        var _l9 = mx.managers.SystemManager.form;
        _l9.focusManager._onMouseDown();
    } // End of the function
    static function onMouseMove(Void)
    {
        mx.managers.SystemManager.idleFrames = 0;
    } // End of the function
    static function onMouseUp(Void)
    {
        mx.managers.SystemManager.isMouseDown = false;
        mx.managers.SystemManager.idleFrames = 0;
    } // End of the function
    static function activate(f)
    {
        if (mx.managers.SystemManager.form != undefined)
        {
            if (mx.managers.SystemManager.form != f && mx.managers.SystemManager.forms.length > 1)
            {
                var _l1 = mx.managers.SystemManager.form;
                _l1.focusManager.deactivate();
            } // end if
        } // end if
        mx.managers.SystemManager.form = f;
        f.focusManager.activate();
    } // End of the function
    static function deactivate(f)
    {
        if (mx.managers.SystemManager.form != undefined)
        {
            if (mx.managers.SystemManager.form == f && mx.managers.SystemManager.forms.length > 1)
            {
                var _l5 = mx.managers.SystemManager.form;
                _l5.focusManager.deactivate();
                var _l3 = mx.managers.SystemManager.forms.length;
                var _l1;
                var _l2;
                _l1 = 0;
                while (_l1 < _l3)
                {
                    if (mx.managers.SystemManager.forms[_l1] == f)
                    {
                        _l1 = _l1 + 1;
                        while (_l1 < _l3)
                        {
                            if (mx.managers.SystemManager.forms[_l1]._visible == true)
                            {
                                _l2 = mx.managers.SystemManager.forms[_l1];
                            } // end if
                            ++_l1;
                        } // end while
                        mx.managers.SystemManager.form = _l2;
                        break;
                    }
                    else if (mx.managers.SystemManager.forms[_l1]._visible == true)
                    {
                        _l2 = mx.managers.SystemManager.forms[_l1];
                    } // end if
                    ++_l1;
                } // end while
                _l5 = mx.managers.SystemManager.form;
                _l5.focusManager.activate();
            } // end if
        } // end if
    } // End of the function
    static function addFocusManager(f)
    {
        mx.managers.SystemManager.forms.push(f);
        mx.managers.SystemManager.activate(f);
    } // End of the function
    static function removeFocusManager(f)
    {
        var _l3 = mx.managers.SystemManager.forms.length;
        var _l1;
        _l1 = 0;
        while (_l1 < _l3)
        {
            if (mx.managers.SystemManager.forms[_l1] == f)
            {
                if (mx.managers.SystemManager.form == f)
                {
                    mx.managers.SystemManager.deactivate(f);
                } // end if
                mx.managers.SystemManager.forms.splice(_l1, 1);
                return (undefined);
            } // end if
            ++_l1;
        } // end while
    } // End of the function
    static function enableOverlappedWindows()
    {
        if (!mx.managers.OverlappedWindows.initialized)
        {
            mx.managers.OverlappedWindows.initialized = true;
            mx.managers.SystemManager.checkIdle = mx.managers.OverlappedWindows.checkIdle;
            mx.managers.SystemManager.__addEventListener = mx.managers.OverlappedWindows.__addEventListener;
            mx.managers.SystemManager.__removeEventListener = mx.managers.OverlappedWindows.__removeEventListener;
            mx.managers.SystemManager.onMouseDown = mx.managers.OverlappedWindows.onMouseDown;
            mx.managers.SystemManager.onMouseMove = mx.managers.OverlappedWindows.onMouseMove;
            mx.managers.SystemManager.onMouseUp = mx.managers.OverlappedWindows.onMouseUp;
            mx.managers.SystemManager.activate = mx.managers.OverlappedWindows.activate;
            mx.managers.SystemManager.deactivate = mx.managers.OverlappedWindows.deactivate;
            mx.managers.SystemManager.addFocusManager = mx.managers.OverlappedWindows.addFocusManager;
            mx.managers.SystemManager.removeFocusManager = mx.managers.OverlappedWindows.removeFocusManager;
        } // end if
    } // End of the function
    static var initialized = false;
    static var SystemManagerDependency = mx.managers.SystemManager;
} // End of Class
