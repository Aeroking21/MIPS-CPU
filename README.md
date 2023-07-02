# ISA MIPS CPU Project

The 32-bit MIPS compliant CPU has a Harvard-type interface as it relies on separate memory units for instructions and data; they are therefore accessed in parallel via distinct buses.

The CPU works in a linear and transparent way by performing most operations within one cycle, due to the combinatorial access to memory. The only instructions that pose an exception to the overall “1-instruction- 1-cycle” format are store instructions that involve bytes, half words and, in a way, Jumps, which pose an exception to linearity in order to ensure compliance to the ISA (see the section on branch delay slot).

Both the buses that bridge the CPU with the instruction memory and the RAM maintain the same byte-to address mapping. Namely, the most significant byte of the word, being data or instructions, is held in bits [7:0] of any interface bus and is going to be written at mem[address+0]. This requires an inversion of endianness when words start to get processed inside the CPU before they are outputted.

## How to compile 
1. Go to the directory
2. Compile the assembler with `gcc assemble.cpp -lstdc++ -o assemble.out` (If it says permission denied run `chmod u+x assemble.cpp`)
3. Change the content of the `test.asm` file to the assembly code you want to test (Check below for format/syntax)
4. Assemble the instructions with `./assemble.out test.asm > instructions.mem`
5. Compile all the verilog files with `iverilog -Wall -g 2012 -s CPU_tb -o cpu_tb test/CPU_tb.v test/ROM.v rtl/mips_cpu_harvard.v rtl/alu.v rtl/loadstore.v rtl/RAM.v`
6. Run the output file with `./cpu_tb`
7. Check waveforms with `gtkwave CPU_TB.vcd`
8. Log every bug you find (missbehaving instruction, solution, etc.. so we can discuss together later)

