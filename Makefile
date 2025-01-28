

main: module.o
	gcc -no-pie module.o -o main


module.o: main.asm
	nasm -f elf64 main.asm -o module.o