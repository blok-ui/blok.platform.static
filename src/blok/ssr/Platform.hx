package blok.ssr;

import blok.core.DefaultScheduler;
import blok.ui.Widget;
import blok.render.Object;

class Platform extends blok.render.Platform {
  public static function render(
    child:Widget,
    onRender:(result:Object)->Void
  ) {
    var platform = new Platform(DefaultScheduler.getInstance());
    var widget = new RootWidget(platform, child);
    return platform.mountRootWidget(widget, () -> {
      trace('fx');
      // @todo: Something is very odd about when this executes.
      onRender(widget.resolveRootObject());
      platform.setRenderCallback(() -> onRender(widget.resolveRootObject()));
    });
  }

  var onRender:()->Void;

  function setRenderCallback(onRender) {
    this.onRender = onRender;
  }

  override function performUpdate() {
    super.performUpdate();
    if (onRender != null) onRender();
  }

  public function createPlaceholderObject(widget:Widget):Dynamic {
    return new TextObject('');
  }
}
