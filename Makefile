:PHONY: scalac

run: build scala python javascript bash ruby

clean:
	rm -rf *.tasty *.class *.class*

#Bash
bash:
	bash src/bash/*.sh

# Python
python:
	python3 src/python/*.py

# JavaScript
javascript:
	node src/javascript/*.js

# Ruby
ruby:
	ruby src/ruby/*.rb

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
