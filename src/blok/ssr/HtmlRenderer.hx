package blok.ssr;

import haxe.DynamicAccess;
using StringTools;

class HtmlRenderer {
  static final VOID_ELEMENTS = [
    'area', 'base', 'br', 'col', 'embed', 'hr', 'img', 
    'input', 'keygen', 'link', 'meta', 'param', 'source', 
    'track', 'wbr',
  ];

  public static function stringifyComponent(component:Component) {
    return switch Std.downcast(component, NativeComponent) {
      case null:
        stringifyChildren(component.getChildren());
      case native:
        stringifyNativeComponent(native);
    }
  }

  public static function stringifyChildren(children:Array<Component>) {
    return if (children.length > 0)
      children.map(stringifyComponent).join('');
    else 
      '';
  }

  public static function stringifyNativeComponent(native:NativeComponent<Dynamic>) {
    var attrs:DynamicAccess<String> = filterAttributesForRendering(native.attributes);
    var children = native.getChildren();
    
    if (native.tag == '#text') {
      if (!attrs.exists('content')) return '';
      return attrs.get('content').htmlEscape();
    }

    if (native.tag == '#document' || native.tag == '#fragment') {
      return stringifyChildren(children);
    }

    var tag = switch native.tag.split(':') {
      case [_, name]: name;
      default: native.tag;
    }

    var out = '<${tag}';
    var attrs = [ for (key => value in attrs) '$key="$value"' ];
    if (attrs.length > 0) out += ' ${attrs.join(' ')}';

    // todo: handle innerHTML.

    return if (VOID_ELEMENTS.contains(tag)) {
      out + '/>';
    } else if (children.length > 0) {
      out + '>' + stringifyChildren(children)+ '</${tag}>';
    } else {
      out + '></${tag}>';
    }
  }

  public static function filterAttributesForRendering(attrs:DynamicAccess<Dynamic>) {
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
