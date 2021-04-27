package blok;

import haxe.ds.Map;
import blok.core.html.HtmlBaseProps;

class NodeType<Attrs:{}> {
  static var types:Map<String, NodeType<Dynamic>> = [];

  public static function get<Props:{}>(tag:String):NodeType<Props> {
    if (!types.exists(tag)) { 
      types.set(tag, new NodeType(tag));
    }
    return cast types.get(tag);
  }

  final tag:String;
  // final isSvg:Bool;

  public function new(tag, isSvg = false) {
    this.tag = tag;
    // this.isSvg = isSvg;
  }

  public function create(props:HtmlChildrenProps<Attrs, Dynamic>) {
    return new NativeComponent(tag, {
      attributes: props.attrs,
      children: props.children 
    });
  }

  public function update(component:NativeComponent<Attrs>, props:HtmlChildrenProps<Attrs, Dynamic>) {
    component.updateComponentProperties({
      attributes: props.attrs,
      children: props.children == null ? [] : props.children
    });
  }
}
