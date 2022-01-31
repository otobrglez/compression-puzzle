:PHONY: scalac

run: build scala python javascript

clean:
	rm -rf *.tasty *.class *.class*

# Python
python:
	python3 src/python/*.py

# JavaScript
javascript:
	node src/javascript/*.js

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
