package blok.ssr;

import blok.core.DefaultScheduler;
import blok.ui.Widget;

class Platform extends blok.render.Platform {
  public static function mount(object:RootObject, child:Widget) {
    var platform = new Platform(DefaultScheduler.getInstance());
    var widget = new RootWidget(object, platform, child);
    return platform.mountRootWidget(widget);
  }

  public static function render(child:Widget, ?onRender:(object:HtmlObject)->Void) {
    var root = new RootObject();
    var el = mount(root, child);
    if (onRender != null) {
      el.getObservable().observe(el -> onRender(el.getObject()));
    }
  }

  public function createPlaceholderObject(widget:Widget):Dynamic {
    return new TextObject('');
  }
}
