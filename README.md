<br><br>

<h1 align="center">Ceci est Ma Banque 🏦</h1>

<p align="center">
  <a target="_blank" href="https://github.com/wcalderipe/ma-banque/actions?query=workflow%3ACI+branch%3Amaster ">
    <img src="https://github.com/wcalderipe/ma-banque/workflows/CI/badge.svg">
  </a>
</p>

<br><br>

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

For all diagrams, see [./docs](./docs) directory.


## Further Reading

- [Event Sourcing Made Simple by Philippe Creux](https://kickstarter.engineering/event-sourcing-made-simple-4a2625113224)
  - https://github.com/pcreux/event-sourcing-rails-todo-app-demo
