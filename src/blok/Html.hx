package blok;

@:build(blok.core.html.HtmlBuilder.build(
  'blok.core.html.HtmlTags',
  'blok.VNative', 
  (_:Dynamic)
))
class Html {
  public static inline function fragment(...children:VNode):VNode {
    return Fragment.node({ children: children.toArray() });
  }

  public static inline function text(content:String, ?key:Key):VNode {
    return new VText({ content: content }, key);
  }
}
