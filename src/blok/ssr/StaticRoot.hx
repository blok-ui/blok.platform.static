package blok.ssr;

import haxe.Exception;
import blok.ui.*;
import blok.core.UniqueId;
import blok.exception.BlokException;

using Lambda;

class StaticRoot extends ConcreteWidget {
  public static final type:WidgetType = new UniqueId();

  var onRender:(result:String)->Void;
  var catchException:Null<(e:Exception)->Void>;
  var child:VNode;

  public function new(onRender, catchException, child) {
    this.onRender = onRender;
    this.catchException = catchException;
    this.child = child;
  }

  function complainIfNotRoot() {
    if (__parent != null)
      throw new BlokException('StaticRoot must be a root component', this);
  }

  function notifyWhenRendered() {
    onRender(toConcrete().toArray().join(''));
  }

  public function getWidgetType() {
    return type;
  }

  public function __performUpdate(effects:Effect) {
    try {
      Differ.diffChildren(this, [ child ], __platform, effects);
    } catch (e) {
      if (catchException != null) {
        catchException(e);
        return;
      }
      throw e;
    }
    effects.register(notifyWhenRendered);
  }
  
  public function toConcrete():Concrete {
    return getChildConcreteManagers()
      .map(c -> c.toConcrete().toArray())
      .flatten();
  }

  public function addConcreteChild(child:Widget) {
    // noop
  }

  public function insertConcreteChildAt(pos:Int, child:Widget) {
    // noop
  }

  public function moveConcreteChildTo(pos:Int, child:Widget) {
    // noop
  }

  public function removeConcreteChild(child:Widget) {
    // noop
  }

  override function scheduleUpdatePendingChildren() {
    __platform.schedule(effects -> {
      updatePendingChildren(effects);
      effects.register(notifyWhenRendered); // Ensure we're always notifying.
      null;
    });
  }
}
