package blok.ssr;

import blok.core.UniqueId;

class RootWidget extends blok.ui.RootWidget {
  static final type = new UniqueId();

  final object = new HtmlObject('#document', {}, []);

  public function getWidgetType():UniqueId {
    return type;
  }

  public function resolveRootObject():Dynamic {
    return object;
  }
}
