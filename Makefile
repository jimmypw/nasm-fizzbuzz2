build:
	nasm -f elf64 fizzbuzz.asm
	gcc -o fizzbuzz fizzbuzz.o
test:
	echo Test Placeholder
	false
