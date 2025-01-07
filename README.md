# vim-acton

Vim plugin for the Acton programming language, supporting:

- syntax highlighting
- smart indent

## Install

Modify your configuration file:
- Vim: `~/.vim`
- Neovim: `~/.config/nvim/init.vim`

### Using a plugin manager

[vim-plug](https://github.com/junegunn/vim-plug):
```vim
call plug#begin()

Plug 'actonlang/vim-acton'

call plug#end()
```

[Vundle](https://github.com/VundleVim/Vundle.vim):
```vim
call vundle#begin()

Plugin 'actonlang/vim-acton'

call vundle#end()
```

### Manual install

```bash
git clone https://github.com/actonlang/vim-acton.git
cd vim-acton
mkdir -p ~/.vim/pack/plugins/start
cp -r . ~/.vim/pack/plugins/start/vim-acton
```
