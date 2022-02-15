Red [
	file:   %compress-gregg.red
	author: "Gregg Irwin"
	date:   02-Feb-2022
]

run-length-encode: function [
	"Run-length encode input, in place"
	src [string!] "String to compress (modified)"
][
	if find src charset [#"0" - #"9"][					; Even a single digit will cause us pain.
		print {
		run-length-encode says:
		
			WARNING! Inputs containing digits produce indecipherable output.
			
			But you asked for it, so I'll do it.
		}
	]
	; This isn't concise or efficient, but shows some Red features other
	; langs don't have, and gets you thinking in terms of series! values.
	while [not tail? src][
		not-cur-char: complement charset copy/part src 1 ; Anything not the char we're on now.
		diff-pos: any [                                 ; Char change position 
			find src not-cur-char                       ; We found a different character
			tail src                                    ; We didn't find one, so the tail ends the run
		]
		len: subtract index? diff-pos index? src        ; How long is the run?
		src: change/part src len back diff-pos          ; Change all but the last char in the run to len digits
		src: next src                                   ; Skip the last char in the run, for the next pass
	]
	head src                                            ; Loop left src at the tail; be nice to the user
]

run-length-decode: function [
	"Run-length decode input"
	src [string!] "Run-length encoded string to decompress"
][
	digit: charset [#"0" - #"9"]
	non-digit: complement digit

	if parse src [some digit][								; `parse some` means one or more
		print {
		run-length-decode says:
		
			Inputs containing only digits are indecipherable.
			
			Move along. Nothing to see here.
		}
		return none
	]

	; Src and char-pos are series references, not char! values.
	result: copy ""
	while [not tail? src][
		char-pos: any [find src non-digit  tail src]		; Either we found another char, or we're done
		if not tail? char-pos [
			len: load copy/part src char-pos				; Load converts string of length digits to integer
			append/dup result first char-pos len
		]
		src: next char-pos									; Skip the char we're on, or we'll `find` it again, endlessly
	]
	result
]

tests: [
	"AAABBAAC"
	"ABBCCCDDDD"
	"AAAABBBCCD"
	"AAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaBBCCCDDDD"
	""
	"0"
	;"111111111111111122222222233333333333333456666"
]
;
; foreach orig tests [
;	print ["ORIG:" mold orig tab "RLE:" mold rle: run-length-encode copy orig]    ; COPY is important here!
;	print ["RLE: " mold rle  tab "OUT:" mold out: run-length-decode rle]
;	print either orig = out ["OK"]["Round trip failed"]
;	print '-------
; ]

unless equal? run-length-encode "AAABBAAC" "3A2B2A1C" [
	do make error! "Assertion has failed."
]


