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
4. [Assume that](https://github.com/otobrglez/compression-puzzle/issues/29) the input is always a sequence of ASCII upper-case characters (no numbers or symbols).

## Additional Q/A

- **What if my language is not yet supported?** No problem. Just pretend that it does and provide some instructions on how can it be ran in the PR. We'll try to use the wizzardy of [Nix](https://nixos.org/) and/or [Docker](https://www.docker.com/) to compile and run it along with others.
- **Can I submit multiple solutions?**
Yes; please do.
- **Should we benchmark the solutions agains each other?** 
Possibly.
- **Why are you doing this?** 
Because its fun!
- **Will there be any recap/summary/article written?** 
Hopefully, yes.
- **How can I contact you?** 
Try [@otobrglez](https://twitter.com/otobrglez) on Twitter or via [GitHub issues](https://github.com/otobrglez/compression-puzzle/issues) or something.

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
make clojure
make fs
make go
make haskell
make javascript
make kotlin
make python
make ruby
make rust
make rye-docker
make scala
```

## Benchmarking

Although benchmarking is not the primary goal of this project; some authors are really kean to measure the performance of their solutions and compare them to others. 

These languages have benchmarking suites made and feel free to give the ma try.

```bash
# Python
python src/python/benchmarks.py

# F#
./src/fsharp/benchmark.fsx
```

P.s.: If you feel the urge that you need to benchmark your solution agains others; please feel free to do so and attach some instructions to [your PR](https://github.com/otobrglez/compression-puzzle/pulls).

## Authors

- [Andraž Brodnik](http://github.com/brodul)
- [David Ličen](https://github.com/davision)
- [Janko Metelko](https://github.com/refaktor)
- [Jernej Virag](https://github.com/izacus)
- [Klemen Kogovšek](https://github.com/kkogovsek)
- [Krištof Črnivec](https://github.com/MrChriss)
- [Luka Kacil](https://github.com/lknix)
- [Marek Fajkus](https://github.com/turboMaCk)
- [Miha Novak](https://github.com/mihanovak1024)
- [Mitja Živković](https://linkedin.com/in/mitja-živković-367206)
- [Oto Brglez](https://github.com/otobrglez)
- [Peter Keše](https://github.com/pkese)
- [Simon Belak](https://github.com/sbelak)
- [Simon Žlender](https://github.com/szlend)
- [Tit Petrič](https://github.com/titpetric)
- [Urban Škudnik](https://github.com/uskudnik)
