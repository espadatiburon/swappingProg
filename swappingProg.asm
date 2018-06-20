; Assembly code emitted by HLA compiler
; Version 1.76 build 9932 (prototype)
; HLA compiler written by Randall Hyde
; FASM compatible output

		format	MS COFF


offset32	equ	 
ptr	equ	 

macro global [symbol]
{
 local isextrn
 if defined symbol & ~ defined isextrn
   public symbol
 else if used symbol
   extrn symbol
   isextrn = 1
 end if
}

macro global2 [symbol,type]
{
 local isextrn
 if defined symbol & ~ defined isextrn
   public symbol
 else if used symbol
   extrn symbol:type
   isextrn = 1
 end if
}


ExceptionPtr__hla_	equ	fs:0

		include	'swappingProg.extpub.inc'




		section	'.data' data readable writeable align 16
		include	'swappingProg.data.inc'

		dd	0	;dummy to keep linker happy
		section	'.bss' readable writeable align 16
		include	'swappingProg.bss.inc'

		rb	4	;dummy to keep linker happy
		section	'.text' code readable executable align 16
		include	'swappingProg.consts.inc'

		include	'swappingProg.ro.inc'

; Code begins here:
L809_swapper__hla_:
		mov	dword ptr [L812_tempEAX__hla_+0], eax	;/* tempEAX */
		mov	dword ptr [L813_tempEBX__hla_+0], ebx	;/* tempEBX */
		mov	dword ptr [L814_tempECX__hla_+0], ecx	;/* tempECX */
		mov	dword ptr [L815_tempEDX__hla_+0], edx	;/* tempEDX */
		mov	dword ptr [L816_tempESI__hla_+0], esi	;/* tempESI */
		pop	dword ptr [L810_dReturnAddress__hla_+0]	;/* dReturnAddress */
		pop	ebx
		pop	ecx
		pop	edx
		push	dword ptr [L810_dReturnAddress__hla_+0]	;/* dReturnAddress */
		push	dword ptr [L812_tempEAX__hla_+0]	;/* tempEAX */
		push	dword ptr [L813_tempEBX__hla_+0]	;/* tempEBX */
		push	dword ptr [L814_tempECX__hla_+0]	;/* tempECX */
		push	dword ptr [L815_tempEDX__hla_+0]	;/* tempEDX */
		push	dword ptr [L816_tempESI__hla_+0]	;/* tempESI */

L817_firstCheck__hla_:
		mov	esi, [ecx+0]	;/* [ecx] */
		cmp	[edx+0], si	;/* [edx] */
		jg	L818_firstSwap__hla_

L819_secondCheck__hla_:
		mov	esi, [ecx+0]	;/* [ecx] */
		cmp	si, [ebx+0]	;/* [ebx] */
		jg	L820_secondSwap__hla_
		jmp	L821_endSwaps__hla_

L818_firstSwap__hla_:
		mov	eax, [edx+0]	;/* [edx] */
		mov	word ptr [L811_tempNumber__hla_+0], ax	;/* tempNumber */
		mov	eax, [ecx+0]	;/* [ecx] */
		mov	[edx+0], ax	;/* [edx] */
		mov	ax, word ptr [L811_tempNumber__hla_+0]	;/* tempNumber */
		mov	[ecx+0], ax	;/* [ecx] */
		jmp	L819_secondCheck__hla_

L820_secondSwap__hla_:
		mov	eax, [ebx+0]	;/* [ebx] */
		mov	word ptr [L811_tempNumber__hla_+0], ax	;/* tempNumber */
		mov	eax, [ecx+0]	;/* [ecx] */
		mov	[ebx+0], ax	;/* [ebx] */
		mov	ax, word ptr [L811_tempNumber__hla_+0]	;/* tempNumber */
		mov	[ecx+0], ax	;/* [ecx] */
		jmp	L817_firstCheck__hla_

L821_endSwaps__hla_:
		pop	eax
		pop	ebx
		pop	ecx
		pop	edx
		pop	esi
		ret
xL809_swapper__hla___hla_:
;L809_swapper__hla_ endp




;/* HWexcept__hla_ gets called when Windows raises the exception. */

HWexcept__hla_ :
		jmp	HardwareException__hla_
;HWexcept__hla_  endp

DfltExHndlr__hla_:
		jmp	DefaultExceptionHandler__hla_
;DfltExHndlr__hla_ endp



_HLAMain       :


;/* Set up the Structured Exception Handler record */
;/* for this program. */

		call	BuildExcepts__hla_
		pushd	0		;/* No Dynamic Link. */
		mov	ebp, esp	;/* Pointer to Main's locals */
		push	ebp		;/* Main's display. */


		push	L835_str__hla_
		call	STDOUT_PUTS	; puts
		push	eax
		call	STDIN_GETI16	; geti16
		mov	word ptr [L806_myX__hla_+0], ax	;/* myX */
		pop	eax
		push	L857_str__hla_
		call	STDOUT_PUTS	; puts
		push	eax
		call	STDIN_GETI16	; geti16
		mov	word ptr [L807_myY__hla_+0], ax	;/* myY */
		pop	eax
		push	L879_str__hla_
		call	STDOUT_PUTS	; puts
		push	eax
		call	STDIN_GETI16	; geti16
		mov	word ptr [L808_myZ__hla_+0], ax	;/* myZ */
		pop	eax
		lea	eax, word ptr [L806_myX__hla_+0]	;/* myX */
		push	eax
		lea	eax, word ptr [L807_myY__hla_+0]	;/* myY */
		push	eax
		lea	eax, word ptr [L808_myZ__hla_+0]	;/* myZ */
		push	eax
		call	L809_swapper__hla_
		push	L901_str__hla_
		call	STDOUT_PUTS	; puts
		push	word 00h
		push	word ptr [L806_myX__hla_+0]	; myX
		call	STDOUT_PUTI16	; puti16
		push	L915_str__hla_
		call	STDOUT_PUTS	; puts
		push	word 00h
		push	word ptr [L807_myY__hla_+0]	; myY
		call	STDOUT_PUTI16	; puti16
		push	L929_str__hla_
		call	STDOUT_PUTS	; puts
		push	word 00h
		push	word ptr [L808_myZ__hla_+0]	; myZ
		call	STDOUT_PUTI16	; puti16
QuitMain__hla_:
		push	dword 00h
		call	dword ptr [__imp__ExitProcess@4]
;_HLAMain        endp


