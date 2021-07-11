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

  public function createComponent(engine:Engine, ?parent:Component):Component {
    var native = new NativeComponent(type, '#text', { attributes: props }, false);
    native.initializeComponent(parent, engine, key);
    return native;
  }

  public function updateComponent(engine:Engine, component:Component) {
    component.updateComponentProperties({ attributes: props });
    return component;
  }
}
