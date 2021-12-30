package blok.ui;

using Lambda;

class ComponentManager implements ConcreteManager {
  final component:Component;

  public function new(component) {
    this.component = component;
  }

  public function toConcrete():Concrete {
    return component
      .getChildConcreteManagers()
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

  public function dispose() {
    // noop
  }
}
