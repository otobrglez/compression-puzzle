:PHONY: bash clojure fs go javascript kotlin python ruby scala haskell rust \
	elixir rescript typescript sqlite clean rye-docker red-docker groovy-docker cs c++ cpp-fast cpp-slow \
	r c asm_80x86

run: bash clojure fs go javascript kotlin python ruby scala haskell rust \
	elixir rescript typescript sqlite rye-docker red-docker groovy-docker cs cpp-fast php \
	r c

clean: c++-clean c-clean asm_80x86-clean
	rm -rf build *.tasty *.class *.class* \
		src/ts/*.js src/sqlite/compress_rec.db \
		src/cs/*/bin src/cs/*/obj

# Clojure
clojure:
	cd src/clojure/clojpression-puzzle && \
		clj -X clojpression-puzzle/run

# Crystal
crystal:
	cd src/crystal && \
		crystal run compress_kbc_0.cr

# F#
fs:
	./src/fsharp/compress-pk1.fsx
	./src/fsharp/compress-pk2.fsx
	./src/fsharp/compress-pk3.fsx

cs:
	cd src/cs/pp && dotnet run
	cd src/cs/cjenp && dotnet run
	cd src/cs/ns && dotnet run
	cd src/cs/ns2 && dotnet run
	cd src/cs/ns3 && dotnet run

#Bash
bash:
	bash src/bash/*.sh

#Go
go:
	go run src/go/compress_mitja.go
	go run src/go/compress_tit.go
	go run src/go/compress_david.go

# Python
python:
	find src/python -type f \( -iname "*.py" ! -iname benchmarks.py \) | xargs -n1 python

# JavaScript
javascript:
	find src/javascript -type f \( -iname "*.js" \) | xargs -n1 node

# R
r:
	find src/r -type f \( -iname "*.R" \) | xargs -n1 Rscript
  
# Ruby
ruby:
	ruby src/ruby/compress-kbc-0.rb
	ruby src/ruby/compress-kbc-1.rb

# Scala
CompressionPuzzle01.class:
	scalac src/scala/CompressionPuzzle01.scala

CompressionPuzzle02.class:
	scalac src/scala/CompressionPuzzle02.scala

CompressionPuzzle03.class:
	scalac src/scala/CompressionPuzzle03.scala

scala: CompressionPuzzle01.class CompressionPuzzle02.class CompressionPuzzle03.class
	scala CompressionPuzzle01
	scala CompressionPuzzle02
	scala CompressionPuzzle03

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
	yarn run build && \
		find src/ts -type f \( -iname "*.js" \) | xargs -n1 node

sqlite:
	sqlite3 src/sqlite/compress_rec.db ".read src/sqlite/compress_rec.sql"

cpp-slow:
	clang++ -std=c++17 -O3 src/c++/compress_slow.cpp -o src/c++/compress_slow && \
		./src/c++/compress_slow

cpp-fast:
	clang++ -std=c++17 -O3 src/c++/compress_fast.cpp -o src/c++/compress_fast && \
		./src/c++/compress_fast

c++: cpp-slow cpp-fast

c++-clean:
	rm -f src/c++/compress_slow src/c++/compress_fast

c:
	gcc src/c/tomaz.c -o src/c/tomaz && \
		./src/c/tomaz

c-clean:
	rm -rf ./src/c/tomaz

java:
	javac -d src/java src/java/Compression.java && \
        java -cp src/java compression.Compression

# Lua
lua:
	lua src/lua/compress.lua
	lua src/lua/compress-gsub.lua

## Docker based runners

# Rye
rye-docker:
	docker run --rm -v $(PWD):/app --entrypoint /bin/bash refaktorlabs/ryelang:latest /app/src/rye/run-all.sh

# Red
red-docker:
	docker run --rm -v $(PWD):/app --entrypoint /bin/bash rebolek/red:latest /app/src/red/run-all.sh

groovy-docker:
	docker run --rm -v $(PWD):/home/groovy/scripts \
		-w /home/groovy/scripts groovy groovy src/groovy/*.groovy

pascal-docker:
	docker run --rm -i -t -v $(PWD)/src/pascal:/source nacyot/pascal-fp_compiler:apt \
		pc -Tlinux /source/compress

swift:
	swift src/swift/compress_extension_grandfelix.swift

php:
	php -f src/php/compress_grandfelix.php

asm_80x86:	# Needs FASM to compile https://flatassembler.net/
	fasm -d Linux=TRUE src/asm_80x86/compress_simple.asm src/asm_80x86/compress_simple.o
	gcc -m32 src/asm_80x86/compress_simple.o -o src/asm_80x86/compress_simple
	strip src/asm_80x86/compress_simple

asm_80x86-clean:
	rm src/asm_80x86/*.o src/asm_80x86/compress_simple

# Rebuild the README with stats and attributions
update-readme:
	./updated-authors.rb > README2.md
	mv README2.md README.md
