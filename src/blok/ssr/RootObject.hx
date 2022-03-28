package blok.ssr;

import Blok.Observable;

class RootObject extends HtmlObject {
  public final onUpdate:Observable<RootObject>;
  var platform:Null<blok.ui.Platform>;
  var isScheduled:Bool = false;

  public function new() {
    super('#document', {});
    onUpdate = new Observable(this);
  }

  public function setup(platform) {
    this.platform = platform;
  }

  override function notify() {
    if (!isScheduled && platform != null && onUpdate != null) {
      isScheduled = true;
      platform.scheduleEffects(effects -> effects.register(() -> {
        isScheduled = false;
        onUpdate.notify();
      }));
    }
  }  
}
