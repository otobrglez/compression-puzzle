Red[]

; here’s the original one-liner solution I used in the console:
[out: "" parse "AAABBAAC" [collect into out some [s: set char skip any char e: keep (rejoin [(length? s) - length? e char])]]]
; and here’s a one-liner for a decompression
[out: "" digit: charset "0123456789" parse "3A2B2A1C" [some [copy number some digit set char skip (append/dup out char load number)]]]


compress: func [
	"Run-length encoding compressor"
	src [string!] "String to compress"
	/local out char s e
] [
	; initialize buffer
	out: make string! 10
	parse src [
		collect into out some [
			; mark start of a sequence
			s:
			; get first char in a sequence
			set char skip
			; get all remaining chars in a sequence
			any char
			; mark the length of the sequence
			e:
			; store length and char
			keep (rejoin [(length? s) - length? e char])
		]
	]
	; return result
	out
]

unless equal? compress "AAABBAAC" "3A2B2A1C" [
	do make error! "Assertion has failed"
]

decompress: func [
	"Run-length encoding decompressor"
	src [string!] "String to decompress"
	/local out digit number char
] [
	; initalize buffer
	out: make string! 10
	; setup digit charset for easier parsing
	digit: charset "0123456789"
	parse src [
		some [
			; get length
			copy number some digit
			; get char
			set char skip
			; add char to output length-times
			(append/dup out char load number)
		]
	]
	; return result
	out
]
