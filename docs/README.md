# Documentation

Diagrams are written in [PlantUML](https://plantuml.com/).

See [DIAGRAMS.md](./DIAGRAMS.md).

## Installing

```
# Linux
sudo apt install plantuml
```

## Rendering diagrams

Executing the rake task below in the root directory will render all
`./docs/*.puml` files into `.png`.

```
bundle exec rake docs:diagram:build_container
bundle exec rake docs:diagram:render
```

_**Note:** If `styles.puml` file changed, rebuilding the container is
required before render the diagrams again, otherwise changes won't be
applied._

## Build DIAGRAMS.md

```
bundle exec rake docs:diagram:build_markdown
```

## Resources

- [Docker Container with PlantUML](https://hub.docker.com/r/think/plantuml/)
- [Visual Studio extension to preview changes as you type](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml)
- [PlantUML cheatsheet](https://blog.anoff.io/puml-cheatsheet.pdf)
- [UML cheatsheet](https://loufranco.com/wp-content/uploads/2012/11/cheatsheet.pdf)
- [PlantUML All Skin Params Documentation](https://plantuml-documentation.readthedocs.io/en/latest/formatting/all-skin-params.html)
- [Awesome PlantUML repository with examples and templates](https://github.com/Voronenko/awesome-plantuml)
