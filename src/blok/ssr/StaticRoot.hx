package blok.ssr;

import haxe.Exception;
import blok.exception.BlokException;

using blok.ssr.HtmlRenderer;

class StaticRoot extends Component {
  @prop var onRender:(result:String)->Void;
  @prop var catchException:(e:Exception)->Void;
  @prop var child:VNode;

  @before
  function complainIfNotRoot() {
    if (__parent != null)
      throw new BlokException('StaticRoot must be a root component', this);
  }

  @effect
  function notifyWhenRendered() {
    onRender(getChildComponents().stringifyChildren());
  }

  override function componentDidCatch(exception:Exception):VNode {
    catchException(exception);
    return new VNodeNone();
  }

  override function __dequeueUpdates() {
    super.__dequeueUpdates();
    // ALWAYS run our onRender callback if any children change.
    // note: I'm not 100% sure this is right, but it _should_ be
    //       the only thing we need to do.
    notifyWhenRendered();
  }

  public function render() {
    return child;
  }
}
