;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Z80 Test 2/28/2024 RB
;-------------------------------
org 0
  di                  ; f3
  ld sp, l_stack_top  ; 31 00 84

  ld a, 0xab          ; 3e ab
  out (0xc0), a       ; d3 c0  0106
  ld a, 0xcd          ; 3e cd
  out (0xc1), a       ; d3 c1

  jp l_entry          ; c3 00 01

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
  ld (hl), 0x5A

l_loop:
  inc l
  ld (hl), a
  jr l_loop

org 0x8000
l_ram_start:
  db 00

org 0x8400           ; 1K RAM
l_stack_top:         ; SP is pre-incremented i.e. 803F is first address push'd

