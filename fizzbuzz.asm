BITS 64

EXTERN printf

SECTION .DATA
	fizz     DB " fizz",0
	buzz     DB " buzz",0
	printstr DB "%s",0
	printnum DB "%d",0
	lf       DB 10,0

SECTION .TEXT
	GLOBAL main

main:
	push rbp      ; configure stack frame
	mov rbp, rsp
	sub rsp, 0x20 
	mov rcx, 1 ; used for counting
loop:
	mov [rbp - 0x8], rcx ; stash loop counter
	mov rdi, rcx
	call fizzbuzz
	mov rcx, [rbp - 0x8] ; restore loop counter
	add rcx, 1 ; increment the countr
	mov rax, 20000
	cmp rcx, rax ; only loop 50 times
	jl loop
end:
	pop rbp
	jmp exit

newline:
	push rbp
	mov rbp, rsp
	mov rax, 1
	mov rdi, lf
	call printf
	pop rbp
	ret

printfnum:
	push rbp
	mov rbp, rsp
	
	mov rax, 1
	mov rsi, rdi
	mov rdi, qword printnum
	call printf

	pop rbp
	ret

fizzbuzz:
	push rbp	; set up the stack frame
	mov rbp, rsp
	sub rsp, 0x10	; create somewhere to store rcx
	mov qword[rbp - 0x08], rdi

	call printfnum
	mov rdi, qword[rbp - 0x08]
	call izfizz
	mov rdi, qword[rbp - 0x08]
	call izbuzz
	mov rdi, qword[rbp - 0x08]
	call newline

	mov rsp, rbp
	pop rbp
	ret

izfizz:
	push rbp
	mov rbp,rsp
	mov edx,0
	mov rax,rdi
	mov rbx,3
	div rbx
	cmp rdx,0
	jne izfizz_end
	; divisable by 3 print fizz.
	call printfizz
izfizz_end:
	pop rbp
	ret

printfizz:
	push rbp
	mov rbp, rsp

	mov rax, 1
	mov rdi, qword fizz
	call printf

	pop rbp
	ret
	
izbuzz:
	push rbp
	mov rbp,rsp
	mov edx,0
	mov rax,rdi
	mov rbx,5
	div rbx
	cmp rdx,0
	jne izbuzz_end
	; divisable by 5 print buzz.
	call printbuzz
izbuzz_end:
	pop rbp
	ret

printbuzz:
	push rbp
	mov rbp, rsp

	mov rax, 1
	mov rdi, qword buzz
	call printf

	pop rbp
	ret

exit:
	mov  rax, 60 ; syscall exit
	mov  rdi, 0 ; exit(0)
	syscall
