class mx.managers.FocusManager extends mx.core.UIComponent
{
    var __defaultPushButton, defPushButton, form, tabEnabled, _height, _width, _y, _x, _alpha, _parent, tabCapture, lastMouse, _visible, lastFocus, lastSelFocus, _searchKey, _lastTarget, _firstNode, _nextIsNext, _nextNode, _lastx, _prevNode, _needPrev, _foundList, _prevObj, _nextObj, _firstObj, _lastObj, _lastNode, lastTabFocus;
    function FocusManager()
    {
        super();
    } // End of the function
    function __get__defaultPushButton()
    {
        return (__defaultPushButton);
    } // End of the function
    function __set__defaultPushButton(x)
    {
        if (__defaultPushButton != x)
        {
            __defaultPushButton.__set__emphasized(false);
            __defaultPushButton = x;
            defPushButton = x;
            x.__set__emphasized(true);
        } // end if
        return (this.__get__defaultPushButton());
        null;
    } // End of the function
    function getMaxTabIndex(o)
    {
        var _l3 = 0;
        var _l6;
        for (var _l6 in o)
        {
            var _l2 = o[_l6];
            if (_l2._parent == o)
            {
                if (_l2.tabIndex != undefined)
                {
                    if (_l2.tabIndex > _l3)
                    {
                        _l3 = _l2.tabIndex;
                    } // end if
                } // end if
                if (_l2.tabChildren == true)
                {
                    var _l4 = this.getMaxTabIndex(_l2);
                    if (_l4 > _l3)
                    {
                        _l3 = _l4;
                    } // end if
                } // end if
            } // end if
        } // end of for...in
        return (_l3);
    } // End of the function
    function getNextTabIndex(Void)
    {
        return (this.getMaxTabIndex(form) + 1);
    } // End of the function
    function __get__nextTabIndex()
    {
        return (this.getNextTabIndex());
    } // End of the function
    function relocate(Void)
    {
        var _l2 = mx.managers.SystemManager.__get__screen();
        this.move(_l2.x - 1, _l2.y - 1);
    } // End of the function
    function init(Void)
    {
        super.init();
        tabEnabled = false;
        _width = _height = 1;
        _x = _y = -1;
        _alpha = 0;
        _parent.focusManager = this;
        _parent.tabChildren = true;
        _parent.tabEnabled = false;
        form = _parent;
        _parent.addEventListener("hide", this);
        _parent.addEventListener("reveal", this);
        mx.managers.SystemManager.init();
        mx.managers.SystemManager.addFocusManager(form);
        tabCapture.tabIndex = 0;
        this.watch("enabled", enabledChanged);
        Selection.addListener(this);
        lastMouse = new Object();
        _global.ASSetPropFlags(_parent, "focusManager", 1);
        _global.ASSetPropFlags(_parent, "tabChildren", 1);
        _global.ASSetPropFlags(_parent, "tabEnabled", 1);
    } // End of the function
    function enabledChanged(id, oldValue, newValue)
    {
        _visible = newValue;
        return (newValue);
    } // End of the function
    function activate(Void)
    {
        Key.addListener(this);
        activated = _visible = true;
        if (lastFocus != undefined)
        {
            bNeedFocus = true;
            if (!mx.managers.SystemManager.isMouseDown)
            {
                this.doLater(this, "restoreFocus");
            } // end if
        } // end if
    } // End of the function
    function deactivate(Void)
    {
        Key.removeListener(this);
        activated = _visible = false;
        var _l2 = this.getSelectionFocus();
        var _l3 = this.getActualFocus(_l2);
        if (this.isOurFocus(_l3))
        {
            lastSelFocus = _l2;
            lastFocus = _l3;
        } // end if
        this.cancelAllDoLaters();
    } // End of the function
    function isOurFocus(o)
    {
        if (o.focusManager == this)
        {
            return (true);
        } // end if
        while (o != undefined)
        {
            if (o.focusManager != undefined)
            {
                return (false);
            } // end if
            if (o._parent == _parent)
            {
                return (true);
            } // end if
            var _l2 = o._parent;
        } // end while
        return (false);
    } // End of the function
    function onSetFocus(o, n)
    {
        if (n == null)
        {
            if (activated)
            {
                bNeedFocus = true;
            } // end if
        }
        else
        {
            var _l2 = this.getFocus();
            if (this.isOurFocus(_l2))
            {
                bNeedFocus = false;
                lastFocus = _l2;
                lastSelFocus = n;
            } // end if
        } // end if
    } // End of the function
    function restoreFocus(Void)
    {
        var _l2 = lastSelFocus.hscroll;
        if (_l2 != undefined)
        {
            var _l5 = lastSelFocus.scroll;
            var _l4 = lastSelFocus.background;
        } // end if
        lastFocus.setFocus();
        var _l3 = Selection;
        Selection.setSelection(_l3.lastBeginIndex, _l3.lastEndIndex);
        if (_l2 != undefined)
        {
            lastSelFocus.scroll = _l5;
            lastSelFocus.hscroll = _l2;
            lastSelFocus.background = _l4;
        } // end if
    } // End of the function
    function onUnload(Void)
    {
        mx.managers.SystemManager.removeFocusManager(form);
    } // End of the function
    function setFocus(o)
    {
        if (o == null)
        {
            Selection.setFocus(null);
        }
        else if (o.setFocus == undefined)
        {
            Selection.setFocus(o);
        }
        else
        {
            o.setFocus();
        } // end if
    } // End of the function
    function getActualFocus(o)
    {
        var _l1 = o._parent;
        while (_l1 != undefined)
        {
            if (_l1.focusTextField != undefined)
            {
                while (_l1.focusTextField != undefined)
                {
                    var _l2 = _l1;
                    _l1 = _l1._parent;
                    if (_l1 == undefined)
                    {
                        return (undefined);
                    } // end if
                    if (_l1.focusTextField == undefined)
                    {
                        return (_l2);
                    } // end if
                } // end while
            } // end if
            if (_l1.tabEnabled != true)
            {
                return (_l2);
            } // end if
            _l2 = _l1;
            _l1 = _l2._parent;
        } // end while
        return (undefined);
    } // End of the function
    function getSelectionFocus()
    {
        var m = Selection.getFocus();
        var o = m;
        return (o);
    } // End of the function
    function getFocus(Void)
    {
        var _l2 = this.getSelectionFocus();
        return (this.getActualFocus(_l2));
    } // End of the function
    function walkTree(p, index, groupName, dir, lookup, firstChild)
    {
        var _l5 = true;
        var _l11;
        for (var _l11 in p)
        {
            var _l2 = p[_l11];
            if (_l2._parent == p && _l2.enabled != false && _l2._visible != false && (_l2.tabEnabled == true || _l2.tabEnabled != false && (_l2.onPress != undefined || _l2.onRelease != undefined || _l2.onReleaseOutside != undefined || _l2.onDragOut != undefined || _l2.onDragOver != undefined || _l2.onRollOver != undefined || _l2.onRollOut != undefined || _l2 instanceof TextField)))
            {
                if (_l2._searchKey == _searchKey)
                {
                    
                } // end if
                _l2._searchKey = _searchKey;
                if (_l2 != _lastTarget)
                {
                    if ((_l2.groupName != undefined || groupName != undefined) && _l2.groupName == groupName)
                    {
                        
                    } // end if
                    if (_l2 instanceof TextField && _l2.selectable == false)
                    {
                        
                    } // end if
                    if (_l5 || _l2.groupName != undefined && _l2.groupName == _firstNode.groupName && _l2.selected == true)
                    {
                        if (firstChild)
                        {
                            _firstNode = _l2;
                            var _l10 = false;
                        } // end if
                    } // end if
                    if (_nextIsNext == true)
                    {
                        if (_l2.groupName != undefined && _l2.groupName == _nextNode.groupName && _l2.selected == true || _nextNode == undefined && (_l2.groupName == undefined || _l2.groupName != undefined && _l2.groupName != groupName))
                        {
                            _nextNode = _l2;
                        } // end if
                    } // end if
                    if (_l2.groupName == undefined || _l2.groupName != groupName)
                    {
                        if (_lastx.groupName != undefined && _l2.groupName == _lastx.groupName && _lastx.selected == true)
                        {
                        }
                        else
                        {
                            _lastx = _l2;
                        } // end if
                    } // end if
                }
                else
                {
                    _prevNode = _lastx;
                    _needPrev = false;
                    _nextIsNext = true;
                } // end if
                if (_l2.tabIndex != undefined)
                {
                    if (_l2.tabIndex == index)
                    {
                        if (_foundList[_l2._name] == undefined)
                        {
                            if (_needPrev)
                            {
                                _prevObj = _l2;
                                _needPrev = false;
                            } // end if
                            _nextObj = _l2;
                        } // end if
                    } // end if
                    if (dir && _l2.tabIndex > index)
                    {
                        if (_nextObj == undefined || _nextObj.tabIndex > _l2.tabIndex && (_l2.groupName == undefined || _nextObj.groupName == undefined || _l2.groupName != _nextObj.groupName) || _nextObj.groupName != undefined && _nextObj.groupName == _l2.groupName && _nextObj.selected != true && (_l2.selected == true || _nextObj.tabIndex > _l2.tabIndex))
                        {
                            _nextObj = _l2;
                        } // end if
                    }
                    else if (!dir && _l2.tabIndex < index)
                    {
                        if (_prevObj == undefined || _prevObj.tabIndex < _l2.tabIndex && (_l2.groupName == undefined || _prevObj.groupName == undefined || _l2.groupName != _prevObj.groupName) || _prevObj.groupName != undefined && _prevObj.groupName == _l2.groupName && _prevObj.selected != true && (_l2.selected == true || _prevObj.tabIndex < _l2.tabIndex))
                        {
                            _prevObj = _l2;
                        } // end if
                    } // end if
                    if (_firstObj == undefined || _l2.tabIndex < _firstObj.tabIndex && (_l2.groupName == undefined || _firstObj.groupName == undefined || _l2.groupName != _firstObj.groupName) || _firstObj.groupName != undefined && _firstObj.groupName == _l2.groupName && _firstObj.selected != true && (_l2.selected == true || _l2.tabIndex < _firstObj.tabIndex))
                    {
                        _firstObj = _l2;
                    } // end if
                    if (_lastObj == undefined || _l2.tabIndex > _lastObj.tabIndex && (_l2.groupName == undefined || _lastObj.groupName == undefined || _l2.groupName != _lastObj.groupName) || _lastObj.groupName != undefined && _lastObj.groupName == _l2.groupName && _lastObj.selected != true && (_l2.selected == true || _l2.tabIndex > _lastObj.tabIndex))
                    {
                        _lastObj = _l2;
                    } // end if
                } // end if
                if (_l2.tabChildren)
                {
                    this.getTabCandidateFromChildren(_l2, index, groupName, dir, _l5 && _l10);
                } // end if
                _l5 = false;
            }
            else if (_l2._parent == p && _l2.tabChildren == true && _l2._visible != false)
            {
                if (_l2 == _lastTarget)
                {
                    if (_l2._searchKey == _searchKey)
                    {
                        
                    } // end if
                    _l2._searchKey = _searchKey;
                    if (_prevNode == undefined)
                    {
                        var _l3 = _lastx;
                        var _l7 = false;
                        while (_l3 != undefined)
                        {
                            if (_l3 == _l2)
                            {
                                _l7 = true;
                                break;
                            } // end if
                            _l3 = _l3._parent;
                        } // end while
                        if (_l7 == false)
                        {
                            _prevNode = _lastx;
                        } // end if
                    } // end if
                    _needPrev = false;
                    if (_nextNode == undefined)
                    {
                        _nextIsNext = true;
                    } // end if
                }
                else if (!(_l2.focusManager != undefined && _l2.focusManager._parent == _l2))
                {
                    if (_l2._searchKey == _searchKey)
                    {
                        
                    } // end if
                    _l2._searchKey = _searchKey;
                    this.getTabCandidateFromChildren(_l2, index, groupName, dir, _l5 && _l10);
                } // end if
                _l5 = false;
            } // end if
        } // end of for...in
        _lastNode = _lastx;
        if (lookup)
        {
            if (p._parent != undefined)
            {
                if (_parent != p)
                {
                    if (_prevNode == undefined && dir)
                    {
                        _needPrev = true;
                    }
                    else if (_nextNode == undefined && !dir)
                    {
                        _nextIsNext = false;
                    } // end if
                    _lastTarget = _lastTarget._parent;
                    this.getTabCandidate(p._parent, index, groupName, dir, true);
                } // end if
            } // end if
        } // end if
    } // End of the function
    function getTabCandidate(o, index, groupName, dir, firstChild)
    {
        var _l2;
        var _l3 = true;
        if (_parent == o)
        {
            _l2 = o;
            _l3 = false;
        }
        else
        {
            _l2 = o._parent;
            if (_l2 == undefined)
            {
                _l2 = o;
                _l3 = false;
            } // end if
        } // end if
        this.walkTree(_l2, index, groupName, dir, _l3, firstChild);
    } // End of the function
    function getTabCandidateFromChildren(o, index, groupName, dir, firstChild)
    {
        this.walkTree(o, index, groupName, dir, false, firstChild);
    } // End of the function
    function getFocusManagerFromObject(o)
    {
        while (o != undefined)
        {
            if (o.focusManager != undefined)
            {
                return (o.focusManager);
            } // end if
            var _l1 = o._parent;
        } // end while
        return (undefined);
    } // End of the function
    function tabHandler(Void)
    {
        bDrawFocus = true;
        var _l5 = this.getSelectionFocus();
        var _l4 = this.getActualFocus(_l5);
        if (_l4 != _l5)
        {
            _l5 = _l4;
        } // end if
        if (this.getFocusManagerFromObject(_l5) != this)
        {
            _l5 == undefined;
        } // end if
        if (_l5 == undefined)
        {
            _l5 = form;
        }
        else if (_l5.tabIndex != undefined)
        {
            if (_foundList != undefined || _foundList.tabIndex != _l5.tabIndex)
            {
                _foundList = new Object();
                _foundList.tabIndex = _l5.tabIndex;
            } // end if
            _foundList[_l5._name] = _l5;
        } // end if
        var _l3 = Key.isDown(16) != true;
        _searchKey = getTimer();
        _needPrev = true;
        _nextIsNext = false;
        _lastx = undefined;
        _firstNode = undefined;
        _lastNode = undefined;
        _nextNode = undefined;
        _prevNode = undefined;
        _firstObj = undefined;
        _lastObj = undefined;
        _nextObj = undefined;
        _prevObj = undefined;
        _lastTarget = _l5;
        var _l6 = _l5;
        this.getTabCandidate(_l6, _l5.tabIndex == undefined ? (0) : (_l5.tabIndex), _l5.groupName, _l3, true);
        var _l2;
        if (_l3)
        {
            if (_nextObj != undefined)
            {
                _l2 = _nextObj;
            }
            else
            {
                _l2 = _firstObj;
            } // end if
        }
        else if (_prevObj != undefined)
        {
            _l2 = _prevObj;
        }
        else
        {
            _l2 = _lastObj;
        } // end if
        if (_l2.tabIndex != _l5.tabIndex)
        {
            _foundList = new Object();
            _foundList.tabIndex = _l2.tabIndex;
            _foundList[_l2._name] = _l2;
        }
        else
        {
            if (_foundList == undefined)
            {
                _foundList = new Object();
                _foundList.tabIndex = _l2.tabIndex;
            } // end if
            _foundList[_l2._name] = _l2;
        } // end if
        if (_l2 == undefined)
        {
            if (_l3 == false)
            {
                if (_nextNode != undefined)
                {
                    _l2 = _nextNode;
                }
                else
                {
                    _l2 = _firstNode;
                } // end if
            }
            else if (_prevNode == undefined || _l5 == form)
            {
                _l2 = _lastNode;
            }
            else
            {
                _l2 = _prevNode;
            } // end if
        } // end if
        if (_l2 == undefined)
        {
            return (undefined);
        } // end if
        lastTabFocus = _l2;
        this.setFocus(_l2);
        if (_l2.emphasized != undefined)
        {
            if (defPushButton != undefined)
            {
                _l5 = defPushButton;
                defPushButton = _l2;
                _l5.emphasized = false;
                _l2.emphasized = true;
            } // end if
        }
        else if (defPushButton != undefined && defPushButton != __defaultPushButton)
        {
            _l5 = defPushButton;
            defPushButton = __defaultPushButton;
            _l5.emphasized = false;
            __defaultPushButton.__set__emphasized(true);
        } // end if
    } // End of the function
    function onKeyDown(Void)
    {
        mx.managers.SystemManager.idleFrames = 0;
        if (defaultPushButtonEnabled)
        {
            if (Key.getCode() == 13)
            {
                if (this.__get__defaultPushButton() != undefined)
                {
                    this.doLater(this, "sendDefaultPushButtonEvent");
                } // end if
            } // end if
        } // end if
    } // End of the function
    function sendDefaultPushButtonEvent(Void)
    {
        defPushButton.dispatchEvent({type: "click"});
    } // End of the function
    function getMousedComponentFromChildren(x, y, o)
    {
        for (var _l7 in o)
        {
            var _l2 = o[_l7];
            if (_l2._visible && _l2.enabled && _l2._parent == o && _l2._searchKey != _searchKey)
            {
                _l2._searchKey = _searchKey;
                if (_l2.hitTest(x, y, true))
                {
                    if (_l2.onPress != undefined || _l2.onRelease != undefined)
                    {
                        return (_l2);
                    } // end if
                    var _l3 = this.getMousedComponentFromChildren(x, y, _l2);
                    if (_l3 != undefined)
                    {
                        return (_l3);
                    } // end if
                    return (_l2);
                } // end if
            } // end if
        } // end of for...in
        return (undefined);
    } // End of the function
    function mouseActivate(Void)
    {
        if (!bNeedFocus)
        {
            return (undefined);
        } // end if
        _searchKey = getTimer();
        var _l2 = this.getMousedComponentFromChildren(lastMouse.x, lastMouse.y, form);
        if (_l2 instanceof mx.core.UIComponent)
        {
            return (undefined);
        } // end if
        _l2 = this.findFocusFromObject(_l2);
        if (_l2 == lastFocus)
        {
            return (undefined);
        } // end if
        if (_l2 == undefined)
        {
            this.doLater(this, "restoreFocus");
            return (undefined);
        } // end if
        var _l3 = _l2.hscroll;
        if (_l3 != undefined)
        {
            var _l6 = _l2.scroll;
            var _l5 = _l2.background;
        } // end if
        this.setFocus(_l2);
        var _l4 = Selection;
        Selection.setSelection(_l4.lastBeginIndex, _l4.lastEndIndex);
        if (_l3 != undefined)
        {
            _l2.scroll = _l6;
            _l2.hscroll = _l3;
            _l2.background = _l5;
        } // end if
    } // End of the function
    function _onMouseDown(Void)
    {
        bDrawFocus = false;
        if (lastFocus != undefined)
        {
            lastFocus.drawFocus(false);
        } // end if
        mx.managers.SystemManager.idleFrames = 0;
        var _l3 = Selection;
        _l3.lastBeginIndex = Selection.getBeginIndex();
        _l3.lastEndIndex = Selection.getEndIndex();
        lastMouse.x = _root._xmouse;
        lastMouse.y = _root._ymouse;
        _root.localToGlobal(lastMouse);
    } // End of the function
    function onMouseUp(Void)
    {
        if (_visible)
        {
            this.doLater(this, "mouseActivate");
        } // end if
    } // End of the function
    function handleEvent(e)
    {
        if (e.type == "reveal")
        {
            mx.managers.SystemManager.activate(form);
        }
        else
        {
            mx.managers.SystemManager.deactivate(form);
        } // end if
    } // End of the function
    static function enableFocusManagement()
    {
        if (!mx.managers.FocusManager.initialized)
        {
            mx.managers.FocusManager.initialized = true;
            Object.registerClass("FocusManager", mx.managers.FocusManager);
            if (_root.focusManager == undefined)
            {
                _root.createClassObject(mx.managers.FocusManager, "focusManager", mx.managers.DepthManager.highestDepth--);
            } // end if
        } // end if
    } // End of the function
    static var symbolName = "FocusManager";
    static var symbolOwner = mx.managers.FocusManager;
    static var version = "2.0.1.78";
    var className = "FocusManager";
    var bNeedFocus = false;
    var bDrawFocus = false;
    var defaultPushButtonEnabled = true;
    var activated = true;
    static var initialized = false;
    static var UIObjectExtensionsDependency = mx.core.ext.UIObjectExtensions;
} // End of Class
