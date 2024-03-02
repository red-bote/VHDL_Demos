;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Z80 Test 2/28/2024 RB
;-------------------------------
org 0
  di
  ld sp, l_stack_top
  jp l_entry

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RST 38 /INT handler
;-------------------------------
ds  0x0038-$
org 0x0038
  di                  ; f3
;  exx                 ; exchanges BC, DE, and HL with shadow registers with BC', DE', and HL'.
;  ex   af, af'        ; save AF, it's not part of the exx exchange

  inc (hl)            ; 34

rst38_out:
;  exx                 ; restore BC, DE, and HL
;  ex   af, af'        ; restore AF
  ei                  ; fb
  ret                 ; c9     reti?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ds  0x0066-$
org 0x0066
;;=============================================================================
;; RST_66()
;;  Description:
;;   Input handler
;; IN:
;; OUT:
;;-----------------------------------------------------------------------------
;    exx             ; exchanges BC, DE, and HL with shadow registers with BC', DE', and HL'.
;    ex af, af'      ; save AF, it's not part of the exx exchange

    ld (hl), a

;    exx
;    ex af, af'      ; restore AF
    retn

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ds 0x0100-$
org 0x0100
;;=============================================================================
l_entry:
  ld hl, l_ram_start
  ld a, 0x5A
  ld (hl), a
  im 1
  ei

l_loop:
  inc a               ; 3c
  jr l_loop           ; 18 fd  jr $-1

org 0x8000
l_ram_start:
  db 00

org 0x8040
l_stack_top:          ; SP is pre-incremented i.e. 803F is first address push'd

