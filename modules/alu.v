module alu(
    input [31:0] a,
    input [31:0] b,
    input logic clk,
    input [3:0] shift_amount,
    input [5:0] func_code, //opcode is always 0 for this module
    output logic zero,
    output [0:31] out,

); //Do shifts as well
    always_comb begin
        case(func_code):
        default: begin end
        6'b100000: out = a+b;// ADD
        6'b100001: out = $unsigned(a) + $unsigned(b); //Unsigned ADD
        6'b100100: out = a&b;//AND
        6'b100111: out = (a~|b); //NOR
        6'b100101: out = (a|b); //OR
        //6'b101010: out = //set on less than immediate
        6'b101011: out = (a<b); //Set on less than
        6'b100010: out = $unsigned(a) < $unsigned(b);
        6'b100011: out = $unsigned(a) - $unsigned(b);
        6'b100110: out = (a^b); //XOR
        6'b111010: out = $signed(b) >>> shift_amount; //arithmetic shift right
        6'b111100: out = b << shift_amount; //Logical Shift left/arithmetic shift left (same operation)
        6'b111110: out = b >> shift_amount; //Logical Shift right.

        zero = (out==0);

    endcase
    end
endmodule

/*when opcode != 0{
    implement all immediates, branches and jumps
}*/ 

