package blok.statik;

import blok.core.Node;
import blok.core.Differ;

class Platform {
  inline public static function createContext() {
    return new blok.core.Context(new Engine());
  }

  public static function mount(root:Node, factory:(context:Context)->VNode) {
    var context = createContext();
    Differ.renderWithSideEffects(root, [ factory(context) ], null, context);
  }

  public static function render(factory:(context:Context)->VNode):String {
    var root = new Node('#document'); 
    mount(root, factory);
    return root.toString();
  }
}