# Piantor pro BT configuration

This repository contains my [ZMK](https://zmk.dev/) configuration for a [Piantor Pro BT from
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

- [x] configure workflow for automatically render keymap image
- [x] nav: `redo`, `paste`, `copy` and `undo` does not work --> removed
- [x] symbol: the $ sign is defined twice, on `t` and `s`, following the plan, should be `(`
- [x] **feature**: add french/german letters with accent
  - [ ] have a look at [zmk-unicode](https://github.com/urob/zmk-unicode)
  - [x] use us-intl layout
  - [x] use `AltRight` + `,` for `ç`
- [x] number: no need for have minus twice
- [x] issue: home row mod: f + i often writes (only a shift issue ?)
- [x] feature: add a mouse layer
- [x] chore: consider use home row mod keys like miryoku (super, alt, ctrl, shift)
- [ ] chore: &trans vs &none for unused keys
- [x] issue: no bluetooth at boot (pc)
  - connect with usb, at least the left keyboard
