Blok Platform Static
====================

Server-side rendering for Blok.

Usage
-----

Blok's static platform is designed to work seamlessly with [blok.platform.dom](https://github.com/blok-ui/blok.platform.dom). The only code that should be different is which `Platform` you use.

Right now, `blok.ssr.Platform` has only one static method: `render`. Using it might look something like this:

```haxe
import blok.Html;
import blok.ssr.Platform;

function main() {
  Platform.render(
    Html.div({
      children: [ Html.text('foo') ]
    }),
    html -> trace(html),
    e -> trace(e.message)
  );
}
```

`Platform.render`'s first callback is called every time the given component finishes rendering. The second can be used to handle any errors encountered when the app renders (but may be omitted if desired). Note that both callbacks may be called any number of times, and that the `onRender` callback will be invoked if ANY child component changes. This should give you the tools needed to handle asynchronous rendering.

> ... although I still need to test it.
