package blok.ui;

import blok.core.UniqueId;

class TextWidget extends ConcreteWidget {
  public static final type:WidgetType = new UniqueId();

  public var textContent:String;

  public function new(textContent) {
    this.textContent = textContent;
  }
  
  public function setText(content:String) {
    if (textContent == content) return;
    textContent = content;
  }
  
  public function getWidgetType() {
    return type;
  }

  public function toConcrete():Concrete {
    return [ textContent ];
  }
  
  public function __performUpdate(effect:Effect):Void {
    // noop
  }

  public function addConcreteChild(widget:Widget) {
    throw 'invalid';
  }

  public function insertConcreteChildAt(pos:Int, widget:Widget) {
    throw 'invalid';
  }

  public function removeConcreteChild(widget:Widget):Void {
    throw 'invalid';
  }

  public function moveConcreteChildTo(pos:Int, child:Widget):Void {
    throw 'invalid';
  }
}
