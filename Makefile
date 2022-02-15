:PHONY: bash clojure fs go javascript kotlin python ruby scala haskell rust \
	elixir rescript typescript sqlite clean rye-docker red-docker

run: bash clojure fs go javascript kotlin python ruby scala haskell rust \
	elixir rescript typescript sqlite rye-docker red-docker c++

clean:
	rm -rf build *.tasty *.class *.class* \
		src/ts/*.js src/sqlite/compress_rec.db

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
	find src/python -type f \( -iname "*.py" ! -iname benchmarks.py \) | xargs -n1 python

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

# Haskell
haskell:
	echo "AAABBAAC" | runhaskell src/haskell/Compress_turbomack.hs

# Rust
rust:
	rustc src/rust/compress.rs -O --test --out-dir build/rust && ./build/rust/compress

rescript:
	(cd src/rescript && rescript) && \
		node src/rescript/lib/**/*.js

elixir:
	elixir src/elixir/compress.exs
	elixir src/elixir/compress_rec.exs

typescript: 
	tsc && node src/ts/*.js

sqlite:
	sqlite3 src/sqlite/compress_rec.db ".read src/sqlite/compress_rec.sql"

c++:
	clang++ -std=c++17 -O3 src/c++/compress_slow.cpp -o src/c++/compress_slow
	clang++ -std=c++17 -O3 src/c++/compress_fast.cpp -o src/c++/compress_fast
	./src/c++/compress_slow
	./src/c++/compress_fast

c++-clean:
	rm -f src/c++/compress_slow src/c++/compress_fast

## Docker based runners

# Rye
rye-docker:
	docker run --rm -v $(PWD):/app --entrypoint /bin/bash refaktorlabs/ryelang:latest /app/src/rye/run-all.sh

# Red
red-docker:
	docker run --rm -v $(PWD):/app --entrypoint /bin/bash rebolek/red:latest /app/src/red/run-all.sh

# Rebuild the README with stats and attributions
update-readme:
	./updated-authors.rb > README2.md
	mv README2.md README.md
