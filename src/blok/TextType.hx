package blok;

class TextType {
  public static function create(props:{ content:String }) {
    return new NativeComponent('#text', {
      attributes: props
    }, false);
  }

  public static function update(component:NativeComponent<{ content:String }>, props:{ content:String }) {
    component.updateComponentProperties({
      attributes: props
    });
  }
}
