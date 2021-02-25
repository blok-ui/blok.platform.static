package blok;

import blok.core.Node;
import blok.core.RenderResult;

class Engine implements blok.core.Engine<Node> {
  public function new() {}

  public function traverseSiblings(first:Node):Cursor {
    return new Cursor(first.parentNode, first);
  }

  public function traverseChildren(parent:Node):Cursor {
    return new Cursor(parent, parent.childNodes[0]);
  }

  public function getRenderResult(node:Node):Null<RenderResult<Node>> {
    return node.rendered;
  }

  public function setRenderResult(node:Node, rendered:Null<RenderResult<Node>>):Void {
    node.rendered = rendered;
  }

  public function createPlaceholder(component:blok.core.Component<Node>):VNode {
    return Html.text('');
  }
}
