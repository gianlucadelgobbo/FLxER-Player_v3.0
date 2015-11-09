class HtmlCellRenderer extends mx.core.UIComponent
{
    var htmlComponent, _mIcon, __height, __width, listOwner, columnIndex;
    function HtmlCellRenderer()
    {
        super();
    } // End of the function
    function createChildren(Void)
    {
        if (HtmlCellRenderer.CssUrl != undefined && HtmlCellRenderer.style_sheet == null)
        {
            HtmlCellRenderer.style_sheet = new TextField.StyleSheet();
            HtmlCellRenderer.style_sheet.load(HtmlCellRenderer.CssUrl);
        } // end if
        if (htmlComponent == undefined)
        {
            this.createEmptyMovieClip("_mIcon", 2);
            this.createLabel("htmlComponent", 1);
        } // end if
        _mIcon.onRollOver = function ()
        {
            _mIcon._alpha = 100;
        };
        _mIcon.onRollOut = function ()
        {
            _mIcon._alpha = 50;
        };
        htmlComponent.html = true;
        htmlComponent.border = false;
        htmlComponent.multiline = true;
        htmlComponent.wordWrap = true;
        htmlComponent.selectable = false;
        htmlComponent.background = false;
        this.size();
    } // End of the function
    function size(Void)
    {
        var _l2 = __height;
        var _l3 = __width;
        htmlComponent.setSize(_l3 - 6, Math.max(_l2, listOwner.rowHeight - 4));
    } // End of the function
    function setValue(str, item, sel)
    {
        if (item == undefined)
        {
            if (htmlComponent != undefined)
            {
                htmlComponent.text = "";
                htmlComponent._visible = false;
                _mIcon.visible = false;
                previousLabel = null;
            } // end if
            return (undefined);
        } // end if
        htmlComponent._visible = true;
        _mIcon.visible = true;
        var _l3 = columnIndex;
        var _l7 = listOwner.getColumnAt(_l3).columnName;
        var _l5 = this.getCellIndex().itemIndex;
        var _l4 = listOwner.dataProvider.getItemAt(_l5).icon;
        if (item.label != undefined)
        {
            if (item.label != undefined)
            {
                if (item.label != previousLabel)
                {
                    _mIcon.attachMovie(_l4, "mIconHolder", 5);
                    var _l6 = htmlComponent.styleSheet;
                    if (_l6 != HtmlCellRenderer.style_sheet && HtmlCellRenderer.style_sheet != null)
                    {
                        htmlComponent.styleSheet = HtmlCellRenderer.style_sheet;
                    } // end if
                    if (item.icon.length > 1)
                    {
                        htmlComponent._x = _mIcon._width + 5;
                    }
                    else
                    {
                        htmlComponent._x = 0;
                        htmlComponent._y = 0;
                    } // end if
                    htmlComponent.text = item.label;
                    htmlComponent.invalidate();
                    previousLabel = item.label;
                } // end if
            }
            else
            {
                htmlComponent.text = "";
            } // end if
        } // end if
    } // End of the function
    function getPreferredHeight(Void)
    {
        return (16);
    } // End of the function
    function getPreferredWidth(Void)
    {
        return (20);
    } // End of the function
    static var style_sheet = null;
    var previousLabel = null;
} // End of Class
