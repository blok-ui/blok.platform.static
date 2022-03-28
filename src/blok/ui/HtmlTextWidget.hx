package blok.ui;

import blok.core.UniqueId;
import blok.ssr.TextObject;

class HtmlTextWidget extends ObjectWidget {
  static final type = new UniqueId();

  final content:String;

  public function new(content, ?key) {
    super(key);
    this.content = content;
  }

  public function getWidgetType():UniqueId {
    return type;
  }
  
  public function getChildren():Array<Widget> {
    return [];
  }

  public function createObject():Dynamic {
    return new TextObject(content);
  }

  public function updateObject(object:Dynamic, ?previousWidget:Widget):Dynamic {
    var text:TextObject = object;
    var previous:HtmlTextWidget = cast previousWidget;
    if (previous != null && content != previous.content) {
      text.updateContent(content);
    }
    return text;
  }

  public function createElement():Element {
    return new ObjectWithoutChildrenElement(this);
  }
}