# Piantor pro BT configuration

This repository contains my ZMK configuration for a [Piantor Pro BT from
Keebart](https://www.keebart.com/products/piantor-wireless).

## layout

My layout is based on the [miryoku keyboard layout](https://github.com/manna-harbour/miryoku/tree/master).
The layout is configured with the [keymap editor](https://nickcoutsos.github.io/keymap-editor/)

![all layers](./draw/piantor_pro_bt.svg)

## draw keymap image

Use the [keymap-drawer project](https://github.com/caksoylar/keymap-drawer) for draw an image of my keymap.

```bash
# parse config for build a yaml file
devbox run parse

# draw svg file based on previous yaml file
devbox run draw
```

## todo

- [ ] configure workflow for automatically render keymap image
- [ ] nav layout: `redo`, `paste`, `copy` and `undo` does not work
