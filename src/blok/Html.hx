package blok;

@:build(blok.core.html.HtmlBuilder.build(
  'blok.core.html.HtmlTags',
  'blok.NodeType', 
  (_:Dynamic)
))
class Html {
  public static inline function fragment(children:Array<VNode>):VNode {
    return VFragment(children);
  }

  public static inline function text(content:String, ?key:Key):VNode {
    return VComponent(TextType, { content: content }, key);
  }
}
