package blok.ssr;

import haxe.Exception;
import blok.ui.*;
import blok.core.UniqueId;
import blok.diff.Differ;
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

  public function __performUpdate(registerEffect:(effect:()->Void)->Void) {
    try {
      Differ.diffChildren(this, [ child ], __platform, registerEffect);
    } catch (e) {
      if (catchException != null) {
        catchException(e);
        return;
      }
      throw e;
    }
    registerEffect(notifyWhenRendered);
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
    __platform.schedule(registerEffect -> {
      updatePendingChildren(registerEffect);
      registerEffect(notifyWhenRendered); // Ensure we're always notifying.
      null;
    });
  }
}
