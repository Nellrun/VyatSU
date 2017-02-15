.386 
.model flat, stdcall 

;MessageBoxA_t                   typedef proto stdcall :DWord, :DWord, :DWord, :DWord
;extern MessageBoxA              : MessageBoxA_t
;ExitProcess                     proto stdcall :DWord
;GetDiskFreeSpaceA                 proto stdcall :DWord, :DWord, :DWord, :DWord, :DWord

extrn ExitProcess: dword 
extrn MessageBoxA: dword 
extrn GetDiskFreeSpaceA: dword 

.data
spc dd ?
bpc dd ?
nfc dd ?
tnc dd ? 

wordDeliver dd 10

head db "Message",0

msgClusterSize db "Size of one sector    =       B",13,
"Size of one cluster    =      sectors",13,
"Number of free clusters =             ",13,
"Total clusters =                 ",0
msgFail db "Error",0 

.code  
asm_main PROC 
;main:
	push offset tnc
	push offset nfc
	push offset bpc
	push offset spc
	push 0
	call GetDiskFreeSpaceA 
	push 40h 
	push offset head 
	cmp ax, 0 
	jz error

	;reading byte per cluster
	mov eax, bpc
	push 25
	call parseInt

	;reading sectors in cluster
	mov eax, spc
	push 59
	call parseInt

	;reading free clusters
	mov eax, nfc
	push 95
	call parseInt

	;reading total clusters
	mov eax, tnc
	push 125
	call parseInt

	push offset msgClusterSize
	jmp cont 
error: push offset msgFail 
cont: 
	push 0 
	call MessageBoxA 
	push 0 
	call ExitProcess 
asm_main ENDP
parseInt PROC
	push ebp
	mov ebp, esp
	mov ebx, [ebp+8]
	push 0FFFFh
	loop_1:
		xor edx, edx
		cmp eax, 0
		je exit
		div wordDeliver
		push edx
		jmp loop_1
	exit:
		loop_2:
			pop eax
			cmp eax, 0FFFFh
			je exit_2
			add eax, 30h
			mov [msgClusterSize][bx], al
			add ebx, 1
			jmp loop_2
		exit_2:
			pop ebp
			ret 4
parseInt ENDP
end