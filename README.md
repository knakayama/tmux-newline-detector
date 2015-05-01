tmux newline detecter
=====================

This [tpm](https://github.com/tmux-plugins/tpm) plugin detects newline in tmux buffer (or clipboard if you use [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)), and ask for you whether or not pasting it to terminal with **kindness**.
Also, add **peek** key binding to show what is in tmux buffer.

## Requirement

1. tmux
2. [tpm](https://github.com/tmux-plugins/tpm)
3. [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard) (optional)

## Install

1. Add above line to your `~/.tmux.conf`

```bash
set-option -g @tpm_plugins "        \
    knakayama/tmux-newline-detecter \
"
```

2. Press `Prefix + U` in tmux session

## Usage

Default peek key binding is `Prefix + P`. If you change this binding, set below line to your `~/.tmux.conf`

```bash
set-option -g @peek 'x' # or your favorite key
```

Default paste key binding is `Prefix + ]`. If you change this binding, set below line to your `~/.tmux.conf`

```bash
set-option -g @paste 'X' # or your favorite key
```

## License

[MIT](http://knakayama.mit-license.org/)

## Author

[knakayama](https://github.com/knakayama)
