## Pre-installation

Before installing these configs, you will need to make sure that the `~/.config`
directory does not exists.

To backup your existing config, consider renaming the folder. For example,

```sh
mv ~/.config ~/.config_backup
```

## Installation

```
git clone https://github.com/wongjiahau/.config ~/.config
```

### Dependencies

Node:

```
npm install -g typescript-language-server typescript
npm install -g graphql-language-service-cli
npm install -g sql-formatter@4.0.2
npm install -g @fsouza/prettierd
```

Rust:

```
cargo install ripgrep
```
