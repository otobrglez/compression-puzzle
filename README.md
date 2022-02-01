# The Compression Puzzle

![GitHub Actions Status](https://github.com/otobrglez/compression-puzzle/actions/workflows/test.yml/badge.svg)

One lovely Friday we were faced with this nice yet intriguing programming puzzle.

```
One shall write a program that compresses string "AAABBAAC" to its compressed form "3A2B2A1C".
```

These attempts were made,...

## Basic rules

1. No external libraries or tools shall be used. Only [standard, bundled libraries](https://en.wikipedia.org/wiki/Standard_library) apply.
2. "[Assert](https://en.wikipedia.org/wiki/Assertion_(software_development))" inside your solution if the function does what it is suppose to do.
3. You can apply as many solutions as you want to any language you want.

## Development

```bash
# Via Nix Shell
$ nix-shell shell.nix --run "make run"
# if you preffer to roll your own local brew
$ make
```

To run individual languages use:

```bash
make bash
make go
make javascript
make python
make ruby
make scala
```

## Authors

- [David Ličen](https://github.com/davision)
- [Andraž Brodnik](http://github.com/brodul)
- [Luka Kacil](https://github.com/lknix)
- [Oto Brglez](https://github.com/otobrglez)
- [Krištof Črnivec](https://github.com/MrChriss)
- [Tit Petrič](https://github.com/titpetric)
- [Urban Škudnik](https://github.com/uskudnik)
