package blok.ssr;

import blok.core.UniqueId;

class RootWidget extends blok.ui.RootWidget {
  static final type = new UniqueId();

  final object:RootObject;

  public function new(object, platform, child) {
    super(platform, child);
    this.object = object;
    object.setup(platform);
  }

  public function getWidgetType():UniqueId {
    return type;
  }

  public function resolveRootObject():Dynamic {
    return object;
  }
}
