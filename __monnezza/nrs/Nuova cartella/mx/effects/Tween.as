class mx.effects.Tween extends Object
{
    var arrayMode, listener, initVal, endVal, startTime, updateFunc, endFunc, ID;
    function Tween(listenerObj, init, end, dur)
    {
        super();
        if (listenerObj == undefined)
        {
            return (undefined);
        } // end if
        if (typeof(init) != "number")
        {
            arrayMode = true;
        } // end if
        listener = listenerObj;
        initVal = init;
        endVal = end;
        if (dur != undefined)
        {
            duration = dur;
        } // end if
        startTime = getTimer();
        if (duration == 0)
        {
            this.endTween();
        }
        else
        {
            mx.effects.Tween.AddTween(this);
        } // end if
    } // End of the function
    static function AddTween(tween)
    {
        tween.ID = mx.effects.Tween.ActiveTweens.length;
        mx.effects.Tween.ActiveTweens.push(tween);
        if (mx.effects.Tween.IntervalToken == undefined)
        {
            mx.effects.Tween.Dispatcher.DispatchTweens = mx.effects.Tween.DispatchTweens;
            mx.effects.Tween.IntervalToken = setInterval(mx.effects.Tween.Dispatcher, "DispatchTweens", mx.effects.Tween.Interval);
        } // end if
    } // End of the function
    static function RemoveTweenAt(index)
    {
        var _l2 = mx.effects.Tween.ActiveTweens;
        if (_l2.length <= index || index < 0 || index == undefined)
        {
            return (undefined);
        } // end if
        _l2.splice(index, 1);
        var _l4 = _l2.length;
        var _l1 = index;
        while (_l1 < _l4)
        {
            --_l2[_l1].ID;
            ++_l1;
        } // end while
        if (_l4 == 0)
        {
            clearInterval(mx.effects.Tween.IntervalToken);
            delete mx.effects.Tween.IntervalToken;
        } // end if
    } // End of the function
    static function DispatchTweens(Void)
    {
        var _l2 = mx.effects.Tween.ActiveTweens;
        var _l3 = _l2.length;
        var _l1 = 0;
        while (_l1 < _l3)
        {
            _l2[_l1].doInterval();
            ++_l1;
        } // end while
        updateAfterEvent();
    } // End of the function
    function doInterval()
    {
        var _l2 = getTimer() - startTime;
        var _l3 = this.getCurVal(_l2);
        if (_l2 >= duration)
        {
            this.endTween();
        }
        else if (updateFunc != undefined)
        {
            listener[updateFunc](_l3);
        }
        else
        {
            listener.onTweenUpdate(_l3);
        } // end if
    } // End of the function
    function getCurVal(curTime)
    {
        if (arrayMode)
        {
            var _l3 = new Array();
            var _l2 = 0;
            while (_l2 < initVal.length)
            {
                _l3[_l2] = this.easingEquation(curTime, initVal[_l2], endVal[_l2] - initVal[_l2], duration);
                ++_l2;
            } // end while
            return (_l3);
        }
        else
        {
            return (this.easingEquation(curTime, initVal, endVal - initVal, duration));
        } // end if
    } // End of the function
    function endTween()
    {
        if (endFunc != undefined)
        {
            listener[endFunc](endVal);
        }
        else
        {
            listener.onTweenEnd(endVal);
        } // end if
        mx.effects.Tween.RemoveTweenAt(ID);
    } // End of the function
    function setTweenHandlers(update, end)
    {
        updateFunc = update;
        endFunc = end;
    } // End of the function
    function easingEquation(t, b, c, d)
    {
        return (c / 2 * (Math.sin(3.141593 * (t / d - 0.500000)) + 1) + b);
    } // End of the function
    static var ActiveTweens = new Array();
    static var Interval = 10;
    static var Dispatcher = new Object();
    var duration = 3000;
} // End of Class
