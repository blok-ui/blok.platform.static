using Blok;

class Run {
  static function main() {
    var out = Platform.render(ctx -> Html.div({
      attrs: {
        className: 'foo'
      },
      children: [
        Html.text('Hello world')
      ]
    }));
    trace(out);
  }
}
