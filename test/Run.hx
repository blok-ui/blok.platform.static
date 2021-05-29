using StringTools;
using Blok;

function main() {
  var times:Int = 1;
  var state = new SimpleState({ foo: 'foo' });

  Platform.render(
    Provider.provide(state, context -> SimpleState.observe(context, state -> 
      Html.div({ className: 'foo-bar', onclick: e -> trace('oh no') },
        Html.text('Foo'),
        ShouldWork.node({ foo: state.foo })
      ))
    ),
    result -> trace(result + ' : ran ' + times++),
    e -> trace(e.message)
  );

  state.setFoo('Something else');
}

class ShouldWork extends Component {
  @prop var foo:String;

  public function render() {
    return Html.section({ className: foo.toLowerCase().replace(' ', '-') },
      Html.header({}, Html.text('Stuff')),
      Html.p({}, Html.text(foo))
    );
  }
}

@service(fallback = new SimpleState({ foo: 'foo' }))
class SimpleState implements State {
  @prop var foo:String;

  @update
  public function setFoo(foo) {
    return UpdateState({ foo: foo });
  }
}
