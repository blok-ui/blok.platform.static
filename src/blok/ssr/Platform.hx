package blok.ssr;

import blok.core.DefaultScheduler;
import blok.ui.Widget;

class Platform extends blok.render.Platform {
  public static function mount(object:RootObject, child:Widget) {
    var platform = new Platform(DefaultScheduler.getInstance());
    var widget = new RootWidget(object, platform, child);
    return platform.mountRootWidget(widget);
  }

  public static function render(child:Widget, ?onRender) {
    var root = new RootObject();
    if (onRender != null) root.onUpdate.observe(onRender, { defer: true });
    return mount(root, child);
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
