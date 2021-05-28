package blok;

import blok.VNodeType.getUniqueTypeId;

private final textType = getUniqueTypeId(); 

class VText implements VNode {
  public final type = textType;
  public final key:Null<Key>;
  public final props:{ content:String };
  public final children:Null<Array<VNode>> = null;

  public function new(props:{ content:String }, ?key) {
    this.props = props;
    this.key = key;
  }

  public function createComponent():Component {
    return new NativeComponent(type, '#text', { attributes: props }, false);
  }

  public function updateComponent(component:Component) {
    component.updateComponentProperties({ attributes: props });
    return component;
  }
}
