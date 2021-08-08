package blok;

import haxe.DynamicAccess;

using Lambda;
using StringTools;

class ElementWidget<Attrs:{}> extends ConcreteWidget {
  public final tag:String;
  public final type:WidgetType;
  public var attributes:Attrs;
  public var children:Array<VNode> = [];

  public function new(type, tag, attributes, children) {
    this.tag = tag;
    this.type = type;
    this.attributes = attributes;
    this.children = children;
  }

  public function __performUpdate(registerEffect:(effect:()->Void)->Void) {
    Differ.diffChildren(this, children, __platform, registerEffect);
  }

  public function setChildren(newChildren:Array<VNode>) {
    __status = WidgetInvalid;
    children = newChildren;
  }

  public function updateAttrs(attrs:Attrs) {
    __status = WidgetInvalid;
    attributes = attrs;
  }

  public function getWidgetType() {
    return type;
  }

  public function toConcrete() {
    return [ stringifyWidget(this) ];
  }

  public function getFirstConcreteChild() {
    return toConcrete();
  }

  public function getLastConcreteChild() {
    return toConcrete();
  }

  public function addConcreteChild(child:Widget) {
    // noop
  }

  public function insertConcreteChildAt(pos:Int, child:Widget) {
    // noop
  }

  public function moveConcreteChildTo(pos:Int, child:Widget) {
    // noop
  }

  public function removeConcreteChild(child:Widget) {
    // noop
  }
}

private final VOID_ELEMENTS = [
  'area', 'base', 'br', 'col', 'embed', 'hr', 'img', 
  'input', 'keygen', 'link', 'meta', 'param', 'source', 
  'track', 'wbr',
];

private function stringifyWidget<Attrs:{}>(widget:ElementWidget<Attrs>) {
  var attrs = filterAttributesForRendering(widget.attributes);
  var children:Array<String> = widget
    .getConcreteChildren()
    .map(c -> c.toConcrete())
    .flatten();

  if (widget.tag == '#document' || widget.tag == '#fragment') {
    return children.join('');
  }

  var tag = switch widget.tag.split(':') {
    case [_, name]: name;
    default: widget.tag;
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

private function filterAttributesForRendering(attrs:DynamicAccess<Dynamic>) {
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
