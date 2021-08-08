package blok.ssr;

import haxe.Exception;

class Platform extends blok.Platform {
  public static function render(
    child:VNode, 
    onRender:(result:String)->Void,
    ?catchException:(e:Exception)->Void
  ) {
    var root = new StaticRoot(onRender, catchException, child);
    var platform = new Platform(new DefaultScheduler());
    platform.mountRootWidget(root);
    return root;
  }

  public function createManagerForComponent(component:Component):ConcreteManager {
    return new ComponentManager(component);
  }
}
