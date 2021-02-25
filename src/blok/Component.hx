package blok;

@:build(blok.core.ComponentBuilder.build((_:blok.core.Node)))
@:autoBuild(blok.core.ComponentBuilder.autoBuild((_:blok.core.Node)))
class Component implements blok.core.Component<blok.core.Node> {}
