package blok.ssr;

import haxe.DynamicAccess;
import blok.core.Debug;
import blok.core.ObjectTools;
import blok.render.Object;

class HtmlObject extends Object {
  static final VOID_ELEMENTS = [
    'area', 'base', 'br', 'col', 'embed', 'hr', 'img', 
    'input', 'keygen', 'link', 'meta', 'param', 'source', 
    'track', 'wbr',
  ];

  final tag:String;
  final attributes:{};
  
  public function new(tag, attributes) {
    this.tag = tag;
    this.attributes = attributes;
  }

  function notify() {
    if (parent != null) {
      Debug.assert(parent is HtmlObject);
      (cast parent:HtmlObject).notify();
    }
  }

  override function append(child:Object) {
    super.append(child);
    notify();
  }

  override function insert(pos:Int, child:Object) {
    super.insert(pos, child);
    notify();
  }

  override function remove() {
    super.remove();
    notify();
  }

  public function updateAttributes(newAttrs:{}) {
    ObjectTools.diffObject(attributes, newAttrs, (key, oldValue, newValue) -> {
      Reflect.setField(attributes, key, newValue);
    });
    notify();
  }

  public function toString():String {
    var attrs = getFilteredAttributes();
    var children:Array<String> = children.filter(c -> c != null).map(c -> c.toString());

    if (tag == '#document' || tag == '#fragment') {
      return children.join('');
    }

    var tag = switch tag.split(':') {
      case [_, name]: name;
      default: tag;
    }

    var out = '<${tag}';
    var attrs = [ for (key => value in attrs) '$key="$value"' ];
    if (attrs.length > 0) out += ' ${attrs.join(' ')}';

    // todo: handle innerHTML.

    return if (VOID_ELEMENTS.contains(tag)) {
      out + '/>';
    } else if (children.length > 0) {
      out + '>' + children.join('') + '</${tag}>';
    } else {
      out + '></${tag}>';
    }
  }

  function getFilteredAttributes() {
    var attrs:DynamicAccess<Dynamic> = attributes;
    var out:DynamicAccess<String> = new DynamicAccess();
  
    for (key => value in attrs) {
      if (key.charAt(0) == 'o' && key.charAt(1) == 'n') {
        // noop
      } else if (Reflect.isFunction(value)) {
        // noop
      } else if (value == null || value == false) {
        // noop
      } else if (key == 'className') {
        out.set('class', value);
      } else if (value == true) {
        out.set(key, key);
      } else {
        out.set(key, Std.string(value));
      }
    }
  
    return out;
  }
}
