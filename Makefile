:PHONY: scalac

run: build scala python javascript bash ruby go fs

clean:
	rm -rf *.tasty *.class *.class*

# F#
fs:
	./src/fsharp/compress-pk1.fsx

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

build: scala
	echo "Building completed."
