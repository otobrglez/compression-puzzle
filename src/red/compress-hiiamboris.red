Red []

; two oneliner solution posted on Red gitter chat by @hiiamboris
; @refaktor added the asserts

; Solution 1

res-1: rejoin parse "AAABBAAC" [collect any [s: set a skip any a e: keep (offset? s e) keep (a)]]

; Solution 2

; got map-each has no value
; res-2: rejoin map-each/eval s split "AAABBAAC" :<> [[length? s s/1]]


; Asserts

unless equal? res-1 "3A2B2A1C" [
	do make error! "Assertion 1 has failed"
]

; unless equal? res-2 "3A2B2A1C" [
; 	do make error! "Assertion 2 has failed"
; ]
