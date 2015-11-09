class mx.core.ExternalContent
{
    var numChildren, mx.core.View.childNameBase + numChildren, prepList, loadList, loadedList, __get__width, __get__height, __get__left, __get__x, __get__top, __get__y, __get__right, __get__bottom, __set__visible, __get__visible;
    function ExternalContent()
    {
    } // End of the function
    function loadExternal(url, placeholderClassName, instanceName, depth, initProps)
    {
        var _l2;
        _l2 = this.createObject(placeholderClassName, instanceName, depth, initProps);
        set(mx.core.View.childNameBase + numChildren, _l2);
        if (prepList == undefined)
        {
            prepList = new Object();
        } // end if
        prepList[instanceName] = {obj: _l2, url: url, complete: false, initProps: initProps};
        this.prepareToLoadMovie(_l2);
        return (_l2);
    } // End of the function
    function prepareToLoadMovie(obj)
    {
        obj.unloadMovie();
        this.doLater(this, "waitForUnload");
    } // End of the function
    function waitForUnload()
    {
        var _l3;
        for (var _l3 in prepList)
        {
            var _l2 = prepList[_l3];
            if (_l2.obj.getBytesTotal() == 0)
            {
                if (loadList == undefined)
                {
                    loadList = new Object();
                } // end if
                loadList[_l3] = _l2;
                _l2.obj.loadMovie(_l2.url);
                delete prepList[_l3];
                this.doLater(this, "checkLoadProgress");
            }
            else
            {
                this.doLater(this, "waitForUnload");
            } // end if
        } // end of for...in
    } // End of the function
    function checkLoadProgress()
    {
        var _l3;
        for (var _l3 in loadList)
        {
            var _l2 = loadList[_l3];
            _l2.loaded = _l2.obj.getBytesLoaded();
            _l2.total = _l2.obj.getBytesTotal();
            if (_l2.total > 0)
            {
                _l2.obj._visible = false;
                this.dispatchEvent({type: "progress", target: _l2.obj, current: _l2.loaded, total: _l2.total});
                if (_l2.loaded == _l2.total)
                {
                    if (loadedList == undefined)
                    {
                        loadedList = new Object();
                    } // end if
                    loadedList[_l3] = _l2;
                    delete loadList[_l3];
                    this.doLater(this, "contentLoaded");
                } // end if
            }
            else if (_l2.total == -1)
            {
                if (_l2.failedOnce != undefined)
                {
                    ++_l2.failedOnce;
                    if (_l2.failedOnce > 3)
                    {
                        this.dispatchEvent({type: "complete", target: _l2.obj, current: _l2.loaded, total: _l2.total});
                        delete loadList[_l3];
                        false;
                    } // end if
                }
                else
                {
                    _l2.failedOnce = 0;
                } // end if
                
            } // end if
            this.doLater(this, "checkLoadProgress");
        } // end of for...in
    } // End of the function
    function contentLoaded()
    {
        var _l4;
        for (var _l4 in loadedList)
        {
            var _l2 = loadedList[_l4];
            _l2.obj._visible = true;
            _l2.obj._complete = true;
            var _l3;
            for (var _l3 in _l2.initProps)
            {
                _l2.obj[_l3] = _l2.initProps[_l3];
            } // end of for...in
            this.childLoaded(_l2.obj);
            this.dispatchEvent({type: "complete", target: _l2.obj, current: _l2.loaded, total: _l2.total});
            delete loadedList[_l4];
            false;
        } // end of for...in
    } // End of the function
    function convertToUIObject(obj)
    {
        if (obj.setSize == undefined)
        {
            obj.addProperty("width", __get__width, null);
            obj.addProperty("height", __get__height, null);
            obj.addProperty("left", __get__left, null);
            obj.addProperty("x", __get__x, null);
            obj.addProperty("top", __get__top, null);
            obj.addProperty("y", __get__y, null);
            obj.addProperty("right", __get__right, null);
            obj.addProperty("bottom", __get__bottom, null);
            obj.addProperty("visible", __get__visible, __set__visible);
            obj.move = mx.core.UIObject.prototype.move;
            obj.setSize = mx.core.UIObject.prototype.setSize;
            obj.size = mx.core.UIObject.prototype.size;
            mx.events.UIEventDispatcher.initialize(obj);
        } // end if
    } // End of the function
    static function enableExternalContent()
    {
    } // End of the function
    static function classConstruct()
    {
        obj.loadExternal = loadExternal;
        obj.prepareToLoadMovie = prepareToLoadMovie;
        obj.waitForUnload = waitForUnload;
        obj.checkLoadProgress = checkLoadProgress;
        obj.contentLoaded = contentLoaded;
        obj.convertToUIObject = convertToUIObject;
        return (true);
    } // End of the function
    static var classConstructed = mx.core.ExternalContent.classConstruct();
    static var ViewDependency = mx.core.View;
} // End of Class
