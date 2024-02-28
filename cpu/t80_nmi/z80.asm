;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Z80 Test 2/28/2024 RB
;-------------------------------
org 0
  di
  ld sp, l_stack_top

  jp l_entry

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

    ; do something
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
  ld (hl), a         ; *($8000) = 0

l_loop:

  inc a
  jr l_loop

org 0x8000
l_ram_start:
  db 00

org 0x8040
l_stack_top:         ; SP is pre-incremented i.e. 803F is first address push'd

