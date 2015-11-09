class mx.managers.DepthManager
{
    var _childCounter, _parent, _topmost;
    function DepthManager()
    {
        MovieClip.prototype.createClassChildAtDepth = createClassChildAtDepth;
        MovieClip.prototype.createChildAtDepth = createChildAtDepth;
        MovieClip.prototype.setDepthTo = setDepthTo;
        MovieClip.prototype.setDepthAbove = setDepthAbove;
        MovieClip.prototype.setDepthBelow = setDepthBelow;
        MovieClip.prototype.findNextAvailableDepth = findNextAvailableDepth;
        MovieClip.prototype.shuffleDepths = shuffleDepths;
        MovieClip.prototype.getDepthByFlag = getDepthByFlag;
        MovieClip.prototype.buildDepthTable = buildDepthTable;
        _global.ASSetPropFlags(MovieClip.prototype, "createClassChildAtDepth", 1);
        _global.ASSetPropFlags(MovieClip.prototype, "createChildAtDepth", 1);
        _global.ASSetPropFlags(MovieClip.prototype, "setDepthTo", 1);
        _global.ASSetPropFlags(MovieClip.prototype, "setDepthAbove", 1);
        _global.ASSetPropFlags(MovieClip.prototype, "setDepthBelow", 1);
        _global.ASSetPropFlags(MovieClip.prototype, "findNextAvailableDepth", 1);
        _global.ASSetPropFlags(MovieClip.prototype, "shuffleDepths", 1);
        _global.ASSetPropFlags(MovieClip.prototype, "getDepthByFlag", 1);
        _global.ASSetPropFlags(MovieClip.prototype, "buildDepthTable", 1);
    } // End of the function
    static function sortFunction(a, b)
    {
        if (a.getDepth() > b.getDepth())
        {
            return (1);
        } // end if
        return (-1);
    } // End of the function
    static function test(depth)
    {
        if (mx.managers.DepthManager.reservedDepth == depth)
        {
            return (false);
        }
        else
        {
            return (true);
        } // end if
    } // End of the function
    static function createClassObjectAtDepth(className, depthSpace, initObj)
    {
        var _l1;
        switch (depthSpace)
        {
            case mx.managers.DepthManager.kCursor:
            {
                _l1 = mx.managers.DepthManager.holder.createClassChildAtDepth(className, mx.managers.DepthManager.kTopmost, initObj);
                break;
            } 
            case mx.managers.DepthManager.kTooltip:
            {
                _l1 = mx.managers.DepthManager.holder.createClassChildAtDepth(className, mx.managers.DepthManager.kTop, initObj);
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
        return (_l1);
    } // End of the function
    static function createObjectAtDepth(linkageName, depthSpace, initObj)
    {
        var _l1;
        switch (depthSpace)
        {
            case mx.managers.DepthManager.kCursor:
            {
                _l1 = mx.managers.DepthManager.holder.createChildAtDepth(linkageName, mx.managers.DepthManager.kTopmost, initObj);
                break;
            } 
            case mx.managers.DepthManager.kTooltip:
            {
                _l1 = mx.managers.DepthManager.holder.createChildAtDepth(linkageName, mx.managers.DepthManager.kTop, initObj);
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
        return (_l1);
    } // End of the function
    function createClassChildAtDepth(className, depthFlag, initObj)
    {
        if (_childCounter == undefined)
        {
            _childCounter = 0;
        } // end if
        var _l3 = this.buildDepthTable();
        var _l2 = this.getDepthByFlag(depthFlag, _l3);
        var _l5 = "down";
        if (mx.managers.DepthManager.kBottom == depthFlag)
        {
            _l5 = "up";
        } // end if
        var _l6;
        if (_l3[_l2] != undefined)
        {
            _l6 = _l2;
            _l2 = this.findNextAvailableDepth(_l2, _l3, _l5);
        } // end if
        var _l4 = this.createClassObject(className, "depthChild" + _childCounter++, _l2, initObj);
        if (_l6 != undefined)
        {
            _l3[_l2] = _l4;
            this.shuffleDepths(_l4, _l6, _l3, _l5);
        } // end if
        if (mx.managers.DepthManager.kTopmost == depthFlag)
        {
            _l4._topmost = true;
        } // end if
        return (_l4);
    } // End of the function
    function createChildAtDepth(linkageName, depthFlag, initObj)
    {
        if (_childCounter == undefined)
        {
            _childCounter = 0;
        } // end if
        var _l3 = this.buildDepthTable();
        var _l2 = this.getDepthByFlag(depthFlag, _l3);
        var _l5 = "down";
        if (mx.managers.DepthManager.kBottom == depthFlag)
        {
            _l5 = "up";
        } // end if
        var _l6;
        if (_l3[_l2] != undefined)
        {
            _l6 = _l2;
            _l2 = this.findNextAvailableDepth(_l2, _l3, _l5);
        } // end if
        var _l4 = this.createObject(linkageName, "depthChild" + _childCounter++, _l2, initObj);
        if (_l6 != undefined)
        {
            _l3[_l2] = _l4;
            this.shuffleDepths(_l4, _l6, _l3, _l5);
        } // end if
        if (mx.managers.DepthManager.kTopmost == depthFlag)
        {
            _l4._topmost = true;
        } // end if
        return (_l4);
    } // End of the function
    function setDepthTo(depthFlag)
    {
        var _l2 = _parent.buildDepthTable();
        var _l3 = _parent.getDepthByFlag(depthFlag, _l2);
        this.shuffleDepths(this, MovieClip, _l3, _l2);
        this.swapDepths(_l3);
        if (mx.managers.DepthManager.kTopmost == depthFlag)
        {
            _topmost = true;
        }
        else
        {
            delete this._topmost;
        } // end if
    } // End of the function
    function setDepthAbove(targetInstance)
    {
        if (targetInstance._parent != _parent)
        {
            return (undefined);
        } // end if
        var _l2 = targetInstance.getDepth() + 1;
        var _l3 = _parent.buildDepthTable();
        if (_l3[_l2] != undefined && this.getDepth() < _l2)
        {
            _l2 = _l2 - 1;
        } // end if
        if (_l2 > mx.managers.DepthManager.highestDepth)
        {
            _l2 = mx.managers.DepthManager.highestDepth;
        } // end if
        if (_l2 == mx.managers.DepthManager.highestDepth)
        {
            _parent.shuffleDepths(this, _l2, _l3, "down");
        }
        else if (_l3[_l2] != undefined)
        {
            _parent.shuffleDepths(this, _l2, _l3, undefined);
        }
        else
        {
            this.swapDepths(_l2);
        } // end if
    } // End of the function
    function setDepthBelow(targetInstance)
    {
        if (targetInstance._parent != _parent)
        {
            return (undefined);
        } // end if
        var _l6 = targetInstance.getDepth() - 1;
        var _l3 = _parent.buildDepthTable();
        if (_l3[_l6] != undefined && this.getDepth() > _l6)
        {
            _l6 = _l6 + 1;
        } // end if
        var _l4 = mx.managers.DepthManager.lowestDepth + mx.managers.DepthManager.numberOfAuthortimeLayers;
        var _l5;
        for (var _l5 in _l3)
        {
            var _l2 = _l3[_l5];
            if (_l2._parent != undefined)
            {
                _l4 = Math.min(_l4, _l2.getDepth());
            } // end if
        } // end of for...in
        if (_l6 < _l4)
        {
            _l6 = _l4;
        } // end if
        if (_l6 == _l4)
        {
            _parent.shuffleDepths(this, _l6, _l3, "up");
        }
        else if (_l3[_l6] != undefined)
        {
            _parent.shuffleDepths(this, _l6, _l3, undefined);
        }
        else
        {
            this.swapDepths(_l6);
        } // end if
    } // End of the function
    function findNextAvailableDepth(targetDepth, depthTable, direction)
    {
        var _l5 = mx.managers.DepthManager.lowestDepth + mx.managers.DepthManager.numberOfAuthortimeLayers;
        if (_l5 > targetDepth)
        {
            var _l4 = _l5;
        } // end if
        if (depthTable[_l4] == undefined)
        {
            return (_l4);
        } // end if
        var _l1 = _l4;
        var _l2 = _l4;
        if (direction == "down")
        {
            while (depthTable[_l2] != undefined)
            {
                --_l2;
            } // end while
            return (_l2);
        } // end if
        while (depthTable[_l1] != undefined)
        {
            ++_l1;
        } // end while
        return (_l1);
    } // End of the function
    function shuffleDepths(subject, targetDepth, depthTable, direction)
    {
        var _l9 = mx.managers.DepthManager.lowestDepth + mx.managers.DepthManager.numberOfAuthortimeLayers;
        var _l8 = _l9;
        var _l5;
        for (var _l5 in depthTable)
        {
            var _l7 = depthTable[_l5];
            if (_l7._parent != undefined)
            {
                _l9 = Math.min(_l9, _l7.getDepth());
            } // end if
        } // end of for...in
        if (direction == undefined)
        {
            if (subject.getDepth() > targetDepth)
            {
                var _l12 = "up";
            }
            else
            {
                _l12 = "down";
            } // end if
        } // end if
        var _l1 = new Array();
        for (var _l5 in depthTable)
        {
            _l7 = depthTable[_l5];
            if (_l7._parent != undefined)
            {
                _l1.push(_l7);
            } // end if
        } // end of for...in
        _l1.sort(mx.managers.DepthManager.sortFunction);
        if (_l12 == "up")
        {
            var _l3;
            var _l11;
            while (_l1.length > 0)
            {
                _l3 = _l1.pop();
                if (_l3 == subject)
                {
                    break;
                } // end if
            } // end while
            while (_l1.length > 0)
            {
                _l11 = subject.getDepth();
                _l3 = _l1.pop();
                var _l4 = _l3.getDepth();
                if (_l11 > _l4 + 1)
                {
                    if (_l4 >= 0)
                    {
                        subject.swapDepths(_l4 + 1);
                    }
                    else if (_l11 > _l8 && _l4 < _l8)
                    {
                        subject.swapDepths(_l8);
                    } // end if
                } // end if
                subject.swapDepths(_l3);
                if (_l4 == targetDepth)
                {
                    break;
                } // end if
            } // end while
        }
        else if (_l12 == "down")
        {
            while (_l1.length > 0)
            {
                _l3 = _l1.shift();
                if (_l3 == subject)
                {
                    break;
                } // end if
            } // end while
            while (_l1.length > 0)
            {
                _l11 = _l3.getDepth();
                _l3 = _l1.shift();
                _l4 = _l3.getDepth();
                if (_l11 < _l4 - 1 && _l4 > 0)
                {
                    subject.swapDepths(_l4 - 1);
                } // end if
                subject.swapDepths(_l3);
                if (_l4 == targetDepth)
                {
                    break;
                } // end if
            } // end while
        } // end if
    } // End of the function
    function getDepthByFlag(depthFlag, depthTable)
    {
        var _l2 = 0;
        if (mx.managers.DepthManager.kTop == depthFlag || mx.managers.DepthManager.kNotopmost == depthFlag)
        {
            var _l5 = 0;
            var _l7 = false;
            var _l8;
            for (var _l8 in depthTable)
            {
                var _l9 = depthTable[_l8];
                var _l3 = typeof(_l9);
                if (_l3 == "movieclip" || _l3 == "object" && _l9.__getTextFormat != undefined)
                {
                    if (_l9.getDepth() <= mx.managers.DepthManager.highestDepth)
                    {
                        if (!_l9._topmost)
                        {
                            _l2 = Math.max(_l2, _l9.getDepth());
                        }
                        else if (!_l7)
                        {
                            _l5 = _l9.getDepth();
                            _l7 = true;
                        }
                        else
                        {
                            _l5 = Math.min(_l5, _l9.getDepth());
                        } // end if
                    } // end if
                } // end if
            } // end of for...in
            _l2 = _l2 + 20;
            if (_l7)
            {
                if (_l2 >= _l5)
                {
                    _l2 = _l5 - 1;
                } // end if
            } // end if
        }
        else if (mx.managers.DepthManager.kBottom == depthFlag)
        {
            for (var _l8 in depthTable)
            {
                _l9 = depthTable[_l8];
                _l3 = typeof(_l9);
                if (_l3 == "movieclip" || _l3 == "object" && _l9.__getTextFormat != undefined)
                {
                    if (_l9.getDepth() <= mx.managers.DepthManager.highestDepth)
                    {
                        _l2 = Math.min(_l2, _l9.getDepth());
                    } // end if
                } // end if
            } // end of for...in
            _l2 = _l2 - 20;
        }
        else if (mx.managers.DepthManager.kTopmost == depthFlag)
        {
            for (var _l8 in depthTable)
            {
                _l9 = depthTable[_l8];
                _l3 = typeof(_l9);
                if (_l3 == "movieclip" || _l3 == "object" && _l9.__getTextFormat != undefined)
                {
                    if (_l9.getDepth() <= mx.managers.DepthManager.highestDepth)
                    {
                        _l2 = Math.max(_l2, _l9.getDepth());
                    } // end if
                } // end if
            } // end of for...in
            _l2 = _l2 + 100;
        } // end if
        if (_l2 >= mx.managers.DepthManager.highestDepth)
        {
            _l2 = mx.managers.DepthManager.highestDepth;
        } // end if
        var _l6 = mx.managers.DepthManager.lowestDepth + mx.managers.DepthManager.numberOfAuthortimeLayers;
        for (var _l9 in depthTable)
        {
            var _l4 = depthTable[_l9];
            if (_l4._parent != undefined)
            {
                _l6 = Math.min(_l6, _l4.getDepth());
            } // end if
        } // end of for...in
        if (_l2 <= _l6)
        {
            _l2 = _l6;
        } // end if
        return (_l2);
    } // End of the function
    function buildDepthTable(Void)
    {
        var _l5 = new Array();
        var _l4;
        for (var _l4 in this)
        {
            var _l2 = this[_l4];
            var _l3 = typeof(_l2);
            if (_l3 == "movieclip" || _l3 == "object" && _l2.__getTextFormat != undefined)
            {
                if (_l2._parent == this)
                {
                    _l5[_l2.getDepth()] = _l2;
                } // end if
            } // end if
        } // end of for...in
        return (_l5);
    } // End of the function
    static var reservedDepth = 1048575;
    static var highestDepth = 1048574;
    static var lowestDepth = -16383;
    static var numberOfAuthortimeLayers = 383;
    static var kCursor = 101;
    static var kTooltip = 102;
    static var kTop = 201;
    static var kBottom = 202;
    static var kTopmost = 203;
    static var kNotopmost = 204;
    static var holder = _root.createEmptyMovieClip("reserved", mx.managers.DepthManager.reservedDepth);
    static var __depthManager = new mx.managers.DepthManager();
} // End of Class
