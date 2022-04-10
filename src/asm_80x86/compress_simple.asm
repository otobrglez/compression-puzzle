; Simple 80x86 assembler example for the Compression Puzzle
; https://github.com/otobrglez/compression-puzzle/
; by Kevin

format PE console
entry start

include 'win32a.inc'

;======================================
section '.data' data readable writeable
;======================================

uncompressed    db "AAABBAAC",0                 ; The input buffer
newline         db 10,0                         ; Convenience: CR
what            db "?",0                        ; Convenience: String buffer, 1 character long.
current_char    db "%s",0                       ; C-printf buffer of 1 string, used to print the current character
current_count   db "%d",0                       ; C-printf buffer of the current count (decimal)

;=======================================
section '.code' code readable executable
;=======================================

; Load the reference character into the B1 register
; Iterate through the buffer, using AX to store the next character.
; Increment CX if the next character is the same as the reference character.
; When a new character is detected, print the current results,
; reset the CX counter to 1 (We always have at least 1 incidence).
; Stop processing when we reach the end of the (null-terminated) buffer.

start:
        cinvoke printf, uncompressed            ; Print the uncompressed buffer
        cinvoke printf, newline                 ; Print a newline

        mov edi, uncompressed                   ; Load EDI with the buffer address (the first character)
next:
        movsx bx, byte [edi]                    ; Load the current character into BX

        mov [what],bl                           ; Write the current character into [what], so that we can print it
        cinvoke printf, current_char, what      ; Print the current character
        mov ecx, 1                              ; Count the first occurence of the character.
again:
        inc edi                                 ; Move to the next position
        movsx ax, byte [edi]                    ; Load this character into AX
        cmp ax, 0                               ; Check if we have reached the end of the buffer
        je done                                 ; If so, then stop checking

        cmp ax, bx                              ; Is this character the same as the current character?
        jne print                               ; If not, go and print the current result.
        inc ecx                                 ; Else, increment the counter
        jmp again                               ; and check next character in buffer

print:
        cinvoke printf, current_count, ecx      ; Print the current count

        jmp next                                ; Start over

done:
        cinvoke printf, current_count, ecx      ; Print the final tally

        stdcall [ExitProcess],0                 ; Exit the application

;====================================
section '.idata' import data readable
;====================================

library kernel,'kernel32.dll',\
        msvcrt,'msvcrt.dll'

import  kernel,\
        ExitProcess,'ExitProcess'

import  msvcrt,\
        printf,'printf'
