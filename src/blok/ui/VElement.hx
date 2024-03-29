package blok.ui;

import blok.core.UniqueId;
import blok.html.HtmlBaseProps;

class VElement<Attrs:{}> implements VNode {
  public static inline final SVG_NS = 'http://www.w3.org/2000/svg';
  static var types:Map<String, WidgetType> = [];

  public static function create<Attrs:{}>(tag:String, props):VElement<Attrs> {
    if (!types.exists(tag)) {
      types.set(tag, new UniqueId());
    }
    var isSvg = false;
    var realTag = switch tag.split(':') {
      case ['svg', name]: 
        isSvg = true;
        name;
      default:
        tag;
    }
    return new VElement(types.get(tag), realTag, props, isSvg);
  }

  public final key:Key;
  public final type:WidgetType;
  public final props:Dynamic;
  public final children:Null<Array<VNode>>;
  final isSvg:Bool;
  final tag:String;

  public function new(type, tag, props:HtmlChildrenProps<Attrs, Dynamic>, isSvg) {
    this.type = type;
    this.tag = tag;
    this.isSvg = isSvg;
    this.props = props.attrs;
    this.children = props.children;
    this.key = props.key;
  }

  public function createWidget(?parent:Widget, platform:Platform, effects:Effect):Widget {
    var element = new ElementWidget(type, tag, props, children);
    element.initializeWidget(parent, platform, key);
    element.performUpdate(effects);
    return element;
  }

  public function updateWidget(widget:Widget, effects:Effect):Widget {
    var native:ElementWidget<Attrs> = cast widget;
    native.updateAttrs(props);
    native.setChildren(children);
    native.performUpdate(effects);
    return widget;
  }
}
