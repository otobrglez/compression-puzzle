:PHONY: scalac

run: scala python javascript bash ruby go fs clojure rye

clean:
	rm -rf *.tasty *.class *.class*

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
	python3 src/python/*.py

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

rye: rye-build
	./rye-src/rye src/rye/compress_jm_rec.rye
	./rye-src/rye src/rye/compress_jm_rec_steps.rye

# Rye
rye-src: GO111MODULE = auto
rye-src:	
	export GO111MODULE=${GO111MODULE} && \
	git clone --depth=1 --branch=main https://github.com/refaktor/rye.git rye-src && cd rye-src && \
		go get -u -v \
		github.com/refaktor/go-peg \
		github.com/refaktor/liner \
		golang.org/x/net/html \
		github.com/pkg/profile \
		github.com/pkg/term

rye-build: GO111MODULE = auto
rye-build: rye-src
	 cd rye-src && export GO111MODULE=${GO111MODULE} && \
			go build -x -tags "b_tiny" -o rye .

rye-clean:
	rm -rf rye-src
