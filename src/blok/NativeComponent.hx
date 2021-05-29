package blok;

@:allow(blok.ssr)
@component(dontGenerateType)
class NativeComponent<Attrs:{}> extends Component {
  @prop var attributes:Attrs = null;
  @prop var children:Array<VNode> = [];
  public var tag:String;
  final type:VNodeType;
  var shouldUpdate:Bool;
  
  public function new(type, tag, props, shouldUpdate = true) {
    this.type = type;
    this.tag = tag;
    this.shouldUpdate = shouldUpdate;
    __initComponentProps(props);
  }

  override function shouldComponentUpdate():Bool {
    return shouldUpdate;
  }

  function getComponentType():VNodeType {
    return type;
  }
  
  public function render():VNode {
    return if (children != null && children.length > 0) 
      new VFragment(children) 
    else 
      VFragment.empty();
  }

  override function __ensureVNode(vn:Null<VNode>):VNode {
    // No placeholders needed for NativeComponents.
    return if (vn == null) VFragment.empty() else vn;
  }
}
