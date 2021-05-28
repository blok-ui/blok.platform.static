package blok;

import blok.VNodeType.getUniqueTypeId;
import blok.core.html.HtmlBaseProps;

class VNative<Attrs:{}> implements VNode {
  static var types:Map<String, VNodeType> = [];

  public static function create<Attrs:{}>(tag:String, props):VNative<Attrs> {
    if (!types.exists(tag)) {
      types.set(tag, getUniqueTypeId());
    }
    var realTag = switch tag.split(':') {
      case ['svg', name]:
        name;
      default:
        tag;
    }
    return new VNative(types.get(tag), realTag, props);
  }

  public final key:Key;
  public final type:VNodeType;
  public final props:HtmlChildrenProps<Attrs, Dynamic>;
  public final children:Null<Array<VNode>> = null;
  final tag:String;

  public function new(type, tag, props) {
    this.type = type;
    this.tag = tag;
    this.props = props;
    this.key = props.key;
  }

  public function createComponent() {
    return new NativeComponent(type, tag, {
      attributes: props.attrs,
      children: props.children
    }, true);
  }

  public function updateComponent(component:Component):Component {
    component.updateComponentProperties({
      attributes: props.attrs,
      children: props.children
    });
    return component;
  }
}