# Diagrams

Diagrams are written in [PlantUML](https://plantuml.com/).

## Installing

```
# Linux
sudo apt install plantuml
```

## Rendering diagrams

Executing the rake task below in the root directory will render all
`./docs/*.puml` files into `.png`.

```
bundle exec rake docs:diagram:render
```

## Resources

- [Docker Container with PlantUML](https://hub.docker.com/r/think/plantuml/)
- [Visual Studio extension to preview changes as you type](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml)
- [PlantUML cheatsheet](https://blog.anoff.io/puml-cheatsheet.pdf)
- [Awesome PlantUML repository with examples and templates](https://github.com/Voronenko/awesome-plantuml)
