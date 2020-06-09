# Tools

## godoc (alias of 'go doc')

![Demo: godoc](resources/godoc.gif)

### Usage

```sh
# View GoDoc of 'net/http' package 
godoc http

# View GoDoc of 'Server' in 'net/http' package 
godoc http.Server
```

**Shortcut Key**

- Ctrl-o: Open web page(http://godoc.org) of GoDoc of package in browser

### Installation

1. Install [go](https://github.com/golang/go) & [fzf](https://github.com/junegunn/fzf)
2. Copy code in [godoc_alias.zsh](https://github.com/x-color/tools/blob/master/godoc_alias.zsh).
3. Paste code to ~/.zshrc
4. Execute `source ~/.zshrc`

