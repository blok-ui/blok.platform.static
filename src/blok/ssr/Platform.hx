package blok.ssr;

import haxe.Exception;

class Platform {
  public static function render(
    child:VNode, 
    onRender:(result:String)->Void,
    ?catchException:(e:Exception)->Void
  ) {
    var engine = new Engine([]);
    var root = new StaticRoot({
      onRender: onRender,
      child: child,
      catchException: catchException == null
        ? e -> throw e
        : catchException
    });
    
    root.initializeRootComponent(engine);
    root.renderRootComponent();

    return root;
  }
}
