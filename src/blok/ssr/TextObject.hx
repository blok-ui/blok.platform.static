package blok.ssr;

import blok.render.Object;

class TextObject extends Object {
  var content:String;

  public function new(content) {
    this.content = content;
  }

  public function updateContent(content) {
    if (content == null) content = '';
    this.content = content;
  }

  public function toString():String {
    return content;
  }
}
