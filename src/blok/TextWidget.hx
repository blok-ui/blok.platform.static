package blok;

import blok.WidgetType.getUniqueTypeId;

class TextWidget extends ConcreteWidget {
  public static final type:WidgetType = getUniqueTypeId();

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
  
  public function __performUpdate(registerEffect:(effect:()->Void)->Void):Void {
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
