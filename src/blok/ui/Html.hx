package blok.ui;

@:build(blok.html.HtmlBuilder.build(
  'blok.html.HtmlTags',
  'blok.ui.HtmlElementWidget', 
  (_:blok.render.Object)
))
class Html {
  public static inline function fragment(...children:Widget):Widget {
    return new FragmentWidget(children);
  }

  public static inline function text(content:String, ?key:Key):Widget {
    return new HtmlTextWidget(content, key);
  }
}
