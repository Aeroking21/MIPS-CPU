# Team00 ISA Project


## How to compile 
1. Go to the directory
2. Compile the assembler with `gcc assemble.cpp -lstdc++ -o assemble.out` (If it says permission denied run `chmod u+x assemble.cpp`)
3. Change the content of the `test.asm` file to the assembly code you want to test (Check below for format/syntax)
4. Assemble the instructions with `./assemble.out test.asm > instructions.mem`
5. Compile all the verilog files with `iverilog -Wall -g 2012 -s CPU_tb -o cpu_tb test/CPU_tb.v test/ROM.v rtl/mips_cpu_harvard.v rtl/alu.v rtl/loadstore.v rtl/RAM.v`
6. Run the output file with `./cpu_tb`
7. Check waveforms with `gtkwave CPU_TB.vcd`
8. Log every bug you find (missbehaving instruction, solution, etc.. so we can discuss together later)

