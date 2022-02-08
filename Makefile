:PHONY: bash clojure fs go javascript kotlin python ruby scala haskell rust clean

run: bash clojure fs go javascript kotlin python ruby scala haskell rust

clean:
	rm -rf build *.tasty *.class *.class*

# Clojure
clojure:
	cd src/clojure/clojpression-puzzle && \
		clj -X clojpression-puzzle/run

# F#
fs:
	./src/fsharp/compress-pk1.fsx
	./src/fsharp/compress-pk2.fsx
	./src/fsharp/compress-pk3.fsx

#Bash
bash:
	bash src/bash/*.sh

#Go
go:
	go run src/go/compress_mitja.go
	go run src/go/compress_tit.go

# Python
python:
	python3 src/python/compress_*.py

# JavaScript
javascript:
	node src/javascript/*.js


# Ruby
ruby:
	ruby src/ruby/compress-kbc-0.rb
	ruby src/ruby/compress-kbc-1.rb

# Scala
CompressionPuzzle01.class:
	scalac src/scala/CompressionPuzzle01.scala

CompressionPuzzle02.class:
	scalac src/scala/CompressionPuzzle02.scala

scala: CompressionPuzzle01.class CompressionPuzzle02.class
	scala CompressionPuzzle01
	scala CompressionPuzzle02

# Kotlin
kotlin:
	kotlinc -script src/kotlin/compress.kts
	kotlinc -script src/kotlin/mn1024_compress.kts

# Rye
rye-docker:
	docker run --rm -v $(PWD):/app --entrypoint /bin/bash refaktorlabs/ryelang:latest /app/src/rye/run-all.sh

# Haskell
haskell:
	echo "AAABBAAC" | runhaskell src/haskell/Compress_turbomack.hs

# Rust
rust:
	rustc src/rust/compress.rs -O --test --out-dir build/rust && ./build/rust/compress
