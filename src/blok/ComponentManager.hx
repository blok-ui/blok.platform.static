package blok;

using Lambda;

class ComponentManager implements ConcreteManager {
  final component:Component;

  public function new(component) {
    this.component = component;
  }

  public function toConcrete():Array<Dynamic> {
    return component
      .getConcreteChildren()
      .map(c -> c.toConcrete())
      .flatten();
  }

  public function getFirstConcreteChild() {
    return toConcrete()[0];
  }

  public function getLastConcreteChild() {
    return toConcrete().pop();
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
