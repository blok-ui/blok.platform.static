package blok.ui;

class VText implements VNode {
  public final type:WidgetType = TextWidget.type;
  public final key:Null<Key>;
  public final props:Dynamic;
  public final children:Null<Array<VNode>> = null;

  public function new(text:String, ?key) {
    this.key = key;
    this.props = text;
  }

  public function createWidget(?parent:Widget, platform:Platform, effect:Effect):Widget {
    var widget = new TextWidget(props);
    widget.initializeWidget(parent, platform, key);
    widget.performUpdate(effect);
    return widget;
  }

  public function updateWidget(widget:Widget, effect:Effect):Widget {
    var text:TextWidget = cast widget;
    text.setText(props);
    text.performUpdate(effect);
    return widget;
  }
}
