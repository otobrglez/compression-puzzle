Red[]


compress: func [
	src [string!]
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
