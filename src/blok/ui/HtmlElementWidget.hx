package blok.ui;

import blok.core.UniqueId;
import blok.ssr.HtmlObject;
import blok.html.HtmlBaseProps;

class HtmlElementWidget<Attrs:{}> extends ObjectWidget {
  static final types:Map<String, UniqueId> = [];
  
  public static function create<Attrs:{}>(tag:String, props):HtmlElementWidget<Attrs> {
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
    return new HtmlElementWidget(types.get(tag), realTag, props, isSvg);
  }
  
  final type:UniqueId;
  public final tag:String;
  public final attrs:Dynamic;
  final children:Null<Array<Widget>>;
  final isSvg:Bool;

  public function new(type, tag, props:HtmlChildrenProps<Attrs, HtmlObject>, isSvg) {
    super(props.key);
    this.type = type;
    this.tag = tag;
    this.attrs = props.attrs;
    this.children = props.children;
    this.isSvg = isSvg;
  }

  public function getChildren():Array<Widget> {
    return children;
  }

  public function getWidgetType():UniqueId {
    return type;
  }

  public function createObject():Dynamic {
    return new HtmlObject(tag, attrs, []);
  }

  public function updateObject(object:Dynamic, ?previousWidget:Widget):Dynamic {
    (object:HtmlObject).updateAttributes(attrs);
    return object;
  }

  public function createElement():Element {
    return new ObjectWithChildrenElement(this);
  }
}
