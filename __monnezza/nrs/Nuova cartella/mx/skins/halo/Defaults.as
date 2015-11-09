class mx.skins.halo.Defaults
{
    function Defaults()
    {
    } // End of the function
    static function setThemeDefaults()
    {
        var _l2 = _global.style;
        _l2.themeColor = 8453965;
        _l2.disabledColor = 8684164;
        _l2.modalTransparency = 0;
        _l2.filled = true;
        _l2.stroked = true;
        _l2.strokeWidth = 1;
        _l2.strokeColor = 0;
        _l2.fillColor = 16777215;
        _l2.repeatInterval = 35;
        _l2.repeatDelay = 500;
        _l2.fontFamily = "_sans";
        _l2.fontSize = 12;
        _l2.selectionColor = 13500353;
        _l2.rollOverColor = 14942166;
        _l2.useRollOver = true;
        _l2.backgroundDisabledColor = 14540253;
        _l2.selectionDisabledColor = 14540253;
        _l2.selectionDuration = 200;
        _l2.openDuration = 250;
        _l2.borderStyle = "inset";
        _l2.color = 734012;
        _l2.textSelectedColor = 24371;
        _l2.textRollOverColor = 2831164;
        _l2.textDisabledColor = 16777215;
        _l2.vGridLines = true;
        _l2.hGridLines = false;
        _l2.vGridLineColor = 6710886;
        _l2.hGridLineColor = 6710886;
        _l2.headerColor = 15395562;
        _l2.indentation = 17;
        _l2.folderOpenIcon = "TreeFolderOpen";
        _l2.folderClosedIcon = "TreeFolderClosed";
        _l2.defaultLeafIcon = "TreeNodeIcon";
        _l2.disclosureOpenIcon = "TreeDisclosureOpen";
        _l2.disclosureClosedIcon = "TreeDisclosureClosed";
        _l2.popupDuration = 150;
        _l2.todayColor = 6710886;
        _l2 = _global.styles.ScrollSelectList = new mx.styles.CSSStyleDeclaration();
        _l2.backgroundColor = 16777215;
        _l2.borderColor = 13290186;
        _l2.borderStyle = "inset";
        _l2 = _global.styles.ComboBox = new mx.styles.CSSStyleDeclaration();
        _l2.borderStyle = "inset";
        _l2 = _global.styles.NumericStepper = new mx.styles.CSSStyleDeclaration();
        _l2.textAlign = "center";
        _l2 = _global.styles.RectBorder = new mx.styles.CSSStyleDeclaration();
        _l2.borderColor = 14015965;
        _l2.buttonColor = 7305079;
        _l2.shadowColor = 15658734;
        _l2.highlightColor = 12897484;
        _l2.shadowCapColor = 14015965;
        _l2.borderCapColor = 9542041;
        var _l4 = new Object();
        _l4.borderColor = 16711680;
        _l4.buttonColor = 16711680;
        _l4.shadowColor = 16711680;
        _l4.highlightColor = 16711680;
        _l4.shadowCapColor = 16711680;
        _l4.borderCapColor = 16711680;
        mx.core.UIComponent.prototype.origBorderStyles = _l4;
        var _l3;
        _l3 = _global.styles.TextInput = new mx.styles.CSSStyleDeclaration();
        _l3.backgroundColor = 16777215;
        _l3.borderStyle = "inset";
        _global.styles.TextArea = _global.styles.TextInput;
        _l3 = _global.styles.Window = new mx.styles.CSSStyleDeclaration();
        _l3.borderStyle = "default";
        _l3 = _global.styles.windowStyles = new mx.styles.CSSStyleDeclaration();
        _l3.fontWeight = "bold";
        _l3 = _global.styles.dataGridStyles = new mx.styles.CSSStyleDeclaration();
        _l3.fontWeight = "bold";
        _l3 = _global.styles.Alert = new mx.styles.CSSStyleDeclaration();
        _l3.borderStyle = "alert";
        _l3 = _global.styles.ScrollView = new mx.styles.CSSStyleDeclaration();
        _l3.borderStyle = "inset";
        _l3 = _global.styles.View = new mx.styles.CSSStyleDeclaration();
        _l3.borderStyle = "none";
        _l3 = _global.styles.ProgressBar = new mx.styles.CSSStyleDeclaration();
        _l3.color = 11187123;
        _l3.fontWeight = "bold";
        _l3 = _global.styles.AccordionHeader = new mx.styles.CSSStyleDeclaration();
        _l3.fontWeight = "bold";
        _l3.fontSize = "11";
        _l3 = _global.styles.Accordion = new mx.styles.CSSStyleDeclaration();
        _l3.borderStyle = "solid";
        _l3.backgroundColor = 16777215;
        _l3.borderColor = 9081738;
        _l3.headerHeight = 22;
        _l3.marginLeft = _l3.marginRight = _l3.marginTop = _l3.marginBottom = -1;
        _l3.verticalGap = -1;
        _l3 = _global.styles.DateChooser = new mx.styles.CSSStyleDeclaration();
        _l3.borderColor = 9542041;
        _l3.headerColor = 16777215;
        _l3 = _global.styles.CalendarLayout = new mx.styles.CSSStyleDeclaration();
        _l3.fontSize = 10;
        _l3.textAlign = "right";
        _l3.color = 2831164;
        _l3 = _global.styles.WeekDayStyle = new mx.styles.CSSStyleDeclaration();
        _l3.fontWeight = "bold";
        _l3.fontSize = 11;
        _l3.textAlign = "center";
        _l3.color = 2831164;
        _l3 = _global.styles.TodayStyle = new mx.styles.CSSStyleDeclaration();
        _l3.color = 16777215;
        _l3 = _global.styles.HeaderDateText = new mx.styles.CSSStyleDeclaration();
        _l3.fontSize = 12;
        _l3.fontWeight = "bold";
        _l3.textAlign = "center";
    } // End of the function
    function drawRoundRect(x, y, w, h, r, c, alpha, rot, gradient, ratios)
    {
        if (typeof(r) == "object")
        {
            var _l18 = r.br;
            var _l16 = r.bl;
            var _l15 = r.tl;
            var _l10 = r.tr;
        }
        else
        {
            _l10 = r;
            _l15 = r;
            _l16 = r;
            _l18 = r;
        } // end if
        if (typeof(c) == "object")
        {
            if (typeof(alpha) != "object")
            {
                var _l9 = [alpha, alpha];
            }
            else
            {
                _l9 = alpha;
            } // end if
            if (ratios == undefined)
            {
                var _l17 = [0, 255];
            } // end if
            var _l14 = h * 0.700000;
            if (typeof(rot) != "object")
            {
                var _l11 = {matrixType: "box", x: -_l14, y: _l14, w: w * 2, h: h * 4, r: rot * 0.017453};
            }
            else
            {
                _l11 = rot;
            } // end if
            if (gradient == "radial")
            {
                this.beginGradientFill("radial", c, _l9, _l17, _l11);
            }
            else
            {
                this.beginGradientFill("linear", c, _l9, _l17, _l11);
            } // end if
        }
        else if (c != undefined)
        {
            this.beginFill(c, alpha);
        } // end if
        var _l2 = _l18;
        var _l13 = _l2 - _l2 * 0.707107;
        var _l12 = _l2 - _l2 * 0.414214;
        this.moveTo(x + w, y + h - _l2);
        this.lineTo(x + w, y + h - _l2);
        this.curveTo(x + w, y + h - _l12, x + w - _l13, y + h - _l13);
        this.curveTo(x + w - _l12, y + h, x + w - _l2, y + h);
        _l2 = _l16;
        _l13 = _l2 - _l2 * 0.707107;
        _l12 = _l2 - _l2 * 0.414214;
        this.lineTo(x + _l2, y + h);
        this.curveTo(x + _l12, y + h, x + _l13, y + h - _l13);
        this.curveTo(x, y + h - _l12, x, y + h - _l2);
        _l2 = _l15;
        _l13 = _l2 - _l2 * 0.707107;
        _l12 = _l2 - _l2 * 0.414214;
        this.lineTo(x, y + _l2);
        this.curveTo(x, y + _l12, x + _l13, y + _l13);
        this.curveTo(x + _l12, y, x + _l2, y);
        _l2 = _l10;
        _l13 = _l2 - _l2 * 0.707107;
        _l12 = _l2 - _l2 * 0.414214;
        this.lineTo(x + w - _l2, y);
        this.curveTo(x + w - _l12, y, x + w - _l13, y + _l13);
        this.curveTo(x + w, y + _l12, x + w, y + _l2);
        this.lineTo(x + w, y + h - _l2);
        if (c != undefined)
        {
            this.endFill();
        } // end if
    } // End of the function
    static function classConstruct()
    {
        mx.core.ext.UIObjectExtensions.Extensions();
        mx.skins.halo.Defaults.setThemeDefaults();
        mx.core.UIObject.prototype.drawRoundRect = mx.skins.halo.Defaults.prototype.drawRoundRect;
        return (true);
    } // End of the function
    static var classConstructed = mx.skins.halo.Defaults.classConstruct();
    static var CSSStyleDeclarationDependency = mx.styles.CSSStyleDeclaration;
    static var UIObjectExtensionsDependency = mx.core.ext.UIObjectExtensions;
    static var UIObjectDependency = mx.core.UIObject;
} // End of Class
