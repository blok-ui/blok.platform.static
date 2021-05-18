package blok;

@:allow(blok.NodeType)
@:allow(blok.ssr)
@component(dontGenerateType)
class NativeComponent<Attrs:{}> extends Component {
  @prop var attributes:Attrs = null;
  @prop var children:Array<VNode> = [];
  public var tag:String;
  var shouldUpdate:Bool;
  
  public function new(tag, props, shouldUpdate = true) {
    this.tag = tag;
    this.shouldUpdate = shouldUpdate;
    __initComponentProps(props);
  }

  override function shouldComponentUpdate():Bool {
    return shouldUpdate;
  }
  
  public function render():VNode {
    return if (children.length > 0) VFragment(children) else VNone;
  }
}
