<br><br>

<h1 align="center">Ceci est Ma Banque 🏦</h1>

<p align="center">
  <a target="_blank" href="https://github.com/wcalderipe/ma-banque/actions?query=workflow%3ACI+branch%3Amaster ">
    <img src="https://github.com/wcalderipe/ma-banque/workflows/CI/badge.svg">
  </a>
</p>

<br><br>

A minimalist banking implementation based on [Philippe Creux's blog post Event Sourcing Made Simple](https://kickstarter.engineering/event-sourcing-made-simple-4a2625113224).

## Getting Started

```
# Spin up Postgres container
docker-compose up -d

rails db:setup
rails server
```

## Documentation

So far the only documentation are diagrams to simply express commands,
events and reactors required for an action flow.

For all diagrams, see [./DIAGRAMS.md](./docs/DIAGRAMS.md).

## Further Reading

- [Event Sourcing Made Simple by Philippe Creux](https://kickstarter.engineering/event-sourcing-made-simple-4a2625113224)
- [event-sourcing-rails-todo-app-demo repository by Philippe Creux](https://github.com/pcreux/event-sourcing-rails-todo-app-demo)
- [EventSourcing by Martin Fowler](https://martinfowler.com/eaaDev/EventSourcing.html)
- [YOW! Nights March 2016 Martin Fowler - Event Sourcing](https://www.youtube.com/watch?v=aweV9FLTZkU)
- [What do you mean by "Event-Driven"? by Martin Fowler](https://martinfowler.com/articles/201701-event-driven.html)
- [event_sourced_record](https://github.com/fhwang/event_sourced_record)
